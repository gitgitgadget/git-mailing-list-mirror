Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EC3C433F5
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 08:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20CD7611C3
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 08:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbhISIss (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 04:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhISIsr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 04:48:47 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF5FC061574
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 01:47:22 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t18so23015805wrb.0
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 01:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oOma3SSITQe7zXD1ysyByPiRKl9kWEhgDPwGwachduo=;
        b=IlLt49Zy4AZetiSUPLY6M3dmLfnPspVLY6DiJXryI6bx5DI73pHZd7MaiUyMWe5H9Y
         HiUrnF4u5b3Qeb7o44fk+RjDorIITzRX3PwVVKMQsSUsj6yWPEhjvruMQHw3L76A5zMn
         AQIacMWvucHSHCIdVf81XF4y3N9oHuTKF43wHs5s6LTBdBEZ3wvueFaP/M2Pb67j3Z6+
         vWPU3cRjylc9JBFRV/VtY7iDkRHrTaFGzVXWc5366WLqiuR9JTwQkDUm/AUEF+JzHzID
         H6PrQC32e2R5r4Kxd/q+Ivx5QvmNBf2R/HWUvtZULNHD66ZYGVDv403q85GkvhkFHDlz
         kqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oOma3SSITQe7zXD1ysyByPiRKl9kWEhgDPwGwachduo=;
        b=DIBlAGQI7QrKkANvLxTDCjhsUL0H2IQhesVq+twiA22XEyH5jL/MAmeiTasLM19Y8l
         1BmjJ1rL9+pllX76Q0KJM3SUWc6cUebXq1bRSsX0aJB40j5qzV5IhSx571zMh6PUTfxK
         mQk7v+DG6KUSvmw1ILFyV4fq50U5UBCCwiWEZX2yMv3V0t56nNPSnehy/tYjQbHM+a/r
         GvaR9lNwxJn5i8BFzG/V1g3WAyMMMmxaK1n+4Fe2i5H8WPMj/h2KKm9cfB0E41x8lK8q
         zz1CF9slwxeWkmy6RR6qnYt0LXPASk3Hqvt7S0BY9y+DZFPo33vgQd4qWhdbnsYQbeTC
         lW8w==
X-Gm-Message-State: AOAM531C9wMddxMDWlfhWpmofbLgz/WqtEt4gDkGO4LIaJJULJizqZOd
        ev8gcjYvarEIpXjpS8wvZCWSejQ+D0aa3g==
X-Google-Smtp-Source: ABdhPJyKtrBv8xzWPQWPATCqWwD5wi54xcyxR6CiB2NSIAuK7KjN+cLvZpXYSAWSAZpx9M93xMR+GA==
X-Received: by 2002:a5d:4cc6:: with SMTP id c6mr21936999wrt.108.1632041241083;
        Sun, 19 Sep 2021 01:47:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i67sm7884497wmi.41.2021.09.19.01.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 01:47:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/5] repo-settings.c: refactor for clarity, get rid of hacks etc.
