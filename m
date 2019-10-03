Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E6B81F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 00:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbfJCAlq (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 20:41:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60798 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfJCAlp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 20:41:45 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF6031D7EA;
        Wed,  2 Oct 2019 20:41:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bVB9hHp/LS4QxAvShZEt0V5lJz0=; b=SxTIu4
        oPd6UzrycWGNxTro/c9NHxOk1fsbc31VRA/+ztXLOzHXrpgjt37cSGs3/1xnOJr4
        IobtLCvz8rRQNdiiW6h5nXRuCMYJXPOEhb0Rp9swScZOMjHJOQlcQ41xDQv3sZ55
        GcGYAQfvIZTw/aFqm31/meZkStp60f14WLWhk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XEhl+ZJCVIc19M+HR72mQhnUMst46HXV
        taT0/wHPIqTj+64V30EC++Y+ZVZh1EAaOuXMiyPpJWb0RwacJ+GoWmFogOY0eASR
        Dr/lTEPSR1/6viwGirzb0HIHpjg7zWO7JBWIizjvHA0s5HVKXavIsGK0iDMfxXCj
        plEmIV+GSbk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A7EBD1D7E9;
        Wed,  2 Oct 2019 20:41:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 13FDB1D7E8;
        Wed,  2 Oct 2019 20:41:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] range-diff: internally force `diff.noprefix=false`
References: <pull.373.git.gitgitgadget@gmail.com>
        <1f84f92846bc14d21aa7339c8baa0f9bb710b17d.1570039511.git.gitgitgadget@gmail.com>
        <xmqq4l0qewu5.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 03 Oct 2019 09:41:41 +0900
In-Reply-To: <xmqq4l0qewu5.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 03 Oct 2019 05:06:26 +0900")
Message-ID: <xmqqv9t6d5iy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9210BB14-E576-11E9-B308-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> When parsing the diffs, `range-diff` expects to see the prefixes `a/`
>> and `b/` in the diff headers.
>
> If so, passing src/dst prefix as command line option is a much
> better solution, I think.  diff.noprefix may not stay to be (or it
> may already not to be) the only thing how the prefix gets chosen.

That is, "--src-prefix=a/ --dst-prefix=b/", so that configuration
variables yet to be invented for setting prefixes different from a/
and b/ can also be overridden, not just diff.noprefix (ancient Git
used l/ and k/ as src and dst prefix, IIRC).


