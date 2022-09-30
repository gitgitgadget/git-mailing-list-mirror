Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF0DC43219
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 23:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiI3XYC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 19:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbiI3XYB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 19:24:01 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91677138F28
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 16:24:00 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B2C31145D68;
        Fri, 30 Sep 2022 19:23:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NVcHe/wwiU9A
        9i6yXFBjbujeeBVLMM9xu1DmOENlaUM=; b=Cd4vSa4Fj43MQP9yjnXKYCqVNwkS
        KQ1ClC0BsW+GN10yHcwyfVEtMQ3Kn1zz7gAmWhT37h55z0BVXJxfQLIc0I4Ya7aT
        jUWbJ0xWEzxBz+uh0FkrWpRwJ6b3Ru1aIClQlHyTXbriKxIdMxd8p2/gFWBJA/8g
        169VIpDxlOZmv7g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A92EC145D67;
        Fri, 30 Sep 2022 19:23:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 177CF145D64;
        Fri, 30 Sep 2022 19:23:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
Subject: Re: [PATCH v5 0/6] cat-file: add --batch-command remote-object-info
 command
References: <20220502170904.2770649-1-calvinwan@google.com>
        <20220728230210.2952731-1-calvinwan@google.com>
Date:   Fri, 30 Sep 2022 16:23:58 -0700
In-Reply-To: <20220728230210.2952731-1-calvinwan@google.com> (Calvin Wan's
        message of "Thu, 28 Jul 2022 23:02:04 +0000")
Message-ID: <xmqqedvs78fl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F607DBB2-4116-11ED-986C-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Sometimes it is useful to get information about an object without havin=
g
> to download it completely. The server logic has already been implemente=
d
> as =E2=80=9Ca2ba162cda (object-info: support for retrieving object info=
,
> 2021-04-20)=E2=80=9D. This patch implements the client option for it.
>
> Add `--object-info` option to `cat-file --batch-command`. This option
> allows the client to make an object-info command request to a server
> that supports protocol v2. If the server is v2, but does not allow for
> the object-info command request, the entire object is fetched and the
> relevant object info is returned.
>
> =3D=3D=3D Changes since v4 =3D=3D=3D
>  - Instead of making 2 rounds trips to determine whether the server can
>    handle the client object-info request, the server now advertises the
>    features it can send back so the client can immediately fallback to
>    fetch if any feature is not supported
>  - Fixed nits and clarified some documentation/commit messages
>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> Helped-by: Jonathan Tan <jonathantanmy@google.com>

FWIW, this one seems to make t1006 fail under SANITIZE=3Daddress, i.e.

    $ SANITIZE=3Daddress make test

I thought it would be better to report this before you send out v6
after the release.

Thanks.
