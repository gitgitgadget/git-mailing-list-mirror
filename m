Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16DDE20958
	for <e@80x24.org>; Thu, 23 Mar 2017 16:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756357AbdCWQwG (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 12:52:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54691 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756335AbdCWQwF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 12:52:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 466A08A86D;
        Thu, 23 Mar 2017 12:51:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Jlk64mRhcytMVGunBHRYj1QLbw4=; b=Y+ga17
        lVrnVoAcYgKvAYMCTiLWiKz50WpPW16LoPR0EeItF8ug4AFIukGC+mopKguXFNv3
        6KGgy0q/buuFZNGVg+34vPYH/Oqq3vJTEndi90eQ42rn/DNAuFrC2Q1UTH8v31gX
        OHc/eJsz3JArOttmhuoJ1XElHbWldCaHijxd4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gERaZQR/PiJYv2H2zDKO181A8t8+sLVw
        EYZwX46nbCtftWrVB2FGWjLX+1Tb4IYCUsc++buzBWJHTblFRU3l2LThg+sgFqYR
        pIu3u97xY4Mo+6Sb16P3o1brG1aiJo/KClsRVmO7j6sfssp2oKYiaaMSxIE9Mp3D
        Lp34iLyNGVw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F5D58A86C;
        Thu, 23 Mar 2017 12:51:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A8EEE8A86B;
        Thu, 23 Mar 2017 12:51:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2 3/3] sequencer: allow the commit-msg hooks to run during a `reword`
References: <cover.1490194846.git.johannes.schindelin@gmx.de>
        <cover.1490285210.git.johannes.schindelin@gmx.de>
        <315c237eb50572f8e109ea547a2010d9f81c3aff.1490285210.git.johannes.schindelin@gmx.de>
Date:   Thu, 23 Mar 2017 09:51:51 -0700
In-Reply-To: <315c237eb50572f8e109ea547a2010d9f81c3aff.1490285210.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 23 Mar 2017 17:07:17 +0100
        (CET)")
Message-ID: <xmqq60j0ey1k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 04007FE0-0FE9-11E7-9D2A-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> @@ -996,6 +998,8 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>  		if (res || command != TODO_REWORD)
>  			goto leave;
>  		flags |= EDIT_MSG | AMEND_MSG;
> +		if (command == TODO_REWORD)
> +			flags |= VERIFY_MSG;

Good.  This looks even cleaner than what we discussed during the
review of the previous round.  After deciding not to return early,
we set the default set of features in flags and then further add
verify-msg in when needed.  Much easier to understand.

