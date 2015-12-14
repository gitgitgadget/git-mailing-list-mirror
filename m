From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git bisect with temporary commits
Date: Mon, 14 Dec 2015 11:21:06 -0800
Message-ID: <xmqqa8pckfa5.fsf@gitster.mtv.corp.google.com>
References: <20151214163726.GY13519@tonks> <87si34hphr.fsf@igel.home>
	<20151214182255.GB13519@tonks>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org,
	r.seitz@beh.ch
To: Florian Bruhin <me@the-compiler.org>
X-From: git-owner@vger.kernel.org Mon Dec 14 20:21:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8YgY-0006Kd-5Z
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 20:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbbLNTVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 14:21:20 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58465 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932182AbbLNTVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 14:21:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4749A31F96;
	Mon, 14 Dec 2015 14:21:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ng4APGvdu2xxn1VlY7qnMxaIb9Y=; b=tEr6vd
	K0yK9GUFQg8JMCe2x7FhiRXTOyfAS/wCA5R1he+XSwwVjud+OJUj2R13VH1j9bLO
	eSR0GGbP0k5+6y90h49bIVLGylaiTFIgFzL79y+EKr79/gUeJ3pmwrNafNKREk/n
	zZtab3CxU6M0D9bd/mDWCAqYvVpEiM947p1vo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NtHdALAAZiXmnUOOMLu1F3Wb7URZC0Vd
	P2fMptqMMC4aGKV72knBChR1EjngutOXoYaoicfMldxbE8PuXLvPjDPd5pUTz9qJ
	+evH2i9RL0sV3HIDirQn2Syz7kPV0kPigKiNGbhCMz8CiRX1gbfcn96YU9o/meQr
	LmNcZWNZdsY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0891031F94;
	Mon, 14 Dec 2015 14:21:15 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0C9EF31F91;
	Mon, 14 Dec 2015 14:21:13 -0500 (EST)
In-Reply-To: <20151214182255.GB13519@tonks> (Florian Bruhin's message of "Mon,
	14 Dec 2015 19:22:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D74F349C-A297-11E5-A436-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282384>

Florian Bruhin <me@the-compiler.org> writes:

> * Andreas Schwab <schwab@linux-m68k.org> [2015-12-14 19:08:48 +0100]:
>> Florian Bruhin <me@the-compiler.org> writes:
>> 
>> > Now when trying to say it's good (and forgetting to remove the
>> > temporary commits), I get this:
>> >
>> >     $ git bisect good
>> >     Bisecting: a merge base must be tested
>> >     [981e1093dae24b37189bcba2dd848b0c3388080c] still good and does not compile
>> >
>> > Is this intended behaviour? Shouldn't git either do a reset to the
>> > commit we're currently bisecting, or warn the user as it was probably
>> > unintended to add new commits?
>> 
>> You should instead tell git that HEAD^ is good, since that is what git
>> asked you to test.
>
> I see - but wouldn't it make more sense for a "git bisect good" (or
> bad, respectively) without arguments to assume I mean the commit
> bisect checked out for me, not HEAD?
>
> I don't see any scenario where the current behaviour would make sense,
> but I might be missing something.

When the commit "bisect" checked out is untestable, the user can
freely go to another commit, e.g. "git reset --hard HEAD^" to go
back one step, and then test it instead.  "git bisect good" has
to mark the then-current HEAD, not the commit that was checked out,
for this to work.
