From: Sven Strickroth <sven@cs-ware.de>
Subject: [PATCH] Close config file handle if the entry to unset is not found
Date: Fri, 14 Aug 2015 21:18:59 +0200
Message-ID: <55CE3F23.7040702@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 14 21:25:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQKc0-00035R-DG
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 21:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbbHNTZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 15:25:52 -0400
Received: from srv1.79p.de ([213.239.234.118]:48141 "EHLO srv1.79p.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328AbbHNTZv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 15:25:51 -0400
X-Greylist: delayed 393 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Aug 2015 15:25:51 EDT
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: from [IPv6:2003:88:6b2b:1300:a502:7b37:ac72:2ad5] (p200300886B2B1300A5027B37AC722AD5.dip0.t-ipconnect.de [IPv6:2003:88:6b2b:1300:a502:7b37:ac72:2ad5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: sven@cs-ware.de)
	by srv1.79p.de (Postfix) with ESMTPSA id 18D10223D7C;
	Fri, 14 Aug 2015 21:19:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs-ware.de;
	s=mail2015; t=1439579955;
	bh=r1NTbbl+kKtPQc64E4n9CAXFREBv2DxvTDB4Jy+OsTk=;
	h=From:To:Subject:Date;
	b=psg6jn8U5uPWgVolV9anl9L+4RwyaPPi3wtl6HWyFAqA21n8fBDX+pZsjNpY3MkXC
	 H1hADDI1Er1kF0I6m/eSxiirEXrXpZToyBGkubXqU+dzpecVi8Fhx/LXD6ZS6ziDVY
	 TRzWRL7iI8RqpJp6LB4iwKJdqfhUzzr4AfOqr66KibGT+/KPBcaLQbTrd7/ZPphGnd
	 KpCmRnPHSUK8gSHtl1NcKTyH6vgfRgnIW52xNAOeUFdZvPelKYse68mZDpttIXJHA0
	 QJzzNxwdAeRIMTQP80EzQH3GraYlvQDQbhYfTTQK1T3EOyHHcBODjSZ2Z+np7weB7G
	 2GeJuPVRPDiSg==
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275924>

Without this patch there might be open handle leaks.

Signed-off-by: Sup Yut Sum <ch3cooli@gmail.com>
Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.c b/config.c
index 9fd275f..89b49e3 100644
--- a/config.c
+++ b/config.c
@@ -2048,6 +2048,7 @@ int git_config_set_multivar_in_file(const char *config_filename,
 		if ((store.seen == 0 && value == NULL) ||
 				(store.seen > 1 && multi_replace == 0)) {
 			ret = CONFIG_NOTHING_SET;
+			close(in_fd);
 			goto out_free;
 		}
 
-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
