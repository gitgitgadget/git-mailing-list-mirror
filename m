Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED93C07E9B
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 13:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 202ED60200
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 13:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238585AbhGSMwu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 08:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238588AbhGSMwn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 08:52:43 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDACAC061574
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 05:55:04 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n4so10377791wms.1
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 06:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TymVszFjsJBdjwLDTQ6Si3e5nI9WQC7VP4b+jb56DIU=;
        b=p7Cv4DMuWuVK5EWUtT8YeYVjBl+RPJY+LH63a+DDIOg5kmuQ3XtMvnsIfxk0P0jXfu
         HTGsjWO61fIZXXRz72afEDXqLN7eypCVN8XLAmXbMYjrXbUJt81d8+adj4t55yT4+o0e
         J5CJUpnUhmzDlnfnUFWe4upX57HiJqa1nYsne3gULRcwodG2xYZtTvP7c3Miic/s76gm
         rOe60ILBZAoS8GK08RPNB05DSM/dfQaTAAK/+O9UJByQthDfUxs/eAL7bUu+Wi6I6qUm
         3vFkHglDGzwSHqO2Yl/CxGia5OXckO6X+YjlbQMZIXC0Q+oNM41upMTk1YZoJ4HzbUy4
         11uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TymVszFjsJBdjwLDTQ6Si3e5nI9WQC7VP4b+jb56DIU=;
        b=fWxPrRbqTyV9JLJhZQmGRebcOWAOFBJlK5X0N692tRnx+Wk/c+RsMMaBOopR2bqGK/
         FPOLERV0L9ttCMUyNyu2gEyV6sWhJTJ5hYU+ykfLbS7cOMSvo9OOO7s4DAcEcoRxCiAE
         JxvRRe4C4TzZL+9ZulJoNNLl6xxo7aWIE6ossJeXwdxfiKkM64wMTCjiA/mAn0IK/j8Z
         5TbZTvgODCoNu7nmYSJJXzVd1vn9j2tRYB6LMR8ARLa69a/OnogihtikmID0Q8nF68Io
         5+P0MI87CAxQOH7nWRq5uR+BIfCPD3V/LETx1J+QGp/0cT165dx0PIbtN7AqElaPGJme
         iK2w==
X-Gm-Message-State: AOAM5337tFA5QTqEpGyA7TKwOlz+vGWQc2nKVtsReBTAWTp1Dakah5cn
        7ix7gz1oR0koHavHQt77qw/n0RM2krs=
X-Google-Smtp-Source: ABdhPJwm/VBvzA8v4lZfZ2dVe8/GMXQJhnurMyzQ7PmdvLbowy4dzvayVvfgxQ5VKMBY4p2JZGuYzw==
X-Received: by 2002:a1c:20c7:: with SMTP id g190mr15774509wmg.16.1626701601162;
        Mon, 19 Jul 2021 06:33:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u16sm24447433wrw.36.2021.07.19.06.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 06:33:20 -0700 (PDT)
Message-Id: <1ec5c06cbe9c0b3ceded291822431baa1564485e.1626701596.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v4.git.git.1626701596.gitgitgadget@gmail.com>
References: <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
        <pull.1041.v4.git.git.1626701596.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Jul 2021 13:33:10 +0000
Subject: [PATCH v4 3/9] ssh signing: retrieve a default key from ssh-agent
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Fabian Stelzer <fs@gigacodes.de>,
        Fabian Stelzer <fs@gigacodes.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Fabian Stelzer <fs@gigacodes.de>

if user.signingkey is not set and a ssh signature is requested we call
ssh-add -L and use the first key we get

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 gpg-interface.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index a086123754d..35e584b94ef 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -470,11 +470,35 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
+/* Returns the first public key from an ssh-agent to use for signing */
+static char *get_default_ssh_signing_key(void)
+{
+	struct child_process ssh_add = CHILD_PROCESS_INIT;
+	int ret = -1;
+	struct strbuf key_stdout = STRBUF_INIT;
+	struct strbuf **keys;
+
+	strvec_pushl(&ssh_add.args, "ssh-add", "-L", NULL);
+	ret = pipe_command(&ssh_add, NULL, 0, &key_stdout, 0, NULL, 0);
+	if (!ret) {
+		keys = strbuf_split_max(&key_stdout, '\n', 2);
+		if (keys[0])
+			return strbuf_detach(keys[0], NULL);
+	}
+
+	strbuf_release(&key_stdout);
+	return "";
+}
+
 const char *get_signing_key(void)
 {
 	if (configured_signing_key)
 		return configured_signing_key;
-	return git_committer_info(IDENT_STRICT|IDENT_NO_DATE);
+	if (!strcmp(use_format->name, "ssh")) {
+		return get_default_ssh_signing_key();
+	} else {
+		return git_committer_info(IDENT_STRICT | IDENT_NO_DATE);
+	}
 }
 
 int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
-- 
gitgitgadget

