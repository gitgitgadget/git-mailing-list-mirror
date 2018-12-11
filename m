Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5055D20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 20:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbeLKUvS (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 15:51:18 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34535 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeLKUvS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 15:51:18 -0500
Received: by mail-ed1-f65.google.com with SMTP id b3so13744327ede.1
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 12:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=+wCv8inA8hSotQV+Ic8Rds62IkoD3ABJuxPDJIRsiEg=;
        b=gialNB+2ExEIyvyO7p2kaO4XZcp9NqBrwNmjS7xHnvUL/DmcMRpkmdTVNiAIQu9aQe
         TTSqXDbWQpovReOa8IUv3VPlIsq/Ty1nmmqB4buYq/XSqt5rXY2Kefv+iwnxIFtMeOpW
         8UW9k3JEN28EKafHd/9NLZL48fsOZbjjwJ21Ithw+yuwafWyYgJfBFKBaP0fOQYqKF7w
         KrGIRl6h+B3nxwfDa3NYk+uat4bUKjWbMo3eVe8r4N/BMpHuAVwnFoVAQUv6sJbHGBgO
         NRdbOc6NclLmIrj1l/9BWS/wVc8fudzSbbXOYHh6450YiGI0nttaFSrLpEWuv2OSlKSN
         ubmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=+wCv8inA8hSotQV+Ic8Rds62IkoD3ABJuxPDJIRsiEg=;
        b=m6L2+Bmb5Mkyv1viOVpyEV4IwtNoFONfQllsqoWmtZl6rI+hzt1wpBkxD4etrqLtgZ
         vLit5PZT4rVs1n5eXLIrkQNwsggFncxg5V8Pz4MwETSZxWijxzdHGGLByDJeeq06ui27
         He+RCMvFJR8kQKbB5eaMS0V6HL75Dbpzt6t7o1x0IVlIxozfrBcY6T+0j63EOZTVh2qM
         RG5VgGAnttr/75oMvk7m54ivXt7myynJXRYpLkg5ZtJKWRquZbfQzgtUfkraYF99RT5p
         WnzYU95iT46XlmsipvzkSkvXPxNVpD63Agzw0rVbukghFW7rgtCwzSJdyCMFrkpLyDXx
         8NgA==
X-Gm-Message-State: AA+aEWao6xOxDveiUQgJxUO7UMdi4goxdP+yr+CwFdB4MwlK4OtbTy8E
        qMfG0YdrNzz6wXLD0frfyBB1vdTG
X-Google-Smtp-Source: AFSGD/U7XU8M3OqL+jeixub6D/+51+62+DZ81cuXd+LW4BBSdVod3tuwukS31m6IK8wobK6mKfIFXQ==
X-Received: by 2002:a17:906:3712:: with SMTP id d18-v6mr13326924ejc.126.1544561474907;
        Tue, 11 Dec 2018 12:51:14 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id gz20-v6sm2358625ejb.56.2018.12.11.12.51.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 12:51:13 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     sandals@crustytoothpaste.net, git@vger.kernel.org,
        pcre-dev@exim.org
Subject: Re: [RFC PATCH 1/2] grep: fallback to interpreter if JIT fails with pcre1
References: <20181209230024.43444-1-carenas@gmail.com> <20181209230024.43444-2-carenas@gmail.com> <87r2eqxnru.fsf@evledraar.gmail.com> <20181210004252.GK890086@genre.crustytoothpaste.net> <87pnu9yekk.fsf@evledraar.gmail.com> <CAPUEspjHs7+G+FHXjxb4rCcNLqaybbhZESik=14_9Q5h2HMzMA@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAPUEspjHs7+G+FHXjxb4rCcNLqaybbhZESik=14_9Q5h2HMzMA@mail.gmail.com>
Date:   Tue, 11 Dec 2018 21:51:12 +0100
Message-ID: <87zhtbn5xb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 11 2018, Carlo Arenas wrote:

> On Mon, Dec 10, 2018 at 12:24 AM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> On Mon, Dec 10 2018, brian m. carlson wrote:
>> > Considering that some Linux users use PaX kernels with standard
>> > distributions and that most BSD kernels can be custom-compiled with a
>> > variety of options enabled or disabled, I think this is something we
>> > should detect dynamically.
>>
>> Right. I'm asking whether we're mixing up cases where it can always be
>> detected at compile-time on some systems v.s. cases where it'll
>> potentially change at runtime.
>
> the closer we come to a system specific issues is with macOS where the
> compiler (in some newer versions) is allocating the memory using the
> MAP_JIT flag, which seems was originally meant to be only used in iOS
> and has the strange characteristic of failing the mmap for versions
> older than 10.14 if it was called more than once.
>
> IMHO as brian pointed out, this is better done at runtime.

Sure. Just something I was wondering since it wasn't clear from the
patch. Makes sense, if it's always runtime (or not worth the effort to
divide the two) let's do that.

>> >> I'm inclined to suggest that we should have another ifdef here for "if
>> >> JIT fails I'd like it to die", so that e.g. packages I build (for
>> >> internal use) don't silently slow down in the future, only for me to
>> >> find some months later that someone enabled an overzealous SELinux
>> >> policy and we swept this under the rug.
>> >
>> > My view is that JIT is a nice performance optimization, but it's
>> > optional. I honestly don't think it should even be exposed through the
>> > API: if it works, then things are faster, and if it doesn't, then
>> > they're not. I don't see the value in an option for causing things to be
>> > broken if someone improves the security of the system.
>>
>> For many users that's definitely the case, but for others that's like
>> saying a RDBMS is still going to be functional if the "ORDER BY"
>> function degrades to bubblesort. The JIT improves performance my
>> multi-hundred percents sometimes, so some users (e.g. me) rely on that
>> not being silently degraded.
>
> the opposite is also true, specially considering that some old
> versions of pcre result in a segfault instead of an error message and
> therefore since there is no way to disable JIT, the only option left
> is not to use `git grep -P` (or the equivalent git log call)

Right, of course it segfaulting is a bug...

>> So I'm wondering if we can have something like:
>>
>>     if (!jit)
>>         if (must_have_jit)
>>             BUG(...); // Like currently
>>         else
>>             fallback(); // new behavior
>
> I am wondering if something like a `git doctor` command might be an
> interesting alternative to this.
>
> This way we could (for ex: in NetBSD) give the user a hint of what to
> do to make their git grep -P faster when we detect we are running the
> fallback, and might be useful as well to provide hints for
> optimizations that could be used in other cases (probably even
> depending on the size of the git repository)

Such a command has been discussed before on-list. I think it's a good
idea for the more fuzzy things like optimization suggests, but for the
case of expecting something at compile-time where not having that at
runtime is a boolean state it's nicer to just die with a BUG(...).

> For your use case, you just need to add a crontab that will trigger an
> alarm if this command ever mentions PCRE

...The reason I'd like it to die is because it neatly and naturally
integrates with all existing test infrastructure I have. I.e. build
package, run stress tests on all sorts of machines, see that it passes,
and SELinux isn't ruining it or whatever.

I know this works now (I always get PCRE v2 JIT) because it doesn't die
or segfault. I'd like not to have it regress to having worse
performance.

Having a cronjob to test for "does PCRE v2 JIT still work?" is not as
easy & isn't a drop-in solution.
