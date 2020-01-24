Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8EEC35242
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 03:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D461524655
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 03:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z8/qpD0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbgAXDfb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 22:35:31 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:33646 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbgAXDfa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 22:35:30 -0500
Received: by mail-yw1-f74.google.com with SMTP id e66so539802ywf.0
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 19:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cyO149RfctL+SLMlcgnvh4ZsUVUgUM/UYJB6OSgVkmo=;
        b=Z8/qpD0J8GUwjdDZuii7wni8NTGy94wH/4XLLMtiN40WE5s8nAOvO2WcheJhYDilYj
         hXQCU+O69qgunO0/MCyUA+jxUgJ2Gytxfb5ZK8cWS7AoLDrkjwNFh4h+EGxpBKQTzDtV
         wzWOmcuV1m0S91pq2D/Avy94IQcgJPLjY7/+xwOjtZvLAeFHWM6XYfktsPrkfrhf3mV5
         POJ/1NwvvcMjQTGf0klLixnxRuCpT35cYo0Tn3DOoL81v6SHH15SBzEC3rIbyrRUxx1h
         RUF2fHGWUapixDO3/RVK7WkGpuVZdfObrl2GRIxRSVs6NJD1LXnF77C8IYuorSv8KYW4
         3Ncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cyO149RfctL+SLMlcgnvh4ZsUVUgUM/UYJB6OSgVkmo=;
        b=OgnzlfgB8DLuKiYeT8loI/7NIlD5j23gxLpcQpW0M6TaXwm51oGGoSi0XfUOS8XYAo
         3Zs84gfB+It70GYRxj1YD8Q+5R7AlLdHqE6uHUzEWurCRsCmYV/zvkf5CaGXjn9gn2iw
         C09bQI1AfdiIWKL9LJa9/qM8oybQa8UM/5JBcg8ERGT0JpIdplFtGMqMkELd5tZz9/s5
         6opxLOt7PVueipbfkuFUZDHL1qN3XN1J/Jud5MudbKYTC9KQbo3cYeQksDnTCKo84Ndk
         ohjTXSnBtAYrA77i4mnCKybQc2kbCt/z22lv6RzC33Jobf37DMjqVJFxhpm8A9/cnfvt
         rE7Q==
X-Gm-Message-State: APjAAAWqVdemYkSif06/EWDVH6dplNZUvds5i+QgE3YKoHkOETnkWaX9
        D3yvCmDjFtcyvEXU+aT/5lqMzKdSTFXu+bV6AK+vAkC91nbknbUvtfbn02heaMjY41GMjHJYGlZ
        1tqaHePH79IIeY4xhxE/gL5mfGrcY5gfxL42Kp++25Qi42VuHo1heNe/QcAIFreEx278FfSNlpg
        ==
X-Google-Smtp-Source: APXvYqzJ73HMj1XWuQYlV5bVAOd1wjPNKqNSVQK2X6FLsNlzanIpaWg07OASuFC8yVoMCMIf/UvjQ+SPpSMW+g2NTkc=
X-Received: by 2002:a0d:c6c1:: with SMTP id i184mr616553ywd.389.1579836929284;
 Thu, 23 Jan 2020 19:35:29 -0800 (PST)
Date:   Thu, 23 Jan 2020 19:34:29 -0800
In-Reply-To: <20200124033436.81097-1-emilyshaffer@google.com>
Message-Id: <20200124033436.81097-9-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200124033436.81097-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v5 08/15] bugreport: include user interactive shell
From:   emilyshaffer@google.com
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

It's possible a user may complain about the way that Git interacts with
their interactive shell, e.g. autocompletion or shell prompt. In that
case, it's useful for us to know which shell they're using
interactively.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 bugreport.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/bugreport.c b/bugreport.c
index 73f6d39517..07b84b9c94 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -22,6 +22,7 @@ static void get_system_info(struct strbuf *sys_info)
 {
 	struct strbuf version_info = STRBUF_INIT;
 	struct utsname uname_info;
+	char *shell = NULL;
 
 	/* get git version from native cmd */
 	strbuf_addstr(sys_info, "git version:\n");
@@ -44,6 +45,10 @@ static void get_system_info(struct strbuf *sys_info)
 	get_compiler_info(sys_info);
 	strbuf_complete_line(sys_info);
 
+	shell = getenv("SHELL");
+	strbuf_addf(sys_info, "$SHELL (typically, interactive shell): %s\n",
+		    shell ? shell : "(NULL)");
+
 	strbuf_addstr(sys_info, "git-remote-https --build-info:\n");
 	get_curl_version_info(sys_info);
 	strbuf_complete_line(sys_info);
-- 
2.25.0.341.g760bfbb309-goog

