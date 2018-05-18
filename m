Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E2841F51C
	for <e@80x24.org>; Fri, 18 May 2018 14:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbeEROSM (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 10:18:12 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52464 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752140AbeEROSI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 10:18:08 -0400
Received: by mail-wm0-f65.google.com with SMTP id w194-v6so14342358wmf.2
        for <git@vger.kernel.org>; Fri, 18 May 2018 07:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ww8IsRkNiM+u7B6ad2uZLf8YDeY9T4dympO60e4MrKc=;
        b=b7OOfUbiJ1+srM0ybAMOaVv9t2cKYomLDImIFa6IdtbhV9Y6ZKFzUhIZoMpWSjZEkC
         JGgxShT+uvrNLMC1otJ2r3uTTBR93qCuYCFqJVLxi3CLM+P25zsrYevLdtY1bNhHuT19
         HZrdpGcfK5rdsK6A4r8b587sbZpk6NA98AqHANJfrlWMzMKC2TMQGN5UrVHLSroUQ476
         hgWEkUBHi38iUUI87E0oF5BofDpcJnXposAnKgbAjukwjMGgCbbbSNsgOMEK0eED1GsV
         ChWEnxwD0/SfZn69MLwvy3oHGh2GtevbPkigK+ja187u0bk8Xphu5FrWPQTxKoEc0ve/
         FzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ww8IsRkNiM+u7B6ad2uZLf8YDeY9T4dympO60e4MrKc=;
        b=CtOsKPUINLDJZfpH9TU50ilu6aiS+VgNtsoBUApKE1nmCxgUyGsTw+datWgI+IdciJ
         5oY7ccYSzqntpL9QvGtKuZU/IV4FhWPNe5uWkZ3IAm/jhwO3fSwcdsj074UPhRUD3w8F
         AuqhDlC7HUDMUmd++9uggRmR98HY36rtWoN0iItm+5gYVAQimUmDdmDLL+Phk1uatkpr
         qzDVKduWkw49VdLO+0+eX/aY9IgUQMiHG8V1L6u85R5QJ23k5QxNNe3h1zva3eQhQIxc
         5vtZgHZ+nKI3H0aPfR3B701612g3ZLTVvDCon4sRj3+EMY/c/xrNVQFokQGjdg3RwdNQ
         goLQ==
X-Gm-Message-State: ALKqPweYotHEo5THfvC+KtoFLVzf5B8obmWofWkjkvT7pCGeyIcooOgW
        UB63+g1KvlBDykecs/gSO66kew==
X-Google-Smtp-Source: AB8JxZoCx/wGq3ZjGeW66cokiKAneLeUme3H9OukOhq3hGpqTrFA7ckJJDX+DSJhewTPjHKbm2NaWw==
X-Received: by 2002:a1c:e58a:: with SMTP id c132-v6mr4641593wmh.23.1526653087767;
        Fri, 18 May 2018 07:18:07 -0700 (PDT)
Received: from localhost.localdomain (x4db17294.dyn.telefonica.de. [77.177.114.148])
        by smtp.gmail.com with ESMTPSA id u37-v6sm7606937wrb.53.2018.05.18.07.18.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 May 2018 07:18:07 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Clemens Buchacher <drizzd@gmx.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Manlio Perillo <manlio.perillo@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/2] completion: don't return with error from __gitcomp_file_direct()
Date:   Fri, 18 May 2018 16:17:50 +0200
Message-Id: <20180518141751.16350-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.799.gd371044c7c
In-Reply-To: <20180518141751.16350-1-szeder.dev@gmail.com>
References: <xmqq1sf24syg.fsf@gitster-ct.c.googlers.com>
 <20180518141751.16350-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In __gitcomp_file_direct() we tell Bash that it should handle our
possible completion words as filenames with the following piece of
cleverness:

  # use a hack to enable file mode in bash < 4
  compopt -o filenames +o nospace 2>/dev/null ||
  compgen -f /non-existing-dir/ > /dev/null

Unfortunately, this makes this function always return with error
when it is not invoked in real completion, but e.g. in tests of
't9902-completion.sh':

  - First the 'compopt' line errors out
    - either because in Bash v3.x there is no such command,
    - or because in Bash v4.x it complains about "not currently
      executing completion function",

  - then 'compgen' just silently returns with error because of the
    non-existing directory.

Since __gitcomp_file_direct() is now the last command executed in
__git_complete_index_file(), that function returns with error as well,
which prevents it from being invoked in tests directly as is, and
would require extra steps in test to hide its error code.

So let's make sure that __gitcomp_file_direct() doesn't return with
error, because in the tests coming in the following patch we do want
to exercise __git_complete_index_file() directly,

__gitcomp_file() contains the same construct, and thus it, too, always
returns with error.  Update that function accordingly as well.

While at it, also remove the space from between the redirection
operator and the filename in both functions.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 816901f0f0..8bc79a5226 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -420,7 +420,8 @@ __gitcomp_file_direct ()
 
 	# use a hack to enable file mode in bash < 4
 	compopt -o filenames +o nospace 2>/dev/null ||
-	compgen -f /non-existing-dir/ > /dev/null
+	compgen -f /non-existing-dir/ >/dev/null ||
+	true
 }
 
 # Generates completion reply with compgen from newline-separated possible
@@ -442,7 +443,8 @@ __gitcomp_file ()
 
 	# use a hack to enable file mode in bash < 4
 	compopt -o filenames +o nospace 2>/dev/null ||
-	compgen -f /non-existing-dir/ > /dev/null
+	compgen -f /non-existing-dir/ >/dev/null ||
+	true
 }
 
 # Execute 'git ls-files', unless the --committable option is specified, in
-- 
2.17.0.799.gd371044c7c

