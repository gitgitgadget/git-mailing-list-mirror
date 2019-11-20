Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06191C43215
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 04:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE01620857
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 04:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GwKPJgd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfKTEEK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 23:04:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59536 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbfKTEEK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 23:04:10 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 099EF2A57F;
        Tue, 19 Nov 2019 23:04:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=25FhFry101jFa+n+hRNru6TOBsg=; b=GwKPJg
        d3qwnk9YmXchnXe8HL5RkXu3jxelhtSGzCRZKD2ZXimfF+nBMlOjmqB17hb6xnt0
        gOehaxTTEjYH0mTUVtk3OEL9LALYFQgDlQGtRSBvBOYgP+6keMB8bS7B+NTUzaWK
        GBUbbPHKI+nxKR58zOEQDlzN+ZZns0EWpjIMg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qtRD9jTUtJof/PNLcwe7v0t++vc04KO2
        t6FLu1f5nkNlEgIC9lDpsjv5kZgohi77koA7C7PrC+ucAy+IM65uBPv7rd12rKA2
        D+DOSKNzEaATXsaTmkXl9Gdp8d1MSBWXSat1QMyWT6q9tLx4p5SPc9wPu+ERGoWt
        rW3HeuHJVcU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F1D322A57E;
        Tue, 19 Nov 2019 23:04:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 533902A57D;
        Tue, 19 Nov 2019 23:04:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH v3 0/6] Add --pathspec-from-file option for reset, commit
References: <pull.445.v2.git.1573055478.gitgitgadget@gmail.com>
        <pull.445.v3.git.1574182135.gitgitgadget@gmail.com>
Date:   Wed, 20 Nov 2019 13:04:06 +0900
In-Reply-To: <pull.445.v3.git.1574182135.gitgitgadget@gmail.com> (Alexandr
        Miloslavskiy via GitGitGadget's message of "Tue, 19 Nov 2019 16:48:49
        +0000")
Message-ID: <xmqqa78rchxl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC6F9B6E-0B4A-11EA-9565-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Changes from V2:
>
> 1) Some polishing in documentation 2) = NULL removed from 
> parse_pathspec_file()
>
> Alexandr Miloslavskiy (6):
>   parse-options.h: add new options `--pathspec-from-file`,
>     `--pathspec-file-nul`
>   pathspec: add new function to parse file
>   doc: reset: synchronize <pathspec> description
>   reset: support the `--pathspec-from-file` option
>   doc: commit: synchronize <pathspec> description
>   commit: support the --pathspec-from-file option

Nicely done.  I think this is now ready for 'next'.

Thanks.
