Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71B351FAFB
	for <e@80x24.org>; Tue, 11 Apr 2017 07:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753043AbdDKHom (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 03:44:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53729 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753907AbdDKHok (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 03:44:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E285C891A9;
        Tue, 11 Apr 2017 03:44:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=B1xUiBkV9M70zVe7H17IH4J8CM8=; b=H4bkhs
        2aLBLMp5EOxykjfL5ool4i9YrKgwzmsKcn57W2GmUdEnvdhw/u+gelCNd8V9qnrx
        JmF9s8eYlvMGmXq3L3uV2jC2BrqIkI6o0PgwiEuH5RQHOZ7/N9jTFRaApYON9iCR
        W4yw7nA4Xo40UysQe0j1SX1vCeIP3HtQGZtvw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LGZ4Ce2Y+RZzdYoZ5QoqybvJUIwdHbFY
        Yjjuii04uO2PrCD3iRrHz9zOu0gJlGwG3fHvWKicpcFbAB4arQtzYTZkWMzqomrS
        Z9FP2fZL9pC/x1WzNkfsp2UNfoBvf3D3wnV86xi+EoLZWWV4if40cLVduTnrIw/b
        ksaScCNxFIQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D9D98891A8;
        Tue, 11 Apr 2017 03:44:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4DDAD891A7;
        Tue, 11 Apr 2017 03:44:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH v3 0/5] propagating push-options, remote and refspec
References: <20170331235623.166408-1-bmwill@google.com>
        <20170405174719.1297-1-bmwill@google.com>
Date:   Tue, 11 Apr 2017 00:44:36 -0700
In-Reply-To: <20170405174719.1297-1-bmwill@google.com> (Brandon Williams's
        message of "Wed, 5 Apr 2017 10:47:14 -0700")
Message-ID: <xmqqr30zqtgb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B70A6920-1E8A-11E7-B9FD-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> v3 builds upon v2 by adding 3 additional patches to add functionality to also
> propagate the remote and refspec down to children process's working to push
> submodules.  The remote and refspec will only be propagated if the provided
> remote is configured. A remote provided in the form of a URL will cause the
> remote and refspec to not be propagated down to the submodules and instead the
> default remote and refspec will be used, preserving existing functionality.
> Currently the only supported LHS of a refspec must exactly match a single ref
> in the submodule (e.g. a branch name).
>
> Patches [1/5] and [2/5] remain unchanged from v2.

2/5 seems to be a bit different in 5545 ll.156,+6, though.

>
> Brandon Williams (5):
>   push: unmark a local variable as static
>   push: propagate push-options with --recurse-submodules
>   remote: expose parse_push_refspec function
>   submodule--helper: add push-check subcommand
>   push: propagate remote and refspec with --recurse-submodules
>
>  builtin/push.c                 |  5 +--
>  builtin/submodule--helper.c    | 45 +++++++++++++++++++++++++
>  remote.c                       |  2 +-
>  remote.h                       |  1 +
>  submodule.c                    | 74 +++++++++++++++++++++++++++++++++++++++---
>  submodule.h                    |  5 ++-
>  t/t5531-deep-submodule-push.sh | 52 +++++++++++++++++++++++++++++
>  t/t5545-push-options.sh        | 40 +++++++++++++++++++++++
>  transport.c                    |  4 ++-
>  9 files changed, 219 insertions(+), 9 deletions(-)
