Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6FEB211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 03:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbeLEDiC (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 22:38:02 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59373 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbeLEDiC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 22:38:02 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DD9571182ED;
        Tue,  4 Dec 2018 22:37:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rUJ+Yo+LLzz8
        suKtf33VT6XuqMs=; b=MpDxI5lmlSsMZ/xJaQKdXs7oiDtgXbww7DPCNmMmarS2
        K5ms+pKzt37kZTaZgVtqxdB1U0o3SuI581Ha2TTXLQW4LadBEEY4HW666ZFi6EV+
        vaKdKuH8+y0qNMnOIc2uswrQYsYEB5yMW4d8xoogTliDTWB90zKMSEsU1nRLCRY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Ee5U8g
        ZS9fIOnLIE7KyTCEa5oYctmkLfLC5Ywy15XwfjUwWt8Xn+EREIEmIGmrsnr8GyEN
        fX0ruXTMtUbD/WrPTYL7DfGvDWUqGVSZyU21+O5owK9WgiUmWnyrOSHCm3I62voR
        GwPeTwfIauE/Vh5cPskLzJFm00uJ3r0TfmGnk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D597B1182EC;
        Tue,  4 Dec 2018 22:37:59 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 51C8F1182EB;
        Tue,  4 Dec 2018 22:37:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 3/3] sha1-file: change alternate "error:" message to "warning:"
References: <87tvjtvah0.fsf@evledraar.gmail.com>
        <20181204132716.19208-4-avarab@gmail.com>
Date:   Wed, 05 Dec 2018 12:37:58 +0900
In-Reply-To: <20181204132716.19208-4-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 4 Dec 2018 14:27:16 +0100")
Message-ID: <xmqqva48d4o9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 29402234-F83F-11E8-ADB4-063AD72159A7-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the "error" message emitted by alt_odb_usable() to be a
> "warning" instead. As noted in commits leading up to this one this has
> never impacted the exit code ever since the check was initially added
> in 26125f6b9b ("detect broken alternates.", 2006-02-22).
>
> It's confusing to emit an "error" when e.g. "git fsck" will exit with
> 0, so let's emit a "warning:" instead.

OK, that sounds sensible.  An alternative that may be more sensible
is to actually diagnose this as an error, but the purpose of this
message is to help users diagnose a possible misconfiguration and
keeping the repository "working" with the remaining set of object
stores by leaving it as a mere warning, like this patch does, is
probably a better approach.

