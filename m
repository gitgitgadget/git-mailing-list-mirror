Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EFFC432BE
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 19:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0BAF60BD3
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 19:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhG1Tg4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 15:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhG1Tgy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 15:36:54 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0ADC061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 12:36:51 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n11so2160000wmd.2
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 12:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lqbSXX8jpTPtZhYmCWc8M3GgipL/aUuCy5pf1+6Eg9Y=;
        b=GtEa2JskS4fWVkqLHBwgNNJcvbJEbTD+Ie78tUXUjcX8QX4NCaFzQAT8MZaGanxL8I
         7iIATVTN+NZ08DaP1TPzpHFifBJ73s3gCx/YJRuoEe2yBMoF746DxPDMMIPzjh6HKGIt
         OeHSU9BxRJSvX4dwpKib8ip1QbC6CowJqpjwqpUCEb5cSz9ST3KSAU4WOfkSCIueSNkZ
         NPwxt/i+pATjSIZ18DNn1kJtgl8ZdomlfYobWbP3wh4NuMAFCLZTH68IZnhq1U/rycrC
         wOLb5x2t1wU5Y7amC9345/ocZBXR0HWhhBr5F/NXDDLkSWzPJXJgHkIkrjIC8Kf5pfw+
         YLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lqbSXX8jpTPtZhYmCWc8M3GgipL/aUuCy5pf1+6Eg9Y=;
        b=UfumAavkYwpU8eBEfBh9JPBMVfYbBpF540SBm2DzcGeE10A5BRY4WU5L3JFdAJ78qy
         /F0ix6aGcAUU+g6SiUJAVs5TEHyFg3fl9TYjIzZYik7C8mvU3RD3sCnJwJh22giO5KpY
         OnoV3pi4sJZf8BnZhcdEoRneqkFMJN9FmCoiIn8e43dq6Fw1cy0/24oJPoILiD3gUk9u
         Bmajl9W7ewjSHyJ77Ax6D9atok8xxynXjdus1cLJ6JEo5Nbn3PwvhhK07M3Y1JUSlo7o
         DoC0jzec/1KjNaQfaPADpY4j+xbpjO0OX4rtJdI0S5tpVZpUTcAifKYvuAdJJK4hi0BW
         JiXg==
X-Gm-Message-State: AOAM530wUukExsWj/2DcNEwAHrMab7Knp1AOly+EfajG2N54TDIUS0Ff
        ghqxHzubBmzgznutZ3zepSc4UO+5m04=
X-Google-Smtp-Source: ABdhPJxTlYGSM8ZtJyFlyoHaBWE/Ijgx6dlNjFZpXaHM3f13fKZB4LB6+240aw+24Q/aRAkZ3oCkSA==
X-Received: by 2002:a05:600c:35c1:: with SMTP id r1mr1219420wmq.0.1627501010531;
        Wed, 28 Jul 2021 12:36:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q14sm762529wrs.8.2021.07.28.12.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 12:36:49 -0700 (PDT)
Message-Id: <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v5.git.git.1627391744.gitgitgadget@gmail.com>
References: <pull.1041.v5.git.git.1627391744.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 28 Jul 2021 19:36:40 +0000
Subject: [PATCH v6 0/9] ssh signing: Add commit & tag signing/verification via SSH keys using
 ssh-keygen
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
        Fabian Stelzer <fs@gigacodes.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have added support for using keyfiles directly, lots of tests and
generally cleaned up the signing & verification code a lot.

I can still rename things from being gpg specific to a more general
"signing" but thats rather cosmetic. Also i'm not sure if i named the new
test files correctly.

openssh 8.7 will add valid-after, valid-before options to the allowed keys
keyring. This allows us to pass the commit timestamp to the verification
call and make key rollover possible and still be able to verify older
commits. Set valid-after=NOW when adding your key to the keyring and set
valid-before to make it fail if used after a certain date. Software like
gitolite/github or corporate automation can do this automatically when ssh
push keys are addded / removed I will add this feature in a follow up patch
afterwards.

v3 addresses some issues & refactoring and splits the large commit into
several smaller ones.

v4:

 * restructures and cleans up the whole patch set - patches build on its own
   now and commit messages try to explain whats going on
 * got rid of the if branches and used callback functions in the format
   struct
 * fixed a bug with whitespace in principal identifiers that required a
   rewrite of the parse_ssh_output function
 * rewrote documentation to be more clear - also renamed keyring back to
   allowedSignersFile

v5:

 * moved t7527 to t7528 to not collide with another patch in "seen"
 * clean up return logic for failed signing & verification
 * some minor renames / reformatting to make things clearer

v6: fixed tests when using shm output dir

