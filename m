From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Fwd: Gitweb error
Date: Sun, 29 Jan 2012 01:37:16 +0100
Message-ID: <201201290137.17556.jnareb@gmail.com>
References: <5fa08a8b-f0a2-4796-bf0d-06a8f13bf703@b23g2000yqn.googlegroups.com> <m362fwesdw.fsf_-_@localhost.localdomain> <CA+EqV8w5qz+iwg_PPB4M5Q-LS48B=yncR9UdR-r58BLtAEPPrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: rajesh boyapati <boyapatisrajesh@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 29 01:36:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrIlJ-0004oR-AE
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jan 2012 01:36:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087Ab2A2Ags (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jan 2012 19:36:48 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42975 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab2A2Agr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2012 19:36:47 -0500
Received: by eaal13 with SMTP id l13so681061eaa.19
        for <git@vger.kernel.org>; Sat, 28 Jan 2012 16:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=xgWuQt1jP+YupVJzkcG/CcAz6NlVJC+kjOMSZ21/s0E=;
        b=eei9MTxHJIVL45jRueZVgW0M3UOe81XeUHSn3MdCXgnXXhpgQjCOchbSQTZ1cKChwe
         BzCfdDUy/yuItJoy5hNaI7GMcE3mK9YM8mXMPu8r+WrlGFHuEwiKhpvqY6o5qo7S3PFs
         rd8Q46LHKPYXWbeuAcw97XxVZ9+1YLfeHAyU8=
Received: by 10.213.4.134 with SMTP id 6mr2012416ebr.86.1327797406264;
        Sat, 28 Jan 2012 16:36:46 -0800 (PST)
Received: from [192.168.1.13] (abvp249.neoplus.adsl.tpnet.pl. [83.8.213.249])
        by mx.google.com with ESMTPS id t11sm23989534eea.10.2012.01.28.16.36.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 Jan 2012 16:36:45 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <CA+EqV8w5qz+iwg_PPB4M5Q-LS48B=yncR9UdR-r58BLtAEPPrA@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189269>

On Fri, 27 Jan 2012, rajesh boyapati wrote:
> On Fri, Jan 27, 2012 at 3:39 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> > rajesh boyapati <boyapatisrajesh@gmail.com> writes:

> > > When I go to one of the projects in gerrit through gitweb and when I
> > > click "summary", I am getting the below error.
> > > If I click other tabs(log, shortlog, commit, tree,etc) after clicking
> > > "summary", I am getting following error in error-log.
> > > If I click other tabs(log, shortlog, commit, tree,etc) before clicking
> > > "summary", everything works fine.

It is strange that you get an intermittent error like this, and make
it even harder to debug - HTTP is stateless.

> > > Error:
> > > =================================================================
> > > [2012-01-25 18:50:32,334] ERROR
> > > com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: [Wed Jan 25
> > > 18:50:32 2012] gitweb.cgi: Use of uninitialized value $head in string
> > > eq at /usr/lib/cgi-bin/gitweb.cgi line 4720.
> >
> > Could you show this line and about 3 lines of context in your
> > gitweb.cgi?
> >
> 
>     my $alternate = 1;
>     for (my $i = $from; $i <= $to; $i++) {
>         my $entry = $headlist->[$i];
>         my %ref = %$entry;
>         my $curr = $ref{'id'} eq $head;
>         if ($alternate) {
>             print "<tr class=\"dark\">\n";
>         } else {
>             print "<tr class=\"light\">\n";
>         }
>         $alternate ^= 1;
 
Hmmmm... I see that we do not check if $head is defined here before using
it.  This can happen legitimately if we are on yet to be born orphan branch
(so $head, which should be named $head_at, is undefined) but there exist
other branches (so $headlist is not empty).

But I don't think it is what happened in your case, is it?

[...]
-- 
Jakub Narebski
Poland
