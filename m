Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7BAD20A17
	for <e@80x24.org>; Sun, 15 Jan 2017 02:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750792AbdAOCmY (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jan 2017 21:42:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63468 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750780AbdAOCmX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2017 21:42:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 77AF56111A;
        Sat, 14 Jan 2017 21:42:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fwAh5YeTb7mbcN6hFl9uG5GP6/U=; b=LJKoD7
        cDd2W4F/h8sLCbViDqiJiVMY//caV58jAgudMgY0WBtFSPbhLsLfPsymwX5Gw3uQ
        SmxwNxdHaU25tUpakJg5+sH2YjCeRXdAkOEpkZR9FRbosoEdouRRP5Ugy+KYvjus
        WDlFXNnkx2h6+SDqA5+KZ2JsPIxTajCgZKfyE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XI1F2MhkBAcB91Agr+w55EzdnWUHUg5p
        f0vq7cUuCQl2+KGu4i2e5MY2T3W8FByjEZIQhnNsQqi87zvS+JEMqh8adrsQZxTQ
        AhTxN/ORZlxjvJ6F88ip+mqnbxmoYf4WpoFZfkFz+FGEp4l+2oznwKbV7il6uP/O
        3IFg+fv3c5Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BD8B61119;
        Sat, 14 Jan 2017 21:42:22 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BD68561118;
        Sat, 14 Jan 2017 21:42:21 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCHv3 2/2] builtin/commit.c: switch to xstrfmt(), instead of snprintf,
References: <20170113175801.39468-1-gitter.spiros@gmail.com>
        <20170113175801.39468-2-gitter.spiros@gmail.com>
        <20170113183309.GA28002@google.com>
        <CA+EOSBm_ciQ-7bXuzn4Ba7Q5qqihaYH3Sdkkv+0M0VKWbhk=7w@mail.gmail.com>
Date:   Sat, 14 Jan 2017 18:42:20 -0800
In-Reply-To: <CA+EOSBm_ciQ-7bXuzn4Ba7Q5qqihaYH3Sdkkv+0M0VKWbhk=7w@mail.gmail.com>
        (Elia Pinto's message of "Sat, 14 Jan 2017 13:42:18 +0100")
Message-ID: <xmqqr345cacz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3D4BD382-DACC-11E6-93AF-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elia Pinto <gitter.spiros@gmail.com> writes:

> Ok. I agree. But  is it strictly necessary to resend for this ?

FWIW, the attacched is what I queued locally, after complaining
"both have the same title?  They need to be explained better."

In any case, I sense that 2/2 will be redone using strbuf, from the
looks of what is discussed in a subthread nearby?

Thanks.

commit 8d7aa4ba6a00b3ff69261e88b4842c0df5662125
Author: Elia Pinto <gitter.spiros@gmail.com>
Date:   Fri Jan 13 17:58:00 2017 +0000

    builtin/commit.c: remove the PATH_MAX limitation via dynamic allocation
    
    Remove the PATH_MAX limitation from the environment setting that
    points to a filename by switching to dynamic allocation.
    
    As a side effect of this change, we also reduce the snprintf()
    calls, that may silently truncate results if the programmer is not
    careful.
    
    Helped-by: Junio C Hamano <gitster@pobox.com>
    Helped-by: Jeff King <peff@peff.net>
    Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

commit 2a7e328877982557d921a398af9442093290c613
Author: Elia Pinto <gitter.spiros@gmail.com>
Date:   Fri Jan 13 17:58:01 2017 +0000

    builtin/commit.c: switch to xstrfmt(), instead of snprintf()
    
    Switch to dynamic allocation with xstrfmt(), so we can avoid dealing
    with magic numbers in the code and reduce the cognitive burden from
    the programmers.  The original code is correct, but programmers no
    longer have to count bytes needed for static allocation to know that.
    
    As a side effect of this change, we also reduce the snprintf()
    calls, that may silently truncate results if the programmer is not
    careful.
    
    Helped-by: Junio C Hamano <gitster@pobox.com>
    Helped-by: Jeff King <peff@peff.net>
    Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
