Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8359C433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 20:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiGKUag (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 16:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiGKUaV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 16:30:21 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC2D8D5D9
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 13:28:11 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id y4so7667695edc.4
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 13:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=dXaFrzS7EDxA3ShfXiJOqhQz8OR+aySIZYGjyIGDtAM=;
        b=g40PL8zFkE8SJaOT/R6Xlsh5KO2MjK+tex5qvTUo4I6qZpZu+vnsnlW6027t2p+a7L
         yaPqRVdskDYdb8Uv5uUXEb8JhLigOYon6zonnM0Yp+auWtfctjE5AfMcN0rmUZLtOEeU
         T3QfbusS7zs8FuVBIrsGsthhknjDqD3BhNBc2smQB7a7wYfvNGY5REnThbl5X44LO2S4
         C4xdx2WA21bkS4Ztuhy2dvVHWV20k+O0svu49hQxbn3t9y7KYd9vaq5ciPqb7Ko1H+HL
         988APlu0EIuF+S7XmYiTrHZLElwZdP7D8ncGL5Aoqmc6o/ouleRphXVSwnUcOtZ6t0mj
         Xm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=dXaFrzS7EDxA3ShfXiJOqhQz8OR+aySIZYGjyIGDtAM=;
        b=z4xmizZFka0P31wDUFlvACveg/533Y8kNhGV4omzgZjLUQbbpHCgqpPyJ1PP9+R32R
         FNqO43kdLzKAOHVs9YmNvky+8pMnjXqqrsuGSBHK/vqRCySTf3H3R5afCSdxFTv66XOs
         Azd5sm6MmMfyKM13Tx0AVuCDJ8ckLbDWsH5LgAQDr7NUZ6WhxNmTksmfr+RAL5udjf6I
         kUs6lvGZW6JPceZ11AbLbKDigo8cz1cwGs2dVFFKhx+bYwlFE38AH6hkiG5eNFVFglLC
         1woPVY/Qle25NFLxyJt3gTOB7yj1ydQhBna5hKoUsDhWmq4+/JMmFjcJhcfMRujI9Z/O
         QXtg==
X-Gm-Message-State: AJIora8akGVv/4Grt/64/fT2C9LUZZyVZwAsUlARr2nTWKzFXD3U6CFI
        RwOxwgR7nWzECTfgBYiX00w=
X-Google-Smtp-Source: AGRyM1tdkWfRh6uUKQEPUA0ZSExD1JmCQ7XvUvk5vAXJlLXFqlLiW3TchBKDtdPLIgALeXofGzmCSg==
X-Received: by 2002:a05:6402:12d8:b0:43a:6a70:9039 with SMTP id k24-20020a05640212d800b0043a6a709039mr27520219edx.379.1657571287716;
        Mon, 11 Jul 2022 13:28:07 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id y26-20020a056402135a00b00435a742e350sm4910409edw.75.2022.07.11.13.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 13:28:06 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oB00a-0015zV-Sg;
        Mon, 11 Jul 2022 22:27:56 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Automatic code formatting
Date:   Mon, 11 Jul 2022 22:15:38 +0200
References: <YstJl+5BPyR5RWnR@tapette.crustytoothpaste.net>
 <006c01d894aa$3b9f33b0$b2dd9b10$@nexbridge.com>
 <Yst1tmpBU0DHdi5P@tapette.crustytoothpaste.net>
 <007f01d894c5$8b1cd3a0$a1567ae0$@nexbridge.com>
 <CABPp-BF0vCE4pzKEhjzNaJAOQYkYQ3Wvt+H5guzD3aZLdMO8kQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CABPp-BF0vCE4pzKEhjzNaJAOQYkYQ3Wvt+H5guzD3aZLdMO8kQ@mail.gmail.com>
Message-ID: <220711.86pmib5r8z.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 11 2022, Elijah Newren wrote:

> On Sun, Jul 10, 2022 at 6:31 PM <rsbecker@nexbridge.com> wrote:
>>
>> On July 10, 2022 8:59 PM, brian m. carlson wrote:
>> >On 2022-07-10 at 22:13:01, rsbecker@nexbridge.com wrote:
>> >>
>> >> Being one of the platforms that will be specifically excluded from
>> >> this proposal, I would like to offer an alternative. Before that,
>> >> please remember that not everything is Linux. My suggestion is to
>> >> create infrastructure to automatically format on add/commit. This
>> >> could be pluggable relatively simply with clean filter that is
>> >> language specific - perhaps with a helper option that installs the
>> >> formatter easily (because clean filters are notoriously painful to
>> >> install for newbies from my observations). It would be nice to have
>> >> something in perl that is more portable and pervasive than clang -
>> >> although perl could launch clang where available. I think having
>> >> infrastructure for code formatting that is built into git is actually
>> >> highly desirable - assuming that it is not unduly difficult to install
>> >> those. It would extend beyond git contributions, but the contributors
>> >> could be told (Contributor's Guide) that then need to follow standard
>> >> X, which may very well be clang format. There are java formatters, php
>> >> and perl formatters, even COBOL and TAL formatters. My position is
>> >> that having a standard way to plug these in is a more general plan
>> >> that would reach a larger community. Git contributions could then just
>> >> leverage standard git functionality.
>> >
>> >I am willing to acknowledge the fact that not everybody has clang on their
>> >preferred platform.  However, I assume you do have a laptop or desktop with
>> >which you access your platform (since I believe it's a server
>> >platform) and that you can install software there, or that you have the ability to
>> >run some sort of virtualization framework on some system.
>> >
>> >I am in general not very willing to say that we can't use or have useful developer
>> >tools because of uncommon platforms.  Linux, Windows, macOS, and (I believe)
>> >FreeBSD, NetBSD, and OpenBSD all support clang and related tools, and I don't
>> >think it's unreasonable for us to expect that someone can have access to such a
>> >system as part of development, even if that's in a VM.  Those six operating
>> >systems plus Chrome OS constitute the overwhelming majority of desktop and
>> >laptop systems, and there are several options which are free (both as in speech
>> >and beer).
>> >
>> >Moreover, clang and LLVM are extremely portable[0].  As a practical matter, any
>> >platform wanting to support software written in Rust (a popular and growing
>> >language) will likely need LLVM, and there is also a lot of software in C and C++
>> >that only supports GCC-compatible compilers.  I do feel that providing support for
>> >modern toolchains is an important part of providing a viable OS port, and that we
>> >should be able to rely on porters for that OS to do that work.  I realize that LLVM is
>> >not yet ported to your system, but I believe it's going to functionally need to
>> >happen sooner or later.  When it does, you'll be able to send patches directly
>> >without needing to copy to another OS to format the code.
>>
>> I should point out that gcc will *never* according to our latest
>> intel, be supported on my platforms. *Never* is, of course, an
>> indeterminate definition, but until various matters I cannot legally
>> discuss change, which are not likely for at least 5 years, anything
>> depending on gcc is out of the picture and unavailable, including
>> clang. I understand the position regarding git contributions, but I
>> am trying to get the point across that formatting code to a standard
>> is a more general desire than just git contributions. It is a broad
>> desire/requirement that should be considered. Rather than making
>> processes git-contribution-specific, providing a more general
>> solution that git contributors can use is more effective.
>
> I don't understand why this matters to the proposal, though.  My
> experience with projects adopting code-formatting is that there are
> always some people who just don't use it (e.g. because they use a
> different IDE that doesn't integrate with it, or they never bother
> installing the extra tool, etc.).  Such users run the risk of having
> automated CI jobs flag their code with a problem, and then they have
> to go back and fix it, but it's still a net win because reviewers
> don't have to spend time catching those problems, and the original
> folks would have had to fix their code anyway.  In fact, in some
> projects, I've been one of those users and having the project use a
> code formatter that I didn't want to bother to set up and run didn't
> negatively impact me at all.
>
> Whether or not we have an automatic formatter, you're still
> responsible to fix your code to match the project's guidelines.  I
> don't think that becomes any harder, because if we have an automatic
> formatter, the _most_ that changes is there's a flag day where the
> style is adjusted slightly.  After that point, all you have to do is
> the same as today: look at the surrounding code to see the format and
> follow it.  So, from what I can see, you lose nothing from this
> proposal if it is implemented.

I'm not saying I'm against this for the git project, but I think this is
a rather rosy view of how automated code formatting tends to go. I've
also seen all of:

 * It used to be trivial-ish to submit a patch to the project, and as my
   RFC series a lot of these minor formatting issues slide through the
   cracks, and we're not really worse for wear, but now it becomes a
   matter of automated enforcement.

   Which can be good, but also...

 * I think what's being pointed out upthread here is that it's also
   important that we pick development tools that are portable, because
   yes you'll find out about the issue eventually, but it's much faster
   if the turnaround is on your own computer.

   Some people who submit patches to git.git also don't use GitHub CI at
   all, so they'd find out about it after it hits "seen".

   You might argue that we'll catch it otherwise, but I have a "make"
   command you can run to get a ~30k diff that demonstrates otherwise :)

 * For e.g. the struct alignment exceptions I pointed out in the RFC
   cover letter I have myself (and seen others) written code that looks
   visually pleasant, but the code formatter happens to hate it
   (e.g. when you want to align a table in a certain way).

   Yes, you can usually use whatever the magic "format off" incantation
   is. But if you thought we had bikeshedding about code nits now, wait
   until we have long threads about whether something is or isn't the
   right time & place to override the automated formatting logic, and
   whether clang-format is buggy or whatever :)

In any case, per the RFC I sent I really think we should step more
gently into this area.

I was trying to find out if clang-format could be run in some mode where
it could only adjust one bit of its configured formatting,
e.g. "}\n\telse {" to "} else {", but I didn't find a way to do that.

That would also be a way to phase it in, and see how helpful
v.s. annoying it would be to e.g. run it in CI.

I also wonder if we can just go for another formatter altogether that's
more portable, e.g. GNU indent, but I haven't tested out how it compares
to clang-format.
