Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA94C76195
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 22:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjCXWGb convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 24 Mar 2023 18:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCXWGa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 18:06:30 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C973F1FE3
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 15:06:28 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 32OM5cbZ3150078
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 22:05:39 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Felipe Contreras'" <felipe.contreras@gmail.com>
Cc:     <phillip.wood@dunelm.org.uk>, "'demerphq'" <demerphq@gmail.com>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "'Emily Shaffer'" <nasamuffin@google.com>,
        "'Git List'" <git@vger.kernel.org>,
        "'Jonathan Nieder'" <jrn@google.com>,
        "'Jose Lopes'" <jabolopes@google.com>,
        "'Aleksandr Mikhailov'" <avmikhailov@google.com>
References: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com> <xmqq3573lx2d.fsf@gitster.g> <CANgJU+XoT42u91WP7-p4V41w7q-UVhutL2LUfNkp3_BRCOn-FQ@mail.gmail.com> <4222af90-bd6b-d970-2829-1ddfaeb770bf@dunelm.org.uk> <CAMP44s1Qqd2cYcf7OGxz1-PY-8TF2KG+9jPEWMrnCaCfPe_1sw@mail.gmail.com> <008101d95ddf$7863d900$692b8b00$@nexbridge.com> <CAMP44s1X6LGpFfA_Zb_GakXehBJDeGrfFcehPgv+YM++xKHN3A@mail.gmail.com> <008201d95de1$359285c0$a0b79140$@nexbridge.com> <CAMP44s3Gk67rPEPjoAxLHS4KrCQBb6VoPJ6Rqm-FTK+8PTaRRQ@mail.gmail.com> <004d01d95e86$bd355d40$37a017c0$@nexbridge.com> <CAMP44s3fXYcOsq-XRNZX0y6D=W37=ONELUpTBtkzv4KLbym2iA@mail.gmail.com>
In-Reply-To: <CAMP44s3fXYcOsq-XRNZX0y6D=W37=ONELUpTBtkzv4KLbym2iA@mail.gmail.com>
Subject: RE: Proposal/Discussion: Turning parts of Git into libraries
Date:   Fri, 24 Mar 2023 18:06:12 -0400
Organization: Nexbridge Inc.
Message-ID: <005601d95e9c$dc20b360$94621a20$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG8LXqmDy16wlKS+NWZyvs9ueIudgFiwiOjAhx6XsUBunDI+AMx1EoXAf+oBUwCWl34mAGnUWavAtcXSH0CyaUCPAJd9VuprpF6ziA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, March 24, 2023 5:22 PM, Felipe Contreras wrote:
>On Fri, Mar 24, 2023 at 1:28 PM <rsbecker@nexbridge.com> wrote:
>>
>> On Thursday, March 23, 2023 7:55 PM, Felipe Contreras wrote:
>> >On Thu, Mar 23, 2023 at 5:43 PM <rsbecker@nexbridge.com> wrote:
>> >>
>> >> On Thursday, March 23, 2023 7:35 PM, Felipe Contreras wrote:
>> >> >On Thu, Mar 23, 2023 at 5:30 PM <rsbecker@nexbridge.com> wrote:
>> >> >>
>> >> >> On Thursday, March 23, 2023 7:22 PM, Felipe Contreras wrote:
>> >> >> >On Sat, Feb 18, 2023 at 5:12 AM Phillip Wood
>> >> >> ><phillip.wood123@gmail.com>
>> >> >wrote:
>> >> >> >>
>> >> >> >> On 18/02/2023 01:59, demerphq wrote:
>> >> >> >> > On Sat, 18 Feb 2023 at 00:24, Junio C Hamano
>> >> >> >> > <gitster@pobox.com>
>> >wrote:
>> >> >> >> >>
>> >> >> >> >> Emily Shaffer <nasamuffin@google.com> writes:
>> >> >> >> >>
>> >> >> >> >>> Basically, if this effort turns out not to be fruitful as
>> >> >> >> >>> a whole, I'd like for us to still have left a positive impact on the
>codebase.
>> >> >> >> >>> ...
>> >> >> >> >>> So what's next? Naturally, I'm looking forward to a
>> >> >> >> >>> spirited discussion about this topic - I'd like to know
>> >> >> >> >>> which concerns haven't been addressed and figure out
>> >> >> >> >>> whether we can find a way around them, and generally
>> >> >> >> >>> build awareness of this effort with the
>> >> >community.
>> >> >> >> >>
>> >> >> >> >> On of the gravest concerns is that the devil is in the details.
>> >> >> >> >>
>> >> >> >> >> For example, "die() is inconvenient to callers, let's
>> >> >> >> >> propagate errors up the callchain" is an easy thing to
>> >> >> >> >> say, but it would take much more than "let's propagate errors up"
>> >> >> >> >> to libify something like
>> >> >> >> >> check_connected() to do the same thing without spawning a
>> >> >> >> >> separate process that is expected to exit with failure.
>> >> >> >> >
>> >> >> >> >
>> >> >> >> > What does "propagate errors up the callchain" mean?  One
>> >> >> >> > interpretation I can think of seems quite horrible, but
>> >> >> >> > another seems quite doable and reasonable and likely not
>> >> >> >> > even very invasive of the existing code:
>> >> >> >> >
>> >> >> >> > You can use setjmp/longjmp to implement a form of "try", so
>> >> >> >> > that errors dont have to be *explicitly* returned *in* the call chain.
>> >> >> >> > And you could probably do so without changing very much of
>> >> >> >> > the existing code at all, and maintain a high level of
>> >> >> >> > conceptual alignment with the current code strategy.
>> >> >> >>
>> >> >> >> Using setjmp/longjmp is an interesting suggestion, I think
>> >> >> >> lua does something similar to what you describe for perl.
>> >> >> >> However I think both of those use a allocator with garbage
>> >> >> >> collection. I worry that using longjmp in git would be more
>> >> >> >> invasive (or result in more memory leaks) as we'd need to to
>> >> >> >> guard each allocation with some code to clean it up and then
>> >> >> >> propagate the error. That means we're back to manually
>> >> >> >> propagating errors up the call
>> >chain in many cases.
>> >> >> >
>> >> >> >We could just use talloc [1].
>> >> >>
>> >> >> talloc is not portable.
>> >> >
>> >> >What makes you say that?
>> >>
>> >> talloc is not part of a POSIX standard I could find.
>> >
>> >It's a library, like: z, ssl, curl, pcre2-8, etc. Libraries can be
>> >compiled on different platforms.
>>
>> talloc adds additional *required* dependencies to git, including python3 - required
>to configure and build talloc - which is not available on the NonStop ia64 platform
>(required support through end of 2025). I must express my resistance to what would
>amount to losing support for git on this NonStop platform.
>
>That is not true. You don't need python3 for talloc, not even to build it, it's just a
>single simple c file, it's easy to compile.
>
>The only reason python is used is to run waf, which is used to build Samba, which is
>much more complex, but you don't need to run it, especially if you know the
>characteristics of your system.
>
>This simple Makefile builds libtalloc.so just fine:
>
>  CC := gcc
>  CFLAGS := -fPIC -I./lib/replace
>  LDFLAGS := -Wl,--no-undefined
>
>  # For talloc.c
>  CFLAGS += -DTALLOC_BUILD_VERSION_MAJOR=2
>-DTALLOC_BUILD_VERSION_MINOR=4 -DTALLOC_BUILD_VERSION_RELEASE=0
>  CFLAGS += -DHAVE_CONSTRUCTOR_ATTRIBUTE -DHAVE_VA_COPY -
>DHAVE_VALGRIND_MEMCHECK_H -DHAVE_INTPTR_T
>
>  # For replace.h
>  CFLAGS += -DNO_CONFIG_H -D__STDC_WANT_LIB_EXT1__=1
>  CFLAGS += -DHAVE_STDBOOL_H -DHAVE_BOOL -DHAVE_STRING_H -
>DHAVE_LIMITS_H -DHAVE_STDINT_H
>  CFLAGS += -DHAVE_DLFCN_H -DHAVE_UINTPTR_T -DHAVE_C99_VSNPRINTF -
>DHAVE_MEMMOVE -DHAVE_STRNLEN -DHAVE_VSNPRINTF
>
>  libtalloc.so: talloc.o
>    $(CC) $(LDFLAGS) -shared -o $@ $^
>
>But of course, most of those defines are not even needed with a simple "replace.h"
>that is less than 10 lines of code.

The 2.4.0 version is substantially more complex than one .c file. The version I just unpacked has 61 C and H files, and requires more than a trivial makefile. 

config.h requires that the ./configure script runs (which it does not because of python3). replace.h is over 1000 lines in this version.

This also gets into git supply chain issues where people who want to build git, outside of specific platforms, need to modify the build environment associated with talloc, which changes the delivered signature.

Speaking purely from a selfish standpoint, this is more than a trivial amount of work at least for me (the above Makefile does not satisfy 2.4.0) that is proposed in order to make talloc a seamless addition. Running the talloc test suite, which I consider a requirement to adding this as a dependency, is also problematic for the reasons I previously indicated.

We may just have to agree to disagree, but I stand by my concern that this suggestion will cause maintenance issues given the current state of the talloc code - and I do not have the cycles to become a community maintainer of that code also.

--Randall

