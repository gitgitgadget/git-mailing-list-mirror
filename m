Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84FF51FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 23:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754648AbcHZXq1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 19:46:27 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32907 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753133AbcHZXq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 19:46:26 -0400
Received: by mail-wm0-f66.google.com with SMTP id o80so1357104wme.0
        for <git@vger.kernel.org>; Fri, 26 Aug 2016 16:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LUa5fgnfM00teURc5OuTXMEiTA7t5m7IceuBEvw+KsU=;
        b=L4ntiQCMN+wgOLLzzBHbSIaic0nFfRe954U1Ne7+tLvdRDOVm4ZiFopvwZljeBe+XE
         SiwF7ZQS/hJg9KhBBD+LmggTdHJND1vrsE4DvPR+UD0th3osZaQ/BgoTf/8O8BXtBNHs
         1AsWvrtSCruMYfaYzCZe0/bqzDjO8fscpmjifGTiAG8Ui2wurOZK5wCpmZ6/FMZa5wGp
         2NNlH8sCQgbh86X4jgMcTpNVqU9/PIq1UgIdkmun8dhmbO0Lph62PA5ceLYEBhcsHkiV
         xp6MjEk1b/o/7bifHDoAjphAz7fiBGAxk10ztn2xeGgZ8/XkwPsaCV6NxqF68j6PcuLZ
         Z2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LUa5fgnfM00teURc5OuTXMEiTA7t5m7IceuBEvw+KsU=;
        b=dkchwolwW+O1hXVdYkAwpwH6w/O9icv6KaTmIthVZ5fkxJaIv5zComGnuhj/wZFXYw
         s5bbNKP08GZzD178f3KQbNohGcITS1QhUedqHw6SvH6ygcL+sUkTzkB3SZmKJRZN4SGn
         6662+zAzPwWk4KM+e0sHTH4j8/7Lj9ENlPioMjC3eFD2IQm3CAwrdDGKsbZS+omiO39b
         IcHUpvpmMVB+l4U4FJmXPhXa4JGcTdZFSGEEp++oDCR3G6QkNcWgF7msrUWz1mQRCAfC
         J7CIOG9H7N91rfjenP4SAQkqraPI+uUP9p9YrmYbjRBkkuACjGkaRu8wcDr/WK6ukVav
         vIiw==
X-Gm-Message-State: AE9vXwNvwpqCOlc0EYSnI+chgvTin1GHdk7YUDfNVG0VkR2C7YpuH1cMTSQ1QgtPb+83YBjfOVea2TDjAc3nkw==
X-Received: by 10.194.149.113 with SMTP id tz17mr6195441wjb.64.1472255184779;
 Fri, 26 Aug 2016 16:46:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.227.163 with HTTP; Fri, 26 Aug 2016 16:46:24 -0700 (PDT)
In-Reply-To: <xmqqvaz7ys9u.fsf@gitster.mtv.corp.google.com>
References: <20160811184501.384-1-chriscool@tuxfamily.org> <20160811184501.384-13-chriscool@tuxfamily.org>
 <xmqqvaz7ys9u.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 27 Aug 2016 01:46:24 +0200
Message-ID: <CAP8UFD0UxpRbbBeONETjMmdAeA64NoHXc+eAjasYQSCuc5=EyQ@mail.gmail.com>
Subject: Re: [PATCH v12 12/13] apply: learn to use a different index file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 11, 2016 at 10:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> Sometimes we want to apply in a different index file.
>>
>> Before the apply functionality was libified it was possible to
>> use the GIT_INDEX_FILE environment variable, for this purpose.
>>
>> But now, as the apply functionality has been libified, it should
>> be possible to do that in a libified way.
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  apply.c | 10 ++++++++--
>>  apply.h |  1 +
>>  2 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/apply.c b/apply.c
>> index 2ec2a8a..7e561a4 100644
>> --- a/apply.c
>> +++ b/apply.c
>> @@ -4674,8 +4674,14 @@ static int apply_patch(struct apply_state *state,
>>               state->apply = 0;
>>
>>       state->update_index = state->check_index && state->apply;
>> -     if (state->update_index && state->newfd < 0)
>> -             state->newfd = hold_locked_index(state->lock_file, 1);
>> +     if (state->update_index && state->newfd < 0) {
>> +             if (state->index_file)
>> +                     state->newfd = hold_lock_file_for_update(state->lock_file,
>> +                                                              state->index_file,
>> +                                                              LOCK_DIE_ON_ERROR);
>> +             else
>> +                     state->newfd = hold_locked_index(state->lock_file, 1);
>> +     }
>>
>>       if (state->check_index && read_cache() < 0) {
>>               error(_("unable to read index file"));
>
> Here is a call to read_cache() that reads the default index file on
> the filesystem into the default in-core index "the_index".
>
> Shouldn't it be reading from state->index_file instead?

Yes, it should.

> If we limit the review only to the context of your series, I think
>
>     fall_back_threeway()
>      -> build_fake_ancestor() -- uses index_path to use custom index
>      -> discard_cache()
>      -> read_cache_from(index_path) -- reads back the fake ancestor
>      -> write_index_as_tree() -- writes the fake_ancestor
>      -> run_apply(index_path)
>         -> apply_all_patches()
>            -> apply_patch()
>
> is the only codepath that uses a custom index file, so when the
> control reaches this function with a custom index file, the in-core
> index is already populated, making read_cache() a no-op, and that is
> the only thing that makes the resulting code avoid triggering this
> bug, but as part of a general "libified" codepath,

Yeah, I agree with this reasoning.

> I think it should
> be made to read from state->index_file using read_cache_from().

Yeah, I will change it.

> I only noticed this call to read_cache(), but there may be others
> lurking nearby.

Yeah, there is another one in get_current_sha1() which is only called
by build_fake_ancestor() (from apply.c not from builtin/am.c as there
is a function with this name in both files), but this function is
currently called only when --build-fake-ancestor is passed which is
not the case in run_apply() in am.c. I will change it too.

Thanks,
Christian.
