Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ABA31F453
	for <e@80x24.org>; Sat, 20 Oct 2018 11:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeJTTYi (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 15:24:38 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33283 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbeJTTYi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 15:24:38 -0400
Received: by mail-ed1-f68.google.com with SMTP id l14-v6so24701781edq.0
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 04:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ItKa/2dZiymxXDGTKlXq2Fwx8wx7PbIA9xjCIu7GsE4=;
        b=BzF1xmNCx6srcm6g2yStIzyXNMpZn8+RcBn0ufm9nLsssKQW4GJAQ65O9rmJEPuguQ
         Epq8u+6/FPt6e6ledh+DpeVNoIwlI1mNxKqlm0figX5Tt1/eZrKDbGqAFsaHDaclqHMq
         xaKTqplUDRYtV/Y6P9TLio2bvG20MIrpkOyxl3XcRPilnj5WOcCQWR22mv1n8TurhGN0
         YXnIONgGxt2jeN6Aa0OVttf/bNnc/AhIFNWr/Ql7uoj5952dQst7REBjsWgQeM+19N2R
         yOVa4e2pRn2Nrqave/h6AhNwHKZBSIndewCjfJO2pemVeWMwWSFYEU68gWL56O/2x4/f
         Z3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ItKa/2dZiymxXDGTKlXq2Fwx8wx7PbIA9xjCIu7GsE4=;
        b=kQ0MkSFgSUWze7fK9mxRM3/Tt4WLQW/79mOZntp2mtE77PH8EXILqBzH8Q18jz+asw
         Xj8URTpLXN1+/O7ZzcPgWEquwt3I7qfur1MDsccAgSmVqeaW+mLKJcZrolcm9PDdn1kV
         xDn7SNX/1kQBdQCRzkJSNEbJz65lcPbtCSH6gIJ/nMSc/9cZ+GY23pYpdXOL6XGSlJwR
         WTcl7pXJ92dHKltNQXBDHueWKxSzSybHsGql51LeBYSBbHipRR7ryYG/wZwfngbmUbe9
         +ct3yJGnHT5vjv1eBHmUEK9c3xYXWlMSleYDpP6sEdjam571og0yQJiJHkUA5jHvjFdb
         HZQA==
X-Gm-Message-State: ABuFfohjjlxNsuyGTv67852JS7+c/jrT1k0HWJN05OPGHoJDs/P3tpVB
        GkTWjnugrvVSnB9H7d3T/bE=
X-Google-Smtp-Source: ACcGV62Qzzp78Rz6jQCux4UCDbRd8txJ7qxB2nAdRkpmAUexHk+C2f4TWU4IufMll5p2kBRHTHoIRw==
X-Received: by 2002:a05:6402:1541:: with SMTP id p1mr7992924edx.104.1540034070168;
        Sat, 20 Oct 2018 04:14:30 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id u57-v6sm10042022edm.97.2018.10.20.04.14.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Oct 2018 04:14:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Tim Schumacher <timschumi@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] alias: detect loops in mixed execution mode
References: <87o9dar9qc.fsf@evledraar.gmail.com> <20181018225739.28857-1-avarab@gmail.com> <20181019220755.GA31563@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181019220755.GA31563@sigill.intra.peff.net>
Date:   Sat, 20 Oct 2018 13:14:28 +0200
Message-ID: <87ftx0dg4r.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 19 2018, Jeff King wrote:

> On Thu, Oct 18, 2018 at 10:57:39PM +0000, Ævar Arnfjörð Bjarmason wrote:
>
>> Add detection for aliasing loops in cases where one of the aliases
>> re-invokes git as a shell command. This catches cases like:
>>
>>     [alias]
>>     foo = !git bar
>>     bar = !git foo
>>
>> Before this change running "git {foo,bar}" would create a
>> forkbomb. Now using the aliasing loop detection and call history
>> reporting added in 82f71d9a5a ("alias: show the call history when an
>> alias is looping", 2018-09-16) and c6d75bc17a ("alias: add support for
>> aliases of an alias", 2018-09-16) we'll instead report:
>>
>>     fatal: alias loop detected: expansion of 'foo' does not terminate:
>>       foo <==
>>       bar ==>
>
> The regular alias expansion can generally assume that there's no
> conditional recursion going on, because it's expanding everything
> itself. But when we involve multiple processes, things get trickier.
>
> For instance, I could do this:
>
>   [alias]
>   countdown = "!f() { echo \"$@\"; test \"$1\" -gt 0 && git countdown $(($1-1)); }; f"
>
> which works now, but not with your patch.
>
> Now obviously that's a silly toy example, but are there real cases which
> might trigger this? Some plausible ones I can think of:
>
>   - an alias which handles some special cases, then chains to itself for
>     the simpler one (or to another alias or script, which ends up
>     chaining back to the original)
>
>   - an alias that runs a git command, which then spawns a hook or other
>     user-controlled script, which incidentally uses that same alias
>
> I'd guess this sort of thing is pretty rare. But I wonder if we're
> crossing the line of trying to assume too much about what the user's
> arbitrary code does.
>
> A simple depth counter can limit the fork bomb, and with a high enough
> depth would be unlikely to trigger a false positive. It could also
> protect non-aliases more reasonably, too (e.g., if you have a 1000-deep
> git process hierarchy, there's a good chance you've found an infinite
> loop in git itself).

I don't think this edge case you're describing is very plausible, and I
doubt it exists in the wild.

But going by my personal incredulity and a git release breaking code in
the wild would suck, so agree that I need to re-roll this to anticipate
that.

I don't have time to write it now, but what do you think about a version
of this where we introduce a core.recursionLimit setting, and by default
set it to "1" (for one recursion), so by default die just as we do now,
but with some advice() saying that we've bailed out early because this
looks crazy, but you can set it to e.g. "1000" if you think you know
what you're doing, or "0" for no limit.

The reason I'd like to do that is because I think it's *way* more common
to do this accidentally than intentionally, and by having a default
limit of 1000 we'd print a really long error message, or alternatively
would have to get into the mess of de-duplicating the callstack as we
print the error.

It also has the advantage that if people in the wild really use this
they'll chime in about this new annoying core.recursionLimit=1 setting,
at the cost of me having annoyed them all by breaking their working
code.

>> +static void init_cmd_history(struct strbuf *env, struct string_list *cmd_list)
>> +{
>> +	const char *old = getenv(COMMAND_HISTORY_ENVIRONMENT);
>> +	struct strbuf **cmd_history, **ptr;
>> +
>> +	if (!old || !*old)
>> +		return;
>> +
>> +	strbuf_addstr(env, old);
>> +	strbuf_rtrim(env);
>> +
>> +	cmd_history = strbuf_split_buf(old, strlen(old), ' ', 0);
>> +	for (ptr = cmd_history; *ptr; ptr++) {
>> +		strbuf_rtrim(*ptr);
>> +		string_list_append(cmd_list, (*ptr)->buf);
>> +	}
>> +	strbuf_list_free(cmd_history);
>
> Maybe string_list_split() would be a little simpler?

Yeah looks like it. I cargo-culted this from elsewhere without looking
at that API. I'll look into it.
