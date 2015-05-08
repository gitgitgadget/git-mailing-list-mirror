From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sequencer.c: abbreviate hashs placed in the middle of messages
Date: Fri, 08 May 2015 13:24:49 -0700
Message-ID: <xmqqa8xekeb2.fsf@gitster.dls.corp.google.com>
References: <1431104035-2056-1-git-send-email-ralf.thielow@gmail.com>
	<CAPig+cSeNn0r7N6vp+qs4NTNwfYx5p-zUX3tkifuXLu+nB2yNQ@mail.gmail.com>
	<xmqqbnhvm1f5.fsf@gitster.dls.corp.google.com>
	<CAN0XMOKPbKUMwU5-T78m_knt=9O2GkKaqmXKViSi5k-Z7Damrg@mail.gmail.com>
	<xmqqtwvmlxlo.fsf@gitster.dls.corp.google.com>
	<CAN0XMO+ZY-oXb1aWK3TzUxDRuBEEoasxjdagYQQoB+JVheju9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 08 22:25:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqopM-0007Sj-M7
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 22:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbbEHUYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 16:24:52 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63144 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932189AbbEHUYv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 16:24:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 945C14EDB6;
	Fri,  8 May 2015 16:24:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2eVxtrnXfSbercN7hQ5VapQI5cU=; b=lodvxN
	HFAt5SCy0kyfYzkHwSZsdgjNLfzbjXZcy2r0gNjJcLMeLnhrrjaydoXUNHAKeCe8
	A6ZpDcRdxcrxvSfJtCXOX9S5EZn+hmqBlTT7gS/RMhn/HXAlTzpIsUnDyM2708Ef
	BHYSrel8TvVcTrDJCKTUNnX2i7m13HZdHa9gM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nyd4EncjECGMjvDo97GeXkxPgQkF+WzG
	mSKtvLdaiua3MX8ArowfQLJFpz82cnjpzRIaMtpMHuNdKr0aZZC9epNWQJ2pzFeW
	9cSsMQ4zK2ReSyOsNDICeJNCwGHpR0VIgkNyYKfTXh61Iyyh1ySVB0P9JfwXmKXu
	n4lw22NZpjw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B5734EDB5;
	Fri,  8 May 2015 16:24:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0AC254EDB3;
	Fri,  8 May 2015 16:24:49 -0400 (EDT)
In-Reply-To: <CAN0XMO+ZY-oXb1aWK3TzUxDRuBEEoasxjdagYQQoB+JVheju9Q@mail.gmail.com>
	(Ralf Thielow's message of "Fri, 8 May 2015 21:56:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 46EF5776-F5C0-11E4-8862-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268659>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>
>> And shortening the output feels to me a more expedient thing to do
>> because we do not have to analyse the ramification of possible
>> information loss (your "It has value since...").  If we analyse the
>> issue well, we might realize that there is little point in showing
>> the commit object name in hexadecimal, be it in full or in shortened
>> form.
>>
>> If the proposal were to parrot what the user typed on the command
>> line, e.g. one of these (or their rephrased versions)
>>
>>         error: commit 'next' is a merge but no -m option was given.
>>         error: no -m option was given to pick a merge 'next'.
>>
>> against the above example, then I would say that would be an
>> improvement, but that is not what is being discussed, so...
>
> Commits to be merged don't have to be branches.

I am not sure how that changes anything.

    $ git cherry-pick 38e70713119c25ab5699df6b2fb13e4133d399ab
    error: that commit is a merge and you didn't give me -m <which-parent>

    $ git cherry-pick 38e70713119c25ab5699df6b2fb13e4133d399ab
    error: the commit 38e707... is a merge and you didn't give me -m <which-parent>

Puzzled.
