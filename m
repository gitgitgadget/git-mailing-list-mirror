Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCD6EEB57F
	for <git@archiver.kernel.org>; Sat,  9 Sep 2023 05:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238473AbjIIF0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Sep 2023 01:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjIIF0q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2023 01:26:46 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501B6FE
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 22:26:43 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E6C2E22483;
        Sat,  9 Sep 2023 01:26:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=sS9CG5KW3Fb7AFs3vtGa5dv40FLDPJsJICXfWa
        T5hqY=; b=dMeKkmATVmI/dU69YCry0NTmtqJg82G+2r5KXYE1auCfqxQCPdIQrO
        6bWLEkcIThS5uZ8vSw2/kbti+gC80NzwJA3GpaTj712yFgPedj8ZpgUmfC5yv672
        sTFxDjAGoKY7menK1gnL4+c583iKifzhI0wVUtJX1DdV7J5VFwbmI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DE8E722482;
        Sat,  9 Sep 2023 01:26:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8B00D22481;
        Sat,  9 Sep 2023 01:26:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, nasamuffin@google.com,
        jonathantanmy@google.com, linusa@google.com,
        phillip.wood123@gmail.com, vdye@github.com
Subject: Re: [PATCH v3 6/6] git-std-lib: add test file to call git-std-lib.a
 functions
In-Reply-To: <20230908174443.1027716-6-calvinwan@google.com> (Calvin Wan's
        message of "Fri, 8 Sep 2023 17:44:43 +0000")
References: <20230908174134.1026823-1-calvinwan@google.com>
        <20230908174443.1027716-6-calvinwan@google.com>
Date:   Fri, 08 Sep 2023 22:26:38 -0700
Message-ID: <xmqqy1hfrk6p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73F8782E-4ED1-11EE-9424-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> +
> +test-git-std-lib:
> +	cc -It -o stdlib-test stdlib-test.c -L. -l:../git-std-lib.a

Yuck, no.  Try to share as much with the main Makefile one level up.

> +	./stdlib-test
> diff --git a/t/stdlib-test.c b/t/stdlib-test.c
> new file mode 100644
> index 0000000000..76fed9ecbf
> --- /dev/null
> +++ b/t/stdlib-test.c
> @@ -0,0 +1,231 @@
> +#include "../git-compat-util.h"
> +#include "../abspath.h"
> +#include "../hex-ll.h"
> +#include "../parse.h"
> +#include "../strbuf.h"
> +#include "../string-list.h"

Use -I.. or something, to match what the main Makefile does, so that
you do not have to have these "../".  With -I.., you could even say

    #include <hex-ll.h>
    #include <parse.h>

etc.


> +	// skip_to_optional_arg_default(const char *str, const char *prefix,
> +	// 			 const char **arg, const char *def)

No // comments in this codebase, please.

> +	strbuf_addchars(sb, 1, 1);
> +	strbuf_addf(sb, "%s", "foo");

https://github.com/git/git/actions/runs/6126669144/job/16631124765#step:4:657

