Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 541C62018F
	for <e@80x24.org>; Wed, 13 Jul 2016 15:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbcGMPon (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 11:44:43 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36469 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbcGMPol (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 11:44:41 -0400
Received: by mail-lf0-f66.google.com with SMTP id 33so3970522lfw.3
        for <git@vger.kernel.org>; Wed, 13 Jul 2016 08:44:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zT3T/O+M0gUmt0Ucn6iDSohvU79MtH1kh5we40aZKFE=;
        b=KDRoCRfAViqut+8d+j06QmidiY8odt27lIzXaVpOZVVrrikuMKoZ6n8e3EL2YpRv7A
         I+1PknKn/04TcK3iNWJUcElbxvmQ0vr87qPw7Ty5fs+Bx5pvOhMO2EPGK9OUw0MVGluj
         fvBFM1kFDj5tXTJSRTF/FiRKkezTB+MHKAH+DkGATTUo05JCrqUzaUup8rs2bI+5qRcP
         NbFCGay4tZaY5src3nctlbyzATPgwRhgqR7G22UEYFfeQXFx18CSKMyjA09SqeXAPdjS
         bUVJOxvbQ+HxY7kB5Ny4fz0EEJiJQixr7gD/GC0SKkm3C62FJI9HQleYaTstKr9gCLBb
         jFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zT3T/O+M0gUmt0Ucn6iDSohvU79MtH1kh5we40aZKFE=;
        b=l16YCTbuVmI+pknZb/zbJHSKJDqEUGVBdztZgt1YhlQNYGOX86X/fxBnUmaWkuINOw
         RyqUZuZUysgTFzkXTo2SgoME9NnZv8rVKd4m1iLEZOY0jD0t1cXDBxk7zc/3B+QPsHMk
         Se2GTSmVEt8DfGJLj3//xUa3AqKQeV/44RcJcz13OUogUy7GL1LcoshpCVL9aGu1ktQa
         tUdngJTitIhrsRHtgDBr4vio7r+8veH/HWINBAjYgIJw7vQp5oh7hxL/s8B3nIQDiUbq
         BAG8vEWvdjtHTHva6FDPMf/HxEQBvvWmXTUOI/M+HkF5x59vCrhqB7dvqw8CkxB2tUWc
         IyDQ==
X-Gm-Message-State: ALyK8tI5z8vhi+0FuI33LiwqHNlpuwDdqvnD+fiAfElPHc8J2nd9Axvy5WYyMak+mdeU+w==
X-Received: by 10.25.84.132 with SMTP id i126mr4295896lfb.116.1468424657932;
        Wed, 13 Jul 2016 08:44:17 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id 90sm2575484lfw.30.2016.07.13.08.44.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Jul 2016 08:44:17 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, michelbach94@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 5/7] index-pack: correct "offset" type in unpack_entry_data()
Date:	Wed, 13 Jul 2016 17:44:02 +0200
Message-Id: <20160713154404.22909-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.9.1.564.gb2f7278
In-Reply-To: <20160713154404.22909-1-pclouds@gmail.com>
References: <20160705170558.10906-1-pclouds@gmail.com>
 <20160713154404.22909-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

unpack_entry_data() receives an off_t value from unpack_raw_entry(),
which could be larger than unsigned long on 32-bit systems with large
file support. Correct the type so truncation does not happen. This
only affects bad object reporting though.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/index-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index e2d8ae4..1008d7f 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -430,7 +430,7 @@ static int is_delta_type(enum object_type type)
 	return (type == OBJ_REF_DELTA || type == OBJ_OFS_DELTA);
 }
 
-static void *unpack_entry_data(unsigned long offset, unsigned long size,
+static void *unpack_entry_data(off_t offset, unsigned long size,
 			       enum object_type type, unsigned char *sha1)
 {
 	static char fixed_buf[8192];
-- 
2.9.1.564.gb2f7278

