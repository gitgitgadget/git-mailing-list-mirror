Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474DA14A94
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdg9KXf3"
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D870430C2
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 05:27:52 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4083cd3917eso22983575e9.3
        for <git@vger.kernel.org>; Sat, 11 Nov 2023 05:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699709271; x=1700314071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRanAjX2iMvnIwX1Ii11jsfsHrE5JY6lU/9F/mBEydA=;
        b=fdg9KXf3ro2YhEdYrL93zXqHEOGEyORk2ATVfBHQUh7pzu8Id7MqzbxL57cFtIPCxe
         cJkE+Oiz0UHizBu7iwL0kyBfMvkvUcn6rs7mxxcLkFNTTezkfqhUkBakun/PI1W5JhV3
         kDPWEORPX8QTRARh6kVvDOsbwi3ZOaUPMoD5H/xjCGQAkbjoWItchtefFlexg3fwjZu9
         7d6IiTSPZyOwKR3oMlnouUO7NOWh/bky6+fLTr6+7/+eW/sC/phJiTRC3/q4joB3HmGV
         /rbsZH6vMzGBzAI9JIlw2wwv7x2dXCYdLI+xe1+inN2JmY9LQXUIg729dvoygDu/s0Hm
         4rPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699709271; x=1700314071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRanAjX2iMvnIwX1Ii11jsfsHrE5JY6lU/9F/mBEydA=;
        b=AdwxuP64nQj/kyB718ivk4b/ezByfhlh8ryJ2HsKtN1p2WPTl9fI5otEfRv0Etw85E
         uwcVkOeqNTV/xglTAe8PAROVoYXElMHiFbXNnk3Yy7dN6L4Ryhagn33Y4E0uWhWAbCSm
         8B90vD7rsizXhULqzeHPRGglXvu8BDg9xpqlqKWvJ1aYTStD0IA+AwS6q4E9Rl+PU6d+
         4Yk7xZsA+S1RkfSXlFreKkB+YRE81cgkCvIpTTibgjPQ39yzEeTooHSYyovYTCo3Atcs
         v4j31ISmd9V4kCUBMoMwl/kTOXMMUt0443Ypyc2d5u+2KpIyAf2uPfIxLS9dabf+YgX3
         6QWA==
X-Gm-Message-State: AOJu0Yzaej5jt7lo6GkV8TkwSTyWM3yGQXRw4zn8Hn/YXgAHzzhNuhBF
	OOsTrF5sHnCQg6eUmeVQAFzi3HvLpqEZgg==
X-Google-Smtp-Source: AGHT+IEVAzsHs3Zvx9ZP7Y5RGSJQ3OJWFKVF8uxtC1Jz1tIma5SM5w1+Owa1gZpd5zFkFVW2etJSfA==
X-Received: by 2002:a5d:5445:0:b0:32d:8094:f4c8 with SMTP id w5-20020a5d5445000000b0032d8094f4c8mr1503498wrv.19.1699709271247;
        Sat, 11 Nov 2023 05:27:51 -0800 (PST)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id h4-20020adff4c4000000b0031ad5fb5a0fsm1467102wrp.58.2023.11.11.05.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 05:27:50 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	newren@gmail.com,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v4 2/4] rebase: support --autosquash without -i
Date: Sat, 11 Nov 2023 13:27:16 +0000
Message-ID: <20231111132720.78877-3-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.43.0-rc1
In-Reply-To: <20231111132720.78877-1-andy.koppe@gmail.com>
References: <20231105000808.10171-1-andy.koppe@gmail.com>
 <20231111132720.78877-1-andy.koppe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The --autosquash option prevents preemptive fast-forwarding and triggers
conflicts with amend backend options, yet it only actually performs
auto-squashing when combined with the --interactive (or -i) option.

Remove the latter restriction and tweak the --autosquash description
accordingly.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Documentation/git-rebase.txt | 2 +-
 builtin/rebase.c             | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index b4526ca246..10548e715c 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -592,7 +592,7 @@ See also INCOMPATIBLE OPTIONS below.
 	When the commit log message begins with "squash! ..." or "fixup! ..."
 	or "amend! ...", and there is already a commit in the todo list that
 	matches the same `...`, automatically modify the todo list of
-	`rebase -i`, so that the commit marked for squashing comes right after
+	`rebase`, so that the commit marked for squashing comes right after
 	the commit to be modified, and change the action of the moved commit
 	from `pick` to `squash` or `fixup` or `fixup -C` respectively. A commit
 	matches the `...` if the commit subject matches, or if the `...` refers
diff --git a/builtin/rebase.c b/builtin/rebase.c
index a73de7892b..9f8192e0a5 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -710,10 +710,8 @@ static int run_specific_rebase(struct rebase_options *opts)
 	if (opts->type == REBASE_MERGE) {
 		/* Run sequencer-based rebase */
 		setenv("GIT_CHERRY_PICK_HELP", resolvemsg, 1);
-		if (!(opts->flags & REBASE_INTERACTIVE_EXPLICIT)) {
+		if (!(opts->flags & REBASE_INTERACTIVE_EXPLICIT))
 			setenv("GIT_SEQUENCE_EDITOR", ":", 1);
-			opts->autosquash = 0;
-		}
 		if (opts->gpg_sign_opt) {
 			/* remove the leading "-S" */
 			char *tmp = xstrdup(opts->gpg_sign_opt + 2);
-- 
2.43.0-rc1

