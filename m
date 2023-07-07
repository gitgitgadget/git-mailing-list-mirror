Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6894EB64DA
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 15:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjGGPTB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 11:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbjGGPS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 11:18:59 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C9A2117
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 08:18:58 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-403713e7344so16290511cf.2
        for <git@vger.kernel.org>; Fri, 07 Jul 2023 08:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688743137; x=1691335137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQYY8EN7ov4ig5DhJvBW5mlmG2zr+o8bg+t58va+/jI=;
        b=TGO5bNIALIjRndDMPlgttGMcnE9q0wDUpr3vFj1i3nvUOIpwRxc5ikAw1wcymRXH9E
         mGCy/rK9/uFxh7i8UvsMvNJFPjJegpLJX8rC1u8n+EAdsVDiGaxmNTYdm/YJB0EkAw4D
         SvOuo519LExxxaxzckb9J8s52fq+iCcQ3/yujUUe9hrB8fOLe4OrtnIq6fdjriZVEFQ7
         xx0zDR62G1F5pIfslNwGxWL7rzHa4s/nc8P9vlowtYkLsJBgFiv/ZYbhrdavAO4WzR3s
         3S75Db8m1Cvw7NYeqO+5zVqr4sFijhf2h6onzCNqM9jMxsZXI9KKVK0Oi3Qjn4Iagp2E
         rqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688743137; x=1691335137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQYY8EN7ov4ig5DhJvBW5mlmG2zr+o8bg+t58va+/jI=;
        b=Zv0o9eTGX8m3abhQ/SSQP2J5QqhJoBN7iAuhJHghelDGjnwzDBq3wPfWKnFYmCIlxs
         4blsojhc6x20GeLkiHgh8rbZ00lFLptO5uSf7DZbHVowohMOiqAGu6GVi/SCLsAsjC6e
         amNWgwxGJ3+Rgkcz26W1rZg0PTaHleenBpKvMcU7ZAYhqzaFLQ4mxbOj3xlhhfyNeMqO
         1HAARKZxcXq1BIOuXTEG57mcFMvJbQgXXPVPQFFOUem4cPIixTbYvng4ut/cmO4AnoAM
         XI//S4doTfSK25OsDa34xPxdokJxBNFTB3A3r9sT1ibaHIl7xSDnIS5l2OviuOOnUg+1
         q1HQ==
X-Gm-Message-State: ABy/qLaZigA7Pm8SoXvJ551vmt5l5YyHAwvQbqf+p01ih0NLVinAqTuu
        NiFWnJ4SzUKEk10nXFGiv82+EhZ5dj4=
X-Google-Smtp-Source: APBJJlEyWr/LiE2u6WOz3X0uppeklvhCmumOPUWbx/wBAxw01s1ylq8exo7NAHL9W1dRZ1XwaaWorg==
X-Received: by 2002:ac8:5a82:0:b0:3ff:2eb9:ff1b with SMTP id c2-20020ac85a82000000b003ff2eb9ff1bmr6394633qtc.58.1688743137607;
        Fri, 07 Jul 2023 08:18:57 -0700 (PDT)
Received: from localhost.localdomain ([69.158.190.118])
        by smtp.googlemail.com with ESMTPSA id a14-20020aed278e000000b004039e9199cesm338698qtd.60.2023.07.07.08.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 08:18:57 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com
Subject: [PATCH v2 1/3] Enable gitattributes read from sparse directories
Date:   Fri,  7 Jul 2023 11:18:37 -0400
Message-Id: <20230707151839.504494-2-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230707151839.504494-1-cheskaqiqi@gmail.com>
References: <20230701064843.147496-1-cheskaqiqi@gmail.com>
 <20230707151839.504494-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git check-attr' cannot currently find attributes of a file within a
sparse directory. This is due to .gitattributes files are irrelevant in
sparse-checkout cone mode, as the file is considered sparse only if all
paths within its parent directory are also sparse. In addition,
searching for a .gitattributes file causes expansion of the sparse
index, which is avoided to prevent potential performance degradation.

However, this behavior can lead to missing attributes for files inside
sparse directories, causing inconsistencies in file handling.

To resolve this, revise 'git check-attr' to allow attribute reading for
files in sparse directories from the corresponding .gitattributes files:

1.Utilize path_in_cone_mode_sparse_checkout() and index_name_pos_sparse
to check if a path falls within a sparse directory.

2.If path is inside a sparse directory, employ the value of
index_name_pos_sparse() to find the sparse directory containing path and
path relative to sparse directory. Proceed to read attributes from the
tree OID of the sparse directory using read_attr_from_blob().

3.If path is not inside a sparse directory，ensure that attributes are
fetched from the index blob with read_blob_data_from_index().

Helped-by: Victoria Dye <vdye@github.com>
Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 attr.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/attr.c b/attr.c
index 7d39ac4a29..03deb18fb3 100644
--- a/attr.c
+++ b/attr.c
@@ -808,35 +808,35 @@ static struct attr_stack *read_attr_from_blob(struct index_state *istate,
 static struct attr_stack *read_attr_from_index(struct index_state *istate,
 					       const char *path, unsigned flags)
 {
+	struct attr_stack *stack = NULL;
 	char *buf;
 	unsigned long size;
+	int pos;
 
 	if (!istate)
 		return NULL;
 
-	/*
-	 * The .gitattributes file only applies to files within its
-	 * parent directory. In the case of cone-mode sparse-checkout,
-	 * the .gitattributes file is sparse if and only if all paths
-	 * within that directory are also sparse. Thus, don't load the
-	 * .gitattributes file since it will not matter.
-	 *
-	 * In the case of a sparse index, it is critical that we don't go
-	 * looking for a .gitattributes file, as doing so would cause the
-	 * index to expand.
-	 */
-	if (!path_in_cone_mode_sparse_checkout(path, istate))
-		return NULL;
+	pos = index_name_pos_sparse(istate, path, strlen(path));
+	pos = -pos-2;
+	if (!path_in_cone_mode_sparse_checkout(path, istate) && pos>=0) {
+		if (!S_ISSPARSEDIR(istate->cache[pos]->ce_mode))
+			return NULL;
 
-	buf = read_blob_data_from_index(istate, path, &size);
-	if (!buf)
-		return NULL;
-	if (size >= ATTR_MAX_FILE_SIZE) {
-		warning(_("ignoring overly large gitattributes blob '%s'"), path);
-		return NULL;
+		if (strncmp(istate->cache[pos]->name, path, ce_namelen(istate->cache[pos])) == 0) {
+			const char *relative_path = path + ce_namelen(istate->cache[pos]);  
+			stack = read_attr_from_blob(istate, &istate->cache[pos]->oid, relative_path, flags);
+		}
+	} else {
+		buf = read_blob_data_from_index(istate, path, &size);
+		if (!buf)
+			return NULL;
+		if (size >= ATTR_MAX_FILE_SIZE) {
+			warning(_("ignoring overly large gitattributes blob '%s'"), path);
+			return NULL;
+		}
+		stack = read_attr_from_buf(buf, path, flags);
 	}
-
-	return read_attr_from_buf(buf, path, flags);
+	return stack;
 }
 
 static struct attr_stack *read_attr(struct index_state *istate,
-- 
2.39.0

