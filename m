From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] git.spec: Workaround localized messages not put in any RPM
Date: Fri, 3 Feb 2012 22:49:07 +0100
Message-ID: <201202032249.07594.jnareb@gmail.com>
References: <7vipjwzvc2.fsf@alter.siamese.dyndns.org> <7vehubpuv7.fsf@alter.siamese.dyndns.org> <201202032155.26532.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 22:49:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtR0P-0002vA-2W
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 22:49:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757791Ab2BCVtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 16:49:11 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:60283 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314Ab2BCVtK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 16:49:10 -0500
Received: by eekc14 with SMTP id c14so1302964eek.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 13:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=bV5i0zzvI4Ml/RxZxwUd0CeYHTPH1QSZyza1Mvgrj2U=;
        b=cFW+c30ElMbewKwbnzZB1x0tygh0LwtMq3m5/cPrxdRqhbOQ5IV+PM+bW3eL3ngXve
         MBDnPk8oxxKHXgoOvzEiWRb/cCnOVomPmA2CXjJpE6gf9ASqLmV/mUhhZ4Cm1py/JOol
         bGbKGQIK9JTjko70IG0CiqKW4J+xD8ujGmeMg=
Received: by 10.14.124.69 with SMTP id w45mr2813925eeh.6.1328305749045;
        Fri, 03 Feb 2012 13:49:09 -0800 (PST)
Received: from [192.168.1.13] (abwn75.neoplus.adsl.tpnet.pl. [83.8.237.75])
        by mx.google.com with ESMTPS id y12sm26545548eeb.11.2012.02.03.13.49.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Feb 2012 13:49:08 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201202032155.26532.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189808>

Currently building git RPM from tarball results in the following
error:

  RPM build errors:
     Installed (but unpackaged) file(s) found:
     /usr/share/locale/is/LC_MESSAGES/git.mo

This is caused by the fact that localized messages do not have their
place in some RPM package.  Let's postpone decision where they should
be put (be it git-i18n-Icelandic, or git-i18n, or git package itself)
for later by removing locale files at the end of install phase.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 git.spec.in |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index c562c62..b93df10 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -134,6 +134,7 @@ find $RPM_BUILD_ROOT -type f -name perllocal.pod -exec rm -f {} ';'
 %else
 rm -rf $RPM_BUILD_ROOT%{_mandir}
 %endif
+rm -rf $RPM_BUILD_ROOT%{_datadir}/locale
 
 mkdir -p $RPM_BUILD_ROOT%{_sysconfdir}/bash_completion.d
 install -m 644 -T contrib/completion/git-completion.bash $RPM_BUILD_ROOT%{_sysconfdir}/bash_completion.d/git
-- 
1.7.9
