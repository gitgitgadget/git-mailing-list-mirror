Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C06C6FD20
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 19:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjCXT2P convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 24 Mar 2023 15:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjCXT2K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 15:28:10 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5704685
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 12:28:07 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 32OJRIKi3122088
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 19:27:18 GMT
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
References: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com> <xmqq3573lx2d.fsf@gitster.g> <CANgJU+XoT42u91WP7-p4V41w7q-UVhutL2LUfNkp3_BRCOn-FQ@mail.gmail.com> <4222af90-bd6b-d970-2829-1ddfaeb770bf@dunelm.org.uk> <CAMP44s1Qqd2cYcf7OGxz1-PY-8TF2KG+9jPEWMrnCaCfPe_1sw@mail.gmail.com> <008101d95ddf$7863d900$692b8b00$@nexbridge.com> <CAMP44s1X6LGpFfA_Zb_GakXehBJDeGrfFcehPgv+YM++xKHN3A@mail.gmail.com> <008201d95de1$359285c0$a0b79140$@nexbridge.com> <CAMP44s3Gk67rPEPjoAxLHS4KrCQBb6VoPJ6Rqm-FTK+8PTaRRQ@mail.gmail.com>
In-Reply-To: <CAMP44s3Gk67rPEPjoAxLHS4KrCQBb6VoPJ6Rqm-FTK+8PTaRRQ@mail.gmail.com>
Subject: RE: Proposal/Discussion: Turning parts of Git into libraries
Date:   Fri, 24 Mar 2023 15:27:51 -0400
Organization: Nexbridge Inc.
Message-ID: <004d01d95e86$bd355d40$37a017c0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG8LXqmDy16wlKS+NWZyvs9ueIudgFiwiOjAhx6XsUBunDI+AMx1EoXAf+oBUwCWl34mAGnUWavAtcXSH2uuo//0A==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday, March 23, 2023 7:55 PM, Felipe Contreras wrote:
>On Thu, Mar 23, 2023 at 5:43 PM <rsbecker@nexbridge.com> wrote:
>>
>> On Thursday, March 23, 2023 7:35 PM, Felipe Contreras wrote:
>> >On Thu, Mar 23, 2023 at 5:30 PM <rsbecker@nexbridge.com> wrote:
>> >>
>> >> On Thursday, March 23, 2023 7:22 PM, Felipe Contreras wrote:
>> >> >On Sat, Feb 18, 2023 at 5:12 AM Phillip Wood
>> >> ><phillip.wood123@gmail.com>
>> >wrote:
>> >> >>
>> >> >> On 18/02/2023 01:59, demerphq wrote:
>> >> >> > On Sat, 18 Feb 2023 at 00:24, Junio C Hamano <gitster@pobox.com>
>wrote:
>> >> >> >>
>> >> >> >> Emily Shaffer <nasamuffin@google.com> writes:
>> >> >> >>
>> >> >> >>> Basically, if this effort turns out not to be fruitful as a
>> >> >> >>> whole, I'd like for us to still have left a positive impact on the codebase.
>> >> >> >>> ...
>> >> >> >>> So what's next? Naturally, I'm looking forward to a spirited
>> >> >> >>> discussion about this topic - I'd like to know which
>> >> >> >>> concerns haven't been addressed and figure out whether we
>> >> >> >>> can find a way around them, and generally build awareness of
>> >> >> >>> this effort with the
>> >community.
>> >> >> >>
>> >> >> >> On of the gravest concerns is that the devil is in the details.
>> >> >> >>
>> >> >> >> For example, "die() is inconvenient to callers, let's
>> >> >> >> propagate errors up the callchain" is an easy thing to say,
>> >> >> >> but it would take much more than "let's propagate errors up"
>> >> >> >> to libify something like
>> >> >> >> check_connected() to do the same thing without spawning a
>> >> >> >> separate process that is expected to exit with failure.
>> >> >> >
>> >> >> >
>> >> >> > What does "propagate errors up the callchain" mean?  One
>> >> >> > interpretation I can think of seems quite horrible, but
>> >> >> > another seems quite doable and reasonable and likely not even
>> >> >> > very invasive of the existing code:
>> >> >> >
>> >> >> > You can use setjmp/longjmp to implement a form of "try", so
>> >> >> > that errors dont have to be *explicitly* returned *in* the call chain.
>> >> >> > And you could probably do so without changing very much of the
>> >> >> > existing code at all, and maintain a high level of conceptual
>> >> >> > alignment with the current code strategy.
>> >> >>
>> >> >> Using setjmp/longjmp is an interesting suggestion, I think lua
>> >> >> does something similar to what you describe for perl. However I
>> >> >> think both of those use a allocator with garbage collection. I
>> >> >> worry that using longjmp in git would be more invasive (or
>> >> >> result in more memory leaks) as we'd need to to guard each
>> >> >> allocation with some code to clean it up and then propagate the
>> >> >> error. That means we're back to manually propagating errors up the call
>chain in many cases.
>> >> >
>> >> >We could just use talloc [1].
>> >>
>> >> talloc is not portable.
>> >
>> >What makes you say that?
>>
>> talloc is not part of a POSIX standard I could find.
>
>It's a library, like: z, ssl, curl, pcre2-8, etc. Libraries can be compiled on different
>platforms.

talloc adds additional *required* dependencies to git, including python3 - required to configure and build talloc - which is not available on the NonStop ia64 platform (required support through end of 2025). I must express my resistance to what would amount to losing support for git on this NonStop platform.

--Randall

