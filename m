Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90DEC433EF
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 15:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiFXPeA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 11:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiFXPdz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 11:33:55 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C78E0A6
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 08:33:53 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 049071466BF;
        Fri, 24 Jun 2022 11:33:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0kA6x/xbUFDw
        Qm+IX2QNgjBa3/JpTxjMhDcVbYEc/lE=; b=rTtxcx4wAqvlEXNZl5tuNVlBcTqG
        6UrY+l4Nlp5uNJylfAhSWKOoHomzAQRcuHdRGcnT8LnFC2TmbsukweHcNsXBZcnc
        hN2qnE8Udh0tFuuTtjqqc9nB061LbPo5bGhdJAP4yHs404O2PiyChyM+a76NG2/l
        jcDsq8+nxpuL3YM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F0C601466BE;
        Fri, 24 Jun 2022 11:33:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5E5C71466BD;
        Fri, 24 Jun 2022 11:33:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v3] ls-files: introduce "--format" option
References: <pull.1262.v2.git.1655629990185.gitgitgadget@gmail.com>
        <pull.1262.v3.git.1655777140231.gitgitgadget@gmail.com>
        <220624.86letmi383.gmgdl@evledraar.gmail.com>
Date:   Fri, 24 Jun 2022 08:33:51 -0700
In-Reply-To: <220624.86letmi383.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 24 Jun 2022 15:25:13 +0200")
Message-ID: <xmqqsfnuvzxc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0D0A2F9A-F3D3-11EC-8D3F-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Jun 21 2022, ZheNing Hu via GitGitGadget wrote:
>> +	if (skip_prefix(start, "(objectmode)", &p))
>> +		strbuf_addf(sb, "%06o", data->ce->ce_mode);
>> +	else if (skip_prefix(start, "(objectname)", &p))
>> +		strbuf_add_unique_abbrev(sb, &data->ce->oid, abbrev);
>> +	else if (skip_prefix(start, "(stage)", &p))
>> +		strbuf_addf(sb, "%d", ce_stage(data->ce));
>> +	else if (skip_prefix(start, "(path)", &p))
>> +		write_name_to_buf(sb, data->pathname);

These are just "values".

>> +	else if (skip_prefix(start, "(ctime)", &p))
>> +		strbuf_addf(sb, "ctime: %u:%u",
>> +			    sd->sd_ctime.sec, sd->sd_ctime.nsec);
>> +	else if (skip_prefix(start, "(mtime)", &p))
>> +		strbuf_addf(sb, "mtime: %u:%u",
>> +			    sd->sd_mtime.sec, sd->sd_mtime.nsec);
>> +	else if (skip_prefix(start, "(dev)", &p))
>> +		strbuf_addf(sb, "dev: %u", sd->sd_dev);
>> +	else if (skip_prefix(start, "(ino)", &p))
>> +		strbuf_addf(sb, "ino: %u", sd->sd_ino);
>> +	else if (skip_prefix(start, "(uid)", &p))
>> +		strbuf_addf(sb, "uid: %u", sd->sd_uid);
>> +	else if (skip_prefix(start, "(gid)", &p))
>> +		strbuf_addf(sb, "gid: %u", sd->sd_gid);
>> +	else if (skip_prefix(start, "(size)", &p))
>> +		strbuf_addf(sb, "size: %u", sd->sd_size);
>> +	else if (skip_prefix(start, "(flags)", &p))
>> +		strbuf_addf(sb, "flags: %x", data->ce->ce_flags);

These are not.

> In my mind almost the entire point of a --format is that you can
> e.g. \0-delimit it, and don't need to do other parsing games.
>
> So this really should be adding just e.g. "%x", not "flags: %x",=20

Yes.  A very good point, if we were showing these fields (I already
said I doubt it is useful), they should also show just "values"
After all, people can do "--format=3Dmode: %(objectmode)" if they want
an identifying tag before the value.

Thanks.
