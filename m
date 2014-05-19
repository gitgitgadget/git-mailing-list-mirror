From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Sun, 18 May 2014 23:11:17 -0700
Message-ID: <xmqqppja2t8a.fsf@gitster.dls.corp.google.com>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
	<20140516084126.GB21468@sigill.intra.peff.net>
	<xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>
	<20140516225228.GA3988@sigill.intra.peff.net>
	<5376f2ca5c90d_65b915db2f877@nysa.notmuch>
	<20140517062413.GA13003@sigill.intra.peff.net>
	<xmqq1tvq4r43.fsf@gitster.dls.corp.google.com>
	<53795ef8e4023_10da88d30825@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 19 08:11:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmGnJ-0003aZ-86
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 08:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624AbaESGLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 02:11:24 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58682 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbaESGLW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 02:11:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 844D211767;
	Mon, 19 May 2014 02:11:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fUS23YEaeB6M+Dswbpb90PPc68s=; b=UDYmLN
	8nWIXQgeItTuRF6GboJDp+DqMrKKu3ysW1NkJMZHDk+R7OtUToEC+5cAATgh8s0N
	Jz645Zj+DMsCbxwzRFyuFvmyaPT0kaGPGA6XGXaA1KhcIWfByYY3VkPWBCDZkUND
	aDgPtib4GQooEzSf3cladUHL5MZ5EPUobpQrA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bJVhc3AbsmFCnfylPPOYJyi3I78TfqwN
	vHnt+h29UaLmPmf68gSzJHYhgDDN+9fxSRjRacLCxQ3ejMtgnsL+Y/SiHN5IUWuD
	2+3wocez6grFdQuhUrvQTuoGr2jiOVUEACeU5G7Xqqn+Eop6UInJyZ9NqNUaI1dh
	2Bhlz0FKArs=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7B0AA11764;
	Mon, 19 May 2014 02:11:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9F73611761;
	Mon, 19 May 2014 02:11:18 -0400 (EDT)
In-Reply-To: <53795ef8e4023_10da88d30825@nysa.notmuch> (Felipe Contreras's
	message of "Sun, 18 May 2014 20:31:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6455197E-DF1C-11E3-8D25-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249561>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>
>>  - The "always warn" does not force update at the point of use, but
>>    it still does not help them to notice well before they try to use
>>    it for the first time after update;
>
> I don't understand this sentence. They will see a big fat warning every
> time they run the tool, of course they'll notice.

Let me ask one question first, in order to avoid miscommunication,
as I really want to get the first step for v2.0-rc4 in a concrete
shape tomorrow.  Do you think gradual transition worth pursuing or
do you think it is a waste of time?

I do not think it matters that much, but since you said you do not
understand...

What I meant was that when they update their Git (perhaps at the
beginning of the week), the won't know they will now be running
stale code.  The warning comes only when they first run it (perhaps
at the end of the week) to do some real work with a remote hg
repository, which may not be a convenient time to do their sysadmin
task.  And the next time when they update their Git, they may have
already forgotten about the warning.  The ideal transition would be
to somehow let them notice when they are in sysadmin mode.

>>  - "Break the build" attempts to help them notice when they try to
>>    update, not when they need to use the updated one right at this
>>    moment.
>
> This cannot be done.

Renaming the directory will not "break at the build time" for those
who have already did "ln -s" these scripts, of course, but it will
"break at the build time" for others (i.e. those who "cp"), no?
Again, not very important, as I too consider it optional.  If you
are shooting for an expedited transition, it is perfectly fine to
drop it.

> They click that URL, and the are immediately greated with this:
>
>   To enable this, simply add the git-remote-hg script anywhere in your $PATH:
>
>     wget https://raw.github.com/felipec/git-remote-hg/master/git-remote-hg -O ~/bin/git-remote-hg
>     chmod +x ~/bin/git-remote-hg

Perfect.  I did check the page when double-checking the URL while
writing the README thing, and I did skim the page, but I must have
missed it.

We could add these two to the warning, then, to discourage people
who see "please visit this URL" and say "Yuck, I have no time for
that" without actually visiting.

>> So to summarize, the following timeline is a full possibility:
>> ...
>>   2. add warning that is given every time the scripts are run and
>>      give the same instruction as in README.
>> 
>>   3. (optional) cripple the script to make them always fail after
>>      showing the same warning as above.
>
> This is what I want, and I already sent the patches for; the scripts
> will be stubs. At this point you would have effectively removed the
> code, which what I want.

I think explained why the step 3 would not help very much compared
to the "there is no script, only README remains" endgame (and that
is why it is marked as "optional").  Actually, you reminded me that
a very short and easy-to-follow instruction is on the page referred
to from README and the warnings, which means that this step would
make even less difference compared to the endgame.

I don't think I saw you explain why that is not the case and why we
do want this step (and I cannot quite tell if you are aiming for
more gradual transition that wants this step, or an expedited one
that does not).  I am fine with either way.

In any case, I'd ask another question to avoid wasting time on
miscommunication.  By "This is what I want", do you mean you want
this step 3 also in v2.0, or do you mean you want 2 alone in v2.0
then step 3 some time later?

Unless you want 2 and 3 together at v2.0, we do not have to decide
the merit of step 3 before v2.0-rc4; if you do want 2 and 3 together
for v2.0, then your prompt answer matters a lot.

You said your "wish" wasn't "respected" in another message, when I
explained that I thought you did not want to disrupt v2.0 by
insisting on removing these scripts and that was why I listed
options that did not involve removal of the scripts.  Are you saying
that you wish you want to see them removed or crippled at v2.0?
Changing your mind after discussion is perfectly fine, by the way.

Thanks.
