From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: make search form generate pathinfo-style URLs
Date: Mon, 9 Jul 2007 12:03:42 -0700 (PDT)
Message-ID: <272578.10203.qm@web31813.mail.mud.yahoo.com>
References: <7vejjk6i96.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, jnareb@gmail.com, pasky@suse.cz,
	ltuikov@yahoo.com
To: Junio C Hamano <gitster@pobox.com>,
	Matt McCutchen <hashproduct@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 21:03:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7yWQ-0002zC-9j
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 21:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754626AbXGITDn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 15:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754444AbXGITDn
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 15:03:43 -0400
Received: from web31813.mail.mud.yahoo.com ([68.142.207.76]:44963 "HELO
	web31813.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754194AbXGITDm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jul 2007 15:03:42 -0400
Received: (qmail 10438 invoked by uid 60001); 9 Jul 2007 19:03:42 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=iPr6d40mTXTjYOLc/5gUVWM63+H796/swENlLwi65UBVjFJcmt36PMXAYFm2IrEubQZqWlzTyDY/qQRedZVs4lH0W7spGnXBPK7ABlreuh+EgGCxWOrkDOoMEvpmd86lOssZRPLM7l5ZMQiZuTTSGLXtpRdZobVvxncl9arWquA=;
X-YMail-OSG: hgTCYRMVM1kq07NOmWowdcMdQO_VT2ENDBOEb3vYcZyPK0lPEpBK1QeevyaZwr0Y22.j8Q--
Received: from [71.80.230.107] by web31813.mail.mud.yahoo.com via HTTP; Mon, 09 Jul 2007 12:03:42 PDT
In-Reply-To: <7vejjk6i96.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52012>

--- Junio C Hamano <gitster@pobox.com> wrote:

> Matt McCutchen <hashproduct@gmail.com> writes:
> 
> > The search form generated traditional-style URLs with a "p=" parameter
> > even when the pathinfo feature was on.  This patch makes it generate
> > pathinfo-style URLs when appropriate.
> >
> > Signed-off-by: Matt McCutchen <hashproduct@gmail.com>
> > ---
> >  gitweb/gitweb.perl |   12 +++++++++---
> >  1 files changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index f36428e..7b0e110 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -2215,12 +2215,18 @@ EOF
> >  		} else {
> >  			$search_hash = "HEAD";
> >  		}
> > +		my $action = $my_uri;
> > +		my ($use_pathinfo) = gitweb_check_feature('pathinfo');
> > +		if ($use_pathinfo) {
> > +			$action .= "/$project";
> > +		} else {
> > +			$cgi->param("p", $project);
> > +		}
> >  		$cgi->param("a", "search");
> >  		$cgi->param("h", $search_hash);
> > -		$cgi->param("p", $project);
> > -		print $cgi->startform(-method => "get", -action => $my_uri) .
> > +		print $cgi->startform(-method => "get", -action => $action) .
> >  		      "<div class=\"search\">\n" .
> > -		      $cgi->hidden(-name => "p") . "\n" .
> > +		      (!$use_pathinfo && $cgi->hidden(-name => "p") . "\n") .
> 
> Ahhhhh.  (!$use_pathinfo && blah) when $use_pathinfo is true
> evaluates to an empty string, which saves you from protecting
> yourself from undef.  Perhaps clever, but is not terribly nice.
> 
> Other than that, the patch looks sane to me.

Good catch.

    Luben
