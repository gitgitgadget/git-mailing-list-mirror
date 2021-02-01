Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC49C433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 20:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA6E664ECB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 20:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhBAUz5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 15:55:57 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57217 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhBAUz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 15:55:57 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8857C11EE0E;
        Mon,  1 Feb 2021 15:55:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ASfYT8iuQChc
        yND8C9jAjuo4pOU=; b=ZxB384NL44RvhokYDrpZcS65DhWT5ZUt3FVDpucJAiRh
        73ngKG12Qx4+OFhTTuCYT3JCNgNtg80n/5Cwh4yn3/BFHa0vq5U/veZeGORK4FeI
        +4gtReeXiHRvPjzT91ptfo3NsPahcuk2GktPhMjrLRn53LPaWPot3DOsrk2F5/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Swsbu6
        6bHtWo2OOcykXVivzFDDeqkD0zfVgRsc3sc0tZKWSS2bIBgrRm9XrC8RhpMzpTW3
        IvUDQzzhg7Fklt3ZR73jk7EA55qPIOm1tnmBOfRBGpPJjGJI3H7/cb8gv/sLe31L
        hQijqtMygbJK+lWeaO0UtxrR1VFsLxr2zaNU4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 814DC11EE0D;
        Mon,  1 Feb 2021 15:55:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CBBA111EE0C;
        Mon,  1 Feb 2021 15:55:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Vincent Lefevre <vincent@vinc17.net>
Subject: Re: [PATCH] pager: exit without error on SIGPIPE
References: <YAG/vzctP4JwSp5x@zira.vinc17.org>
        <bc88492979fee215d5be06ccbc246ae0171a9ced.1611910122.git.liu.denton@gmail.com>
        <87czxjomn8.fsf@evledraar.gmail.com>
        <xmqqtuqvn0i7.fsf@gitster.c.googlers.com>
        <87wnvrefbv.fsf@evledraar.gmail.com>
Date:   Mon, 01 Feb 2021 12:55:09 -0800
In-Reply-To: <87wnvrefbv.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 01 Feb 2021 20:52:04 +0100")
Message-ID: <xmqq8s87ld8y.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C60A1134-64CF-11EB-8CA1-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Would it be the matter of propagating the exit status of the pager
>> noticed by wait_or_white() down thru finish_command_in_signal() and
>> wait_for_pager(1) to here, so
>>
>>  - If we know pager exited with non-zero status, we would report,
>>    perhaps with warning(_("..."));
>>
>>  - If we notice we got a SIGPIPE, we ignore it---it is nothing of
>>    interest to the end-user;
>>
>>  - Otherwise we do not do anything differently.
>>
>> would be sufficient?  Implementors of "git -p" may know that "git"
>> happens to implement its paging by piping its output to an external
>> pager, but the end-users do not care.  Implementors may say they are
>> giving 'q' to their pager "less", but to the end-users, who report
>> "I ran 'git log' and after reading a pageful, I told it to 'q'uit",
>> the distinction does not have any importance.
>>
>> Or are there more to it, in that the exit status we get from the
>> pager, combined with the kind of signal we are getting, is not
>> sufficient for us to tell what is going on?
>
> It is, I just wonder if ignoring the exit code is a practical issue as
> long as we're not clobbering SIGPIPE, particularly with my trace2
> logging patch in this thread.
>
> But yeah, we could patch git to handle this in the general case....

Sorry, but now you lost me.

I was merely wondering if Denton's patch can become a small update
on top of these, if we just made sure that the exit code of the
pager noticed by wait_or_whine() is reported to the code where
Denton makes the decision to say "let's not re-raise but simply exit
with 0 return as what we got is SIGPIPE".  I guess we could even
make git exit with the pager's return code in that case, as the
end-user observable result would be similar to "git log | less"
where 'less' may be segfaulting or exiting cleanly.

IOW, something like this on top of your three-patch series?

 pager.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git c/pager.c w/pager.c
index 3d37dd7ada..73bc5fc0e4 100644
--- c/pager.c
+++ w/pager.c
@@ -28,8 +28,14 @@ static void wait_for_pager_atexit(void)
=20
 static void wait_for_pager_signal(int signo)
 {
+	int status;
+
 	close_pager_fds();
-	finish_command_in_signal(&pager_process);
+	status =3D finish_command_in_signal(&pager_process);
+
+	if (signo =3D=3D SIGPIPE)
+		exit(status);
+
 	sigchain_pop(signo);
 	raise(signo);
 }
