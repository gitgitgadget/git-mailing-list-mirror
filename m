From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] merge-base: teach "--fork-point" mode
Date: Mon, 28 Oct 2013 07:47:14 -0700
Message-ID: <xmqqwqkxh2q5.fsf@gitster.dls.corp.google.com>
References: <xmqqhac6o5hj.fsf@gitster.dls.corp.google.com>
	<1382641884-14756-1-git-send-email-gitster@pobox.com>
	<1382641884-14756-3-git-send-email-gitster@pobox.com>
	<CAPig+cQrBMMqSmOk0GSZJ9PTHNt-t+vuOG2Aq=7VTR1EZSeLsw@mail.gmail.com>
	<xmqq61smmkc0.fsf@gitster.dls.corp.google.com>
	<CAPig+cQ2tWFXX-RYnUrHEZCaqaPV6ZwgoPfiNPv9P1jFNTGEYg@mail.gmail.com>
	<xmqqwql2l3ln.fsf@gitster.dls.corp.google.com>
	<xmqqsivql37i.fsf_-_@gitster.dls.corp.google.com>
	<526A19CA.9020609@viscovery.net>
	<xmqqmwlxjnq6.fsf@gitster.dls.corp.google.com>
	<xmqq61sljakf.fsf_-_@gitster.dls.corp.google.com>
	<CANiSa6h7x=CcwwAqvoaOm4-y+6MCugV5BE0OXnfGHvf+iJ66MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 28 15:47:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vao6H-0004UG-58
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 15:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756866Ab3J1OrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 10:47:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59949 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756280Ab3J1OrS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 10:47:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 731904C384;
	Mon, 28 Oct 2013 14:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G6mnlW4ruBnH3L89r7QthMV+D9Y=; b=jdcJCM
	Xd0NiXHyf3DCWb/9n0cOOD6vVBvYOW1qRJ5SFWla/5gKRcjiS4rD1jY8aN9/rPoo
	Qz8Gh9uJWBBmHDRTfKQW+knWgltNVh0/7lxTuuUXZD+5Soy2F9jbhjQ8gdi0E+jR
	lu0xWtnKFsX9zXatekgzbpD87rGQCfocrAODo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E4vx7KZBj4bteb6+ns3sngc71gNyPInY
	BEpA4ws5KDUIhte16v74I/1EqDg7I2rGcrVyNcZfUmBr/1cUfzNjhJqAoh0k137j
	W6Uwuj5QQOpbWsDmnEprQH5V+Rhp2u4GHvuZvjFsOuxjtL6IOsOk7ebqFWiptEip
	DNcuylDz5Ig=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6361E4C382;
	Mon, 28 Oct 2013 14:47:17 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB3934C37F;
	Mon, 28 Oct 2013 14:47:16 +0000 (UTC)
In-Reply-To: <CANiSa6h7x=CcwwAqvoaOm4-y+6MCugV5BE0OXnfGHvf+iJ66MA@mail.gmail.com>
	(Martin von Zweigbergk's message of "Fri, 25 Oct 2013 22:15:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D6F33AC4-3FDF-11E3-8F22-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236831>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

>> +       bases = get_merge_bases_many(derived, revs.nr, revs.commit, 0);
>> + ...
>> +       if (revs.nr <= i)
>> +               return 1; /* not found */
>> +
>> +       printf("%s\n", sha1_to_hex(bases->item->object.sha1));
>> +       free_commit_list(bases);
>> +       return 0;
>
> Should free_commit_list also be called in the two "return 1" cases
> above? I suppose the process will exit soon after this, but that seems
> to be true for all three cases.

You are right that the above is inconsistent. Because the code
intends to be called only once in the lifetime of the program,
it calls get_merge_bases_many() with cleanup set to 0, so in that
sense, not freeing them anywhere may make it even more clear that
this function expects to be shortly followed by a process exit.

>> diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
>> index f80bba8..4f09db0 100755
>> --- a/t/t6010-merge-base.sh
>> +++ b/t/t6010-merge-base.sh
>> @@ -230,4 +230,31 @@ test_expect_success 'criss-cross merge-base for octopus-step' '
>>         test_cmp expected.sorted actual.sorted
>>  '
>>
>> +test_expect_success 'using reflog to find the fork point' '
>> +       git reset --hard &&
>> +       git checkout -b base $E &&
>> +
>> +       (
>> +               for count in 1 2 3 4 5
>> +               do
>> +                       git commit --allow-empty -m "Base commit #$count" &&
>> +                       git rev-parse HEAD >expect$count &&
>> +                       git checkout -B derived &&
>> +                       git commit --allow-empty -m "Derived #$count" &&
>> +                       git rev-parse HEAD >derived$count &&
>> +                       git checkout base || exit 1
>
> I think this creates a history like
>
> ---E---B1--B2--B3--B4--B5 (base)
>         \   \   \   \   \
>          D1  D2  D3  D4  D5 (derived)
>
> So I think the following test would pass even if you drop the
> --fork-point. Did you mean to create a fan-shaped history by resetting
> base to $E on every iteration above?

Just showing that I didn't think things deeply ;-)  I do agree that a
fan-shaped history would show what we want to do a lot better.

Thanks.

>> +                       git merge-base --fork-point base $(cat derived$count) >actual &&
>> +                       test_cmp expect$count actual || exit 1
