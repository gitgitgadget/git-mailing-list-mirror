Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377F0C77B60
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 09:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345618AbjD1JYA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 05:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345391AbjD1JXv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 05:23:51 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEB62114
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 02:23:50 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b52ad6311so11020151b3a.2
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 02:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682673830; x=1685265830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrANtvrLJ5OXmpR6s0jwv4UmUdJ899u5KZRlOyddvew=;
        b=lyANsD+1na3TkU5C226xSYif4JyWGD6OQx0ApMme17BD9Yf7maE8+YvouI65yBoF1O
         iomsM3eWbPv5XrlDpsrULoOsSJX+bDgKa4+wISCUXd+AT9H/kE29C47Z8EU0Et7DQfbN
         CgUUNSowFXhyD0sdSwjUYcsOAESPCeefPOQYw7zBuVVf5NmHy336Ej3kPJ1fZvH3ORis
         ++gcX1lIyIzy2F5yYzxC3FmXGR867B3FzWo1/6APsbi9qaemkt/OcjGfATc+1HTXgKYT
         IJq+Ag6r5Ch1D71w30FCOOUqQV2tyKkhs8gzdyFysnNuCxSgJwrynUm9aGrH8PjcfiRs
         A4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682673830; x=1685265830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrANtvrLJ5OXmpR6s0jwv4UmUdJ899u5KZRlOyddvew=;
        b=Z1TtrHjA4yc3MkcP+nlVGzDym7hj/Ij1BsRKsGHx1M7W4UUKaSlaFpjZ4rwM3u7n04
         aPLtySWzSZRnwnkZqr9nh2cl3OXTahhSihiDCPmi38I21dn71eY+QdmjIBesgJJ/sROh
         +QlMDp+0hyQo3YciSQUdOt6zQa9O0ORCktlWpEaFsAtLEPD7f+gKbKK9U6NrTopQLpKC
         9tIulHtQrysD+i4LOpDtHrsV3fYlEQNr3YV38vsdfSruLVc3PQeqCfHCNEnFbtrcZr5I
         i4tdoYnebApxXvzWSXo+miyFa31uU6E/YZZLAueCSD4Hy0aOD1EY1VP9yCXsDWSCGW2T
         So0A==
X-Gm-Message-State: AC+VfDxg+oRid6YzhI4D1fcxnz60OQIkn4fL5f0LxcxI8VLhlYJzZezQ
        IE+Nuuka0/tgW6RVRkbJGf/3+AOCmlqoCg==
X-Google-Smtp-Source: ACHHUZ546/qjdGArWMW5rFxx0mlQQhZkv1OsBqVwuP3wQ7Il/B3piinptrQzacFsgyca8wI/hG5+bA==
X-Received: by 2002:a05:6a00:24c1:b0:63d:2d99:2e91 with SMTP id d1-20020a056a0024c100b0063d2d992e91mr6782158pfv.28.1682673829908;
        Fri, 28 Apr 2023 02:23:49 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.51])
        by smtp.gmail.com with ESMTPSA id i21-20020a056a00225500b0063b8f33cb81sm15107078pfu.93.2023.04.28.02.23.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Apr 2023 02:23:49 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v9 2/6] notes.c: use designated initializers for clarity
Date:   Fri, 28 Apr 2023 17:23:30 +0800
Message-ID: <4ad7840584191d6bbb3fcba72887aa569c797a15.1682671758.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.40.0.358.g2947072e.dirty
In-Reply-To: <cover.1682671758.git.dyroneteng@gmail.com>
References: <cover.1682671758.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

The "struct note_data d = { 0, 0, NULL, STRBUF_INIT };" style could be
replaced with designated initializer for clarity.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/notes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index c501c6ee..9d8ca795 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -405,7 +405,7 @@ static int add(int argc, const char **argv, const char *prefix)
 	struct notes_tree *t;
 	struct object_id object, new_note;
 	const struct object_id *note;
-	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
+	struct note_data d = { .buf = STRBUF_INIT };
 	struct option options[] = {
 		OPT_CALLBACK_F('m', "message", &d, N_("message"),
 			N_("note contents as a string"), PARSE_OPT_NONEG,
@@ -571,7 +571,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	const struct object_id *note;
 	char *logmsg;
 	const char * const *usage;
-	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
+	struct note_data d = { .buf = STRBUF_INIT };
 	struct option options[] = {
 		OPT_CALLBACK_F('m', "message", &d, N_("message"),
 			N_("note contents as a string"), PARSE_OPT_NONEG,
-- 
2.40.0.358.g2947072e.dirty

