Return-Path: <SRS0=Fs4s=6X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADDFC54E49
	for <git@archiver.kernel.org>; Sat,  9 May 2020 21:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD2052192A
	for <git@archiver.kernel.org>; Sat,  9 May 2020 21:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="akm2lMT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgEIVl7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 17:41:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54065 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgEIVl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 May 2020 17:41:58 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DAA2AB92D8;
        Sat,  9 May 2020 17:41:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ACBfcMGb7Ui+5fyC1a901vNnWks=; b=akm2lM
        T0RxTUN8i4LVln0m7L9DiqUjqvO+ndVBAf0j4YaT6+V/S8xmDQfl4pqFDY8s2WM7
        +H0d3Vtot50hPWSB9w2hcvdrZUa3r84LRa6zbFYCzPfRsCSaGzSHCCCvpffVRYhH
        4uja97vb2QE5XI87rKw1GeLoBz1s9VX/YETeo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IjCD377H4xaiBov9Wvsa39+v7d1RM0Sc
        Ydb62GBIeRMhK/xdmpAPn7zrKjrHL3DPJixuxPyrHn+9jWaYgFJBY912DtwGvX5/
        3L7JS1f5bGFyjSnufOAPM+u71HQxh/qq29dKae/SlTtA1siGEq+fyG8vqn/jTsfE
        Rzjq2N4z828=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D2BACB92D7;
        Sat,  9 May 2020 17:41:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 260ABB92D5;
        Sat,  9 May 2020 17:41:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     George Brown <321.george@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] contrib/git-jump: cat output when not a terminal
References: <CAFKec1W0-OOQYypP-3VC=dJnuNDrykdQ2xibc=u4D=Zo6if-+Q@mail.gmail.com>
Date:   Sat, 09 May 2020 14:41:52 -0700
In-Reply-To: <CAFKec1W0-OOQYypP-3VC=dJnuNDrykdQ2xibc=u4D=Zo6if-+Q@mail.gmail.com>
        (George Brown's message of "Sat, 9 May 2020 20:15:40 +0100")
Message-ID: <xmqqd07cvl9b.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E63E358A-923D-11EA-8656-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

George Brown <321.george@gmail.com> writes:

> contrib/git-jump: cat output when not a terminal
>
> The current usage to populate Vim's quickfix list cannot be used from
> within the editor as it invokes another instance.
>
> Check if stdout is to a terminal or not. If not simply cat the output.

The are editors that open their own window, or tell an already open
editor instance to edit the buffer (think: emacsclient) and in order
to be functional, they do not have to be launched from inside a
working terminal window (whose input comes from the keyboard---the
test "-t 1" is an approximate check for that).

Wouldn't this change hurt the users of such an editor?

Would it work to set GIT_EDITOR to "cat" while performing the
"populating quickfix list" (whatever that is) operation?

> Signed-off-by: George Brown <321.george@gmail.com>
> ---
>  contrib/git-jump/git-jump | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
> index 931b0fe3a9..253341c64e 100755
> --- a/contrib/git-jump/git-jump
> +++ b/contrib/git-jump/git-jump
> @@ -19,8 +19,12 @@ EOF
>  }
>
>  open_editor() {
> -    editor=`git var GIT_EDITOR`
> -    eval "$editor -q \$1"
> +    if test -t 1; then
> +        editor=`git var GIT_EDITOR`
> +        eval "$editor -q \$1"
> +    else
> +        cat "$1"
> +    fi
>  }
>
>  mode_diff() {
