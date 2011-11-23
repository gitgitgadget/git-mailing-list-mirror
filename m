From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add test that checkout does not overwrite entries in
 .git/info/exclude
Date: Wed, 23 Nov 2011 09:16:51 -0800
Message-ID: <7vy5v6bvy4.fsf@alter.siamese.dyndns.org>
References: <CAPRVejcpAZrLWCeHTZJr9Uk6_z6hTPQLLd6pCOKteYnRGMQ5ig@mail.gmail.com>
 <7vehx2ijf8.fsf@alter.siamese.dyndns.org>
 <20111120221930.GF14902@foodlogiq3-xp-d620.thebe.ath.cx>
 <7vzkfqgn91.fsf@alter.siamese.dyndns.org> <4EC9FC81.3080306@viscovery.net>
 <20111121081701.GA7985@do> <7vk46th5bz.fsf@alter.siamese.dyndns.org>
 <CACsJy8A7HVe8kLR5j9Ej0tJhpkxigCXRqpg9DvE9qJsfengi1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Taylor Hedberg <tmhedberg@gmail.com>,
	Bertrand BENOIT <projettwk@users.sourceforge.net>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 18:17:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTGRP-00063h-Ii
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 18:16:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755223Ab1KWRQ5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Nov 2011 12:16:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59159 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755172Ab1KWRQy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Nov 2011 12:16:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBE346EBF;
	Wed, 23 Nov 2011 12:16:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=tbrraTg3oEe7
	uG5eTPcFTdw/weQ=; b=GSR4zkLNdQwvc9N3xTePgWSajjCCjzIdj9pIqULSkaDU
	/n6IjQxWOUD/iaVAUzAgp9THkuhadEL2eNaWOOXlkHrPWooUN9QvYt0f26yT6ZFa
	SzQr8mSu7fw6ZvJeWGwH4eZA46JJGPxa/dZF+XosPVfYwJMAuyydgj/7bJksbJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=yJv2ec
	uXLaQa/yDzIm90zqx4gdy+H4M5MBFXiuF+m4vA0CTl9qfYiz+pYD5ueg6z/vdmQ7
	nz68w797T7J0jR6ou7pv3X+GJqJYYrWViDOSuc3tMoYaob8K57fplYyw1X1jfyV+
	aK85sRZ2o2vF7xTlwIJUu2Kn0wU/70nnyxqXo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3F566EBE;
	Wed, 23 Nov 2011 12:16:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A2FA6EBD; Wed, 23 Nov 2011
 12:16:53 -0500 (EST)
In-Reply-To: <CACsJy8A7HVe8kLR5j9Ej0tJhpkxigCXRqpg9DvE9qJsfengi1Q@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 23 Nov 2011 18:40:34 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0177818-15F6-11E1-B868-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185855>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Mon, Nov 21, 2011 at 10:18 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> In the medium term, I think one reasonable way forward solving the "=
TODO
>> that used to be tracked but now untracked and ignored" issue is to
>> introduce "info/exclude-override" that comes between command line an=
d
>> in-tree patterns. The info/exclude file is designed as the fallback
>> definition to be used when all other sources are too lax, and comes =
near
>> the precedence stack; the "TODO" situation however calls for an over=
ride
>> that is stronger than the in-tree patterns.
>
> "info/precious" might be a better name

The above is only about the precedence order and is not about introduci=
ng
the new "precious" class at all.

>> In the longer term, we should carefully determine if we need "precio=
us" in
>> the first place. The last time this was brought up there were people=
 who
>> argued they are OK with having to remove the ignored file by hand wh=
en
>> checking out another branch (i.e. we switch the semantics of "ignore=
d" so
>> that they are "not tracked but all precious").
>>
>> I think it matters in two cases.
>>
>> =C2=A0(1) If you change an untracked "cruft" file on branch A into a=
 directory
>> =C2=A0 =C2=A0 with tracked files in it on another branch B. If you a=
re on branch A,
>> =C2=A0 =C2=A0 have that "cruft" file (perhaps it is a build product =
after running
>> =C2=A0 =C2=A0 "make"), and try to checkout branch B, such an updated=
 "git checkout"
>> =C2=A0 =C2=A0 will start erroring out telling you that "cruft" will =
be lost.
>>
>> =C2=A0(2) If you have a directory on branch A, underneath of which t=
here are
>> =C2=A0 =C2=A0 untracked "cruft" files (e.g. think "build/" directory=
 that is full
>> =C2=A0 =C2=A0 of "*.o" files and ".gitignore" to mark object files a=
s ignored but
>> =C2=A0 =C2=A0 is otherwise empty), and another branch B that has the=
 same path as a
>> =C2=A0 =C2=A0 file. If you are on branch A, have "cruft" files in th=
at directory,
>> =C2=A0 =C2=A0 and try to checkout branch B, such an updated "git che=
ckout" will
>> =C2=A0 =C2=A0 start erroring out telling you that "cruft" will be lo=
st.
>
> I think we should do this regardless precious being added or not.

Because (see below)?

>> If people are OK with such a behaviour, we can do without "precious"=
=2E
>
> What about git-clean to remove ignored but not precious files?

"clean" without -x is a way to remove untracked and not ignored files,
i.e. remove "test.c", "trash-patch", "notes" that are not part of the
sources but were crufts you hand generated during your development proc=
ess
that you do not need, without removing build products such as "main.o".=
 If
we switch the semantics of "ignored" from "untracked and is expendable =
for
the purpose of checking out another conflicting branch" to "untracked b=
ut
is not expendable", it is clear that it should not remove them.

"clean -x" is more subtle. It has been a way to say "Remove cruft the
usual way, and in addition, remove the expendable build products, just
like 'make clean' _should_ do, but I do not trust my Makefile". If we
introduced "precious", it would be very clear what it should do---even
with "-x" precious files should be kept. But if we don't and just try t=
o
get away by changing the semantics of "ignored", they will still need t=
o
be removed, so we won't really get the "precious".

The conclusion from this is that it is a mistake to change the semantic=
s
of "ignored" from the current "untracked and expendable if needed" if t=
he
purpose of that change is to avoid introducing the new "precious" class=
=2E

I don't care too much about it, as I do not use "git clean -x" myself ;=
-)
but that wouldn't stop others from think about the issue and try to com=
e
up with a good solid design.

> Or do excluded() twice, the first time to check for precious files,
> the second for all ignored rules. Callers are changed anyway, but thi=
s
> way git-add for example will be untouched because it does not care
> about precious stuff. Only unpack-trees and maybe git-clean are
> changed.

I don't think we want to go there, as it will encourage different
codepaths doing different things without a good reason. Having to add
ignore source manually in different codepaths was the real cause of the
inconsistency bug around info/exclude vs .gitignore we discussed earlie=
r.
