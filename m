Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 605691F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 10:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeJJR4g (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 13:56:36 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:18224 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeJJR4g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 13:56:36 -0400
Received: from [192.168.2.201] ([92.28.142.68])
        by smtp.talktalk.net with SMTP
        id ABpVg2nLBbZX5ABpVgf4Ku; Wed, 10 Oct 2018 11:35:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1539167702;
        bh=sRgKPDFdYgAE2cq3vEm5sLVkFsYIr0UNWlulcIj6njk=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=lL2CcvXpUnnuJ59ARrg7mW2Fris86cg/m3LiVBq9zj8WXgQ0UD5vQ1AJ/Z/NZRLgT
         YPwnxlHz4xlozf+24gSZJefsXMLF7f3fhH+vfF1Ae+0bhVDvnjtGmkbZMdZ1AxWOSi
         8/kSDWTDQBsozZOBQ8dTfWGhfkA9MvKaq3vs7XPw=
X-Originating-IP: [92.28.142.68]
X-Spam: 0
X-OAuthority: v=2.3 cv=Poq9kTE3 c=1 sm=1 tr=0 a=UGDAwvN9cmeZh0o4udnnNw==:117
 a=UGDAwvN9cmeZh0o4udnnNw==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=5rxgeBVgAAAA:8 a=pGLkceISAAAA:8 a=zRia4iBppm8qi4fFBPUA:9
 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22 a=PwKx63F5tFurRwaNxrlG:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] sequencer: use read_author_script()
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
References: <20180912101029.28052-1-phillip.wood@talktalk.net>
 <20180912101029.28052-4-phillip.wood@talktalk.net>
 <CAPig+cS8ncvp8Se2Q24z9CFkiVey2zHP8i3oYVDPfGoP1kuDdA@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <2a8e3ea2-d97f-5e03-e4c7-4badb11e69b9@talktalk.net>
Date:   Wed, 10 Oct 2018 11:35:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cS8ncvp8Se2Q24z9CFkiVey2zHP8i3oYVDPfGoP1kuDdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCjGCQdqe1ecs3avnkYaslpEx1NidtSTbQ6PniUEEuU40fx6KMHG0RIun7a1U/jl8zW9tLq9nvcRnJLamb5PNtPCjUxGrNiJHgFWqj7vewEPlK3GvRAN
 p2bjyJi5ZpyjlXN5/pwUQDvErDSWhRwb0yYDxKtuzsNa+F/C8ahYp4qq7BUi5tOAHDYnfKfbOGJktgUh6QYpizrAd6dLuMdtf2WE0r8D77kOTWODTvolhAeb
 Z/7EfG02Ldlj2GxGtnvRYIuTlZOqab9tcPL0ALiqnbGQdxoi6N2gKm3zEby/PKgzG/SMqh+0jw6usPTpLile0g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/09/2018 01:31, Eric Sunshine wrote:
