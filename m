From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 01/19] read-cache.c: fix constness of verify_hdr()
Date: Wed, 27 Apr 2016 16:04:23 -0400
Message-ID: <1461787481-877-2-git-send-email-dturner@twopensource.com>
References: <1461787481-877-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 27 22:05:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avVi2-0003Bu-7s
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 22:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753368AbcD0UFN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2016 16:05:13 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:36095 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237AbcD0UFK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 16:05:10 -0400
Received: by mail-qg0-f43.google.com with SMTP id d90so21813323qgd.3
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 13:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uewEGQ0wF/3DxfN+baDwQCJkdkBanU90hVkFsq63qvw=;
        b=V5Z1MpHZw/IDKSEkvKQYo3pfa/gvMHMOe99T/nxgFkn4Xf64MWgn/NOZIJyuDAHj+p
         laA6nbX0IREIDUX2hCYDndRG2alD15u0QvKQl4EQNbkrfQtCJZd0wyihWQGJ32/7xWCK
         NX+B3iyNHbasS4X3R9fNJTzxelogmuyW4Xv96q42cvzumHacmc5bCMUYpnrV4xo9mmys
         SUJ5Wa+aC5mhnExhVDKbaqmx3eXYWGPFphcEkJgmnJ+aPfCP4kmTVmsdVjCBkjcIcEdF
         wMPPDgAUAJZOmmCMCeEgJq5iXGYqFteGwy2o+w7eJtbSaV/ZJ4GkkqCVVSdd4ySPILKm
         3+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uewEGQ0wF/3DxfN+baDwQCJkdkBanU90hVkFsq63qvw=;
        b=czURK7g8Tp1VbA9QAKtpctvZuGCewDIhCMj5kultwoP4lDITnncZ+LjPOkoRuMq6Rl
         8Sd1xKSwJPzJgjemY8xA6s/ypYBsBJErNNe/y+cGlkecmD9t5uyEZCR/jCFfokpztZsD
         ep+jpLvhuRH3bX86mBsSVRGEx5MEPq0wG9/1/CVENfOfzPk7W1ZfdBTk3OandrN7OEK5
         /RA+YYeDbgRWYovZe4ZKJYUoLmFfB+SHfEUQzQjeRvsVwZwQu3kRxp9kxYN45u1WwLuI
         RsxRh5yvJS7ocdb5kq4DVz/ZMhGrx69tmwAXh+hWvZ/IpsUo8shisaVZ19mTpVF+SSU3
         a9NQ==
X-Gm-Message-State: AOPr4FXYA4XTqK2j4iVbhijdFFJU76Eoch4lxSArHQCfWwiTF1qIAkvNO5nPkXu53qeHPQ==
X-Received: by 10.140.95.83 with SMTP id h77mr10332872qge.105.1461787509889;
        Wed, 27 Apr 2016 13:05:09 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id r124sm1700085qhr.48.2016.04.27.13.05.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Apr 2016 13:05:08 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461787481-877-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292790>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index d9fb78b..16cc487 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1345,7 +1345,7 @@ struct ondisk_cache_entry_extended {
 			    ondisk_cache_entry_extended_size(ce_namelen(ce)) : \
 			    ondisk_cache_entry_size(ce_namelen(ce)))
=20
-static int verify_hdr(struct cache_header *hdr, unsigned long size)
+static int verify_hdr(const struct cache_header *hdr, unsigned long si=
ze)
 {
 	git_SHA_CTX c;
 	unsigned char sha1[20];
--=20
2.4.2.767.g62658d5-twtrsrc
