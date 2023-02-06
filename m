Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E75C05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 21:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjBFVqJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 16:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBFVqI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 16:46:08 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D5427D4F
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 13:46:05 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ml19so38444338ejb.0
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 13:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VYY1WCEsl7B7ME43Sakb8eXLfDFRIMf+HoZl9kFBU80=;
        b=GQsHTKQgPAgjjKy1B79pQyuXI2YiHlUmY9ez6Me7yEdoYOyP8sHFK1wbqYs49a3pdq
         yL/g3weuNYim8sc0eGTaI1UnXN0yNuyk4Baab4eC8h50aDPQppikLFCQoeFStUvTlKt+
         HwAKoJURgfX8YrUtqSXhUqzaSX7zNkRWuajIZOrNDkt/T2KcM2TTSLZOVgSWOwxhNArh
         8qjtllFXCqWa1qymNdYSuCyX7cvDfRZYxxKxK688icuvg0/ERoYtWYAYcUrYJ20hCkDI
         +dLZqD1/YS3l9ppp3LCoioufmc4YW1BhpZKCVljV7uYlUZLLijtj9x+n7xqZyprHlGqp
         35tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VYY1WCEsl7B7ME43Sakb8eXLfDFRIMf+HoZl9kFBU80=;
        b=5EiukTGWbwI8ewXcp7QE/W5uE/IAyDNbPgSQvEHXuAJadm582lDlAXQgaC2YcSxCHM
         X2jPAeQQU6RgDjIQyzD//8/KAFjAEFmPB1khg+R4SNafsSe396ixw2Rws9Tke0lS2T8+
         U0n5kI5GcfYbOpIV7BesMIVXeCsw6YYJhI3nmF8N5A9wVea6hBi8cf1cWG5pDDzJHl8f
         mJQVPRBxlkC5U36L6AsZ9fcbS8u6rtRKRfrHo9RqE3wsGgDNaMJZ+1UMCAGaS8iRBIa9
         Dm0AxIbpmy9ZcenhsFXY8kfncmtA46UEdw5rPIjEukZIggQedS11ntKBZhbV4t/aR/Jr
         +zWA==
X-Gm-Message-State: AO0yUKVeUSHojYkK5waPTkX1jNnxatBO+S/+Z8axLQZCFwnhzrc/HfE1
        dytLEAWP6pZ2CkdpKx/c90o=
X-Google-Smtp-Source: AK7set9rH2cZkGvFlmBAWGLsy3BglPeYayNsE3w2dWjBF3kviqIOplSd7O0VnTEtVSRPc4aAT3/k4g==
X-Received: by 2002:a17:906:942:b0:888:7ac8:c0f4 with SMTP id j2-20020a170906094200b008887ac8c0f4mr1044257ejd.25.1675719963626;
        Mon, 06 Feb 2023 13:46:03 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id x16-20020a170906149000b00889c115cf6asm5987030ejc.145.2023.02.06.13.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 13:46:03 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pP9JK-000XTJ-16;
        Mon, 06 Feb 2023 22:46:02 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Victoria Dye <vdye@github.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v7 00/12] Enhance credential helper protocol to include
 auth headers
Date:   Mon, 06 Feb 2023 22:32:45 +0100
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
        <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
        <e57c1ca3-c21c-db41-a386-e5887f46055c@github.com>
        <xmqqwn5bg695.fsf@gitster.g>
        <Y9JkMLueCwjkLHOr@coredump.intra.peff.net>
        <xmqqfsbxcmdd.fsf@gitster.g>
        <6f83ed25-a7e1-06dd-f180-d70c7e1b1973@gmx.de>
        <230202.86edr8pax5.gmgdl@evledraar.gmail.com>
        <60c3f1d0-2858-8811-7eb0-d6f586bf2ab8@gmx.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <60c3f1d0-2858-8811-7eb0-d6f586bf2ab8@gmx.de>
