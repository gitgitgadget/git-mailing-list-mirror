Return-Path: <SRS0=yrqn=7N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C52CC433DF
	for <git@archiver.kernel.org>; Sun, 31 May 2020 17:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B04092074A
	for <git@archiver.kernel.org>; Sun, 31 May 2020 17:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="blXQbzMQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgEaRfe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 May 2020 13:35:34 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64332 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgEaRfe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 May 2020 13:35:34 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8CC28CDCCF;
        Sun, 31 May 2020 13:35:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uCKV9Ni2pdY5BwfOIvC8k/g4ndk=; b=blXQbz
        MQcw0MrjC4WLEfcgqy8QpZhefcwEELy57G1szIrjd0v3PjPpVnqnI2pWadX5/iKt
        FIQVo0OLZo594ixeMblm2c6sBrnoIj6tyDj79WG0mpkWNEp4VWY/QU3NDgbySmJE
        aE/YfJ7GXW7w01etu5dFp8noA3ChBs5SfCxek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wEUcxuye+el4lLY+rQHqvYZgv+JEcaiV
        YoF6iJgCnyFordPhfw452lwPKYv/n/oj6THtLh63CM9b2QXjNF72dRbC6sdkaxDE
        1GKl1G8JNgKyLfb74FosPPthVGY+twZQpmip0hoH3MpNDs7Qt1s8h7KSDlk39VmO
        WBAv/VYzL28=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 85351CDCCE;
        Sun, 31 May 2020 13:35:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9EA28CDCCA;
        Sun, 31 May 2020 13:35:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 8/8] upload-pack: send part of packfile response as uri
References: <cover.1590789428.git.jonathantanmy@google.com>
        <2cfee363873736d9ff73cd38d96f3533bb49c904.1590789428.git.jonathantanmy@google.com>
Date:   Sun, 31 May 2020 10:35:27 -0700
In-Reply-To: <2cfee363873736d9ff73cd38d96f3533bb49c904.1590789428.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Fri, 29 May 2020 15:30:20 -0700")
Message-ID: <xmqq367gvwgw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F13E2DC-A365-11EA-A168-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>  static void create_pack_file(const struct object_array *have_obj,
>  			     const struct object_array *want_obj,
> -			     struct list_objects_filter_options *filter_options)
> +			     struct list_objects_filter_options *filter_options,
> +			     const struct string_list *uri_protocols)
>  {

I wanted to see why you rebased on top of 'next' to see possible
interactions with topics in-flight, and I found out that this series
was trivial to rebase on 'master'.

The codebase however is moving in the direction to reduce the number
of parameters this function takes, and the above change does not
play well with the cc/upload-pack-data-2 topic that cleans up the
code around this area.

Can you help review cc/upload-pack-data and cc/upload-pack-data-2
topics, as you'd eventually be basing your topic on top of the
result of merging these two clean-up topics to 'master'?  The former
is already in 'next' after Peff's review, and after finding nothing
glaringly wrong in it, I am not so worried about it, but the latter
may benefit from an extra set of eyes.

Thanks.


