Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33119C54FCF
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 15:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0622120772
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 15:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SZSyhPOF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgCYPP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:15:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62944 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbgCYPP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 11:15:56 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7DBECBDF5A;
        Wed, 25 Mar 2020 11:15:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Pw81DbkW23WrP3WO85IMvg7+ams=; b=SZSyhP
        OFg7usQxj1lis35bCeO3b5PfxK8tGewCL4w3sLN30PSZIdu62u3h91LiWe4qIG43
        gVrRs9wXWR3UVi/dyVq5rHYASdmxRy3eM835D7NP+Z+skmD+rgA2pB9mEfE9/7FI
        pSy9xnnbqnKpZT4htPz1T90duyaslqdPRcHVs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sIzFO+i76Ipvji2mPYFmaTSSjVuPXe+P
        nA42iuGe7wBenOae9JLa54df0h3UkZvVs0uXZ6RYKz4Oyy0n5zn/x2fJ4lFzgXSy
        sHpcVHXFANd36b4/KdJQYwu+sps1QaMLTr05rILqai2oiBXNUotYWbCLJaFGKPLe
        rTCbbdp9MuY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5F50ABDF59;
        Wed, 25 Mar 2020 11:15:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7D6A2BDF56;
        Wed, 25 Mar 2020 11:15:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 2/3] send-pack: mark failure of atomic push properly
References: <20200322131815.11872-3-worldhello.net@gmail.com>
        <20200325143608.45141-3-zhiyou.jx@alibaba-inc.com>
Date:   Wed, 25 Mar 2020 08:15:49 -0700
In-Reply-To: <20200325143608.45141-3-zhiyou.jx@alibaba-inc.com> (Jiang Xin's
        message of "Wed, 25 Mar 2020 22:36:07 +0800")
Message-ID: <xmqq5zesxy6y.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83A4A3CE-6EAB-11EA-9C4B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> When pusing with SSH or other smart protocol, references are validated
> by function `check_to_send_update()` beforce they are sent in commands

beforce -> before

> to `send_pack()` of "receve-pack".  For atomic push, if a reference is
> rejected after the validation, only references pushed by user should be
> marked as failure, instead of report failure on all remote references.
>
> Commit v2.22.0-1-g3bca1e7f9f (transport-helper: enforce atomic in
> push_refs_with_push, 2019-07-11) wanted to fix report issue of HTTP
> protocol, but marked all remote references failure for atomic push.
>
> Revert part of that commit and add additional status for function
> `atomic_push_failure()`.  The additional status for it except the
> "REF_STATUS_EXPECTING_REPORT" status are:
>
> - REF_STATUS_NONE : Not marked as "REF_STATUS_EXPECTING_REPORT" yet.
> - REF_STATUS_OK   : Assume OK for dryrun or status_report is disabled.
>
> This commit break test case in t5541, and will fix in other commit.

Presumably the fix in 3/3 is too big to be included in here?  Let's
see how it goes, as such a strategy sometimes helps understand the
change and sometimes does not.

> diff --git a/send-pack.c b/send-pack.c
> index 0407841ae8..ff016c468c 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -334,6 +334,8 @@ static int atomic_push_failure(struct send_pack_args *args,
>  			continue;
>  
>  		switch (ref->status) {
> +		case REF_STATUS_NONE:
> +		case REF_STATUS_OK:
>  		case REF_STATUS_EXPECTING_REPORT:
>  			ref->status = REF_STATUS_ATOMIC_PUSH_FAILED;
>  			continue;

This is fed the whole *remote_refs list, iterates over them but we
only come here if the ref is actually pushed (i.e. peer_ref is set,
or we are doing a mirror push), so it does sound like the right
place to do this.
