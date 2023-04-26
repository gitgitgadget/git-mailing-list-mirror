Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C546C7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 17:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbjDZRfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 13:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbjDZRfg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 13:35:36 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF8597
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 10:35:35 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-b98434b5311so10704832276.1
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 10:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1682530534; x=1685122534;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=72bNMqUJhDmlNO6lVV+OD0KsODw1Z0eIh5XZUP0z4cI=;
        b=CzKirETVZb10yVPr9OkeimaEm3T3uUZbzdHSXPyKuVgnCXCjxl9tG/710DWniP8Qqx
         MU3ftnwQPdmVj6VhceADI46M14kO6DcLQCZ+6P9Cgv59rnjioYhptM225sVOVG2vCCuQ
         Grn+2rdnPK76DmBDzkaLN5dFW4gWg2RvKJPFe+bip6OmXlMqs4RmfFnsPU9TNNAF1Wsp
         qzOHP3436R+s+G+Gx1hYcSNHtaTz31enijSdeLSBX8q54kwJD6d5B/hCijonA9NuhIQO
         W60Ha7qDjplkyoMOUpkOgdq/2/T43XlNqCNTG1F8q+Wv7I3/sdDR88qekJJvVnQ4aACF
         f+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682530534; x=1685122534;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72bNMqUJhDmlNO6lVV+OD0KsODw1Z0eIh5XZUP0z4cI=;
        b=MX8ER1j6f7Zeq3Q9bxpMKnBiq1Yu8H142+k9tpm4GmCv/CiXRb2cAFi2mFiYlBVl89
         3b/05XdKoYVHHGWDGofRMJpc+RXizj3vlpF25KyOcdFuKl3q4FDRnLe9NcBIYPB0sJox
         HXKUpYv56Jfrq2c51h5o2z+x1gHOTR34ugDweWe590fjf1UKMz8JO6rIfeBdoSzBBUfo
         Ig3Z7ZYkHulByRQD8jJrbRgI3LY5AHE+XxfAtz/mIfgk6cO1y4NskYspIP8eCHe2qki+
         yFBbXB3COJUjoKjY1E16MEXczvV4jyM4W+X4xh5TjFX37PWro6vQI0WqDv4+JWZB+igh
         xomg==
X-Gm-Message-State: AAQBX9dGsKWBgT0M/rn+kjtsEsty+Vh/h/TTecoD9EvXYZTiEcgaLBbJ
        T1OQ0N/6mo7m+yQ51bt+U3Kvv36rFWN/OZpQMw==
X-Google-Smtp-Source: AKy350ZU5pCXNnEuyEcpDlJbpVZkZZzmOhKu0YCebKQZPYHJ/Jy1KaDlaWm6C8+dy5NHxHTgOzc8Lg==
X-Received: by 2002:a25:4250:0:b0:b92:3c99:7fae with SMTP id p77-20020a254250000000b00b923c997faemr15602785yba.23.1682530534507;
        Wed, 26 Apr 2023 10:35:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f1c4:1a6:d1a6:59da? ([2600:1700:e72:80a0:f1c4:1a6:d1a6:59da])
        by smtp.gmail.com with ESMTPSA id r14-20020a5b06ce000000b00b7767ca7496sm4127604ybq.51.2023.04.26.10.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 10:35:34 -0700 (PDT)
Message-ID: <eb1c6c62-1081-a9d2-8504-db8bffc6c870@github.com>
Date:   Wed, 26 Apr 2023 13:35:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Commit graph not using minimal number of columns
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Javier Mora <cousteaulecommandant@gmail.com>, git@vger.kernel.org
References: <CAH1-q0hReZoDWmXo7St10Dk6uc+6ZUQSxqvu1cJ7w3r7ftR9PQ@mail.gmail.com>
 <xmqq8refy114.fsf@gitster.g>
 <86188f31-f492-d195-d4d5-b0582906621a@github.com>
 <xmqq1qk6vd3v.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq1qk6vd3v.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/26/2023 12:10 PM, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:

>> I don't think there is anything actionable to do here, as
>> these commit-ordering options are well-defined and should not
>> be altered. If there was an algorithm to modify the commit
>> order in such a way that minimized the graph output, that
>> would be interesting, but the cases it minimizes are probably
>> too rare to be worth the effort.
> 
> Yes, in addition to and next to "--{topo,date}-order", if somebody
> can come up with a new "--graph-friendly-order", it may be an
> interesting addition.
> 
> A tangent.  I do not offhand remember if --date-order works purely
> on the timestamps in the commit objects, or do we take corrections
> based on the generation numbers?  It seems that we only use the
> compare_commits_by_gen_then_commit_date helper for prio queue
> manipulation (to avoid the "slop" thing terminating the revision
> walk too early) and not actual sorting.  I wonder if it makes much
> difference if we used it instead of compare_commits_by_commit_date()

The --date-order guarantees topological relationships are respected,
which is how it is different from the default order.

For the incremental topo-order logic, the topo_queue determines the
final order (the algorithm ensures that the indegree_queue has walked
far enough that we only add commits to topo_queue if their "in
degree" is zero and thus safe to use within topological constraints).

Here is how we pick the comparison:

	switch (revs->sort_order) {
	default: /* REV_SORT_IN_GRAPH_ORDER */
		info->topo_queue.compare = NULL;
		break;
	case REV_SORT_BY_COMMIT_DATE:
		info->topo_queue.compare = compare_commits_by_commit_date;
		break;
	case REV_SORT_BY_AUTHOR_DATE:
		init_author_date_slab(&info->author_date);
		info->topo_queue.compare = compare_commits_by_author_date;
		info->topo_queue.cb_data = &info->author_date;
		break;
	}

Using NULL makes the topo_queue act as a stack instead of a queue.

But crucially, --date-order sets to compare_commits_by_commit_date, so
generation number has nothing to do with this part of the walk (it has
everything to do with indegree_queue, though).

To adapt this algorithm to a newer, dynamic ordering that cares about
minimizing the rendered graph, I don't think changing the priority
queue comparison would be sufficient. Something deeper would be
required and would be quite messy.

Thanks,
-Stolee
