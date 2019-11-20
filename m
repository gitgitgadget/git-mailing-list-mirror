Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5A7C432C3
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 08:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8AEF22317
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 08:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHbTx8sH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfKTIcV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 03:32:21 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35179 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbfKTIcV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 03:32:21 -0500
Received: by mail-wr1-f66.google.com with SMTP id s5so27057472wrw.2
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 00:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ot/+GB2p+uKNgwcFxiEN1JSqGrLG65Q60vu8w0d+1Q4=;
        b=bHbTx8sHmyWk2IcUu44BRmUA7NHmApwTu/6lW+3ebQHJgSjq7XK2ShKRUfp0is7Xfr
         zvjcJjcAC4/oK2k8SAjQ8X7jxEdJzyjj6qPif+YIYs4hjcKT8j3V24jbIwprlLI+S47Y
         lUkQTSw+jwuTNucBvhJdzy+2aFj0WZGS0J9Crka7lDX5ZcAh5EXMDJVttxIKeVFPdGLL
         WSr7ttdLQVGcwhmA+8BQ/7cm1FxOkjtuiUx3Rb/+isZsxeTOHUjpe8SWpC7aWhUcvXCY
         EYBBliobwmeqCM/K9rdjkZ5uBK41QOZ2vV6RkdwC/MGBFrhbHFO9QUPZT/2yM3G0IVwr
         Gjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ot/+GB2p+uKNgwcFxiEN1JSqGrLG65Q60vu8w0d+1Q4=;
        b=rS9qKS5AXMwq06ddmqfOoJnnL5wuWNC4mLPRPCW60sl83aEZgWku0DA21KLvopR3rj
         RkmntcMN0EFcImc+pEX7hEOBDk/Aiyg7P0k2c0svxJeQU6LwAUdtYQdY48tR4oZB/FWO
         P5WzQ4as+nw+V9gpT8F0LmXdAH3H0um+2sCE+54SwVnz5MfPfkMv8zTunRfCDMSYzKG+
         p378ptw47hClrdBc+hFFnVx8JAAHpQsMX49+J7ZpKipEq/5+h/LqYzfUfIwDoNB/Cglg
         IHjdDe5wo6ShtEPmWPq5mhSzOuduTFmgSiJiojnmnM3EGVcmRQgaR5HEeB5V9bpUCSVk
         zPNw==
X-Gm-Message-State: APjAAAV0BA2zP9PO+A4bQH0kSfQuYtj23BgaOyARWDqlJlapyGikrY2o
        NSthig0zmU5BFzsGpr67uxkpDhj2
X-Google-Smtp-Source: APXvYqygtmOMGxn6tGXToaFpCsVOtSQvgLTUcw9Gx036q+l/6VbPImbECJsCys1mz1SNKIxTJYPRzA==
X-Received: by 2002:adf:db86:: with SMTP id u6mr1777175wri.318.1574238738798;
        Wed, 20 Nov 2019 00:32:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c4sm30876656wrp.86.2019.11.20.00.32.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 00:32:18 -0800 (PST)
Message-Id: <pull.424.v4.git.1574238737.gitgitgadget@gmail.com>
In-Reply-To: <pull.424.v3.git.1573016055.gitgitgadget@gmail.com>
References: <pull.424.v3.git.1573016055.gitgitgadget@gmail.com>
From:   "Utsav Shah via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Nov 2019 08:32:16 +0000
Subject: [PATCH v4 0/1] unpack-trees: skip stat on fsmonitor-valid files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Utsav Shah <ukshah2@illinois.edu>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The index might be aware that a file hasn't modified via fsmonitor, but
unpack-trees did not pay attention to it and checked via ie_match_stat which
can be inefficient on certain filesystems. This significantly slows down
commands that run oneway_merge, like checkout and reset --hard.

This patch makes oneway_merge check whether a file is considered unchanged
through fsmonitor and skips ie_match_stat on it. unpack-trees also now
correctly copies over fsmonitor validity state from the source index.
Finally, for correctness, we force a refresh of fsmonitor state in
tweak_fsmonitor.

After this change, commands like stash (that use reset --hard internally) go
from 8s or more to ~2s on a 250k file repository on a mac.

Changes since the last version are:

 * The sanity checks around accessing the fsmonitor_dirty bitmap have been
   moved to another patch, which is in message id [1]
 * Unintended indentation changes in fsmonitor have been removed
 * A comment explaining what untracked->use_fsmonitor means has been
   re-added (it was dropped in the previous version)
 * A few "helped-by" entries have been added to the patch

