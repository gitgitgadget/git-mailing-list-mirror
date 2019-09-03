Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C4DA1F461
	for <e@80x24.org>; Tue,  3 Sep 2019 19:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfICTKs (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 15:10:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37770 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfICTKr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 15:10:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id r195so721570wme.2
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 12:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zAW/EA0LBzbz3wNTwH+DBiyd93xaXJdL2Ge95fq9fXw=;
        b=gRmStDk4uJi1r/KnvxT2/SCPUEDcCINZwmKcAJx5rqvjJAvvc8XxR7+DS1Uh5ur93P
         wO12SAdXI9/KWaXRuVO8CFFOSMr6rWmo9cenXlCJtIaTUTXV1yh3XKPY7BHEVcdVcqM/
         wRyrUy4Rh4pXgINXmnSCkQbhVYf/jn+3lle0fez8Ykurt77q44bbJk2yUdCGMgNRYjTx
         Pzigh2UFyJFe4wBRzhpPYNCDfULFnXY9/oPCsPKf1qczGUDOsW8wPs7hGjx0nVs0adKc
         6wIHsml9g28X3D8oif9QqLNpOOdq8sJPieMdE+slGu8z5uRH4sOi5UNHgstUuxS+1la3
         T8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zAW/EA0LBzbz3wNTwH+DBiyd93xaXJdL2Ge95fq9fXw=;
        b=XqV+wC/eQukOco3IZfaIWfF0lc+YE3ulW+EPtvXey1YfJo8/ar0nqfVCGSUjVnwjaV
         MVT5bjXhMKTP+esTFs3nv5rUosxhNF2SbCQnX+w3TQF9/S0ivBLko4Na7RyyBHOwltTK
         mdxCO639swELMqF0jfTOtpNLV2/pIvdg/HczSLpsn1oi12qb94VPC0Jv6+yTuRYYk4P0
         k1/KhGKg6M0VGmW1VuMCZhJlPiBtIWIE3pBufr98wpuD4WW1gVkBAPnjT15Jm9WSNZD/
         MF+alSla3oz6FoZdh8Vso9+rDOXEyBvScCWI92cw3rj/Ka+7GBFHvwAV9JWGPWkTvqkd
         ohsA==
X-Gm-Message-State: APjAAAX6aWRXEAG17YSEwR7++6WyMaMUUtU0kiltZZO2n8881vXlWTDn
        /G0q3zsah08o9uHW2CBpw80RcTY/
X-Google-Smtp-Source: APXvYqyhhaxDjiLMA7iF4Bh5l3mv16Lqe4FtFmk/tc0+G0DocHiWQf43RbchJNd2Yt6TEnQcUdwDGw==
X-Received: by 2002:a1c:2ec6:: with SMTP id u189mr1030514wmu.67.1567537844963;
        Tue, 03 Sep 2019 12:10:44 -0700 (PDT)
Received: from localhost ([95.148.214.9])
        by smtp.gmail.com with ESMTPSA id q26sm286908wmf.45.2019.09.03.12.10.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Sep 2019 12:10:43 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 0/3] make sure stash refreshes the index properly
Date:   Tue,  3 Sep 2019 20:10:38 +0100
Message-Id: <20190903191041.10470-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.194.ge5444969c9
In-Reply-To: <20190829182748.43802-1-t.gummerer@gmail.com>
References: <20190829182748.43802-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Martin and Junio for the comments on the previous round.

Changes compared to the previous round:
- Document that when failing to refresh the index, the result won't be
  written to disk.
- Rollback the lock file if refreshing the index fails, so we don't
  end up with a lock file that can't be rolled back or committed after
  the function returns
- Some small tweaks in the commit message and documentation of the
  function.

Range-diff below:

1:  1f25fe227c ! 1:  7cc9f5fff4 factor out refresh_and_write_cache function
    @@ Commit message
         factor out refresh_and_write_cache function
     
         Getting the lock for the index, refreshing it and then writing it is a
    -    pattern that happens more than once throughout the codebase.  Factor
    -    out the refresh_and_write_cache function from builtin/am.c to
    -    read-cache.c, so it can be re-used in other places in a subsequent
    -    commit.
    +    pattern that happens more than once throughout the codebase, and isn't
    +    trivial to get right.  Factor out the refresh_and_write_cache function
    +    from builtin/am.c to read-cache.c, so it can be re-used in other
    +    places in a subsequent commit.
     
         Note that we return different error codes for failing to refresh the
         cache, and failing to write the index.  The current caller only cares
    @@ cache.h: void fill_stat_cache_info(struct index_state *istate, struct cache_entr
     + * 'COMMIT_LOCK | write_flags' is passed to 'write_locked_index()', so
     + * the lockfile is always either committed or rolled back.
     + *
    -+ * Return 1 if refreshing the cache failed, -1 if writing the cache to
    -+ * disk failed, 0 on success.
    ++ * Return 1 if refreshing the index returns an error, -1 if writing
    ++ * the index to disk fails, 0 on success.
    ++ *
    ++ * Note that if refreshing the index returns an error, we don't write
    ++ * the result to disk.
     + */
     +int repo_refresh_and_write_index(struct repository*, unsigned int refresh_flags, unsigned int write_flags, const struct pathspec *, char *seen, const char *header_msg);
     +
    @@ read-cache.c: static void show_file(const char * fmt, const char * name, int in_
     +	struct lock_file lock_file = LOCK_INIT;
     +
     +	repo_hold_locked_index(repo, &lock_file, LOCK_DIE_ON_ERROR);
    -+	if (refresh_index(repo->index, refresh_flags, pathspec, seen, header_msg))
    ++	if (refresh_index(repo->index, refresh_flags, pathspec, seen, header_msg)) {
    ++		rollback_lock_file(&lock_file);
     +		return 1;
    ++	}
     +	if (write_locked_index(repo->index, &lock_file, COMMIT_LOCK | write_flags))
     +		return -1;
     +	return 0;
2:  148a65d649 = 2:  0367d938b1 merge: use refresh_and_write_cache
3:  e0f6815192 = 3:  8ed3df9fec stash: make sure to write refreshed cache

Thomas Gummerer (3):
  factor out refresh_and_write_cache function
  merge: use refresh_and_write_cache
  stash: make sure to write refreshed cache

 builtin/am.c     | 16 ++--------------
 builtin/merge.c  | 13 +++----------
 builtin/stash.c  | 11 +++++++----
 cache.h          | 16 ++++++++++++++++
 read-cache.c     | 19 +++++++++++++++++++
 t/t3903-stash.sh | 16 ++++++++++++++++
 6 files changed, 63 insertions(+), 28 deletions(-)

-- 
2.23.0.rc2.194.ge5444969c9
