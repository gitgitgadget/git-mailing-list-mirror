From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout: do not corrupt HEAD on empty repo
Date: Tue, 08 May 2012 10:13:05 -0700
Message-ID: <7v8vh2wq8u.fsf@alter.siamese.dyndns.org>
References: <1336493114-4984-1-git-send-email-kusmabite@gmail.com>
 <CABPQNSau5snkNLqsnBnsLVBVNKHXnvb8rsE8DbNfpo9__5uijA@mail.gmail.com>
 <7vsjfawrmw.fsf@alter.siamese.dyndns.org>
 <CABPQNSbyh8oMfz8GbDDn_bdLc8RpEt5sq7wxtVFh61ekD_j8yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, j.sixt@viscovery.net, schwab@linux-m68k.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue May 08 19:13:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRnyM-00033K-TN
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 19:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756384Ab2EHRNJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 13:13:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50707 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754666Ab2EHRNI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 May 2012 13:13:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CA417102;
	Tue,  8 May 2012 13:13:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=15y8xY4zLu4h
	Wl9JXopijTB0A0Q=; b=LRnvSjB5+tkYuDfWxQTpPZFfajnOFOJuDcPl351t5YQ+
	u0PM0bClTMT6GyBoMV9WOH9rms9yhuSIapYJ9B6S8nkhQvXgPD8dqMdAWbokhqlr
	Is5s/slP5zHP0TR7BaS468vETe5b3F2EC/FxDArRAkuGOSm+AsO4qqz26p7kync=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=U9nGr+
	/589Ijdj8CHsREpSgjE0G0nO0+CA4ZQ5LEM5LLyNxwVxsDKKo++q4bbpS+ma48s1
	Du6/u8cExkCn0GZVwVhPGEevVwDafEGQ5HaqBZzz0hmZJNDdwi50z2OUUGq5iZ4G
	NFjCWBw0LtaK3o4H1u1QB4tuSUiMlplJMIObI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 802687101;
	Tue,  8 May 2012 13:13:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DAA4E7100; Tue,  8 May 2012
 13:13:06 -0400 (EDT)
In-Reply-To: <CABPQNSbyh8oMfz8GbDDn_bdLc8RpEt5sq7wxtVFh61ekD_j8yQ@mail.gmail.com> (Erik
 Faye-Lund's message of "Tue, 8 May 2012 18:52:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1431955E-9931-11E1-A03D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197396>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> On Tue, May 8, 2012 at 6:43 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> ...
>> Hrm, I am of two minds. =C2=A0Yes, we may want checkout to fail, but=
 at the
>> same time, we would want to make sure that a failed checkout does no=
t
>> corrupt the HEAD.
>
> Good point.
>
>> =C2=A0Perhaps it would make it more palatable if you replaced
>> "cat .git/HEAD" with "git symbolic-ref HEAD" in the original?
>
> Ah, yes. That's much better. Do you want me to resend (improving the
> test and replacing "CRT" with "vsnprintf")? I also spotted a typo in
> the commit message ("crasheed" vs "crashed")...

Surely.

By the way, notice I said "we *may* want checkout to fail"?  With the
discussion "why is it wrong to allow 'git checkout' to be no-op in a
freshly created repository" stemming from your other "I do not claim it=
 is
correct but it makes the test pass" message, we may actually want to ma=
ke
that 'checkout' in the test pass, and then 'test_must_fail git checkout=
'
in the test would have to go when that happens.
