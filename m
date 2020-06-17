Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25A2C433E0
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 20:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF66E21548
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 20:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KDtlr3Cx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgFQUSj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:18:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60268 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQUSj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 16:18:39 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 330EB7CA74;
        Wed, 17 Jun 2020 16:18:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=HReYSoGdLV3d
        tmNQz4hqBL5F+Yo=; b=KDtlr3CxoQPX/5FVFjKBI5cc5lvRz8bSp/ls3WM1w0Ls
        iDhQ6YKP3CftUP/aWayVcj50ygz35II0l0ZHh8MDxOmdi/+aEivaS6uCk0m7lDI7
        QGsWRrIGNSDurCUuTG08k/JZdAW7FwFiDT/Bef5JhveN2BJXsMKTWFLmB6ozH28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Yd303k
        w0qnvltu1FgrZlXjW32mGSDQ1E/5ygFH0aqaFibTD5boHXv/cLt+7TC9xui1LcC6
        PoHhXxg1OVm7JXe9PeYXA8TF6e06JH88DWYdbcdT+WVn8nq0oybH/E4t7sm7Drne
        1pty36Oa+yZrpQgzcqJPOKEpXcGx2jzxmLUWk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 29A517CA73;
        Wed, 17 Jun 2020 16:18:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A419B7CA72;
        Wed, 17 Jun 2020 16:18:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     git@vger.kernel.org
Subject: Re: git log -- <old path> not working
References: <20200615212521.GT6112@intel.com>
Date:   Wed, 17 Jun 2020 13:18:36 -0700
In-Reply-To: <20200615212521.GT6112@intel.com> ("Ville =?utf-8?B?U3lyasOk?=
 =?utf-8?B?bMOkIidz?= message of
        "Tue, 16 Jun 2020 00:25:21 +0300")
Message-ID: <xmqqlfkltpib.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B99F24D6-B0D7-11EA-A475-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com> writes:

> $ git log -- drivers/acpi/configfs.c
> -> nothing
>
> $ git log --follow -- drivers/acpi/configfs.c
> $ git log --full-history -- drivers/acpi/configfs.c
> -> works
>
> First time I've seen this fail. Expected behaviour for
> some reason, or a bug?

Expected. =20

In a history is branchy and mergy,

    ---O---o---o---o---o---M---x
        \                 /
         o---A---o---B---o

where A, B and possibly M made changes to PATH,

    $ git log X -- PATH

may show nothing if the PATH at O and M are identical.  This is
described in "History Simplification" section of "git log --help"
