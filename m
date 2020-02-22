Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32795C35666
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 17:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB501206E2
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 17:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ndz78U4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgBVRu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 12:50:27 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59229 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgBVRu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Feb 2020 12:50:26 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A13CD41B57;
        Sat, 22 Feb 2020 12:50:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XJSNvKBd84s4txKLQWeF8520Qd4=; b=Ndz78U
        4JcFwr3FXWxN3hi+EAMVNJhckMl+qaZHkYOUX6WL2SdSk4wkbcmK30DiYx8aYic+
        yABFbYk38GHJQhAzr2rqXIgsqn4tBYyPHza4ykYq/vL3YhCq/2S37GF5Dt4XREBt
        pdiyr73aDxKyz8TH5tWvqFovyF/+Wr4EDI47Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ahCbHdafv6Z+6yiHZBC8Kac32xI1uSy+
        YlA742t8MBiPgB22/Hp+3avIYrlTJBMbm9jb4UGiBxBpSe3YNUvUPUrzHQDr0hCV
        k2kdqP2MtFZIqVqsnU53lmNeGRLkjm/5b3iXHynp5FWHaGGXDvQcSM+je5XQwhcl
        72tzwZ/gMXk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 984A541B56;
        Sat, 22 Feb 2020 12:50:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0F13A41B55;
        Sat, 22 Feb 2020 12:50:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rasmus Jonsson <wasmus@zom.bi>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH 1/1] t1050: clean up checks for file existence
References: <20200222071335.27292-1-wasmus@zom.bi>
        <20200222071335.27292-2-wasmus@zom.bi>
Date:   Sat, 22 Feb 2020 09:50:22 -0800
In-Reply-To: <20200222071335.27292-2-wasmus@zom.bi> (Rasmus Jonsson's message
        of "Sat, 22 Feb 2020 08:13:35 +0100")
Message-ID: <xmqqo8tq5x5t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD4AF1AA-559B-11EA-A47A-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rasmus Jonsson <wasmus@zom.bi> writes:

> Replace "test -f" with test_path_is_file, which gives more verbose
> and accurate output.

Does it?  "test -f" is designed to be silent, while the helper
function is designed to be verbose to help debugging the tests,
but the accuracy of the latter simply rests on the former.

Also

> Subject: Re: [GSoC][PATCH 1/1] t1050: clean up checks for file existence

"test -f <path>" is not unclean.  It just is that it is less helpful
than using test_path_is_file.

	Subject: [PATCH] t1050: use test_path_is_file instead of "test -f"

	Use test_path_is_file instead of "test -f"; this will help
	when running the test with the "-v" option for debugging.

> Signed-off-by: Rasmus Jonsson <wasmus@zom.bi>
