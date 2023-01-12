Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3677AC46467
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 02:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbjALCtJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 21:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235815AbjALCs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 21:48:26 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5DC30569
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 18:48:25 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id c8-20020a17090a4d0800b00225c3614161so22101094pjg.5
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 18:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrHj+aZkRkfu1Vjq2pC6gNhSRlEtYlL1xcOABSlVpB0=;
        b=fMdtEfnLiPHN40RdnPF4v9GvqIpduRPmqTytdDKqcSW0SHQR64FHVGuRy8GAsRC7g6
         rQmIjGvCo8ZnaIxfWfmTU9jwQmP5le6q8pniUgy3WYUDkbI4jnFc/B0p7gFkPbxCSKHP
         7uqyu35XZv3kjkqVBttWh5J4hg1BIzHg92lMxEMED0xvLY5sZcPzXtoE9gc4q8hgL+36
         9PahnYtigJG1T0u6KE21BOvnXwDzNRZ6gla4W1DWZ5AHFzVbKpHFrcfUt4Qa5iLneEP/
         t5HvFf9bSlPJVmBG2BmW0IWUKjmOMAMtDQS26VtYfgMViYlrnAkG2nYbhC0c5XEKWsdv
         +NKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SrHj+aZkRkfu1Vjq2pC6gNhSRlEtYlL1xcOABSlVpB0=;
        b=MPjTacVglsAIx0fBlsEnNv3B58cN+Coe5IbqQkQFwnro1/a8YtGWMn9HK62lSgZgVz
         fVnk+/udQTGA7wo1313F5aeZVF7J1Sd45Qdk7BBDyaIXbjor3oOZ423I4sZsTVaEKREy
         fVYeZmEThOP8BQ4TCdi3hYMYXgWlZx0Wt72TsjPATkO4D/hHW/NH12nLZEfdBmdAblCZ
         orTbtwHVhX0mJjCLOrBODWbwPbaijaBbS88aU+Zygvi6JfQe5rpf3CWavRbcijl3Mh6E
         xydUNXfyDD9IC3VS4NExMvWtnbpZE/P0zL8uPTaGfAVKsqyG1l1dabSnynj3zhoDmerl
         EB/g==
X-Gm-Message-State: AFqh2kpWXGEUd3PrTZ6brKPa68VgomGTqop2YF1SbO6nXpkYBcbE7r6O
        nC8ijxNOoJF5KU90NgKAMNk=
X-Google-Smtp-Source: AMrXdXs8Vce86OnwnN7pxow/Gyo7nNsrZP6It9H0i/gsLyWz+f7epUpOTGUOI++VqAT37Um2R4odMQ==
X-Received: by 2002:a17:902:9a0b:b0:185:441f:709c with SMTP id v11-20020a1709029a0b00b00185441f709cmr82041453plp.33.1673491704793;
        Wed, 11 Jan 2023 18:48:24 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.48])
        by smtp.gmail.com with ESMTPSA id u9-20020a170903124900b001926392adf9sm10855227plh.271.2023.01.11.18.48.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jan 2023 18:48:24 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, tenglong.tl@alibaba-inc.com,
        sunshine@sunshineco.com
Subject: [PATCH v4 3/5] notes.c: drop unreachable code in 'append_edit()'
Date:   Thu, 12 Jan 2023 10:48:07 +0800
Message-Id: <7b756b4c605e148f6938fee74882091661382173.1673490953.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.386.g6952793f2d9.dirty
In-Reply-To: <cover.1673490953.git.dyroneteng@gmail.com>
References: <cover.1673490953.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Situation of note "removing" shouldn't happen in 'append_edit()',
unless it's a bug. So, let's drop the unreachable "else" code
in "append_edit()".

The notes operation "append" is different with "add", the latter
supports to overwrite the existing note then let the "removing"
happen (e.g. execute `git notes add -f -F /dev/null` on an existing
note), but the former will not because it only does "appends" but
not doing "overwrites".

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/notes.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 8ca55ec83e..b71a81bff1 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -630,13 +630,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		if (add_note(t, &object, &new_note, combine_notes_overwrite))
 			BUG("combine_notes_overwrite failed");
 		logmsg = xstrfmt("Notes added by 'git notes %s'", argv[0]);
-	} else {
-		fprintf(stderr, _("Removing note for object %s\n"),
-			oid_to_hex(&object));
-		remove_note(t, object.hash);
-		logmsg = xstrfmt("Notes removed by 'git notes %s'", argv[0]);
+		commit_notes(the_repository, t, logmsg);
 	}
-	commit_notes(the_repository, t, logmsg);
 
 	free(logmsg);
 	free_note_data(&d);
-- 
2.38.1.386.g6952793f2d9.dirty

