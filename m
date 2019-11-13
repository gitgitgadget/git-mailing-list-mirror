Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0AEA1F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 01:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfKMBaN (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 20:30:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51533 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfKMBaM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 20:30:12 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0CEA32A648;
        Tue, 12 Nov 2019 20:30:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z7H5RqHnbI21g1Rkldn7+W3Luqs=; b=X6MLje
        pMHU3RNBeSRiw7CKtEv38Ytamb8MVVs7nKzFUGe9vN7cMbbxrz/BkYFlfNSVDVSj
        WMB+i2DNk1qcX18rPxUJjUziNEDtNhfZLxY0kpwrvK178n+DWkp4GOxh92YSXLEa
        v3P95/TJZcTowRLVuPw+raEoCoE57c580Da/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NV67RLdGJChiQXhX+2BJgBFbk0i94Wkp
        L5wtY3RGN3gUX2gt/sxUAzOw7QY0gmFUbq6tfOotrmsX4gt50UIjsnpSrAhp6Nb1
        cKnioz+LxJMpAOCSjIjjLnyIPzDPqNYV8MNdgR1MJN5UbJjVDYiNfCLIWDBQvYbw
        uRTGcpm78xs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CCF972A645;
        Tue, 12 Nov 2019 20:30:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5FD522A643;
        Tue, 12 Nov 2019 20:30:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Willford <Kevin.Willford@microsoft.com>
Cc:     Utsav Shah via GitGitGadget <gitgitgadget@gmail.com>,
        William Baker <William.Baker@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Utsav Shah <ukshah2@illinois.edu>
Subject: Re: [PATCH 0/1] fsmonitor: skip sanity check if the index is split
References: <pull.458.git.1573196960.gitgitgadget@gmail.com>
        <xmqqh83bjig6.fsf@gitster-ct.c.googlers.com>
        <xmqqa793jhne.fsf@gitster-ct.c.googlers.com>
        <BN6PR21MB07869E8D1DCAF189C4E472A891740@BN6PR21MB0786.namprd21.prod.outlook.com>
Date:   Wed, 13 Nov 2019 10:30:05 +0900
In-Reply-To: <BN6PR21MB07869E8D1DCAF189C4E472A891740@BN6PR21MB0786.namprd21.prod.outlook.com>
        (Kevin Willford's message of "Mon, 11 Nov 2019 16:55:11 +0000")
Message-ID: <xmqqzhh0d0ma.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2023E63E-05B5-11EA-9B89-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Willford <Kevin.Willford@microsoft.com> writes:

> I agree.  The only 2 places that excluding the split-index make sense are in
> read_fsmonitor_extension and write_fsmonitor_extension because the
> index_state that is being passing into those methods could be the delta index
> in which case the number of entries for the fsmonitor bitmap would almost
> always be more and cause the BUG to be hit which it should not be.

Thanks.  Here is what I came up with to tie the loose ends of this
thread.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] fsmonitor: do not compare bitmap size with size of split index

3444ec2e ("fsmonitor: don't fill bitmap with entries to be removed",
2019-10-11) added a handful of sanity checks that make sure that a
bit position in fsmonitor bitmap does not go beyond the end of the
index.  As each bit in the bitmap corresponds to a path in the
index, this is the right check most of the time.

Except for the case when we are in the split-index mode and looking
at a delta index that is to be overlayed on the base index but
before the base index has actually been merged in, namely in read_
and write_fsmonitor_extension().  In these codepaths, the entries in
the split/delta index is typically a small subset of the entire set
of paths (otherwise why would we be using split-index?), so the
bitmap used by the fsmonitor is almost always larger than the number
of entries in the partial index, and the incorrect comparison would
trigger the BUG().

Reported-by: Utsav Shah <ukshah2@illinois.edu>
Helped-by: Kevin Willford <Kevin.Willford@microsoft.com>
Helped-by: William Baker <William.Baker@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 fsmonitor.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 1f4aa1b150..0477500b39 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -55,7 +55,8 @@ int read_fsmonitor_extension(struct index_state *istate, const void *data,
 	}
 	istate->fsmonitor_dirty = fsmonitor_dirty;
 
-	if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
+	if (!istate->split_index &&
+	    istate->fsmonitor_dirty->bit_size > istate->cache_nr)
 		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
 		    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
 
@@ -83,7 +84,8 @@ void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate)
 	uint32_t ewah_size = 0;
 	int fixup = 0;
 
-	if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
+	if (!istate->split_index &&
+	    istate->fsmonitor_dirty->bit_size > istate->cache_nr)
 		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
 		    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
 
-- 
2.24.0-346-gee0de6d492

