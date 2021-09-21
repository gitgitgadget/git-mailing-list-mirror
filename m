Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC46C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 13:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B463611C5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 13:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhIUNOi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 09:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhIUNOh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 09:14:37 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3D4C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 06:13:08 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t7so5796230wrw.13
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 06:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2tTOyVXgTiZEYmVZrIE8WSI8ZijWPzdp+UPmu6YrcU8=;
        b=Uq8apDCQYY6R0y2QJs3obpFCjXDd6r4TpPqFg0ge9ChkVxZzbB+7PUc4q4yUuVHXL3
         PAfAzqjWlGs5yvt3m9478uX7sVSiZo23SLHnqSF9tW8TxTVUvTHIN8dewu1A33x8Sm/U
         ZRDso8pxBvSioa4L+XRkbnPRb45B3eBFaEqpJ9t/MBH06VaY0ibur40kdbkMQiLld/Oz
         GEwP2Ew+yC+Ym6vxMka1/wa5DgTZ9KgdPGkD5ff9e4ptj3SNzNsqnSprNtjau1bXUR1d
         aDPRpiu5M6vzhJtkIZ/8g5zptFIneEqKCZq0HjVOU76fZeTmA5ULUjrkwZAAn79aBlvB
         Gzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2tTOyVXgTiZEYmVZrIE8WSI8ZijWPzdp+UPmu6YrcU8=;
        b=VBU3wcjS3SiBDerESqbKaw1iL5pgjh4i6tUsmnzGhPecL/Hh26KodvSH6fzxO1vw5k
         P88Yu7OeCb/U+1zFNaZY6O2soV/rRjY7MXkk3gXCFls9GhmN6v5SQcsvQQh7y8Wvel/E
         V88EjPPeoEFGNg7QU0n+VifSq6ZoohTojK0HsX0OxnFcN3clfEBPPJOFsoH4kVaxes9m
         1wiGdd2FeO+x5dYxrTyOMrHQknZhdpBCRkCyLV7DZHpiXfbflZ/7mSCZY4uqQqUA7+QZ
         rIxe5Z1bbGd56SHYlog7HdP21+bGckspkxXUV4AnPLHfFLz1X6bZoDsYaQeNNoe4WNsi
         RfSQ==
X-Gm-Message-State: AOAM5313mcOL21uhYcf+JThs5dbWAhPBcu5sx4vst7JkRuIPJiRATp+d
        SB0urkP25/ZXf34q2gQZlMD2UeKkSvTUSg==
X-Google-Smtp-Source: ABdhPJyQsXEdf79CMHaoT43AbgJfmZk19lsQ2Solg6K1fmoqy1z1Tw1m7drwQD59j1qyR+2rkOkQGA==
X-Received: by 2002:adf:ed92:: with SMTP id c18mr34290452wro.86.1632229986458;
        Tue, 21 Sep 2021 06:13:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v18sm2733260wml.44.2021.09.21.06.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 06:13:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/5] repo-settings.c: refactor for clarity, get rid of hacks etc.
Date:   Tue, 21 Sep 2021 15:12:58 +0200
Message-Id: <cover-v4-0.5-00000000000-20210921T131003Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.gf02a64c1a2d
In-Reply-To: <cover-v3-0.5-00000000000-20210919T084703Z-avarab@gmail.com>
References: <cover-v3-0.5-00000000000-20210919T084703Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A hopefully final re-roll addressing Taylor's v3 review, except for
the suggestion (that I read as) perhaps retaining the test-only code,
which I've decided not to do per
http://lore.kernel.org/git/87tuieakms.fsf@evledraar.gmail.com

The x(un)setenv() now returns void, and the error messages are less
chatty, I also improved a BUG() message in 4/5 that we end up deleting
in 5/5 anyway, so it doesn't matter for the end-state, just for
understanding the patches.

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
 wrapper.c                            |  12 +++
 9 files changed, 98 insertions(+), 94 deletions(-)

