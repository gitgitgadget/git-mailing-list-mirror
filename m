Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF2CECAAA1
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 11:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiJXLSY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 07:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiJXLSV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 07:18:21 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0405FDC1
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 04:18:17 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b12so29935475edd.6
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 04:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CGKzjFGfI+LnHQkWu8LgyoHjqRDqV+203AOxit1jr/s=;
        b=luuF18royS6lwpicT9Q4iNg0v8C0c2plReJS+ZbRYaoJbGmwclz9m8gHylxsY1TVOT
         SkwVl3ha4tLsUvfSb90oGRx1Ky99w1xZVIiyxcN03Jf9brdbC7LkXAQCvvAaaJP2u+AG
         cnJmdcZ8BSd49bq7N1Ef35u9RXYVU3s+uwCKcJDuLOIAzMxpUGNnRs8jkoC5lZx3uZqp
         uDGM5Gq0HIJBwO6BTbktcHyueUccCCXfH5YfxJmJw5pXGW3zH6IZy8V3VoOic5815/BA
         lQ2SRGLeT9OS/Kng1A9WFle1d3mvoGZK6x0194XMPa64Uz+JyFEWbqaQNdk4HasK8Wru
         jTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CGKzjFGfI+LnHQkWu8LgyoHjqRDqV+203AOxit1jr/s=;
        b=6yhqhwcYco3iYynO3olnv4ZVjeem6Im1+vNbKxddQWiIKkVTRn8MjqwHJVez7QHlFW
         k2mOojBDtrv+DHqZL1NM1UGYCAvIAXsfbb27yVFV6VD0m3BHluFLiJhFtz/xQo0eZNRa
         TSVkjd0dhFiPnn4M+To0occSLlWdSKDitwFeV7SkpP3uGR6/UhXL8cTiVAyNzs6BlUoY
         HQdsDzX457kv2tp4GelSevBmBqNllbxtoetBe/93lC0aDdW8LAFOKAvN42g0ArmN2uw1
         ryzO94ZvGCI2McI4OZ8qhJtKYxs4IY84vVhCEMrLMzeIgAkjCz0dyidWmq6LRmTYwIhC
         LQzQ==
X-Gm-Message-State: ACrzQf2izmQ7HbSc5KgeyYDv1lJ07pUIomQXUrif8D/cFXN9cEQsbtaw
        U5bBiU9K2GE84E9xsv1SxAMIeB4oaD0=
X-Google-Smtp-Source: AMsMyM6h0CeiLRuJmDbX++lKnrsq8A5RJ42LrEAzjgF0K0xZGElCeM6xLbGgcZSs71KqEhXDUqH8jg==
X-Received: by 2002:a17:906:fc6:b0:72f:d080:416 with SMTP id c6-20020a1709060fc600b0072fd0800416mr27501825ejk.1.1666610296229;
        Mon, 24 Oct 2022 04:18:16 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id gw22-20020a170906f15600b0073d7ab84375sm15585310ejb.92.2022.10.24.04.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 04:18:15 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1omvTC-007bs8-1n;
        Mon, 24 Oct 2022 13:18:14 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael McClimon <michael@mcclimon.org>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] setup: allow Git.pm to do unsafe repo checking
Date:   Mon, 24 Oct 2022 12:57:29 +0200
References: <20221016212236.12453-1-michael@mcclimon.org>
 <20221022011931.43992-1-michael@mcclimon.org>
 <20221022011931.43992-3-michael@mcclimon.org>
 <221022.86eduzeiek.gmgdl@evledraar.gmail.com>
 <Y1RY38RULkqd9pBN@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y1RY38RULkqd9pBN@coredump.intra.peff.net>
Message-ID: <221024.861qqxeah5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Oct 22 2022, Jeff King wrote:

> On Sat, Oct 22, 2022 at 09:45:14PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> The vulnerability safe.directory was supposed to address was one where
>> you'd set your fsmonitor hook via a config variable, so running "diff",
>> "status" etc. would unexpectedly execute arbitrary code.
>>=20
>> Especially on Windows where apparently the equivalent of the root of a
>> shared mounted volume routinely has global write permissions (user's
>> subdirectories being less permissive).
>>=20
>> An alternative I raised on the security list was to narrowly target just
>> the fsmonitor config, since that was the vulnerability.
>>
>> [...]
>>
>> I'm unaware of any other variable(s) that provide a similar vector, and
>> safe.directory is encouraging users (especially in core.sharedRepository
>> settings) to mark a dir as "safe", and we'd then later have an exploit
>> from a user with rw access who'd use the fsmonitor hook vector.
>
> Here are a few off the top of my head that you can trigger via git-diff:
>
>   - core.pager will run an arbitrary program
>
>   - pager.diff will run an arbitrary program
>
>   - diff.*.textconv runs an arbitrary program; you need matching
>     .gitattributes, but those are under the control of the repository.
>     (not diff.*.command, though, as you need to pass --ext-diff)
>
>   - browser/man paths if you run "git diff --help"
>
> And of course as you expand the set of commands there are more options.
> E.g., credential helper commands if you do anything that wants auth,
> interactive diff-filter for "add -p", hooks for git-commit, git-push,
> etc. Those commands are less likely to be run in an untrusted repository
> than inspection commands like "status" or "diff", but the boundary is
> getting quite fuzzy.
>
> fsmonitor _might_ be the only one that is triggered by git-prompt.sh,
> because it has a limited command palette, generally reads (or sends to
> /dev/null) the stdout of commands (preventing pager invocation), and
> doesn't do text diffs (so no textconv). Even if true, I'm not sure if
> that's a good place to draw the line, though. People do tend to run "git
> log" themselves.

Right, by "a similar" vector I meant the unexpected execution of
fsmonitor as there was software in the wild that was running "status"
for the user.

These are also a problem, but my understanding of that issue is that if
it wasn't for the fsmonitor issue we'd have put that in the bucket of
not running arbitrary commands on a .git you just copied to somewhere,
i.e. that issue was already known.

The difference being that users might have that implicit "status"
running if they cd'd to /mnt/$USER/subdir and there was a hostile
/mnt/.git, but would be much less likely to run "git diff" or whatever
in such a subdir, unless they'd initialized a .git in say
/mnt/$USER/subdir, at which point we'd ignore the /mnt/.git.

Anyway, that's more into the "would it have been a CVE?" territory, so
let's leave that for now.

The important point/question I have is whether we can think of any such
config variable understood by the code that uses Git.pm.

The only ones I can think are the "sendemail.{to,cc}Cmd" variables.

I'm just pointing out that the reason we ended up with the facility (per
my understand) was among other things:

 * A. There were too many config variables to exhaustively audit on the
   security list and be sure we caught them all, and ...
 * B. ...such a change would probably be larger, which ...
 * C. ...given the embargo & desire to keep security patches minimal
   warranted the more general safe.directory approach.
 * D. You can talk about on the public list, or not have a zero-day, but
   not both :)

Now, we may come up with a reason "E" for extending this at this point,
e.g. maybe just being consistent is reason enough.

But in this case "A" doesn't apply, it's maybe 20-30 config variables,
and it's easy to skim the git-{send-email,svn} docs to see what they
are. "B" might be the case, but taht's OK since we're past "D" here,
ditto "C" not applying.