1: (xmqqzhh0d0ma.fsf@gitster-ct.c.googlers.com)

Helped-by: Junio C Hamano gitster@pobox.com [gitster@pobox.com]Helped-by:
Kevin Willford Kevin.Willford@microsoft.com [Kevin.Willford@microsoft.com]
Signed-off-by: Utsav Shah utsav@dropbox.com [utsav@dropbox.com]

Utsav Shah (1):
  unpack-trees: skip stat on fsmonitor-valid files

 fsmonitor.c                 | 23 +++++++++++++++++------
 t/t7519-status-fsmonitor.sh |  9 +++++++--
 unpack-trees.c              |  6 +++++-
 3 files changed, 29 insertions(+), 9 deletions(-)


base-commit: 566a1439f6f56c2171b8853ddbca0ad3f5098770
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-424%2FUtsav2%2Fskip-lstat-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-424/Utsav2/skip-lstat-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/424

Range-diff vs v3:

 1:  4bea7075cf ! 1:  ea7880f2d0 unpack-trees: skip stat on fsmonitor-valid files
     @@ -17,52 +17,29 @@
          internally) go from 8s or more to ~2s on a 250k file repository on a
          mac.
      
     +    Changes since the last version are:
     +    * The sanity checks around accessing the fsmonitor_dirty bitmap have
     +    been moved to another patch, which is in message id [1]
     +    * Unintended indentation changes in fsmonitor have been removed
     +    * A comment explaining what untracked->use_fsmonitor means has been
     +    re-added (it was dropped in the previous version)
     +    * A few "helped-by" entries have been added to the patch
     +
     +    [1]: (xmqqzhh0d0ma.fsf@gitster-ct.c.googlers.com)
     +
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
     +    Helped-by: Kevin Willford <Kevin.Willford@microsoft.com>
          Signed-off-by: Utsav Shah <utsav@dropbox.com>
      
       diff --git a/fsmonitor.c b/fsmonitor.c
       --- a/fsmonitor.c
       +++ b/fsmonitor.c
      @@
     - 
     - 	if (pos >= istate->cache_nr)
     - 		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" >= %u)",
     --		    (uintmax_t)pos, istate->cache_nr);
     -+			(uintmax_t)pos, istate->cache_nr);
     - 
     - 	ce = istate->cache[pos];
     - 	ce->ce_flags &= ~CE_FSMONITOR_VALID;
     -@@
     - 	}
     - 	istate->fsmonitor_dirty = fsmonitor_dirty;
     - 
     --	if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
     --		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
     --		    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
     -+	if (!istate->split_index && istate->fsmonitor_dirty->bit_size > istate->cache_nr)
     -+		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %"PRIuMAX")",
     -+			(uintmax_t)istate->fsmonitor_dirty->bit_size, (uintmax_t)istate->cache_nr);
     -+
     - 
     - 	trace_printf_key(&trace_fsmonitor, "read fsmonitor extension successful");
     - 	return 0;
     -@@
     - 	uint32_t ewah_size = 0;
     - 	int fixup = 0;
     - 
     --	if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
     --		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
     --		    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
     -+	if (!istate->split_index && istate->fsmonitor_dirty->bit_size > istate->cache_nr)
     -+		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %"PRIuMAX")",
     -+			(uintmax_t)istate->fsmonitor_dirty->bit_size, (uintmax_t)istate->cache_nr);
     - 
     - 	put_be32(&hdr_version, INDEX_EXTENSION_VERSION);
     - 	strbuf_add(sb, &hdr_version, sizeof(uint32_t));
     -@@
       		}
       		if (bol < query_result.len)
       			fsmonitor_refresh_callback(istate, buf + bol);
      +
     ++		/* Now mark the untracked cache for fsmonitor usage */
      +		if (istate->untracked)
      +			istate->untracked->use_fsmonitor = 1;
       	} else {
     @@ -88,11 +65,7 @@
       		if (istate->untracked)
       			istate->untracked->use_fsmonitor = 0;
      @@
     - 			/* Mark all previously saved entries as dirty */
     - 			if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
     - 				BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
     --				    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
     -+					(uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
     + 				    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
       			ewah_each_bit(istate->fsmonitor_dirty, fsmonitor_ewah_callback, istate);
       
      -			/* Now mark the untracked cache for fsmonitor usage */

-- 
gitgitgadget
