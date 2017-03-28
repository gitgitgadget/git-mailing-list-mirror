Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 858B01FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 21:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754801AbdC1VUb (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 17:20:31 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:32834 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752401AbdC1VUa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 17:20:30 -0400
Received: by mail-pg0-f50.google.com with SMTP id n5so76462288pgh.0
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 14:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Cn+0Rn/7m/CrgEu8A/ZomarWQca+xwsAbIZuY9DdlJs=;
        b=oo+FUYhCsbdcY5BipNgQPF1AI7LwOmvLSA91IUkY7Ts7J4uqAPyO8dE1HSfMyQRJ5J
         qWGAs+gWJUV1NNGsVR7xnzOivK8B0+8PDOrtoAOVh1FQFMQk5SJmAU79dR9qrsHKjYX8
         pUx2R7x2fUvXIzxEEt8r5DUkZc8nY4Wgv2ZrxBAe9Zr1Ign12CZD7wlOJfAkVYrhtJaZ
         nvwzQ1h2ooW9KtRwkq+rhb1/jXGV9fDWaxyPcszKgzWk29sf8cqObPeBC4cPL9nRv3DS
         asAs2cuauSqbaD6GfHGFeQnmcRAp9QFYKTaQ0styNg3XG70LHnHQ3DM10byrbgtzYC2T
         XrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Cn+0Rn/7m/CrgEu8A/ZomarWQca+xwsAbIZuY9DdlJs=;
        b=PFrfvHokGrqKK25Bm+HPtn/RNVcuah4pA9oqissLXcraE/c0R2BB1GcOQpheULexqR
         sgSP39b5I7RBHxA7sKBmvOZAipesJlzRTisEt8TpA//NZNkr0trJp2y1ISI3SSMyaNjj
         p/3raJ89RvRgTRpOyFdyhnE7U1sIErwIb65k1QRZAogvbTF5YpfoMbWYvijEXmU6Ts4q
         EfdaeYmtMUxo5wGIroHV/lYYsDzUz2Cl7O8tIMLciJ/A5RhFjJqNX0U+PogntwXAN3M2
         NUxm9FfOJfYgzHHGZk/L6NgjnTDJ1dowLuNYj9mohAOArnzS7EGdfOtfTWvcpHyfen5U
         ZR8w==
X-Gm-Message-State: AFeK/H0lcjU/vuq7PEFYChHH8s2jmrhcGA8Ckev3iVozlJurQS7AGXw7/9fUKACobsBbeVqJs/5pEzmw3YHvfIV5
X-Received: by 10.99.247.69 with SMTP id f5mr32931987pgk.63.1490736008863;
 Tue, 28 Mar 2017 14:20:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.186.196 with HTTP; Tue, 28 Mar 2017 14:20:08 -0700 (PDT)
In-Reply-To: <xmqqpoh2z93q.fsf@gitster.mtv.corp.google.com>
References: <20170324182902.19280-1-sbeller@google.com> <20170325003610.15282-1-sbeller@google.com>
 <20170325003610.15282-8-sbeller@google.com> <xmqqpoh2z93q.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 28 Mar 2017 14:20:08 -0700
Message-ID: <CAGZ79kYmWW5tp26aCkWeYjyp8KeP2jcL43JGiPO3pHW=wo7uzw@mail.gmail.com>
Subject: Re: [PATCH 7/7] submodule.c: correctly handle nested submodules in is_submodule_modified
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 27, 2017 at 2:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> When a nested submodule has untracked files, it would be reported as
>> "modified submodule" in the superproject, because submodules are not
>> parsed correctly in is_submodule_modified as they are bucketed into
>> the modified pile as "they are not an untracked file".
>
> I cannot quite parse the above.

I tried to describe the example Jonathan gave in his reply in a shorter form.
I'll
>> +                     /* regular unmerged and renamed files */
>> +                     if (buf.buf[5] == 'S' && buf.buf[8] == 'U')
>> +                             /* nested untracked file */
>> +                             dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
>
> OK, we have untracked one.
>
>> +                     if (memcmp(buf.buf + 5, "S..U", 4))
>> +                             /* other change */
>> +                             dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
>
> And for other cases like C at buf.buf[6] or M at buf.buf[7],
> i.e. where the submodule not just has untracked files but has real
> changes, we say it is truly MODIFIED here.
>
> If there are changes to paths that is not a submodule but a tracked
> file in the submodule in question would have N at buf.buf[5] and is
> also caught with the same "not S..U so that's MODIFIED" logic.
>
> OK.

ok, thanks for checking.

>
> Shouldn't this done as part of 4/7 where is_submodule_modified()
> starts reading from the porcelain v2 output?

I did that in an earlier version of the series. However the change from
porcelain=1 to 2 should not be observable by the end user.

>  4/7 does adjust for
> the change from double question mark (porcelain v1) to a single one
> for untracked, but at the same time it needs to prepare for these
> 'u' (unmerged), '1' (normal modification) and '2' (mods with rename)
> to appear in the output, no?

No, up to patch 5/7 we only had refactors, no user visible changes
intended. And until then we had "has untracked files" and "everything
else". The nice part of the conversion was to cover the "everything else"
part easily.

This patch transforms it into "has untracked files or submodule reports
untracked files (possibly nested)" and "everything else", but the former
is more complicated to compute.

> IOW, with 4/7 and 7/7 done as separate steps, isn't the system
> broken between these steps?

No, see Jonathans answer.

We could argue, that 6/7 and 7/7 done as separate steps is broken,
because since 6/7 we promise to report untracked files inside
submodules as " ?", but we do not report them properly for nested
submodules.

Suppose I have a superproject 'parent', with two submodules 'parent/sub'
and 'parent/sub1'. 'parent/sub' itself contains a submodule 'parent/sub/subsub'.
Now suppose I run, from within 'parent':

    echo hi >sub/subsub/stray-file
    echo hi >sub1/stray-file

with patches 1..5:
    git status --short
     M sub
     M sub1

patch 6:
    git status --short
     m sub
     ? sub1

with patch 7:
    git status --short
     ? sub
     ? sub1

The documentation update in patch 6 is unclear what to expect from
nested submodules, so that documentation is technically not wrong,
but maybe misleading.

I want to resend patch 7 with a documentation update as well as tests.

Thanks,
Stefan
