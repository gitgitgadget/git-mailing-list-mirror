Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31555C77B73
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 13:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjDSNhu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 09:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbjDSNhr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 09:37:47 -0400
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9634C16B3E
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 06:37:08 -0700 (PDT)
Date:   Wed, 19 Apr 2023 13:36:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1681911426; x=1682170626;
        bh=wP9qEL05mkL94BImzltNSYuSsXAVXisXf7zX+bvsrrA=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=nHFPOL9vrmr2i2CtKG7Kg2SUDRLHYqfX9tXQlNAPXIdnpRv4GTKVQMbzWfWtwTbbq
         v0/WlqvHxYyBKQGhhuBaa86/Pw2YIjrYkYpeSY0/U5TmXi1i7Ml4fCLodTk20SZ1kW
         2IFZizcaym9BGesWguVurZ5PT4o+KV73o8BXZQvLGqN7UXpYzXjBAsWm/5jz4pF7dA
         jQr9sIMzX4liSlVTq+7JWSFtBWeMoiKh+ua4Oc86+L5owcHP2fyfmyPbVySppkIcCd
         1NXOXxrESjXdMfufjYwFIAqJpKmrzTDbA14jj/qQijza82Lhn6NC6jeuUHkhquynNo
         pSnuaoALPu82Q==
To:     Junio C Hamano <gitster@pobox.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v9 2/8] t2400: print captured git output when finished
Message-ID: <zyuwfbx5e57ly4ybfbnapbzbkw4ib5xbreu3nawkd4f5srhgfe@pwp4gw3hbgap>
In-Reply-To: <xmqqsfcxdu9k.fsf@gitster.g>
References: <20230417093255.31079-1-jacobabel@nullpo.dev> <20230417093255.31079-3-jacobabel@nullpo.dev> <xmqq8reqkyfz.fsf@gitster.g> <olztmib77r35mx33a655obqpxui6coj74hfxoxfvcudnkpbqns@ixerneqaai45> <xmqqsfcxdu9k.fsf@gitster.g>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/04/19 09:23AM, Jacob Abel wrote:
> On 23/04/18 09:34AM, Junio C Hamano wrote:
> > [...]
>
> Ah ok I understand what you mean now.
>
> Would the following work? Since all we care about in `git worktree add` i=
s
> `stderr`, can't we just duplicate `stderr` to `stdout` while redirecting
> stderr to `actual` so that in the event the git command fails, it's still
> displayed in the output of `sh t2400-*.sh -x`?
>
> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> index 82091cbb1f..a8f734b1c3 100755
> --- a/t/t2400-worktree-add.sh
> +++ b/t/t2400-worktree-add.sh
> @@ -327,8 +327,7 @@ test_expect_success 'add -B' '
>
>  test_expect_success 'add --quiet' '
>  =09test_when_finished "git worktree remove -f -f another-worktree" &&
> -=09test_when_finished "cat actual" &&
> -=09git worktree add --quiet another-worktree main 2>actual &&
> +=09git worktree add --quiet another-worktree main 2>actual 2>&1 &&
>  =09test_must_be_empty actual
>  '
>

Ok scratch that. I tried checking this a bit more and it doesn't work quite
as expected. I'll remove the `cat actual`s from the tests and if I can
think of a better alternative, I'll report back.

