Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386E6C433F5
	for <git@archiver.kernel.org>; Mon,  2 May 2022 18:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiEBSnD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 14:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386935AbiEBSnB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 14:43:01 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB5BA1BE
        for <git@vger.kernel.org>; Mon,  2 May 2022 11:39:29 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-e5ca5c580fso15094701fac.3
        for <git@vger.kernel.org>; Mon, 02 May 2022 11:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jVMdQFFlRoiezuCxSsbkmLxH4dHp3GXptfNQT8BDkck=;
        b=PcNHkGCI3LPulGn2N2+nDekmnP0/yp5Dk1Cgvf1qXIBSplbaFr5wPh/rUNa+wSKNEB
         KMUav/cQf5AbqsQwc+a8VxhgUrS/07Or87hO8WVJS8BGlBx9jlNcPeMjYGa8f9L+sXc9
         Zgep4m5wVND3WMCSeZVseapAvxQhvFY4PBXUtK+ZKWzy13Algz7dco5ehWyjKRalAa8p
         /p/QG+j/JTbtZk6v7f7JNcQgxma+AZONGphZmihmeFroW8OUhzcfyTY3OsdHVftV9Ufv
         W8oqVkWbAnR4oX1F9TgTl6dRZk9KTbPo7qv5vyk+K41zWchAmCE50Df3rcUhHOI1wT8s
         qy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jVMdQFFlRoiezuCxSsbkmLxH4dHp3GXptfNQT8BDkck=;
        b=l9z+EchgNdGseJ1arMnLJF7vGNOo/uuBhrTkNJTodZugvJdgzVS+qpXXbbtmNa112k
         jtxICpd8XEyuIwdvsq72dwO5lcH8EkRg+bHpAXQvw8c0jFhW9w0GHsBspUVz0wNbJS6f
         pS9m96TYgRej4OE8SGPL5F/vXDR9boSGwvi9jphear6S1MrYmF9NjxyCfeo4Upq/znyt
         xp+qKEOl+Fde5kZXOgAX6wqEh1m0hcNyVE2ri3dtrifEabVTtdiFY8HJUhYd5HTibHod
         ZuOWZSO/sOZu0I64FjKe3Rt+m042qqfIaxDiDaAUjBdpEKpvUC7Zv/2+Wt33JH/pj8rB
         OaOw==
X-Gm-Message-State: AOAM530hEEpQ6+L5qe9r1SgbAVng35SlcpfF2B6vEBBBh68nhtv8nmEx
        1QfwD+OCkaX6LhboNmso2UaFUw1E4GQ=
X-Google-Smtp-Source: ABdhPJz32LEsVZq0XewFt5hiAHsXB6PQ4KPulbCzkGcXek5OfebuM21PtkFo2y6t6UJsOe+NXAdp8A==
X-Received: by 2002:a05:6870:5707:b0:de:2cb8:7759 with SMTP id k7-20020a056870570700b000de2cb87759mr254824oap.20.1651516768108;
        Mon, 02 May 2022 11:39:28 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id a12-20020a056808120c00b00325cda1ff8fsm2620952oil.14.2022.05.02.11.39.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 May 2022 11:39:27 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, bagasdotme@gmail.com, phillip.wood123@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [RFC PATCH v3 0/3] fix `sudo make install` regression in maint
Date:   Mon,  2 May 2022 11:39:17 -0700
Message-Id: <20220502183920.88982-1-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.352.g0cd7feaf86f
In-Reply-To: <20220428105852.94449-1-carenas@gmail.com>
References: <20220428105852.94449-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A more involved refactoring, but mainly for the benefit of long term
maintanability, by making the code and documentation changes together
and splitting the tests into pre/post sections, which should hopefully
also make all deficiences of the approach taken clear but still be
useful enough to support the current usecases and allow for future
extensions.

Carlo Marcelo Arenas Belón (3):
  t: document regression git safe.directory when using sudo
  git-compat-util: avoid failing dir ownership checks if running
    privileged
  t0034: enhance framework to allow testing more commands under sudo

 Documentation/config/safe.txt  |   9 +++
 git-compat-util.h              |  40 ++++++++++++-
 t/lib-sudo.sh                  |  31 ++++++++++
 t/t0034-root-safe-directory.sh | 100 +++++++++++++++++++++++++++++++++
 4 files changed, 179 insertions(+), 1 deletion(-)
 create mode 100644 t/lib-sudo.sh
 create mode 100755 t/t0034-root-safe-directory.sh

A range-diff from the previous version (in case someone finds it
useful) shown below:

-:  ----------- > 1:  51d0d485b5f t: document regression git safe.directory when using sudo
1:  b0436d4a50a ! 2:  4928ad698e2 git-compat-util: avoid failing dir ownership checks if running privileged
    @@ Commit message
         those tools create to keep track of the original user id, and do the
         ownership check using that instead.
     
    -    This assumes the environment the user is running with after going
    -    privileged can't be tampered with, and also does the check only for
    -    root to keep the most common case less complicated, but as a side effect
    -    will miss cases where sudo (or an equivalent) was used to change to
    -    another unprivileged user or where the equivalent tool used to raise
    +    This assumes the environment the user is running on after going
    +    privileged can't be tampered with, and also adds code to restrict that
    +    the new behavior only applies if running as root, therefore keeping the
    +    most common case, which runs unprivileged, from changing, but because of
    +    that, it will miss cases where sudo (or an equivalent) was used to change
    +    to another unprivileged user or where the equivalent tool used to raise
         privileges didn't track the original id in a sudo compatible way.
     
         Reported-by: Guy Maurel <guy.j@maurel.de>
    @@ Commit message
         Helped-by: Phillip Wood <phillip.wood123@gmail.com>
         Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
         Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +
    + ## Documentation/config/safe.txt ##
    +@@ Documentation/config/safe.txt: directory was listed in the `safe.directory` list. If `safe.directory=*`
    + is set in system config and you want to re-enable this protection, then
    + initialize your list with an empty value before listing the repositories
    + that you deem safe.
    +++
    ++When git tries to check for ownership of git repositories, it will
    ++obviously do so with the uid of the user that is running git itself,
    ++but if git is running as root, it will check first if it might have
    ++been started through `sudo`, and if that is the case, will instead
    ++use the uid of the user that did so.
    ++If that is not what you would prefer and want git to only trust
    ++repositories that are owned by root instead, then you should remove
    ++the `SUDO_UID` variable from root's environment.
     
      ## git-compat-util.h ##
     @@ git-compat-util.h: static inline int git_offset_1st_component(const char *path)
    @@ git-compat-util.h: static inline int git_offset_1st_component(const char *path)
      }
      
      #define is_path_owned_by_current_user is_path_owned_by_current_uid
    +
    + ## t/t0034-root-safe-directory.sh ##
    +@@ t/t0034-root-safe-directory.sh: test_expect_success SUDO 'setup' '
    + 	)
    + '
    + 
    +-test_expect_failure SUDO 'sudo git status as original owner' '
    ++test_expect_success SUDO 'sudo git status as original owner' '
    + 	(
    + 		cd root/r &&
    + 		git status &&
2:  d05e886d394 < -:  ----------- Documentation: explain how safe.directory works when running under sudo
3:  10ec03d71e4 < -:  ----------- t: add tests for safe.directory when running with sudo
-:  ----------- > 3:  98aae872efd t0034: enhance framework to allow testing more commands under sudo

-- 
2.36.0.352.g0cd7feaf86f

