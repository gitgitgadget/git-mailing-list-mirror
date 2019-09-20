Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10FB41F463
	for <e@80x24.org>; Fri, 20 Sep 2019 20:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfITURH (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 16:17:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60476 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfITURH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 16:17:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1DF158E8F9;
        Fri, 20 Sep 2019 16:17:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=97GgbxuimE8yj0kdmcUQxVhFMqM=; b=US630f
        K9MJSeNhJGJwunVwjSFTmD/zoC34ZLHqR7Xf3deZ8+EocyXTAiYIjN7J+x0QMXDn
        XxC4fFmLNiB9lkW/1/ffuf28g+vm1x2ab5KuufKGGaP8a+c+UgecAN2am1X7OOcR
        Pt2vybyYsBW+2PpXLT8n7jabwjwUQSECy7IDw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=egzD/LwzHGqJk4Jt2Z0W5tBDaWdkFBln
        7N0DGtT/Z0GJVIxj/7Qyi7KTh3uMEsXVTxoc5Wd2qGgAzz2bM4Gh3RA9rhJsnwBR
        x6YWzL+O70fIrtJO06pNPD4q3FleSXjyg2qAh1xbDi/bSL9IJJfFm1Vqo4mryVDO
        LUPnf56dP/w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1633E8E8F8;
        Fri, 20 Sep 2019 16:17:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2AA7D8E8F4;
        Fri, 20 Sep 2019 16:17:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, williamtbakeremail@gmail.com,
        stolee@gmail.com, jeffhost@microsoft.com,
        William Baker <William.Baker@microsoft.com>
Subject: Re: [PATCH v2 1/6] midx: add MIDX_PROGRESS flag Add the MIDX_PROGRESS flag and update the write|verify|expire|repack functions in midx.h to accept a flags parameter.  The MIDX_PROGRESS flag indicates whether the caller of the function would like progress information to be displayed. This patch only changes the method prototypes and does not change the functionality. The functionality change will be handled by a later patch.
References: <pull.337.git.gitgitgadget@gmail.com>
        <pull.337.v2.git.gitgitgadget@gmail.com>
        <6badd9ceaf4851b2984e78a5cfd0cb8ec0c810f5.1568998427.git.gitgitgadget@gmail.com>
        <xmqqr24au480.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 20 Sep 2019 13:16:59 -0700
In-Reply-To: <xmqqr24au480.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 20 Sep 2019 13:01:35 -0700")
Message-ID: <xmqqd0fuu3ic.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B5983AA-DBE3-11E9-B370-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> This step is meant to be just preparing by extending the interface
> and passing the new argument throughout the callchain, I believe,
> and it looks correctly done, assuming that we are OK to take this
> "add a separate 'progress' parameter, when we need more parameters
> later, the interface will gain more and more parameters" approach.

After re-reading the remainder of the series, I think the structure
this patch series takes (i.e. adding a new parameter to these callees)
is better than the alternative (i.e. making sure everybody takes the
pointer to the opts structure).

Thanks.  I couldn't review the proposed log messages of these
commits, which were unreadable, at all, though.