Date:   Sun, 19 Sep 2021 10:47:14 +0200
Message-Id: <cover-v3-0.5-00000000000-20210919T084703Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1092.g44c994ea1be
In-Reply-To: <cover-v2-0.5-00000000000-20210916T182918Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20210916T182918Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This simplification of repo-settings.c addresses Junio's feedback,
changes:

 * Get rid of thename=NULL checkfrom the main codepath of
   xsetenv()/xunsetenv() (but don't feed NULL to %s).
 * Expanded commit message of 2/5 to discuss the safety/desire of
   overriding GIT_CONFIG_COUNT.
 * Marked unreachable code in 3/5 (later removed in 4/5) with a BUG().
 * I kept the UNTRACKED_CACHE_KEEP value instead of
   UNTRACKED_CACHE_UNSET for indicating the default.
 * Don't add a "return" to a void function.

For v2 see: https://lore.kernel.org/git/cover-v2-0.5-00000000000-20210916T182918Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (5):
  wrapper.c: add x{un,}setenv(), and use xsetenv() in environment.c
  environment.c: remove test-specific "ignore_untracked..." variable
  read-cache & fetch-negotiator: check "enum" values in switch()
  repo-settings.c: simplify the setup
  repository.h: don't use a mix of int and bitfields

 cache.h                              |   7 --
 environment.c                        |  10 +--
 fetch-negotiator.c                   |   1 -
 git-compat-util.h                    |   2 +
 read-cache.c                         |  19 +++--
 repo-settings.c                      | 115 +++++++++++++--------------
 repository.h                         |  20 ++---
 t/helper/test-dump-untracked-cache.c |   6 +-
 wrapper.c                            |  15 ++++
 9 files changed, 101 insertions(+), 94 deletions(-)

Range-diff against v2:
1:  49706b26642 ! 1:  4b320edc933 wrapper.c: add x{un,}setenv(), and use xsetenv() in environment.c
    @@ Commit message
         the C library function signatures, including for any future code that
         expects a pointer to a setenv()-like function.
     
    +    I think it would be OK skip the NULL check of the "name" here for the
    +    calls to die_errno(). Almost all of our setenv() callers are taking a
    +    constant string hardcoded in the source as the first argument, and for
    +    the rest we can probably assume they've done the NULL check
    +    themselves. Even if they didn't, modern C libraries are forgiving
    +    about it (e.g. glibc formatting it as "(null)"), on those that aren't,
    +    well, we were about to die anyway. But let's include the check anyway
    +    for good measure.
    +
         1. https://pubs.opengroup.org/onlinepubs/009604499/functions/setenv.html
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    @@ wrapper.c: void *xcalloc(size_t nmemb, size_t size)
      
     +int xsetenv(const char *name, const char *value, int overwrite)
     +{
    -+	if (!name)
    -+		die("xsetenv() got a NULL name, setenv() would return EINVAL");
     +	if (setenv(name, value, overwrite))
    -+		die_errno("setenv(%s, '%s', %d) failed", name, value, overwrite);
    ++		die_errno("setenv(%s, '%s', %d) failed", name ? name : "(null)",
    ++			  value, overwrite);
     +	return 0;
     +}
     +
     +int xunsetenv(const char *name)
     +{
    -+	if (!name)
    -+		die("xunsetenv() got a NULL name, xunsetenv() would return EINVAL");
     +	if (!unsetenv(name))
    -+		die_errno("unsetenv(%s) failed", name);
    ++		die_errno("unsetenv(%s) failed", name ? name : "(null)");
     +	return 0;
     +}
     +
2:  57290842f0f ! 2:  ece340af764 environment.c: remove test-specific "ignore_untracked..." variable
    @@ Commit message
         t7063-status-untracked-cache.sh, but let's fail earlier anyway if that
         were to happen.
     
    +    This breaks any parent process that's potentially using the
    +    GIT_CONFIG_* and GIT_CONFIG_PARAMETERS mechanism to pass one-shot
    +    config setting down to a git subprocess, but in this case we don't
    +    care about the general case of such potential parents. This process
    +    neither spawns other "git" processes, nor is it interested in other
    +    configuration. We might want to pick up other test modes here, but
    +    those will be passed via GIT_TEST_* environment variables.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## cache.h ##
3:  9f1bb0496ed ! 3:  d837d905825 read-cache & fetch-negotiator: check "enum" values in switch()
    @@ Commit message
         case in fetch_negotiator_init() in favor of checking for
         "FETCH_NEGOTIATION_UNSET" and "FETCH_NEGOTIATION_NONE".
     
    +    As will be discussed in a subsequent we'll only ever have either of
    +    these set to FETCH_NEGOTIATION_NONE, FETCH_NEGOTIATION_UNSET and
    +    UNTRACKED_CACHE_UNSET within the prepare_repo_settings() function
    +    itself. In preparation for fixing that code let's add a BUG() here to
    +    mark this as unreachable code.
    +
         See ad0fb659993 (repo-settings: parse core.untrackedCache, 2019-08-13)
         for when the "unset" and "keep" handling for core.untrackedCache was
         consolidated, and aaf633c2ad1 (repo-settings: create
    @@ fetch-negotiator.c: void fetch_negotiator_init(struct repository *r,
      
      	case FETCH_NEGOTIATION_DEFAULT:
     -	default:
    -+	case FETCH_NEGOTIATION_UNSET:
    -+	case FETCH_NEGOTIATION_NONE:
      		default_negotiator_init(negotiator);
      		return;
    ++	case FETCH_NEGOTIATION_NONE:
    ++	case FETCH_NEGOTIATION_UNSET:
    ++		BUG("FETCH_NEGOTIATION_UNSET only in prepare_repo_settings()");
      	}
    + }
     
      ## read-cache.c ##
     @@ read-cache.c: static void tweak_untracked_cache(struct index_state *istate)
    @@ read-cache.c: static void tweak_untracked_cache(struct index_state *istate)
     +	case UNTRACKED_CACHE_WRITE:
      		add_untracked_cache(istate);
     +		break;
    -+	case UNTRACKED_CACHE_UNSET:
     +	case UNTRACKED_CACHE_KEEP:
     +		break;
    ++	case UNTRACKED_CACHE_UNSET:
    ++		BUG("UNTRACKED_CACHE_UNSET only in prepare_repo_settings()");
     +	}
    -+	return;
      }
      
      static void tweak_split_index(struct index_state *istate)
