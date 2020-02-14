Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EAEC352A3
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 01:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1971B2187F
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 01:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aWOUcAAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgBNByG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 20:54:06 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:41235 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbgBNByF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 20:54:05 -0500
Received: by mail-pf1-f202.google.com with SMTP id e16so4978955pff.8
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 17:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gQ3tMQClfO9NRhDHuTTv3sshyVDNk3yEHLSJCyjQC4o=;
        b=aWOUcAAv6VR08Z4mJoJaNxvnmKd91bx6AUtX28SWNXB4rCYy2CS0sEKjkFpcqfmu4F
         xp596dhQe+JB+lm1Z2E75jTy5ms7YRsCShwYPQx2HpUszGW/bo8yDIHNYZePlJ1006tM
         57yAnip+i9MaoWhEZyCeRIgcvsOxJJ3/XocpScUGgxYbvd4SSvN7QqOVHlJ2eZ/SB4tO
         Da2XIvblllhliNrRG+DzYArpvs22BsOiggGj8uSqkW2TIBcawauh9KTtDBg4KStrW/UR
         heZxIbf2zf13p4hwzsNyyZQ6m4a0cVAoN53yz0i7xGFmWiW0lbayyJlIFnv1exxZoGMg
         gktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gQ3tMQClfO9NRhDHuTTv3sshyVDNk3yEHLSJCyjQC4o=;
        b=HlMjG+fmHlGUjkjZtaNmG5k27eFE5zUsQWcKZD+kovCJHEUFewvdFXdV1NSyEI4dE6
         RXn0dNunFh/PO7bWL9z2Clw4hRZSA/LsAD2u8HXuuctBusJPtBVb+8B3cc8e7vQYpyFg
         hlEb+NmJIiQj2NL76I/hGMyzhGvE+mb/0giMJ4e4fSl7od3Lbt2dlLOEaixK4M9egygp
         4FyEYayBRkfZ7qhqOZHO9F4XBt62n7yM1c2qC3ier//d7JoWZHhsJ87TztAkAjTGlDXT
         k52TO5ikALoIYWKniVX9u2keRXOLZdgVFZlnLRi11y15k2uymf9hPy6RcNwiMngKiPhJ
         yskw==
X-Gm-Message-State: APjAAAViFLONgSxyQHkJ/aZ7CbBqCsA+7hv2FZzIkApCI9L44KsvF0co
        m0meSmep7dL7QdT+TJmD+36M3+yztt/ZbykwBQtoueWSYcP+YghCo5wzMw8uPi/Tpfe/DY6qwRi
        Jp3MJ1Ln94TccQsB0o65j5xkI1aZYd28W3uKHrWYKDppSlXwZpnotxi+qJjoPBZBoXneELTFQPQ
        ==
X-Google-Smtp-Source: APXvYqxy/aJXOiHVj/1V1o7CVkwP+u3j/AE8qXq+3ALN4+pAcE4DVcT4zAUZCqUw0MaWwO1hnaKRThy3M80xTHAq4lA=
X-Received: by 2002:a63:66c6:: with SMTP id a189mr779748pgc.401.1581645243781;
 Thu, 13 Feb 2020 17:54:03 -0800 (PST)
Date:   Thu, 13 Feb 2020 17:53:33 -0800
In-Reply-To: <20200214015343.201946-1-emilyshaffer@google.com>
Message-Id: <20200214015343.201946-6-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200214015343.201946-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v7 05/15] bugreport: add uname info
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The contents of uname() can give us some insight into what sort of
system the user is running on, and help us replicate their setup if need
be. The domainname field is not guaranteed to be available, so don't
collect it.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/git-bugreport.txt |  1 +
 bugreport.c                     | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index 6ce2ae2eff..4dd72c60f5 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -26,6 +26,7 @@ The following information is requested from the user:
 The following information is captured automatically:
 
  - 'git version --build-options'
+ - uname sysname, release, version, and machine strings
 
 OPTIONS
 -------
diff --git a/bugreport.c b/bugreport.c
index b7504fe322..b76a1dfb2a 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -7,10 +7,23 @@
 
 static void get_system_info(struct strbuf *sys_info)
 {
+	struct utsname uname_info;
+
 	/* get git version from native cmd */
 	strbuf_addstr(sys_info, "git version:\n");
 	get_version_info(sys_info, 1);
 	strbuf_complete_line(sys_info);
+
+	/* system call for other version info */
+	strbuf_addstr(sys_info, "uname -a: ");
+	if (uname(&uname_info))
+		strbuf_addf(sys_info, "uname() failed with code %d\n", errno);
+	else
+		strbuf_addf(sys_info, "%s %s %s %s\n",
+			    uname_info.sysname,
+			    uname_info.release,
+			    uname_info.version,
+			    uname_info.machine);
 }
 
 static const char * const bugreport_usage[] = {
-- 
2.25.0.265.gbab2e86ba0-goog

