From: Wolfgang Denk <wd@denx.de>
Subject: Re: Cannot install git RPM
Date: Tue, 09 Aug 2005 13:07:05 +0200
Message-ID: <20050809110705.6B1FF352B36@atlas.denx.de>
References: <20050809104040.B9C61352B36@atlas.denx.de>
X-From: git-owner@vger.kernel.org Tue Aug 09 13:08:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2Rxd-0004rT-W9
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 13:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbVHILHT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Aug 2005 07:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbVHILHT
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Aug 2005 07:07:19 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:31122 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932512AbVHILHR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2005 07:07:17 -0400
Received: from fwd27.aul.t-online.de 
	by mailout11.sul.t-online.com with smtp 
	id 1E2Rww-0003pN-01; Tue, 09 Aug 2005 13:07:14 +0200
Received: from denx.de (Z4sgkcZB8etOB1NZ0ukGRt+lSPxDji1CjB+Lp6TUomhrOY-DQCPD4I@[84.150.75.60]) by fwd27.sul.t-online.de
	with esmtp id 1E2Rwo-2DNIrA0; Tue, 9 Aug 2005 13:07:06 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP id BAD0C42BAA
	for <git@vger.kernel.org>; Tue,  9 Aug 2005 13:07:05 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 6B1FF352B36
	for <git@vger.kernel.org>; Tue,  9 Aug 2005 13:07:05 +0200 (MEST)
To: git@vger.kernel.org
In-reply-to: <20050809104040.B9C61352B36@atlas.denx.de> 
Comments: In-reply-to Wolfgang Denk <wd@denx.de>
   message dated "Tue, 09 Aug 2005 12:40:40 +0200."
X-ID: Z4sgkcZB8etOB1NZ0ukGRt+lSPxDji1CjB+Lp6TUomhrOY-DQCPD4I@t-dialin.net
X-TOI-MSGID: 50028a02-646e-4a22-9edc-c8742623253d
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I wrote:

> it is not possible to build RPMs from the current git code:
> 
> RPM build errors:
>     Installed (but unpackaged) file(s) found:
>    /usr/share/git-core/templates/description
>    /usr/share/git-core/templates/hooks/post-update
>    /usr/share/git-core/templates/hooks/update
>    /usr/share/git-core/templates/info/exclude
> make: *** [rpm] Error 1

A simple fix is of course:

-> diff -u git-core.spec.in.ORIG git-core.spec.in
--- git-core.spec.in.ORIG       2005-08-09 10:26:50.845877000 +0200
+++ git-core.spec.in    2005-08-09 12:42:06.872310918 +0200
@@ -40,6 +40,7 @@
 %{!?_without_docs: %doc Documentation/*.html }
 %{!?_without_docs: %{_mandir}/man1/*.1.gz}
 %{!?_without_docs: %{_mandir}/man7/*.7.gz}
+/usr/share/git-core/templates/*
 
 %changelog
 * Thu Jul 14 2005 Eric Biederman <ebiederm@xmission.com>


But the resulting RPM cannot be installed either,  at  least  not  in
standard Fedora Core 2/3/4 installations:

error: Failed dependencies:
        perl(Email::Valid) is needed by git-core-0.99.3-1
        perl(Mail::Sendmail) is needed by git-core-0.99.3-1


Seems git is depending on more and more stuff which is not  available
in standard distros. This makes it not easier for new users...

Is there at least some  documentation  which  external  packages  are
needed, and where to find these?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"There are three principal ways to lose money: wine, women,  and  en-
gineers.  While  the first two are more pleasant, the third is by far
the more certain."                      -- Baron Rothschild, ca. 1800
