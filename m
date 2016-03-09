From: David Turner <dturner@twopensource.com>
Subject: [PATCH 02/19] read-cache.c: fix constness of verify_hdr()
Date: Wed,  9 Mar 2016 13:36:05 -0500
Message-ID: <1457548582-28302-3-git-send-email-dturner@twopensource.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 09 19:36:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiyS-0007AS-IF
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 19:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933805AbcCISgj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2016 13:36:39 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33013 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933692AbcCISgg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 13:36:36 -0500
Received: by mail-qk0-f178.google.com with SMTP id s5so24029225qkd.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 10:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SSoa93rHY6DlfpeRAIMSLhVwvhKGdHd/q7Zc3RtPR7I=;
        b=QWczFc1KYKmejguewlwKzVqyRK/1lIp8+jN5eLK8qn+S0aEB7fQnN/FxkDsw5ac4WG
         wJUWM2m7H/TLoE1KDVaxGsAmV7BeCK7j/LUY72G+K/p2LrkAetBObYcHVRXzZymXo9fE
         1Yel5pJtGvckR7Pc0ArvI026/zwc6b80hFNoy4ehr8HBC7nmRj1J9hlu+uFCtL1V2mNY
         iyBhKq27JqQ8Bu/ZPvOJjPVA543SCaRpZgISmZxNHh6Z5TOx+2/JIvoXGzBih+K1kQDC
         bNt7Y8kZxZOXMlimjpJq2iSZod7pkJkJE3AUwAnTMYpkHSN7LBFsowBmxa0PFaax/0dw
         c6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SSoa93rHY6DlfpeRAIMSLhVwvhKGdHd/q7Zc3RtPR7I=;
        b=Q0MDmpxMgTSslvC95X+T8Qqll46PQkWsAQvu/DdFN4gLi7ifVyeymbCOXzeqX20vpZ
         MDtZlw1Prnvce0Dkb8pvKw1aUTzKHb/YQWXVTvpByPdfWUye6Yok6if4AMFQq0H+iOng
         SkM+xwyV4sfyKt7Nn7u6B2atk24y5/Y+9POYD8205d4yqA49Bodw0ya8wrH2pTXkyXBp
         FK8tovSYWEPEAFJnKtpAY/KXrCkhsTtB1IqS1efaZKh9PB3Glh/1dnPcoCh7GGvaZmQe
         Ut5nAlDpvabdlVgwsEzGDdBSU2gyYTQtMXeWQlpR6Kr/BlZBnFraNQa7Rik8riUcONTK
         hVoQ==
X-Gm-Message-State: AD7BkJJUgxc/FhPcXzeWEHLSxwzzQ0KULLn2akCCT+uTHTWix68sHv/+PeJUmR+KNFf7bw==
X-Received: by 10.55.81.2 with SMTP id f2mr45213395qkb.87.1457548595000;
        Wed, 09 Mar 2016 10:36:35 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.128])
        by smtp.gmail.com with ESMTPSA id r6sm4166929qhb.49.2016.03.09.10.36.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2016 10:36:34 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288549>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
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
