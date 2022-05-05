Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1924C433F5
	for <git@archiver.kernel.org>; Thu,  5 May 2022 19:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384904AbiEETNm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 15:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384902AbiEETNk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 15:13:40 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DCD4EDDE
        for <git@vger.kernel.org>; Thu,  5 May 2022 12:10:00 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C63BE127ECD;
        Thu,  5 May 2022 15:09:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0AmEfatoK37Y4XddWH+53QvWRRw5lacKlFXz4w
        cOeT4=; b=aB/GC9NA3Yix1xd+Y1EWENZA/IMhNf6IhntMSQSdoEYumJMrPuxRqd
        G4DAKRaxKBjCoNT/1yiVpP9h+YY0rrTzsoahNkKWXYVYrg6f5FHPqrTn5FCimbWe
        iE0hjOBVrkeNjAVZCBIoNElGu2W5pOk0yxxco6bzHuoRriKrJztyY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BE5EE127ECC;
        Thu,  5 May 2022 15:09:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D3CF127ECB;
        Thu,  5 May 2022 15:09:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        philipoakley@iee.email, johncai86@gmail.com, me@ttaylorr.com
Subject: Re: [PATCH v4 8/8] cat-file: add --batch-command remote-object-info
 command
References: <20220502170904.2770649-9-calvinwan@google.com>
        <20220504212738.162853-1-jonathantanmy@google.com>
        <CAFySSZCL-ccVK+ZOU5=X4fB3-eu=Cmu-MGpT1cMW+bqmdRcF9w@mail.gmail.com>
        <xmqqbkwbes4d.fsf@gitster.g>
Date:   Thu, 05 May 2022 12:09:55 -0700
In-Reply-To: <xmqqbkwbes4d.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        05 May 2022 11:44:50 -0700")
Message-ID: <xmqq1qx7eqyk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F401CFCE-CCA6-11EC-A127-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I would have expected to see something like
>
> 	start batch
> 	request 1
> 	request 2
> 	...
> 	request 2000
> 	flush batch
>
> during which the other side patiently listens to our requests.  They
> (meaning the local process that reads the above and talks to a
> remote as needed) can coalesce the requests of the same kind
> (e.g. going to the same remote) while buffering and optimize their
> operation without having the caller of them to worry about it that
> way, no?

Ah, that is in the batch mode, and you were syaing that "one request
with multiple objects" would allow multiple object-info requests to
be hanled efficiently even in non-batch mode.  If that was what you
were talking about, I think that does make sense.  Thanks.