Message-ID: <230206.86y1pa4gdh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 02 2023, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Thu, 2 Feb 2023, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Thu, Feb 02 2023, Johannes Schindelin wrote:
>>
>> > On Thu, 26 Jan 2023, Junio C Hamano wrote:
>> >
>> >> Jeff King <peff@peff.net> writes:
>> >>
>> >> >> Thanks, both.  Let's merge it down.
>> >> >
>> >> > Sorry, I'm a bit late to the party, but I left some comments just n=
ow
>> >> > (this topic had been on my review backlog for ages, but I never qui=
te
>> >> > got to it).
>> >> >
>> >> > Many of my comments were small bits that could be fixed on top (tiny
>> >> > leaks, etc). But some of my comments were of the form "no, do it to=
tally
>> >> > differently". It may simply be too late for those ones, but let's s=
ee if
>> >> > Matthew finds anything compelling in them.
>> >>
>> >> I do not mind reverting the merge to 'next' to have an improved
>> >> version.  Your "do we really want to add a custom server based on
>> >> questionable codebase whose quality as a test-bed for real world
>> >> usage is dubious?" is a valid concern.
>> >
>> > Except.
>> >
>> > Except that this code base would have made for a fine base to potentia=
lly
>> > implement an HTTPS-based replacement for the aging and insecure
>> > git-daemon.
>> >
>> > That code base (which is hardly as questionable codebase as you make it
>> > sound because it has been in use for years in a slightly different for=
m)
>> > would have had the opportunity to mature in a relatively safe environm=
ent:
>> > our test suite. And eventually, once robust enough, it could have been
>> > extended to allow for easy and painless yet secure ad-hoc serving of G=
it
>> > repositories, addressing the security concerns around git-daemon.
>> >
>> > And now that we're throwing out that code we don't have that opportuni=
ty,
>> > making the goal to deprecate the git-daemon and replace it by something
>> > that is as easy to set up but talks HTTPS instead much, much harder to
>> > reach.
>>
>> There's many reasons for why you almost never see a git:// URL in the
>> wild anymore.
>
> I am unwilling to accept that statement without any source to back it up.
> Thin air is no substitute for reliable evidence.

Most people exposing git over the Internet use the ssh or http
transport, and our own "git" protocol is relatively obscure.

If you need data I think major hosting sites not offering it, or
deprecating it, is a pretty strong signal, e.g. Microsoft with:
https://github.blog/2021-09-01-improving-git-protocol-security-github/#no-m=
ore-unauthenticated-git

But if you'll grant me that it's 50/50 git/other protocols (I think it's
a *lot* more lopsided), then clearly combining git with 3rd party server
components isn't the limiting factor on deploying it.

Which is the point I was going for.

>> But if "easy and painless" was synonymous with "built with git" or
>> "ships with git" as you seem to be using it, surely it would be more
>> common than doing the same with http or https, which requires an
>> external server?
>
> Oh whoa... "requires an external server"?
>
> My entire point was to suggest a way forward for an _internal_ server that
> speaks https:// instead of git://.

I understand that.

> So I am not suggesting what you seem to have understood me to suggest.

I wasn't suggesting that, and you seem to have not read my reply to the
end, which should have addressed that.

Briefly, we'd like to be guaranteed to have regcomp() and regexec(), but
did the Git project write its own regex engine?

No, we imported (with some minor tweaks) one from glibc/gawk (whatever
current issues have cropped up with it lately...).

So can't we do the same for a httpd? If it really comes to "we must have
it in-tree"?

It seems to me that there's a continuum here, which is at the very
least:

1) We require an external package (e.g. ssh, or apache/httpd)
2) We require an external package *or* built-in (e.g. our SHA-1
   implementations)
3) We use an external package as-is (sha1dc)
4) We adapt an external codebase, and perma-fork it (git-imap-send,
   although that example also kind of sucks)
5) We write it "in-house" from scratch.

It seems to me from reading the upthread that we're jumping straight
from #1 to #5, and it's not clear to me why that is.

Not even that, we currently have CI tests running Apache on *nix boxes,
but you're suggesting a loss of coverage on Windows=20

Is it really harder to just install (or even ship our own package of)
Apache for Windows than it is to embark on PID file handling, logging,
timeout management and the long tail of "80% is easy, the rest is really
hard" of writing our own production-class httpd (as the suggestion is to
have it eventually mature beyond the test suite)?

Maybe, all I'm saying (in trying to mediate the discussion between you
and Jeff) is that it's not obvious to me why that is...