Range-diff against v3:
1:  4b320edc933 ! 1:  4dd317ab65e wrapper.c: add x{un,}setenv(), and use xsetenv() in environment.c
    @@ Commit message
         errno?) the worst we'll do is die with a nonsensical errno value, but
         we'll want to die in either case.
     
    -    We could make these return "void" (as far as I can tell there's no
    -    other x*() wrappers that needed to make that decision before),
    -    i.e. our "return 0" is only to indicate that we didn't error, which we
    -    would have died on. Let's return "int" instead to be consistent with
    -    the C library function signatures, including for any future code that
    -    expects a pointer to a setenv()-like function.
    +    Let's make these return "void" instead of "int". As far as I can tell
    +    there's no other x*() wrappers that needed to make the decision of
    +    deviating from the signature in the C library, but since their return
    +    value is only used to indicate errors (so we'd die here), we can catch
    +    unreachable code such as
    +
    +        if (xsetenv(...) < 0)
    +            [...];
     
         I think it would be OK skip the NULL check of the "name" here for the
         calls to die_errno(). Almost all of our setenv() callers are taking a
    @@ git-compat-util.h: void *xmemdupz(const void *data, size_t len);
      char *xstrndup(const char *str, size_t len);
      void *xrealloc(void *ptr, size_t size);
      void *xcalloc(size_t nmemb, size_t size);
    -+int xsetenv(const char *name, const char *value, int overwrite);
    -+int xunsetenv(const char *name);
    ++void xsetenv(const char *name, const char *value, int overwrite);
    ++void xunsetenv(const char *name);
      void *xmmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
      const char *mmap_os_err(void);
      void *xmmap_gently(void *start, size_t length, int prot, int flags, int fd, off_t offset);
    @@ wrapper.c: void *xcalloc(size_t nmemb, size_t size)
      	return ret;
      }
      
    -+int xsetenv(const char *name, const char *value, int overwrite)
    ++void xsetenv(const char *name, const char *value, int overwrite)
     +{
     +	if (setenv(name, value, overwrite))
    -+		die_errno("setenv(%s, '%s', %d) failed", name ? name : "(null)",
    -+			  value, overwrite);
    -+	return 0;
    ++		die_errno(_("could not setenv '%s'"), name ? name : "(null)");
     +}
     +
    -+int xunsetenv(const char *name)
    ++void xunsetenv(const char *name)
     +{
     +	if (!unsetenv(name))
    -+		die_errno("unsetenv(%s) failed", name ? name : "(null)");
    -+	return 0;
    ++		die_errno(_("could not unsetenv '%s'"), name ? name : "(null)");
     +}
     +
      /*
2:  ece340af764 = 2:  3dc37521184 environment.c: remove test-specific "ignore_untracked..." variable
3:  d837d905825 ! 3:  b36b23ee173 read-cache & fetch-negotiator: check "enum" values in switch()
    @@ fetch-negotiator.c: void fetch_negotiator_init(struct repository *r,
      		return;
     +	case FETCH_NEGOTIATION_NONE:
     +	case FETCH_NEGOTIATION_UNSET:
    -+		BUG("FETCH_NEGOTIATION_UNSET only in prepare_repo_settings()");
    ++		BUG("FETCH_NEGOTIATION_{NONE,UNSET} used outside of prepare_repo_settings()!");
      	}
      }
     
    @@ read-cache.c: static void tweak_untracked_cache(struct index_state *istate)
     +	case UNTRACKED_CACHE_KEEP:
     +		break;
     +	case UNTRACKED_CACHE_UNSET:
    -+		BUG("UNTRACKED_CACHE_UNSET only in prepare_repo_settings()");
    ++		BUG("UNTRACKED_CACHE_UNSET used outside of prepare_repo_settings()!");
     +	}
      }
      
4:  28286a61162 ! 4:  c9f143b26f1 repo-settings.c: simplify the setup
    @@ fetch-negotiator.c: void fetch_negotiator_init(struct repository *r,
      		return;
     -	case FETCH_NEGOTIATION_NONE:
     -	case FETCH_NEGOTIATION_UNSET:
    --		BUG("FETCH_NEGOTIATION_UNSET only in prepare_repo_settings()");
    +-		BUG("FETCH_NEGOTIATION_{NONE,UNSET} used outside of prepare_repo_settings()!");
      	}
      }
     
    @@ read-cache.c: static void tweak_untracked_cache(struct index_state *istate)
     +		 */
      		break;
     -	case UNTRACKED_CACHE_UNSET:
    --		BUG("UNTRACKED_CACHE_UNSET only in prepare_repo_settings()");
    +-		BUG("UNTRACKED_CACHE_UNSET used outside of prepare_repo_settings()!");
      	}
      }
      
5:  3cc033b8864 = 5:  aadd4c42923 repository.h: don't use a mix of int and bitfields
-- 
2.33.0.1098.gf02a64c1a2d

