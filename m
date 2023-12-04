Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZy2LHdF"
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D94E6
	for <git@vger.kernel.org>; Mon,  4 Dec 2023 07:38:00 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id a640c23a62f3a-a1a58fbe5e1so276462266b.2
        for <git@vger.kernel.org>; Mon, 04 Dec 2023 07:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701704279; x=1702309079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jebEjCkqDx0npI6CyhFW+KXav1iFRUJHu0NAv5Sw99c=;
        b=RZy2LHdFlMFNFzzPS0bD9gR3jBxJh7fY9FSsOBov1sndzhf8uOZPPpzvsLcbVfSQOH
         bQL3yiG8g05d6MFIcV1Z4RF9N0q4QaNbFt2le+T0DQgJ/CYHycVI2eSIDiZf6KTMkNP5
         vbGYW3hz4Wro/hzqUe5Q9xyEHndAvMEmzL2LcT8Vtmq+Q0BG91Jfi0wM4TD6a7XzMeA3
         h5+qBkLae+N7C1Wm9GgG0+NiZdJgWNE3LxGIJSHjpSaQfSYlUIII74OZCe+eJ+bMNora
         ZmAqLbjg+3ZoIAdGsL+cqx+kSoLDR59LtQxI4+Qoa6o7k3WYL2MFYXtK7b+bWeJhVMAN
         L/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701704279; x=1702309079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jebEjCkqDx0npI6CyhFW+KXav1iFRUJHu0NAv5Sw99c=;
        b=CoLlU7jJUo5H82HveSUtuQQxXbHTDv+2wvWiJ0jQMsI4e+WfX9a045WP95HCjxT//K
         bgh1b1IIWRETPZo4yZKnTbPhUVbGCfdX2AdQzb/ME5pcU8RBxMCiawglok2mO9of31sZ
         hQ1fem8vLIBYh/COUAobukvSgUegNaWvVgftxt3owVI9auk6a+wEwZvTp/Faldtziza/
         wXuU2HuYrAiECQXiDph1RJVSkIWRDQFE4e6zdgrDTFVSSOn/DCY161D1fUTcKKfZp3Mx
         cixsjCKGV4GBquhYg8wguA+TuyOVs56vwhOYU2PaDAavS9qd3qsG7fD2ZIJvzbelE2MO
         w8lg==
X-Gm-Message-State: AOJu0YxiDEaCaD5fvDLbHJ1ZcO2XF9CqGsZ9P8ZO6ZL+cpXnpPNY1vb9
	M1l5YZAl+DhOESs0Z9LQlaGzCrGGEGB+Uw==
X-Google-Smtp-Source: AGHT+IFnJDxZrHeOdfat9O8+x+NHvWpyYqr48JyFvoFYk7GIOUGRfOJx8TzLJ/dzCTXWCXhxsH0jwg==
X-Received: by 2002:a17:906:2c6:b0:a1b:d9d4:26db with SMTP id 6-20020a17090602c600b00a1bd9d426dbmr165384ejk.124.1701704278609;
        Mon, 04 Dec 2023 07:37:58 -0800 (PST)
Received: from localhost.localdomain ([41.202.207.147])
        by smtp.gmail.com with ESMTPSA id se26-20020a170906ce5a00b009fea232316bsm5367281ejb.193.2023.12.04.07.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 07:37:58 -0800 (PST)
From: Achu Luma <ach.lumap@gmail.com>
To: christian.couder@gmail.com
Cc: ach.lumap@gmail.com,
	git@vger.kernel.org
Subject: [Outreachy][PATCH v3] t2400: avoid using pipes
Date: Mon,  4 Dec 2023 16:37:40 +0100
Message-ID: <20231204153740.2992-1-ach.lumap@gmail.com>
X-Mailer: git-send-email 2.42.0.windows.2
In-Reply-To: <CAP8UFD0KDdwoJw6AzLUpqos=bLumcmDax59_MfQ9TUFqmmpcoA@mail.gmail.com>
References: <CAP8UFD0KDdwoJw6AzLUpqos=bLumcmDax59_MfQ9TUFqmmpcoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The exit code of the preceding command in a pipe is disregarded,
so it's advisable to refrain from relying on it. Instead, by
saving the output of a Git command to a file, we gain the
ability to examine the exit codes of both commands separately.

Signed-off-by: Achu Luma <ach.lumap@gmail.com>
---
 Since v2 I don't send a cover  letter anymore, and I changed 
 my "Signed-of-by: ..." line so that it
 contains my full real name and I added "Outreachy" to the subject.

 t/t2400-worktree-add.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index df4aff7825..7ead05bb98 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -468,7 +468,8 @@ test_expect_success 'put a worktree under rebase' '
 		cd under-rebase &&
 		set_fake_editor &&
 		FAKE_LINES="edit 1" git rebase -i HEAD^ &&
-		git worktree list | grep "under-rebase.*detached HEAD"
+		git worktree list >actual && 
+		grep "under-rebase.*detached HEAD" actual
 	)
 '
 
@@ -509,7 +510,8 @@ test_expect_success 'checkout a branch under bisect' '
 		git bisect start &&
 		git bisect bad &&
 		git bisect good HEAD~2 &&
-		git worktree list | grep "under-bisect.*detached HEAD" &&
+		git worktree list >actual && 
+		grep "under-bisect.*detached HEAD" actual &&
 		test_must_fail git worktree add new-bisect under-bisect &&
 		! test -d new-bisect
 	)
-- 
2.41.0.windows.1

