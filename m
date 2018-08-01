Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B7111F597
	for <e@80x24.org>; Wed,  1 Aug 2018 09:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388792AbeHALNs (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 07:13:48 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:7494 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388742AbeHALNs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 07:13:48 -0400
Received: from [192.168.2.240] ([92.22.30.174])
        by smtp.talktalk.net with SMTP
        id knR8ft6QepXFjknR9fWn14; Wed, 01 Aug 2018 10:28:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1533115736;
        bh=2JR9L6MMNgr9mYlx5AsWispSoBUJnnlMNlcT3tK48nI=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=f38hCcQvmYT9cUnBCwrzvePjSPEqR+zDm3UQgNEKOOvyCZxx7ds3AKDU4bFyQhpDb
         RfHr7I1gY9exAGRqS1PHgW6aEUvH+b5M7kCWr63jFVZzD/2KZGMLqOu/mP+pivodkD
         75YWTuDZXn15g4Yyi/ms712QaYdoG9hECqDiJ6MI=
X-Originating-IP: [92.22.30.174]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ob228CbY c=1 sm=1 tr=0 a=2xfjePbNG5I+/HyESt+5YA==:117
 a=2xfjePbNG5I+/HyESt+5YA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=5rxgeBVgAAAA:8 a=evINK-nbAAAA:8 a=bMFpRRgnoOGxJF5SetUA:9 a=QEXdDO2ut3YA:10
 a=PwKx63F5tFurRwaNxrlG:22 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/2] sequencer: handle errors in read_author_ident()
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <20180731111532.9358-1-phillip.wood@talktalk.net>
 <20180731111532.9358-2-phillip.wood@talktalk.net>
 <CAPig+cT15a-QTTAjC61td4h_YhHz0WSa8iT_3XqUUc6LZHWC=A@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <04f5f533-c971-6adc-9bcd-229e24ab2752@talktalk.net>
Date:   Wed, 1 Aug 2018 10:28:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPig+cT15a-QTTAjC61td4h_YhHz0WSa8iT_3XqUUc6LZHWC=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLtW6BIwoV9TvNA2rbyyQyaBTzJxV2W2Bp4rt46xcVhlNyKR5L/Asl2sPZXKDhS3q2OXHEfoFoobzefDkhC6ozOpVFTkmTSkO83aw3tUdF5KbOuNuaT2
 1nF7gFkR4ycUwhdU3tJwKv7CBQXO8jLNTEexAy2wSXB8dYycaOKuNBRgPByMelS2DCH/PzrJgX9DxhA3hqUwrD7AjxjGlQF8ypUSLr7GeS3bC1YPY7zY8+F/
 UKRdqf6kNKIaygDOM7HtFpL0aafmdTpGKg9Ms6XRKjjvxTskv0gK5PA9FzZxY1UDemONQEhWAQX6jl2tj25sYg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric

Thanks for taking a look at this

On 31/07/18 21:47, Eric Sunshine wrote:
> On Tue, Jul 31, 2018 at 7:15 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>> The calling code treated NULL as a valid return value, so fix this by
>> returning and integer and passing in a parameter to receive the author.
> 
> It might be difficult for future readers (those who didn't follow the
> discussion) to understand how/why NULL is not sufficient to signal an
> error. Perhaps incorporating the explanation from your email[1] which
> discussed that the author name, email, and/or date might change
> unexpectedly would be sufficient. This excerpt from [1] might be a
> good starting point:
> 
>      ... the caller does not treat NULL as an error, so this will
>      change the date and potentially the author of the commit
>      ... [which] does corrupt the author data compared to its
>      expected value.
> 
> [1]: https://public-inbox.org/git/c80cf729-1bbe-10f5-6837-b074d371b91c@talktalk.net/
> 
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>> diff --git a/sequencer.c b/sequencer.c
>> @@ -701,57 +701,58 @@ static char *get_author(const char *message)
>> -static const char *read_author_ident(struct strbuf *buf)
>> +static int read_author_ident(char **author)
> 
> So, the caller is now responsible for freeing the string placed in
> 'author'. Okay.
> 
>>   {
>> -       if (strbuf_read_file(buf, rebase_path_author_script(), 256) <= 0)
>> -               return NULL;
>> +       if (strbuf_read_file(&buf, rebase_path_author_script(), 256) <= 0)
>> +               return -1;
> 
> I think you need to strbuf_release(&buf) in this error path since
> strbuf_read_file() doesn't guarantee that the strbuf hasn't been
> partially populated when it returns an error. (That is, this is
> leaking.)

Good point, I'll fix it

>>          /* dequote values and construct ident line in-place */
> 
> Ugh, this comment should have been adjusted in my series. A minor
> matter, though, which can be tweaked later.
> 
>>          /* validate date since fmt_ident() will die() on bad value */
>>          if (parse_date(val[2], &out)){
>> -               warning(_("invalid date format '%s' in '%s'"),
>> +               error(_("invalid date format '%s' in '%s'"),
>>                          val[2], rebase_path_author_script());
>>                  strbuf_release(&out);
>> -               return NULL;
>> +               strbuf_release(&buf);
>> +               return -1;
> 
> You were careful to print the error, which references a value from
> 'buf', before destroying 'buf'. Good.
> 
> (A simplifying alternative would have been to not print the actual
> value and instead say generally that "the date" was bad. Not a big
> deal.)
> 
>>          }
>> -       strbuf_swap(buf, &out);
>> -       strbuf_release(&out);
>> -       return buf->buf;
>> +       *author = strbuf_detach(&out, NULL);
> 
> And, 'author' is only assigned when 0 is returned, so the caller only
> has to free(author) upon success. Fine.
> 
>> +       strbuf_release(&buf);
>> +       return 0;
>>   }
>>
>>   static const char staged_changes_advice[] =
>> @@ -794,12 +795,14 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
>> -               struct strbuf msg = STRBUF_INIT, script = STRBUF_INIT;
>> -               const char *author = is_rebase_i(opts) ?
>> -                       read_author_ident(&script) : NULL;
>> +               struct strbuf msg = STRBUF_INIT;
>> +               char *author = NULL;
>>                  struct object_id root_commit, *cache_tree_oid;
>>                  int res = 0;
>>
>> +               if (is_rebase_i(opts) && read_author_ident(&author))
>> +                       return -1;
> 
> Logic looks correct, and it's nice to see that you went with 'return
> -1' rather than die(), especially since the caller of run_git_commit()
> is already able to handle -1.

Yes, it reschedules the pick so the user has a chance to fix the 
author-script and then run 'git rebase --continue'

Best Wishes

Phillip

