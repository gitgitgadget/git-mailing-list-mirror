From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2014, #05; Mon, 29)
Date: Tue, 06 Jan 2015 16:29:37 -0800
Message-ID: <xmqqfvbnmo0e.fsf@gitster.dls.corp.google.com>
References: <xmqq387yywm6.fsf@gitster.dls.corp.google.com>
	<CAGZ79kbOnX7LVDB8d2Nw0629MvY+ojmy0kDWATM2Zj8NzPRgjQ@mail.gmail.com>
	<20150105200644.GJ29365@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 01:30:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8eVQ-00084W-1p
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 01:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755870AbbAGA3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 19:29:42 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55850 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754742AbbAGA3k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 19:29:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 796B82E478;
	Tue,  6 Jan 2015 19:29:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4CT++wlo8QJz/ut+SAqTM7uoJFU=; b=iv3YcC
	heH3JUz02MxeYVIXVJFNAnc4zo2fcXxEacL9jba0At4PoLN10f5cMk3hExz/f8bv
	lkeNfkoiKTpWDMZ7YLqrV1Pp9UbNChLHflQ58UfO4+e7P+3rDss7hwuBTrdcdXkw
	mCpUvKHYtxXI5VwD10CA+bi6f7QHzDhwEZeiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KhNe1750a7MHAJPOuE6/m4HgJvuu8Csi
	dTw8Klkax2lf6jUOhJGZ1PgRx99z3nh85aafE2puU/u9aUMkWJow9nLYUYqe0CTq
	MrEpf5OKchDRP+/nAOEpseJLFNxpHFTJJUozq358Azq7XR+sCEUxFvxGgAEVuJSH
	nVb66Ur9Lf8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 70A922E477;
	Tue,  6 Jan 2015 19:29:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EA9602E476;
	Tue,  6 Jan 2015 19:29:38 -0500 (EST)
In-Reply-To: <20150105200644.GJ29365@google.com> (Jonathan Nieder's message of
	"Mon, 5 Jan 2015 12:06:44 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 43D01A88-9604-11E4-8B1E-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262116>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Stefan Beller wrote:
>> On Mon, Dec 29, 2014 at 1:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>>> * sb/copy-fd-errno (2014-11-17) 1 commit
>>>  - copy.c: make copy_fd preserve meaningful errno
>>>
>>>  Will be rerolled as a part of a larger series.
>>
>> I am not expecting to reroll this as part of a larger series any more.
>> So if this makes sense on its own, please pick it up?
>
> I think the errno-based approach is problematic.  No callers today run
> into the problem the patch fixes and if a caller did, I fear that
> caller would be broken in other ways.
>
> That said, no one seemed too excited about the alternative that
> propagates the error message more explicitly with a strbuf.  I'd be
> happy to re-send anyway, or I can work around this patch when
> rerolling.

OK, let's resurrect the issue when more people are actively
interested in having the right mechanism to propagate errors up in
the callchain.  I just re-checked the callers of copy_fd and I agree
that this will not affect existing callers (including the one in
hold_lock_file_for_append() called by add_to_alternates_file() that
passes LOCK_DIE_ON_ERROR), so I am inclined to drop the patch for
now.