4:  b28ad2b2607 ! 4:  28286a61162 repo-settings.c: simplify the setup
    @@ Commit message
     
            In [4] the "unset" and "keep" handling for core.untrackedCache was
            consolidated. But it while we understand the "keep" value, we don't
    -       handle it differently than the case of any other unknown value. So
    -       we can remove UNTRACKED_CACHE_KEEP. It's not handled any
    -       differently than UNTRACKED_CACHE_UNSET once we get past the config
    -       parsing step.
    +       handle it differently than the case of any other unknown value.
    +
    +       So let's retain UNTRACKED_CACHE_KEEP and remove the
    +       UNTRACKED_CACHE_UNSET setting (which was always implicitly
    +       UNTRACKED_CACHE_KEEP before). We don't need to inform any code
    +       after prepare_repo_settings() that the setting was "unset", as far
    +       as anyone else is concerned it's core.untrackedCache=keep. if
    +       "core.untrackedcache" isn't present in the config.
     
          * FETCH_NEGOTIATION_UNSET & FETCH_NEGOTIATION_NONE:
     
    @@ Commit message
     
      ## fetch-negotiator.c ##
     @@ fetch-negotiator.c: void fetch_negotiator_init(struct repository *r,
    - 		return;
    - 
      	case FETCH_NEGOTIATION_DEFAULT:
    --	case FETCH_NEGOTIATION_UNSET:
    --	case FETCH_NEGOTIATION_NONE:
      		default_negotiator_init(negotiator);
      		return;
    +-	case FETCH_NEGOTIATION_NONE:
    +-	case FETCH_NEGOTIATION_UNSET:
    +-		BUG("FETCH_NEGOTIATION_UNSET only in prepare_repo_settings()");
      	}
    + }
     
      ## read-cache.c ##
     @@ read-cache.c: static void tweak_untracked_cache(struct index_state *istate)
      		add_untracked_cache(istate);
      		break;
    - 	case UNTRACKED_CACHE_UNSET:
    --	case UNTRACKED_CACHE_KEEP:
    -+		/* This includes core.untrackedCache=keep */
    + 	case UNTRACKED_CACHE_KEEP:
    ++		/*
    ++		 * Either an explicit "core.untrackedCache=keep", the
    ++		 * default if "core.untrackedCache" isn't configured,
    ++		 * or a fallback on an unknown "core.untrackedCache"
    ++		 * value.
    ++		 */
      		break;
    +-	case UNTRACKED_CACHE_UNSET:
    +-		BUG("UNTRACKED_CACHE_UNSET only in prepare_repo_settings()");
      	}
    - 	return;
    + }
    + 
     
      ## repo-settings.c ##
     @@
    @@ repo-settings.c
      	/* Defaults */
     -	memset(&r->settings, -1, sizeof(r->settings));
     +	r->settings.index_version = -1;
    -+	r->settings.core_untracked_cache = UNTRACKED_CACHE_UNSET;
    ++	r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
     +	r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
     +
     +	/* Booleans config or default, cascades to other settings */
    @@ repo-settings.c
     +		/*
     +		 * If it's set to "keep", or some other non-boolean
     +		 * value then "v < 0". Then we do nothing and keep it
    -+		 * at UNTRACKED_CACHE_UNSET.
    ++		 * at the default of UNTRACKED_CACHE_KEEP.
     +		 */
     +		if (v >= 0)
     +			r->settings.core_untracked_cache = v ?
    @@ repository.h: struct submodule_cache;
     -	UNTRACKED_CACHE_REMOVE = 0,
     -	UNTRACKED_CACHE_KEEP = 1,
     -	UNTRACKED_CACHE_WRITE = 2
    -+	UNTRACKED_CACHE_UNSET,
    ++	UNTRACKED_CACHE_KEEP,
     +	UNTRACKED_CACHE_REMOVE,
     +	UNTRACKED_CACHE_WRITE,
      };
5:  0b5f213a639 = 5:  3cc033b8864 repository.h: don't use a mix of int and bitfields
-- 
2.33.0.1092.g44c994ea1be

