Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5222EB64DC
	for <git@archiver.kernel.org>; Mon, 17 Jul 2023 20:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjGQUxP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jul 2023 16:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjGQUxN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2023 16:53:13 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7795810C7
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 13:52:24 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D98EE1F066;
        Mon, 17 Jul 2023 16:52:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=q/C4Qtu+7snM
        sy7KVeWUphw1LEEN93Yc/iY5Me8M7oU=; b=sjrRc8Dq8AsSuUz6w1/uJVPqmQe4
        G0TQ9NpGewcH0cMGfixpqdgzwwZksrmQYRuOV79S5Js/Poa2MFtuqlWGYUWtEV+E
        y6whhMbILQfJ6nqyjT9gXfWiHX+lcclRpb6Rh9tdEwbF2CVovqJ9XHALinq1iowv
        d0NYmFENAlXqxdQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D25011F065;
        Mon, 17 Jul 2023 16:52:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8ACCB1F064;
        Mon, 17 Jul 2023 16:52:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Adam_=5C=22Sinus=5C=22_Skawi=C5=84ski?= 
        <adam.skawinski@sinpi.net>
Cc:     git@vger.kernel.org
Subject: Re: receive.denyCurrentBranch=updateInstead won't update the repo
References: <CAGE71k3Ccm3hBrfNgXFqO9Zk0V9FkoskgD1ViJ6eSakxdBuqQQ@mail.gmail.com>
Date:   Mon, 17 Jul 2023 13:52:19 -0700
In-Reply-To: <CAGE71k3Ccm3hBrfNgXFqO9Zk0V9FkoskgD1ViJ6eSakxdBuqQQ@mail.gmail.com>
        ("Adam \"Sinus\" =?utf-8?Q?Skawi=C5=84ski=22's?= message of "Mon, 17 Jul
 2023 22:26:26
        +0200")
Message-ID: <xmqqzg3ugt18.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D2AD93BC-24E3-11EE-9A6D-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Adam \"Sinus\" Skawi=C5=84ski"  <adam.skawinski@sinpi.net> writes:

> Note: The `push-to-checkout` hook doesn't seem to run, either, even
> though it's in the .git/hooks/push-to-checkout file, with +x rights as
> needed. I made it output some lines and exit with code 1, so it should
> abort after producing the output - and yet the pushes come through.
> Other hooks, like `update`, work fine and can abort if they exit 1.

I have nothing to offer offhand, but have you compared on the server
side your "update" and "push-to-checkout" hooks?  Even a simple typo
of the filename "push-to-checkout" would make it untable to run ;-).
Similarly to the name of the configuration variable, which is rather
long and prone to be mistyped.  After staring at a problem for a
long time getting frustrated, I myself would miss such a trivial
mistake, and would want to go back and double check just to be sure.

In fact, while trying to reproduce the problem with a simple pair of
repositories, I did manage to mistype denyCurrentBranch and saw that
the machinery not to kick in at all ;-).