Fabian Stelzer (9):
  ssh signing: preliminary refactoring and clean-up
  ssh signing: add ssh signature format and signing using ssh keys
  ssh signing: retrieve a default key from ssh-agent
  ssh signing: provide a textual representation of the signing key
  ssh signing: parse ssh-keygen output and verify signatures
  ssh signing: add test prereqs
  ssh signing: duplicate t7510 tests for commits
  ssh signing: add more tests for logs, tags & push certs
  ssh signing: add documentation

 Documentation/config/gpg.txt     |  39 ++-
 Documentation/config/user.txt    |   6 +
 builtin/receive-pack.c           |   2 +
 fmt-merge-msg.c                  |   6 +-
 gpg-interface.c                  | 490 +++++++++++++++++++++++++++----
 gpg-interface.h                  |   8 +-
 log-tree.c                       |   8 +-
 pretty.c                         |   4 +-
 send-pack.c                      |   8 +-
 t/lib-gpg.sh                     |  29 ++
 t/t4202-log.sh                   |  23 ++
 t/t5534-push-signed.sh           | 101 +++++++
 t/t7031-verify-tag-signed-ssh.sh | 161 ++++++++++
 t/t7528-signed-commit-ssh.sh     | 398 +++++++++++++++++++++++++
 14 files changed, 1218 insertions(+), 65 deletions(-)
 create mode 100755 t/t7031-verify-tag-signed-ssh.sh
 create mode 100755 t/t7528-signed-commit-ssh.sh


base-commit: eb27b338a3e71c7c4079fbac8aeae3f8fbb5c687
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1041%2FFStelzer%2Fsshsign-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1041/FStelzer/sshsign-v6
Pull-Request: https://github.com/git/git/pull/1041

Range-diff vs v5:

  1:  7c8502c65b8 =  1:  7c8502c65b8 ssh signing: preliminary refactoring and clean-up
  2:  f05bab16096 =  2:  f05bab16096 ssh signing: add ssh signature format and signing using ssh keys
  3:  071e6173d8e =  3:  071e6173d8e ssh signing: retrieve a default key from ssh-agent
  4:  7d1d131ff5b =  4:  7d1d131ff5b ssh signing: provide a textual representation of the signing key
  5:  725764018ce =  5:  725764018ce ssh signing: parse ssh-keygen output and verify signatures
  6:  eb677b1b6a8 !  6:  18a26ca49e7 ssh signing: add test prereqs
     @@ t/lib-gpg.sh: test_lazy_prereq RFC1991 '
      +	test $? = 0 || exit 1;
      +	mkdir -p "${GNUPGHOME}" &&
      +	chmod 0700 "${GNUPGHOME}" &&
     -+	ssh-keygen -t ed25519 -N "" -f "${GNUPGHOME}/ed25519_ssh_signing_key" >/dev/null &&
     -+	ssh-keygen -t rsa -b 2048 -N "" -f "${GNUPGHOME}/rsa_2048_ssh_signing_key" >/dev/null &&
     -+	ssh-keygen -t ed25519 -N "super_secret" -f "${GNUPGHOME}/protected_ssh_signing_key" >/dev/null &&
     -+	find "${GNUPGHOME}" -name *ssh_signing_key.pub -exec cat {} \; | awk "{print \"\\\"principal with number \" NR \"\\\" \" \$0}" > "${GNUPGHOME}/ssh.all_valid.allowedSignersFile" &&
     ++	ssh-keygen -t ed25519 -N "" -C "git ed25519 key" -f "${GNUPGHOME}/ed25519_ssh_signing_key" >/dev/null &&
     ++	echo "\"principal with number 1\" $(cat "${GNUPGHOME}/ed25519_ssh_signing_key.pub")" >> "${GNUPGHOME}/ssh.all_valid.allowedSignersFile" &&
     ++	ssh-keygen -t rsa -b 2048 -N "" -C "git rsa2048 key" -f "${GNUPGHOME}/rsa_2048_ssh_signing_key" >/dev/null &&
     ++	echo "\"principal with number 2\" $(cat "${GNUPGHOME}/rsa_2048_ssh_signing_key.pub")" >> "${GNUPGHOME}/ssh.all_valid.allowedSignersFile" &&
     ++	ssh-keygen -t ed25519 -N "super_secret" -C "git ed25519 encrypted key" -f "${GNUPGHOME}/protected_ssh_signing_key" >/dev/null &&
     ++	echo "\"principal with number 3\" $(cat "${GNUPGHOME}/protected_ssh_signing_key.pub")" >> "${GNUPGHOME}/ssh.all_valid.allowedSignersFile" &&
      +	cat "${GNUPGHOME}/ssh.all_valid.allowedSignersFile" &&
      +	ssh-keygen -t ed25519 -N "" -f "${GNUPGHOME}/untrusted_ssh_signing_key" >/dev/null
      +'
  7:  c877951df23 =  7:  01da9a07934 ssh signing: duplicate t7510 tests for commits
  8:  60265e8c399 =  8:  d9707443f5c ssh signing: add more tests for logs, tags & push certs
  9:  f758ce0ade4 =  9:  275af516eba ssh signing: add documentation

-- 
gitgitgadget
