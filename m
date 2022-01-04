Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3467C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 21:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbiADVDv convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 4 Jan 2022 16:03:51 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:34798 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiADVDv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 16:03:51 -0500
Received: by mail-ed1-f42.google.com with SMTP id u25so32029142edf.1
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 13:03:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc:content-transfer-encoding;
        bh=tk960x4lPcUphLkRXpBavtT2DNi+4OCkqxrLsc0N1QQ=;
        b=HLnEuslryYmwINyxJg0sf8PpGsGQJcEEVIpUK8FSrd6LIv7jkSmcs1nSBKq9VtLKok
         l2JMeYsBAq9MyWVWlWs3rwWrPNaurvsdYCnmQbpRWyu6yPZdiGyYzEri3VudYVxYnmsm
         5KxepBE9783zhuDZPYOaVN4clJvEDXxWhKZK48Nj9pYY4Xsbf7EcbEJgX8IfQphrU6XZ
         CKXa/R4gqEIBLsU7fRHeQtPpe5/b7g5xAh/4QT4M7eh8wl0Ew0B86o/cjDxSJ4Qo0quH
         5iIlh8+KYp4s1oLUaJj+TaGPfEaqQJRd5TgvILb7bBlRcaKISrh6oiGz9kHzqmktaEcG
         0BLQ==
X-Gm-Message-State: AOAM530bp0hTytgT9rAKkcvuNvpc62uTtXUxW2S46NsjT5CUBPh/xhSb
        6UjLk9GgAdELz8Q1NtrBTHqqrApRCVyLQjixeX3UMgnq4x0=
X-Google-Smtp-Source: ABdhPJyFCTzLDZCAZ/WXPtaXN+2uIXD3B43cJWf9YmmeGI30pGI+cLPE8t/xybLYduWy2KY/UHq6s+A/nO4ogvqVItY=
X-Received: by 2002:a17:907:3ac1:: with SMTP id fi1mr39624412ejc.668.1641330229736;
 Tue, 04 Jan 2022 13:03:49 -0800 (PST)
MIME-Version: 1.0
References: <9749fa2c-b08d-c08b-ce43-041d13852d02@web.de> <1240d0cd-230d-8a80-2250-37336b834834@iee.email>
 <cb8d6e8a-aaca-c2eb-6cc8-5c4ad33adfdb@gmail.com>
In-Reply-To: <cb8d6e8a-aaca-c2eb-6cc8-5c4ad33adfdb@gmail.com>
From:   Tilman Vogel <tilman.vogel@web.de>
Date:   Tue, 4 Jan 2022 22:03:38 +0100
Message-ID: <CAAbQbbCtFnbfTHnMdY_xi1CN4NyppShZdVhgO73YMubgDjwB-A@mail.gmail.com>
Subject: Re: [BUG] git pull --rebase ignores rebase.autostash config when fast-forwarding
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oh, please excuse my lack of providing the version info: I discovered
the behaviour on 2.34.1 as shipped by current openSUSE Tumbleweed.
Then, I worked on-top of current git master (2ae0a9cb).

Regards and thanks for investigating and fixing this so quickly!

Tilman


Am Di., 4. Jan. 2022 um 19:03 Uhr schrieb Philippe Blain
<levraiphilippeblain@gmail.com>:
>
> Hi Tilman,
>
> Le 2022-01-04 à 07:59, Philip Oakley a écrit :
> > On 03/01/2022 18:08, Tilman Vogel wrote:
> >> Hi git-people,
> >>
> >> I ran into strange behavior when having rebase.autostash enabled and
> >> doing a git pull --rebase:
> >>
> >>> git config rebase.autostash true
> >>> git pull --rebase
> >> Updating cd9ff8a..f3c9840
> >> error: Your local changes to the following files would be overwritten by
> >> merge:
> >>          content
> >> Please commit your changes or stash them before you merge.
> >> Aborting
> >>
> >> Confusingly, this fixes the issue:
> >>
> >>> git config merge.autostash true
> >>> git pull --rebase
> >> Updating cd9ff8a..f3c9840
> >> Created autostash: c615fda
> >> Fast-forward
> >>   content | 1 +
> >>   1 file changed, 1 insertion(+)
> >> Applied autostash.
> >>
> >> Leaving me wonder why merge config options fix rebase behavior.
> >>
> >> So, in order to make it easier to check the problem, I added some
> >> test-cases to the git test-suite. Please see the attached patch.
>
> Thanks, this really makes it easier to bisect the issue.
>
> >>
> >> Or here:
> >> https://github.com/tvogel/git/commit/bc941f9357518a34cfa11788dfb8e7fa7f711705
> >>
> >> I did not try to find the root-cause as I am not experienced with the
> >> code-base but if there are questions, let me know.
> >
> > Which version are you running?
> >
>
> That's a good info to include indeed. I'm guessing you are using v2.34.1 as that's the version
> indicated at the bottom of your attached patch. I can replicate the behaviour on my side on 2.34.1.
> I did not bisect manually but I'm pretty sure it's a regression caused by 340062243a (pull: cleanup autostash
> check, 2021-06-17) (author CC'ed). I checked that the parent of that commit passes all 4 of your added tests, provided
> this is squashed in:
>
> diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
> index 4046a74cad..5ad19b1028 100755
> --- a/t/t5521-pull-options.sh
> +++ b/t/t5521-pull-options.sh
> @@ -260,7 +260,6 @@ test_expect_success 'git pull --rebase --autostash succeeds on ff' '
>         test_commit -C src --printf "more_content" file "more content\ncontent\n" &&
>         echo "dirty" >>dst/file &&
>         git -C dst pull --rebase --autostash >actual 2>&1 &&
> -       grep -q "Fast-forward" actual &&
>         grep -q "Applied autostash." actual
>   '
>
> @@ -273,7 +272,6 @@ test_expect_success 'git pull --rebase with rebase.autostash succeeds on ff' '
>         echo "dirty" >>dst/file &&
>         test_config -C dst rebase.autostash true &&
>         git -C dst pull --rebase  >actual 2>&1 &&
> -       grep -q "Fast-forward" actual &&
>         grep -q "Applied autostash." actual
>   '
>
> After that commit, in case of fast-forward, 'git pull --rebase --autostash' delegates the fast-forward
> operation to 'git merge' under the hood, which was not the case before. The '--autostash' flag seems
> to be forwarded correctly to that 'git merge' invocation, but the config 'rebase.autostash' seems to not
> be passed along.
>
> I did not yet look into why in the code itself. That does explain however why 'merge.autostash' makes it
> work - the 'git merge' invocation does check its own config, and if merge.autostash is there the autostash
> behaviour is activated.
>
> Philippe.
>
>
