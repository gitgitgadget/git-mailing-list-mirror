From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/8] cherry-pick: add --skip-empty option
Date: Mon, 03 Jun 2013 14:45:45 -0700
Message-ID: <7vehcidg1i.fsf@alter.siamese.dyndns.org>
References: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
	<1369799788-24803-4-git-send-email-felipe.contreras@gmail.com>
	<7vr4gjdomk.fsf@alter.siamese.dyndns.org>
	<CAMP44s1GQ2iwwscx4Sx1cxK0U6yWWYvOJqDk_FO_GkFcNKREYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 23:46:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjcZe-0005oY-5I
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 23:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757697Ab3FCVpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 17:45:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44603 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753676Ab3FCVpt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 17:45:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AE55251C2;
	Mon,  3 Jun 2013 21:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iF73GuJBkwATVTO+ocM6A1IWTSk=; b=L5yc3N
	t0TZz+lMbWpvgJI61CDTxM6Chg4jDjrpwyGWatZ6CUC6u/5y0J5q5tQnjvOjLALy
	7IkiA0ark8zQs/buG6RPF9X9SFRBraE3KJCk80En9qgboaMygjT1/XytAYNu5S82
	1oh8a1TxznsFDI7vuA72Qr9BaN8uYyiKkwd8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tHJExLd+NpmfMtYkw+Ibit5a5BJ/Cajj
	FXKHAbB7VISiH0Bts6K7JNRjnfdBuzNzby77E6CrpG/ZrGCUmnhi3U4/z7D32KHg
	J1fLuKsWtrU8onKwKhwM9zCMMIQq66GiwLXcq0HN5dY+csQ9vvt1isJy4XXIoJbc
	+GUpSh7twA4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2BC5251C1;
	Mon,  3 Jun 2013 21:45:48 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2483D251BD;
	Mon,  3 Jun 2013 21:45:48 +0000 (UTC)
In-Reply-To: <CAMP44s1GQ2iwwscx4Sx1cxK0U6yWWYvOJqDk_FO_GkFcNKREYw@mail.gmail.com>
	(Felipe Contreras's message of "Mon, 3 Jun 2013 16:10:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F3D55774-CC96-11E2-AA68-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226295>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Mon, Jun 3, 2013 at 1:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> Pretty much what it says on the tin.
>>>
>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>> ---
>>>  Documentation/git-cherry-pick.txt   |  3 +++
>>>  builtin/revert.c                    |  2 ++
>>>  sequencer.c                         |  6 ++++++
>>>  sequencer.h                         |  1 +
>>>  t/t3508-cherry-pick-many-commits.sh | 13 +++++++++++++
>>>  5 files changed, 25 insertions(+)
>>>
>>> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
>>> index c205d23..fccd936 100644
>>> --- a/Documentation/git-cherry-pick.txt
>>> +++ b/Documentation/git-cherry-pick.txt
>>> @@ -129,6 +129,9 @@ effect to your index in a row.
>>>       redundant commits are ignored.  This option overrides that behavior and
>>>       creates an empty commit object.  Implies `--allow-empty`.
>>>
>>> +--skip-empty::
>>> +     Instead of failing, skip commits that are or become empty.
>>
>> Not quite sure.  Is this "instead of recording an empty commit,"
>> (which may or may not fail depending on the allow-empty settings)?
>
> We are explaining --skip-empty, not --allow-empty.

Exactly.  That is why I found the "Instead of failing" questionable.
It is very easy to read the above as "commits that are or become
empty usually causes the command to fail, and this is a way to cause
it not to fail.".

It is true that

    cherry-pick A

when A becomes empty, dies.  But

    cherry-pick --allow-empty A

when A becomes empty, does not fail, but still does create an empty
commit.  A large difference with --skip-empty, which applies to use
scenario different from --allow-empty was meant to address, is that

    cherry-pick --skip-empty A

when A becomes empty, does not fail and does not create an empty
commit, either.

I think just "Skip commits that are or become empty" without saying
"Instead of failing," is fine, too.