> On Wed, Sep 12, 2018 at 6:11 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>> Use the new function to read the author script, updating
>> read_env_script() and read_author_ident(). This means we now have a
>> single code path that reads the author script and uses sq_dequote() to
>> dequote it. This fixes potential problems with user edited scripts
>> as read_env_script() which did not track quotes properly.
>> [...]
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>  /*
>>   * Read a list of environment variable assignments (such as the author-script
>>   * file) into an environment block. Returns -1 on error, 0 otherwise.
>>   */
> 
> According to this comment, this function is capable of parsing a file
> of arbitrary "NAME=Value" lines, and indeed the original code does
> just that, but...
> 
>>  static int read_env_script(struct argv_array *env)
>>  {
>> +       char *name, *email, *date;
>>
>> -       if (strbuf_read_file(&script, rebase_path_author_script(), 256) <= 0)
>> +       if (read_author_script(rebase_path_author_script(),
>> +                              &name, &email, &date, 0))
> 
> ...the new implementation is able to handle only GIT_AUTHOR_NAME,
> GIT_AUTHOR_EMAIL, and GIT_AUTHOR_DATE, in exactly that order.
> 
> This seems like a pretty serious (and possibly buggy) change of
> behavior, and makes the function much less useful (in general). Is it
> true that it will only ever be used for files containing that limited
> set of names? If so, the behavior change deserves mention in the
> commit message, the function comment needs updating, and the function
> itself probably ought to be renamed.

You're right the change in behavior should be mentioned explicitly, I'd
not thought about it in those terms. I'm not sure if the change is
buggy, this code is what am uses for its author script handling. To me
the point of the author-script file is to set the author details, not to
set arbitrary environment variables. We have already significantly
reduced what someone can do with this file in the transition from shell
to C as we no longer support arbitrary shell code in the file. I'd
rather try and reuse the existing code from am unless someone can
demonstrate an active use for something more general. (I'm still not
sure what use editing the author-script is - it is only of use if the
rebase stops for conflicts, it cannot be used to change the author of an
arbitrary set of commits)

>> +       strbuf_addstr(&script, "GIT_AUTHOR_NAME=");
>> +       strbuf_addstr(&script, name);
>> +       argv_array_push(env, script.buf);
>> +       strbuf_reset(&script);
>> +       strbuf_addstr(&script, "GIT_AUTHOR_EMAIL=");
>> +       strbuf_addstr(&script, email);
>> +       argv_array_push(env, script.buf);
>> +       strbuf_reset(&script);
>> +       strbuf_addstr(&script, "GIT_AUTHOR_DATE=");
>> +       strbuf_addstr(&script, date);
>> +       argv_array_push(env, script.buf);
>> +       strbuf_release(&script);
> 
> Mentioned earlier[1], this can all collapse down to:
> 
> argv_array_pushf(env, "GIT_AUTHOR_NAME=%s", name);
> argv_array_pushf(env, "GIT_AUTHOR_EMAIL=%s", email);
> argv_array_pushf(env, "GIT_AUTHOR_DATE=%s", date);
> 
> However, it's unfortunate that this manual and hard-coded
> reconstruction is needed at all. If you restructure the factoring of
> this patch series, such ugliness can be avoided altogether. For
> instance, the series could be structured like this:
> 
> 1. Introduce a general-purpose function for reading a file containing
> arbitrary "NAME=Value" lines (not carrying about specific key names or
> their order) and returning them in some data structure (perhaps via
> 'string_list' as parse_key_value_squoted() in patch 2/3 does).
> 
> 2. Build read_author_script() atop #1, making it expect and extract
> GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and GIT_AUTHOR_DATE (possibly in
> that order, or possibly not if we don't care).
> 
> 3. Retrofit existing parsers to call one of those two functions (this
> step may happen over several patches). So, for instance,
> read_env_script() would call the generic parser from #1, whereas
> sequencer.c:read_author_ident() would call the more specific parser
> from #2.

That plan requires all new code rather than reusing tried and tested
code from am. Furthermore I'm not sure it has any advantage as far as
users are concerned. My aim with this series was to try and do something
fairly simple that reused the parsing from am, rather than build a whole
new system with its own bugs.

> More below...
> 
>> @@ -790,54 +771,25 @@ static char *get_author(const char *message)
>>  /* Read author-script and return an ident line (author <email> timestamp) */
>>  static const char *read_author_ident(struct strbuf *buf)
>>  {
>> -       const char *keys[] = {
>> -               "GIT_AUTHOR_NAME=", "GIT_AUTHOR_EMAIL=", "GIT_AUTHOR_DATE="
>> -       };
>> -       if (strbuf_read_file(buf, rebase_path_author_script(), 256) <= 0)
>> +       if (read_author_script(rebase_path_author_script(),
>> +                              &name, &email, &date, 0))
>>                 return NULL;
>> -       /* dequote values and construct ident line in-place */
>> -       for (in = buf->buf; i < 3 && in - buf->buf < buf->len; i++) {
>> -               if (!skip_prefix(in, keys[i], (const char **)&in)) {
>> -                       warning(_("could not parse '%s' (looking for '%s')"),
>> -                               rebase_path_author_script(), keys[i]);
>> -                       return NULL;
>> -               }
>> -               if (!sq_dequote(in)) {
>> -                       warning(_("bad quoting on %s value in '%s'"),
>> -                               keys[i], rebase_path_author_script());
>> -                       return NULL;
>> -               }
>> -       if (i < 3) {
>> -               warning(_("could not parse '%s' (looking for '%s')"),
>> -                       rebase_path_author_script(), keys[i]);
>> -               return NULL;
>> -       }
> 
> The parsing code being thrown away here does a better job of
> diagnosing problems (thus helping the user figure out what went wrong)
> than the new shared parser introduced by patch 2/3. The shared
> function only ever reports a generic "unable to parse", whereas the
> above code gets specific, saying that it was looking for a particular
> key or that quoting was broken. I'd have expected the new shared
> parser to encompass the best features of the existing parsers (such as
> presenting better error messages).

You're right but the context is that this function is only used when the
root commit is rebased (and then only for the root commit). Everything
else goes through read_env_script() which doesn't even bother to check
if all the variables have been set or report any parsing errors.

> 
>>         /* validate date since fmt_ident() will die() on bad value */
>> -       if (parse_date(val[2], &out)){
>> +       if (parse_date(date, buf)){
> 
> Re-purposing the strbuf 'buf', which is passed into this function,
> binds this function too tightly with its caller by assuming that the
> caller will never need the original content of 'buf' anymore. Thus, it
> would be better for this code continue using its own local strbuf
> 'out' rather than re-purposing the incoming 'buf'.

That's a good point, I'll fix it.

>>                 warning(_("invalid date format '%s' in '%s'"),
>> -                       val[2], rebase_path_author_script());
>> -               strbuf_release(&out);
>> +                       date, rebase_path_author_script());
>> +               strbuf_release(buf);
> 
> Likewise, it's doubly odd to see this function releasing 'buf' which
> it does not own.
> 
>>                 return NULL;
>>         }
> 
> [1]: https://public-inbox.org/git/CAPig+cRvUr26GZyW6ecYhpwABueBqaEfZH1+JjLaqZo8+RTD6Q@mail.gmail.com/
> 

Thanks for looking at this, I'm keen to keep things simple and reuse the
am author-script parsing if possible. It is more restrictive but I'm not
sure that anyone is actually taking advantage of the flexibility offered
by the current setup and it fixes the de-quoting bugs in read_env_script().

Best Wishes

Phillip
