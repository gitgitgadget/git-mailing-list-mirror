From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-merge: Reduce heads before trying to merge them
Date: Wed, 18 Apr 2012 13:20:05 -0700
Message-ID: <7vzka8kd1m.fsf@alter.siamese.dyndns.org>
References: <CA+55aFzGwPYNn2baFhEr4msBTV7__nkTSUqAZ7=PRVoYrchV5w@mail.gmail.com>
 <1334687118-5386-1-git-send-email-michal.kiedrowicz@gmail.com>
 <7vzkaambre.fsf@alter.siamese.dyndns.org>
 <CA+55aFzLFA535CtjLJe1p62H=nunQ=vrL_mPYsYJB0e8U7mpdg@mail.gmail.com>
 <7vvckym6ec.fsf@alter.siamese.dyndns.org> <20120418201426.7070315f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 22:20:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKbMO-0006Ft-Su
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 22:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755068Ab2DRUUL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Apr 2012 16:20:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40931 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753422Ab2DRUUI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Apr 2012 16:20:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B26D649B;
	Wed, 18 Apr 2012 16:20:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zG5SqluXIgQN
	JAkRkHA/t9dhDCU=; b=W7tTFpUX2M+K27vDe0kfWpaRBqkoJySCRM0KGrC7kcD5
	GOrM0QVD7VZueom7uYX++9WBIoC4wnlQT1LkI0T6ENhKOzzkiKX0d1/oVt3Dtj0g
	seCa1OThNkG5NaEfx8Ikw11DXrkjLWU6bnEH/b6madAjFxBH07xYTitgFYwb7lU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=IX+GGa
	OdK62YUENIYIuklm/QW8Ei2PelMjbvq3z/VaXP4MYztpcKvaoGkiQM+gL3JOgErI
	/kMedvGFlsLlm680qtwtnOJthwEy7hB+OGYlfUbpp5wkEwVI8UHZYdBVFlbThxu9
	WwBRc0mKlnJd5O2a7c5OPs3s9gIQpMlMHobwM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61C98649A;
	Wed, 18 Apr 2012 16:20:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CCE2C6495; Wed, 18 Apr 2012
 16:20:06 -0400 (EDT)
In-Reply-To: <20120418201426.7070315f@gmail.com> (=?utf-8?Q?=22Micha=C5=82?=
 Kiedrowicz"'s message of "Wed, 18 Apr 2012 20:14:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E38A3AF2-8993-11E1-BB96-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195898>

Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
> =20
>> I was cooking a fix on-and-off since yesterday evening, and sent it =
out a
>> few minutes ago. I think the spirit is almost the same as Micha=C5=82=
's updated
>> patch, but it reduces the heads even earlier to catch cases where Mi=
cha=C5=82's
>> updated patch may misdiagnose arity of the resulting merge due to it=
s use
>> of remoteheads->next before the list is reduced (namely, the choice =
of the
>> default strategy based on how many we are merging).
>
> I like your patches, especially how reducing heads is now done in
> collect_parents() instead of doing it twice (before merging and in
> finish_automerge()).  And that you got rid of global remoteheads too.

Thanks.  Linus also said "Yes, that sounds right (on the road with just=
 my
phone, sorry for the html)" off-list to the series.
