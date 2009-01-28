From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv4] gitweb: make static files accessible with PATH_INFO
Date: Wed, 28 Jan 2009 02:47:24 +0100
Message-ID: <200901280247.25317.jnareb@gmail.com>
References: <1233103932-6325-1-git-send-email-giuseppe.bilotta@gmail.com> <7vocxsz19e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 02:48:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRzXw-0006BM-DT
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 02:48:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbZA1Br3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 20:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752013AbZA1Br2
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 20:47:28 -0500
Received: from fk-out-0910.google.com ([209.85.128.188]:38798 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbZA1Br1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 20:47:27 -0500
Received: by fk-out-0910.google.com with SMTP id f33so3473410fkf.5
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 17:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=KbLMPTRhuKqGE0T4YWNOp+npZ4nAeSq+V/BQ3AN87o8=;
        b=imHyrqpXmdYWwfP2HFve9dfXG9B1NlUFd0EbqxqZxtNBdRSzfPZPsTquk443wxQxse
         OHF8qYGqSTeFJbjN1akVZ39gpxrnyY3Hl/4Cls0P44Ef8HiKmuEpp2ZE9gO2jsy13S35
         xhGgvWMosKB3s6d5HBVnGel4RpMgQI+QzMY14=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=QVZLE1xZwo6/zPJO22dhkVipYhc7lMkRz/Zd8evKklkK8Mz47hA2HG+IYoeYMpdqoU
         l70M0+yac37UR0oSkLI7P5MdoxxCrQXI2versH8YJ/SOma/mbU4+P6i3ef/zAQCKwOQo
         LoQQzhReDE/wzfw0DyXMFd0a1aBfkke2f4dlo=
Received: by 10.103.189.15 with SMTP id r15mr593023mup.126.1233107244811;
        Tue, 27 Jan 2009 17:47:24 -0800 (PST)
Received: from ?192.168.1.15? (abvq8.neoplus.adsl.tpnet.pl [83.8.214.8])
        by mx.google.com with ESMTPS id g1sm960662muf.47.2009.01.27.17.47.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jan 2009 17:47:24 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vocxsz19e.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107447>

On Wed, 28 Jan 2009, Junio C Hamano wrote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
> 
> > When PATH_INFO is defined,

I other words: when using PATH_INFO gitweb URL

> > static files such as the default CSS or the 
> > shortcut icon are not accessible beyond the summary page (e.g. in
> > shortlog or commit view).

To be more exact: if static files, such as the default CSS (and also
other stylesheets, if defined), the gitweb favicon / shortcut icon,
or the gitweb logo locations (URIs) are defined using relative URL
with relative path (and default Makefile rule to generate gitweb.cgi
uses basenames like 'gitweb.css', which are relative paths) _THEN_
those static files are not accessible beyond 'summary' and projects
list view (e.g. in 'shortlog' or 'commit' view).

> >
> > Fix this by adding a <base> tag pointing to the script's own URL.

Which defines base URL for all relative links in gitweb.


/Note that this makes the document hierarchy non-portable, but I don't
think we care.../

> >
> > Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> > ---
> >  gitweb/gitweb.perl |    5 +++++
> >  1 files changed, 5 insertions(+), 0 deletions(-)
> >
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index 931db4f..55e3081 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -2901,6 +2901,11 @@ sub git_header_html {
> >  <meta name="robots" content="index, nofollow"/>
> >  <title>$title</title>
> >  EOF
> > +# the stylesheet, favicon etc urls won't work correctly with path_info unless we
> > +# set the appropriate base URL

+# the stylesheet, favicon, etc URLs won't work correctly with path_info,
+# unless we set the appropriate base URL

By the way, I think those comments should be indented aligned to
accompanying code, but this is issue of separate whitespace cleanup,
independent of the issue this commit tries to solve.

> > +	if ($ENV{'PATH_INFO'}) {
> > +		print "<base href=\"$my_url\" />\n";
> > +	}
> 
> Perhaps this is a stupid question, but is $my_url already safe to include
> in the output without any further quoting at this point in the codepath?

Hmmmm... to be safe we probably should use either esc_url($my_url) here
(like in git_feed subroutine).

-- 
Jakub Narebski
Poland
