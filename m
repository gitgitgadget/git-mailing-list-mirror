From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-svn: workaround for a bug in svn serf backend
Date: Fri, 17 Jan 2014 11:23:15 -0800
Message-ID: <xmqqr486wgyk.fsf@gitster.dls.corp.google.com>
References: <20131226202805.GV20443@google.com>
	<1388131515-3015-1-git-send-email-rkagan@mail.ru>
	<20131227200708.GD20443@google.com>
	<20131227203443.GA9189@dcvr.yhbt.net>
	<7veh4yj5mm.fsf@alter.siamese.dyndns.org>
	<CANiYKX4fjYYRneqPxFDmpPg7e5ge9-hNktBvXVLQ=JxtM56tAQ@mail.gmail.com>
	<xmqq4n5qrume.fsf@gitster.dls.corp.google.com>
	<CANiYKX5aUYWV2Kt_yMmAxeC07SuNcs-tJEe8e2SY4p1NHBPKUA@mail.gmail.com>
	<CANiYKX4VhxZsuwKMfaMToner-+ipYmsFy_T6Bgxwj_a950PA3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Benjamin Pabst <benjamin.pabst85@gmail.com>
To: Roman Kagan <rkagan@mail.ru>
X-From: git-owner@vger.kernel.org Fri Jan 17 20:23:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4F0m-0007mf-E8
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 20:23:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610AbaAQTXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 14:23:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52573 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753308AbaAQTXT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 14:23:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF4F262D05;
	Fri, 17 Jan 2014 14:23:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LREaHTDKhYGuq5iyq5Jx+j0ACrE=; b=aKU/Ef
	mvZ0HO2smCnhxVs6RZUaUyAFn4B/OstALXYQg3ckl8sm/NOwuUgDqAOs5L/NyvjS
	C88m0HgvAdkVYXMluxP6VmlsWCU1YUaNSDIj2hP5S37vlaiIrF7V/VhaIa7cyIzC
	JWx+bzvBL3g5HpaJrafh/IqEAL1wwT0Fxo1YE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FyJvTH+5YlywU5sMHJjwWWrzuyyE8g9s
	wIkUmELeuM8A37S5YofMcnAbI9aDfSjJLrWB0msiEIIrSktRxtCyJPLK9eADfKBV
	A6O3Avi/A6KYoYbCKdP71BFqa4layhWCbvAdHgeJr2I52piE0yf6kjeuyoLIs+1Z
	LUEVUcttOqE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B42A762D04;
	Fri, 17 Jan 2014 14:23:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EE7C562CFF;
	Fri, 17 Jan 2014 14:23:17 -0500 (EST)
In-Reply-To: <CANiYKX4VhxZsuwKMfaMToner-+ipYmsFy_T6Bgxwj_a950PA3A@mail.gmail.com>
	(Roman Kagan's message of "Fri, 17 Jan 2014 15:32:01 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D1A9486C-7FAC-11E3-A8E1-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240614>

Roman Kagan <rkagan@mail.ru> writes:

> 2013/12/31 Roman Kagan <rkagan@mail.ru>:
>> 2013/12/30 Junio C Hamano <gitster@pobox.com>:
>>> Roman Kagan <rkagan@mail.ru> writes:
>>>> I'd like to note that it's IMO worth including in the 'maint' branch
>>>> as it's a crasher.  Especially so since the real fix has been merged
>>>> in the subversion upstream and nominated for 1.8 branch, so the
>>>> workaround may soon lose its relevance.
>>>
>>> I do not quite get this part, though.
>>>
>>> If they refused to fix it for real, it would make it likely that
>>> this workaround will stay relevant for a long time, in which case it
>>> would be worth cherry-picking to an older maintenance track.  But if
>>> this workaround is expected to lose its relevance shortly, I see it
>>> as one less reason to cherry-pick it to an older maintenance track.
>>>
>>> Confused...
>>
>> I thought it was exactly the other way around.  By the time the next
>> feature release reaches users, chances are they'd already have
>> subversion with the fix.  OTOH the workaround would benefit those who
>> get their maintenance release of git (e.g. through their Linux distro
>> update) before they get their maintenance release of subversion.
>
> So this actually happened: 1.8.5.3 is out, and some distributions are
> shipping it (Arch, Debian), but the workaround didn't make it there.

The way I read your message was that the fix on the subversion side
is already there and this patch to work it around on our end is of
no importance.

But actually you wanted to say quite the opposite.  They are slow
and it is likely that we need to work their bug around for a while.

If so, then I think it might make sense to cherry-pick it to the
maint branch, even though we usually apply only fixes to our own
bugs to the maintenance track.
