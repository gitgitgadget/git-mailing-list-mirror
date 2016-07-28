Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 792701F858
	for <e@80x24.org>; Thu, 28 Jul 2016 20:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755794AbcG1UCl (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 16:02:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51387 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753301AbcG1UCj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 16:02:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B5BC2F22E;
	Thu, 28 Jul 2016 16:02:38 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iyMpWCYGWeK8zxPi0EegmjJQC94=; b=XD7hBz
	tl++vm0zg9aN54oy0ix8AKDLmny/E52z/qZdq7oj5hSviQ+BZWeC4vpKEpaJ413X
	svcN4s9gqiyHPzzLMvIcZPODOPprcujHgKLNcFtU0av35TqMUr5wiPB/V4iv7rMw
	RkpyMtW08ujz2PbPG7zvJp2g+B3tyhHBVgFZY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QjO1/e6BYPhMJCbtv70vyy/8Rs36kVCS
	J2UWq1jzT81XKBeiBLNRRwNycY90Re/vQ0irpXgDsZNEHoT4yk+ZnBuDO847gNwV
	3v+H7Smw1402b5MgkOoNDULjZ4Tug+69bPh+5iirphsix6BCnzvEXKOYSxz8x8TM
	xZUfkBKywU8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 71A5B2F22B;
	Thu, 28 Jul 2016 16:02:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E877F2F22A;
	Thu, 28 Jul 2016 16:02:37 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCHv2 2/2] submodule update: allow '.' for branch value
References: <20160728172641.8376-3-sbeller@google.com>
	<20160728182132.25088-1-sbeller@google.com>
	<xmqq7fc5shnl.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kactn4VZ5i+fCrBGa77dzFiTngAgVU3R1orz2=EMAZ1Jg@mail.gmail.com>
Date:	Thu, 28 Jul 2016 13:02:35 -0700
In-Reply-To: <CAGZ79kactn4VZ5i+fCrBGa77dzFiTngAgVU3R1orz2=EMAZ1Jg@mail.gmail.com>
	(Stefan Beller's message of "Thu, 28 Jul 2016 12:44:28 -0700")
Message-ID: <xmqqy44lr0o4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B9801F4-54FE-11E6-8697-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Well I wanted to express:
>
>   The .gitmodules used in these Gerrit projects do not conform
>   to Gits understanding of how .gitmodules should look like.
>   Let's make Git understand this Gerrit corner case (which you
>   would only need when using Gerrit).
>
>   Adding special treatment of the "." value is safe as this is an
>   invalid branch name in Git.

Yup, I got it after reading it twice.  My point was that you
shouldn't have to read it twice to get it.

>> I wonder if the above 8-line block wants to be encapsulated to
>> become a part of "git submodule--helper" interface, though.  IOW,
>> branch=$(git submodule--helper branch "$name") or something?
>
> There is already get_submodule_config that we implement in shell,
> which is also used in cmd_summary for reading the .ignore
> field.
>
> So having the "." check in that method (whether in shell or in C)
> doesn't make sense to me.

That's an excuse from the helper implementor's side, isn't it?  I
was coming from the opposite direction, i.e. potential caller of a
helper.  Whenever I want to know "is there a branch configured for
this submodule, and if so what is it?", wouldn't I be entitled to a
helper that consistently gets the real branch name with the magic
"." resolved for me?

>>> +       test "$(git log -1 --oneline)" = "$(GIT_DIR=../../submodule/.git git log -1 --oneline master)"
>>
>> A few issues:
>>
>>   * A crash in "git log" would not be noticed with this.  Perhaps
>>
>>         git log -1 --oneline $one_way_to_invoke >expect &&
>>         git log -1 --oneline $the_other_way >actual &&
>>         test_cmp expect actual
>>
>>     would be better?
>
> Of course. I tried to blend in with the code after looking at the surrounding
> code. Maybe I need to modernize that whole test file as a preparatory step.
>>
>>   * What exactly is this testing?  The current branch (in submodule)
>>     pointing at the same commit as the tip of 'master'?  Or the
>>     current branch _is_ 'master'?
>>
>>   * What exactly is the reason why one has GIT_DIR=... and the other
>>     does not?  I do not think this a place to test that "gitdir: "
>>     in .git points at the right place, so it must be testing
>>     something else, but I cannot guess.
>
> It is testing that the local state is at the same commit as the
> master branch on the remote side.

Ahh, OK, I totally misread that.  "git -C ../../submodule log" would
have been the more modern way to say that, I would guess, but now it
makes sense.

>>> +      # update is not confused by branch="." even if the the superproject
>>> +      # is not on any branch currently
>>> +      git submodule update &&
>>> +      git revert HEAD &&
>>
>> "revert" is rather unusual thing to see in the test.
>
> The tests are so long that I tried to get back in a state that is as least
> different from before to not break the following tests.

I guessed that much; I just expected to see "git reset --hard
$some_old_state" if you want to rewind to the previous state the
next test expects and "revert" looked unusual.

>> Also I am not
>> sure why cmd_update that now has an explicit check to die when
>> branch is set to "." and the head is detached is expected "not" to
>> be confused.  Perhaps I misread the main part of the patch?
>
> Well you *only* explicitly die(..) when you ask for --remote.

OK, I _did_ misread the patch, then.  It would help to have "when
giving no --remote, git submodule" before the comment that begins
with "update is not confused" to avoid the same confusion.

Thanks.

