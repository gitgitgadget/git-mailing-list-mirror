From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Fix handling of non-ASCII characters in inserted HTML files
Date: Wed, 3 Dec 2008 11:21:42 +0100
Message-ID: <200812031121.43606.jnareb@gmail.com>
References: <200811171140.45884.jnareb@gmail.com> <20081201175741.11133.82393.stgit@localhost.localdomain> <7v63m1j4ke.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Tatsuki Sugiura <sugi@nemui.org>,
	Gerrit Pape <pape@smarden.org>, Recai Oktas <roktas@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 11:23:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7ot4-00073Q-WC
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 11:23:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbYLCKVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 05:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbYLCKVz
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 05:21:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:62669 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbYLCKVx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 05:21:53 -0500
Received: by ug-out-1314.google.com with SMTP id 39so3345971ugf.37
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 02:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=DF50KkoEvqCrQfRBCh2/AuFJgu18DVIZQCTxbyra7Yw=;
        b=YRelFQn115tN/B0IiDE9O74vby7NQavaGD2O2X1kwCW3Yx1SYvF/xV3/yMOPcIknp3
         BbVyBW+WyLI4HofuXn0kHROxFem2XuH0sMA2/V1wEDA5pNN8ZDmwiuaR1q/N8x909Oy3
         htSJoxFuvmuBaICUAtBhXhGMsp3zbHn4rW40U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ws5Wo2UcP+DoLp45qZzFgmDer8B8f0asMOPCBXG5gAqeF2N2vtFCSGgUIsPeNtmkgb
         ATQoxWKrW1cJt1dT4LqN3dpczp28El3pbS1qXUoRoiQBa1CKrEzb06pOMcgolDHuyhVc
         NOsLFV4r6KPkxwqLcQHMg+ZT/XSSLGp3aWWpY=
Received: by 10.66.234.13 with SMTP id g13mr1579606ugh.65.1228299711487;
        Wed, 03 Dec 2008 02:21:51 -0800 (PST)
Received: from ?192.168.1.11? (abvk204.neoplus.adsl.tpnet.pl [83.8.208.204])
        by mx.google.com with ESMTPS id l20sm8156330uga.14.2008.12.03.02.21.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Dec 2008 02:21:47 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7v63m1j4ke.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102238>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Use new insert_file() subroutine to insert HTML chunks from external
> > files: $site_header, $home_text (by default indextext.html),
> > $site_footer, and $projectroot/$project/REAME.html.
> >
> > All non-ASCII chars of those files will be broken by Perl IO layer
> > without decoding to utf8, so insert_file() does to_utf8() on each
> > printed line; alternate solution would be to open those files with
> > "binmode $fh, ':utf8'", or even all files with "use open qw(:std :utf8)".

> > This is more complete solution that the one provided by Tatsuki Sugiura
> > in original patch
> >
> >   [PATCH] gitweb: fix encode handling for site_{header,footer}
> >   Msg-Id: <87vdumbxgc.wl@vaj-k-334-sugi.local.valinux.co.jp>
> >   http://thread.gmane.org/gmane.comp.version-control.git/101199
> 
> It may be more complete but it is obviously untested.  Please help me
> trust you better with your future patches.  Because I personally do not
> run gitweb myself, I really need a trustworthy lieutenant(s) in the area.
> 
> [Wed Dec  3 01:52:07 2008] gitweb.perl: Global symbol "$fd" requires explicit package name at /git.git/t/../gitweb/gitweb.perl line 4500.
> [Wed Dec  3 01:52:07 2008] gitweb.perl: Execution of /git.git/t/../gitweb/gitweb.perl aborted due to compilation errors.
> 
> > but it is in principle the same solution.
> >
> > I think this one as it is a bugfix should go in git 1.6.1
> 
> Trading a gitweb with a small bug with a gitweb that does not even pass
> its test script does not feel like a good change to me.
> 
> I think the breakage is the "close $fd" at the end of this hunk:
[...]
> I'll queue it to 'pu', with the "close $fd" removed, for now.

I'm very sorry about that. It was a bit of time since my last patch
sent, and I forgot that nevermind how obvious and simple the change,
one should run relevant parts of test suite, or at least try to run
gitweb / changed command.

With "close $fd" removed the patch is correct (and patches t9500*).
-- 
Jakub Narebski
Poland
