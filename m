Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 591832036D
	for <e@80x24.org>; Wed, 22 Nov 2017 01:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751471AbdKVBeb (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 20:34:31 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54865 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751409AbdKVBea (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 20:34:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA0C1B9E0D;
        Tue, 21 Nov 2017 20:34:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yK3dJdLuPCjMCZ5n74/qTzC8gHs=; b=rsTaA6
        exmmVVhFfqAKhK+fJa8rNylj9n81ue5cYiAwszx87DmTcUEtzKcPHpdWkKtBQnKt
        CHiOIOxFzFkNLGDqCU15w748vnAeTAaQwKmz7HsfFqo7ucDPgg4YBluthb5k0G6m
        6wzbSa2zEF+5uKXlbGeIusfT23pewHjnuh6CY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RUB3coFy74A+sz+hSkNrsuEhEtqIjud9
        mzR/8qF7X4t3p8yGN3Hvc/zjpld0C+nUGmndkfWDSq6vvuP37uAPGLBo7E9wVsq8
        zzqB0Z53uqOipFzL38oXSm/mNRfPV+WNffrrJQRID67gYGpXbgpHdFRwnZenD7or
        71NsEc/7/sQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E18A5B9E0C;
        Tue, 21 Nov 2017 20:34:29 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3D150B9E0B;
        Tue, 21 Nov 2017 20:34:29 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Adam <thomas@xteddy.org>
Cc:     Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH] git-send-email: fix get_maintainer.pl regression
References: <20171116154814.23785-1-alex.bennee@linaro.org>
        <CAPig+cTXq6jSN9f2_xyj=Jfv_cg2kUFUtA5uVkZDrRRSi2x7vg@mail.gmail.com>
        <87wp2jwe9o.fsf@linaro.org> <20171121205206.fvwjkkwhil4abmmk@laptop>
Date:   Wed, 22 Nov 2017 10:34:27 +0900
In-Reply-To: <20171121205206.fvwjkkwhil4abmmk@laptop> (Thomas Adam's message
        of "Tue, 21 Nov 2017 20:52:08 +0000")
Message-ID: <xmqq8tezyu3g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4859FC92-CF25-11E7-A85E-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Adam <thomas@xteddy.org> writes:

> Trying to come up with a reinvention of regexps for email addresses is asking
> for trouble, not to mention a crappy rod for your own back.  Don't do that.
> This is why people use Mail::Address.
>
> https://metacpan.org/pod/distribution/MailTools/lib/Mail/Address.pod

Now we are coming back to cc907506 ("send-email: don't use
Mail::Address, even if available", 2017-08-23).  It argues

    * Having this optional Mail::Address makes it tempting to anwser "please
      install Mail::Address" to users instead of fixing our own code. We've
      reached the stage where bugs in our parser should be fixed, not worked
      around.

but if it costs us maintaining our substitute that much, it seems to
me that depending on Mail::Address is not just tempting but may be a
sensible way forward.

Was there any reason why Mail::Address was _inadequate_?  I know we
had trouble with random garbage that are *not* addresses people put
on the in-body CC: trailer in the past, but I do not recall if they
are something Mail::Address would give worse result and we need our
workaround (hence our own substitute), or Mail::Address would handle
them just fine.
