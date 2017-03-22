Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92CA120323
	for <e@80x24.org>; Wed, 22 Mar 2017 18:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965132AbdCVSMq (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 14:12:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50921 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935475AbdCVSMp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 14:12:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C88F7DA2E;
        Wed, 22 Mar 2017 14:12:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uyllWM1/Eglll+d9ufTo7PBx1C0=; b=A9v728
        QhfT0ijlqjBVK4qXzcqD/+gKwPyvsEcUDtpSIfh4x3E3sJKpFrK7Ccellg2I4hpZ
        A/SzqN/Q8g6uhXqasPpCHNl4yYIenwySOxwfwFrLlxmczo/piI7UXY+8nMhH5TDb
        YcHiZ+yUqoet7xXj34NWUSYCpYfck1k4ZrJKU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vPzeoC+tQUvB29gSgBSwVPm5+UJS55E9
        Mp27cJgj1PXTjQPobqqerPyzIX/Z93nYCGzNZ+y+euklZ2MuYSPyxUb/yNcSqumY
        DJxoEIFyQIjTebvIdzlZgWWHrapQ73tlhwMLMwZ5jKuf9fPjR5jIQwTkmN/ea6Pb
        1M9k/Hd70g0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 431C47DA2D;
        Wed, 22 Mar 2017 14:12:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 975C67DA2C;
        Wed, 22 Mar 2017 14:12:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] t7504: document regression: reword no longer calls commit-msg
References: <cover.1490194846.git.johannes.schindelin@gmx.de>
        <773531a3892fb78e8f70e540fc000bceb2c1bb7b.1490194846.git.johannes.schindelin@gmx.de>
        <CAHGBnuPL9CUincZkFR758KcZL3-Ra=n_fbsc1EQ=vio2scod5w@mail.gmail.com>
Date:   Wed, 22 Mar 2017 11:12:41 -0700
In-Reply-To: <CAHGBnuPL9CUincZkFR758KcZL3-Ra=n_fbsc1EQ=vio2scod5w@mail.gmail.com>
        (Sebastian Schuberth's message of "Wed, 22 Mar 2017 16:18:54 +0100")
Message-ID: <xmqqinn1kwo6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 245F5324-0F2B-11E7-B419-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sebastian Schuberth <sschuberth@gmail.com> writes:

> On Wed, Mar 22, 2017 at 4:01 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>
>> Noticed by Sebastian Schuberth.
>
> Thanks for working on the fix.
>
>> +# set up fake editor to replace `pick` by `reword`
>> +cat > reword-editor <<'EOF'
>> +#!/bin/sh
>> +mv "$1" "$1".bup &&
>> +sed 's/^pick/reword/' <"$1".bup >"$1"
>> +EOF
>
> Maybe use
>
> sed -i 's/^pick/reword/' "$1"
>
> here to avoid renaming the input file? Not sure how portable -i for
> sed is, though. Otherwise, maybe remove the file "$1".bup afterwards
> to be clean?

"-i" is GNUism and it is a good idea to avoid it, but cleaning after
itself may be worth doing to avoid contaminating the working tree.

Thanks.
