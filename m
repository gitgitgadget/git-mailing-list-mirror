Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42B4C19F2B
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 22:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239123AbiG2WTL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 18:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238953AbiG2WTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 18:19:09 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B81747AE
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 15:19:08 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 345F41A4DE5;
        Fri, 29 Jul 2022 18:19:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R9iO3HxhMaKCGCQA9L+efg8AwUUvSzc6rUHphV
        KMpIs=; b=Fsed0CpCyKRVMMFKGEsMc8wIfG+XLIV0GwbZ8SsWqBSeCHMTSlk54S
        3IZjtGa23e9w6G5ldfeq1adFDuGkVaJnT6eTrBg62aylNZqetPBxMfEvzBo0u91g
        flGBxtqxAC2jEGeC8l728RuDQhakyfiBV2H80EIBrqw0qoOG0BBFA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2B2261A4DE4;
        Fri, 29 Jul 2022 18:19:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9CD0B1A4DE1;
        Fri, 29 Jul 2022 18:19:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eugen Konkov <kes-kes@yandex.ru>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Re* --creation-factor=100 does not show code
References: <1196830250.20220726145447@yandex.ru>
        <7229p500-p2r4-on87-6802-8o90s36rr3s4@tzk.qr>
        <xmqqo7x9ch7n.fsf_-_@gitster.g>
        <85snn12q-po05-osqs-n1o0-n6040392q01q@tzk.qr>
Date:   Fri, 29 Jul 2022 15:19:03 -0700
In-Reply-To: <85snn12q-po05-osqs-n1o0-n6040392q01q@tzk.qr> (Johannes
        Schindelin's message of "Fri, 29 Jul 2022 15:16:12 +0200 (CEST)")
Message-ID: <xmqq5yjf4l60.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74BABB76-0F8C-11ED-85F9-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> As to the original claim that percentages only go from 0-100, that is
> easily refuted. If you wanted to pay $12 for something but ended up having
> to pay $30, you'll end up having paid 150% more than planned. There you
> are. A percentage that is greater than 100.

Playing word games and nitpicks on what I said may have helped you
stroke your ego and annoy other folks (including me) in the
discussion, but unfortunately I do not think it is helping us get
closer to improve either the documentation or behaviour of
range-diff.  Now, let's be a bit more constructive and find a way to
unconfuse people like the original reporter?

When we say an option's value is expressed in <percent>, unless we
are careful, people will assume that the valid value the option will
take will lie between 0 and 100, and you cannot blame them.  IOW,
while the word "percent" may be 100% correct in your mind, the way
it is used to describe the feature in "git range-diff --help", it
was not sufficient to help readers.

If we were describing a hypothetical Git subcommand that shows a
picture of a panda, with an option to show the picture in different
sizes, perhaps "git panda --scale=<percent>" option is described
like so:

	--scale=<percent>::
		Instead of showing the picture of a panda at its
		default size, show it scaled.  "--scale=50" means
		show it at 50%, i.e. half the width and height.
		"--scale=200" would show the picture at twice the
		width and height.

and such a description would make it plenty clear that the valid
value range is not constrainted in 0..100.  We'd need something
similar to help users of "git range-diff".

Thanks.
