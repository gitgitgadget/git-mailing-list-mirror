Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D06B41F42D
	for <e@80x24.org>; Sun, 13 May 2018 08:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751132AbeEMIX0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 04:23:26 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35771 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750860AbeEMIXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 04:23:25 -0400
Received: by mail-wm0-f68.google.com with SMTP id o78-v6so9861176wmg.0
        for <git@vger.kernel.org>; Sun, 13 May 2018 01:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OKlKhfOZrjs/ke2GbI5FEr+rFlAurQ8bjv/jNemPBsc=;
        b=WJC8HGiMGT+Bnwgpyu9B/IvelwZ0YscHopB2mVv7DxfDBP/iuvrmnN1SSeHK8BtgnO
         XFOJ3GMe0bLiyb+tmhQWCzNtldbhrQPoRg4VvfqTo0Qejo7DcWIrxDL3NlzzObeLY3Z8
         I5vjy++Xdg5YQXxKfbdPa6M6/BECZQsC7ct6wZSx5KxrHM57oJ2rqjBXpqAnuMHMF0l4
         GNYWMhm4MnVas3oP5sa2AQbpuS1SQuPwMK7pthX2YtoMOP95yTp330cHG1LysIFBTPOj
         EdhQEB/1wwRtXyMuE4OlXcQMfsF5T6fslAFfviBz6/31CvejUAgNRsej0mpn0HCjbqDB
         oZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OKlKhfOZrjs/ke2GbI5FEr+rFlAurQ8bjv/jNemPBsc=;
        b=TtNOO0grGdRaAEoVcZoKm58aVeuRZAKAjYdVuHgBjnjVjecbxi6z2gOlZqfHnPhrso
         THqstEygPMRNdcLiD41POgFv1FXpjnu91WwtQHMHw+ZBvWfgU5G6PgduFVv6OpBRoQLl
         pUEBzEslQBBbWgcV+21HOfwX3EXM9Kr2cXyHKntoqxlnIp8IvHuIzcDLG6r7vMqFyfGH
         8MWW1jdJbX+Btg8DaI0G6LWV5Kd0tJkgaEt+ndpIOC6tgMkBQd50cNkz+IW0Dti+BelX
         r22tLbpxx/1A186pzbAmYv7O3rEUnfXo/FHjiVglDFsujKTqlRoZ/2UyOFxsrwb6ktwe
         JVnA==
X-Gm-Message-State: ALKqPwf0ObDVpZNRig58xcUmZAnAvx6g91BSCHcx3Nwcjn6An2Puqnsy
        hkPsI0D8GUCyqehnHrVHg8iVemL4
X-Google-Smtp-Source: AB8JxZqm6vHpK05QXvptDyLGebdb0UBFiDGP4pb6+brV6VrFBinegyU30ZOosKoBlr3H2pNjSkZrSw==
X-Received: by 2002:a1c:cb88:: with SMTP id b130-v6mr2756159wmg.78.1526199803763;
        Sun, 13 May 2018 01:23:23 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id t189-v6sm5389161wmf.22.2018.05.13.01.23.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 May 2018 01:23:22 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] config: free resources of `struct config_store_data`
Date:   Sun, 13 May 2018 10:23:03 +0200
Message-Id: <20180513082303.19582-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.583.g9a75a153ac
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit fee8572c6d (config: avoid using the global variable `store`,
2018-04-09) dropped the staticness of a certain struct, instead letting
the users create an instance on the stack and pass around a pointer.

We do not free the memory that the struct tracks. When the struct was
static, the memory would always be reachable. Now that we keep the
struct on the stack, though, as soon as we return, it goes out of scope
and we leak the memory it points to.

Introduce and use a small helper function `config_store_data_clear()` to
plug these leaks. This should be safe. The memory tracked here is config
parser events. Once the users (`git_config_set_multivar_in_file_gently()`
and `git_config_copy_or_rename_section_in_file()` at the moment) are
done, no-one should be holding on to a pointer into this memory.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 config.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/config.c b/config.c
index 6f8f1d8c11..83d7d0851a 100644
--- a/config.c
+++ b/config.c
@@ -2333,6 +2333,13 @@ struct config_store_data {
 	unsigned int key_seen:1, section_seen:1, is_keys_section:1;
 };
 
+void config_store_data_clear(struct config_store_data *store)
+{
+	free(store->parsed);
+	free(store->seen);
+	memset(store, 0, sizeof(*store));
+}
+
 static int matches(const char *key, const char *value,
 		   const struct config_store_data *store)
 {
@@ -2887,6 +2894,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		munmap(contents, contents_sz);
 	if (in_fd >= 0)
 		close(in_fd);
+	config_store_data_clear(&store);
 	return ret;
 
 write_err_out:
@@ -3127,6 +3135,7 @@ static int git_config_copy_or_rename_section_in_file(const char *config_filename
 	rollback_lock_file(&lock);
 out_no_rollback:
 	free(filename_buf);
+	config_store_data_clear(&store);
 	return ret;
 }
 
-- 
2.17.0.583.g9a75a153ac

