Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BECC4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 09:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA076610A4
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 09:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238211AbhHJJpI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 05:45:08 -0400
Received: from mail-4316.protonmail.ch ([185.70.43.16]:37889 "EHLO
        mail-4316.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237640AbhHJJpG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 05:45:06 -0400
X-Greylist: delayed 56895 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Aug 2021 05:45:06 EDT
Date:   Tue, 10 Aug 2021 09:44:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eagain.st;
        s=protonmail; t=1628588681;
        bh=tHFocuPbwp2lldicQwzqxDq8CaodA4pJFv49gGw0Ui0=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=bVER8NespkGYm7QoGNGEmwxc+4+s5MbFoB+yyBH+ZFHcYWcv+2NabA/XQwxl34OEQ
         mGmBTQU+vA6/DxEL2VBMlzgTwialrHQaW6u6nMFkC2L2MYdOjD0zpogkl4prMZKoCG
         LVvij0MLbglarDTCn0zl3+5m0vfGQQjugrk164BdioByM/MMcttKBX2scA7FbeEsuh
         Oeb98ghvlXZn5CWe/TC4Z8v/UhlI9cy5Xiig2In+w3NLDMZq6aUCYDZsImHvollTAT
         FgI6/23ZaLsuCtoOSAuIG4BmxlCQnBq6f3fRnrL4UXKfGChMoDTzpJ0iDooe48WSS5
         c5tUU/IbWWVHQ==
To:     Jonathan Nieder <jrnieder@gmail.com>
From:   Kim Altintop <kim@eagain.st>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        jonathantanmy@google.com, bwilliams.eng@gmail.com
Reply-To: Kim Altintop <kim@eagain.st>
Subject: Re: [PATCH 1/3] t5730: introduce fetch command helper
Message-ID: <20210810114433.GC41632@schmidt.localdomain>
In-Reply-To: <YRGz1bFdBP8X/U29@google.com>
References: <20210730135845.633234-1-kim@eagain.st> <20210731203415.618641-1-kim@eagain.st> <20210804203829.661565-1-kim@eagain.st> <20210804205951.668140-1-kim@eagain.st> <20210809175530.75326-1-kim@eagain.st> <20210809175530.75326-2-kim@eagain.st> <YRGEwFauT5QjMSNO@google.com> <CDFBG4S23B1M.141X9FIPP7YHS@schmidt> <xmqqpmume0oa.fsf@gitster.g> <YRGz1bFdBP8X/U29@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Junio C Hamano wrote:
> > Kim Altintop <kim@eagain.st> writes:
>
> >> Perhaps an alternative would be:
> >>
> >> =09write_fetch_command () {
> >> =09=09write_command fetch &&
> >> =09=09echo "0001" &&
> >> =09=09echo "no-progress" &&
> >> =09=09cat /dev/stdin &&
> >> =09=09echo "done" &&
> >> =09=09echo "0000"
> >>  =09}
> >>
> >>
> >> Which would then be called like so:
> >>
> >> =09write_fetch_command >pkt_cmd <<-EOF &&
> >> =09want-ref refs/heads/main
> >> =09have $(git rev-parse a)
> >> =09EOF
> >> =09test-tool pkt-line pack <pkt_cmd >in &&
> >> =09test-tool serve-v2 --stateless-rpc >out <in &&
> >>
> >>
> >> I'm not sure how portable that is, though. Maybe using `while read -r`=
 instead
> >> of `cat /dev/stdin`?
> >
> > If you drop /dev/stdin, the result would be emimently portable.
> > "cat" without any argument reads from the standard input stream
> > and copies it to the standard output stream.
>
> Yep, with that tweak (using "cat" instead of "cat /dev/stdin") this
> looks like a pleasant enough helper.

Great, I'll reroll like this then. Thanks!

