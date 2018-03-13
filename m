Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E09BC1F404
	for <e@80x24.org>; Tue, 13 Mar 2018 16:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932488AbeCMQyB (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 12:54:01 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42121 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752611AbeCMPak (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 11:30:40 -0400
Received: by mail-pg0-f68.google.com with SMTP id x2so3966589pgo.9
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 08:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YNoceGJOPA90FYwPp5ZEMOwohzgYL6EGMpV4Yjgijl4=;
        b=ilERF7JgbdgqFY+lrzV4QofkTwFDTV3kHaSSFcu5OjWVMV4byqLot5ZMis69sSBHti
         7UXhTvTKFSuLG9gpCeEXmlDfni1ep3du5cCjjUArD8BaqiZdJ6pMig6fXNEfBLuY/Tg+
         1N5u98tBuOI9qm8n4HUFPYyHB36WLvYV1Z2FhuMr8Iwh4OwhAYj5s02QU5xSSeqZlBOy
         lksPN1E+O38CGk1hGvw8+DJ/5+NDj+rKsrErOojAMlUXYFfdOiTczGvmdSelerexlIp3
         qMdiwUrTj2OHAOj5o0xcXSqS21KorlTENlT0PIe4kq021jMHgdgnbvxkrLgV38aqIRmq
         1E4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YNoceGJOPA90FYwPp5ZEMOwohzgYL6EGMpV4Yjgijl4=;
        b=LsK82fumCIjDBWxr5ViUuFsiTMM9jE5PBbKPeTf3XnJOfT635i0LQI+UAMSSfJJieN
         SuLrEF2okaOgij83cArqU8asBxZMcpd67Lye0WEcmc2/lftUVBGgnOpviV67w5p943Xj
         ngXgCCW3G9oqdsmigM/dOhkLzPyxHF+fTWPyhom85ZDybvh7C3lLAwUwc7xiTvJX6Le3
         icNqbdd/F4tRGtjQrAq4EfFkPnXcNpl5rH+/pJS5M1x+RJu7kqAkJr975bbca6ncj/iW
         /lvVaiz0Ss38z40CgLyNr69FXd6TjSdbkgyC1j/dPKVu4J+OVl4GQaaS0bj4ehL/gB0D
         tM5g==
X-Gm-Message-State: AElRT7ECIiZcUZ4gy17GPMRYkBN0+LaLYar538KAvY+EhrbEJXLUu5pD
        t8Cqfos9wv+gq5tXBrO0eLgCdC0Dj9w=
X-Google-Smtp-Source: AG47ELtGvrerfVcJVNa0ieuecoLdpwthqGvRqW+rK630eKXxPMc1phTfGeWVrWWXx9QtylRjgsy0ow==
X-Received: by 10.98.72.204 with SMTP id q73mr1044904pfi.48.1520955039201;
        Tue, 13 Mar 2018 08:30:39 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id c11sm1433441pfe.109.2018.03.13.08.30.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Mar 2018 08:30:37 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        tikuta@chromium.org
Subject: [PATCH] sha1_file: restore OBJECT_INFO_QUICK functionality
Date:   Tue, 13 Mar 2018 08:30:29 -0700
Message-Id: <20180313153029.257296-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.16.2.660.g709887971b-goog
In-Reply-To: <xmqqr2ouwgsd.fsf@gitster-ct.c.googlers.com>
References: <xmqqr2ouwgsd.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Support for the OBJECT_INFO_QUICK flag in sha1_object_info_extended()
was added in commit dfdd4afcf9 ("sha1_file: teach
sha1_object_info_extended more flags", 2017-06-26) in order to support
commit e83e71c5e1 ("sha1_file: refactor has_sha1_file_with_flags",
2017-06-26), but it was inadvertently removed in commit 8b4c0103a9
("sha1_file: support lazily fetching missing objects", 2017-12-08).

Restore this functionality.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
> Hmm, OBJECT_INFO_QUICK optimization was added in dfdd4afc
> ("sha1_file: teach sha1_object_info_extended more flags",
> 2017-06-21), but since 8b4c0103 ("sha1_file: support lazily fetching
> missing objects", 2017-12-08) it appears that passing
> OBJECT_INFO_QUICK down the codepath does not do anything
> interesting.  Jonathan (cc'ed), are all remaining hits from "git
> grep OBJECT_INFO_QUICK" all dead no-ops these days?

They are, but they are not supposed to be. Here is a patch correcting
that.
---
 sha1_file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 1b94f39c4..cc0f43ea8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1267,9 +1267,11 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 			return 0;
 
 		/* Not a loose object; someone else may have just packed it. */
-		reprepare_packed_git();
-		if (find_pack_entry(real, &e))
-			break;
+		if (!(flags & OBJECT_INFO_QUICK)) {
+			reprepare_packed_git();
+			if (find_pack_entry(real, &e))
+				break;
+		}
 
 		/* Check if it is a missing object */
 		if (fetch_if_missing && repository_format_partial_clone &&
-- 
2.16.2.660.g709887971b-goog

