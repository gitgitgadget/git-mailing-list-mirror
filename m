From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a test for a problem in "rebase --whitespace=fix"
Date: Sun, 07 Feb 2010 16:15:50 -0800
Message-ID: <7vbpg060qx.fsf@alter.siamese.dyndns.org>
References: <4B6E7564.7040109@gmail.com>
 <7vtytsevsd.fsf@alter.siamese.dyndns.org>
 <6672d0161002071444lba0f751w3e7e33043e1ec2e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 01:16:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeHIL-0007r4-HE
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 01:16:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757377Ab0BHAP6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Feb 2010 19:15:58 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33666 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755692Ab0BHAP5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Feb 2010 19:15:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CCE1C98FED;
	Sun,  7 Feb 2010 19:15:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=drFm+BiVPh6V
	QLKtrj3W0T7T7vE=; b=eVqgCDZFSnmEOLXqMkd2cP6tlKfjx5c7xLur71C8Tywq
	fP6WQKwxc0n8CU1wxEimpwKbqznN9aOpjCi3/BUTUJ+Itc8rdzMvzc2hKMcdNoGN
	DGWezbL3jhaxZ1yed+4HPT/hxz3NzrevM9rPX3iO0JKiMpzl0cSboOJAzHZJyQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xXMCNl
	0oxF0q+pucXwicXK1XCpRNFtDV4gGjl8Px/X5wGN0hT8OdbskuLKCM81Dhg6fMUR
	fRgIKtNc/2TDst5sSkMgBQjTTmCRjgJ6PJs8HUykM610o8zdXxdLHMGwIf3aNNXh
	kQ6bzuKABtNU9RgvRTlshIHkH2sZ2rPYd2z6Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AAE9198FEC;
	Sun,  7 Feb 2010 19:15:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D5C9898FEB; Sun,  7 Feb
 2010 19:15:51 -0500 (EST)
In-Reply-To: <6672d0161002071444lba0f751w3e7e33043e1ec2e8@mail.gmail.com>
 (=?utf-8?Q?=22Bj=C3=B6rn?= Gustavsson"'s message of "Sun\, 7 Feb 2010
 23\:44\:20 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1F69A55E-1447-11DF-BEA9-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139266>

Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com> writes:

> 2010/2/7 Junio C Hamano <gitster@pobox.com>:
>
>> First, is this a condition that we want to change the behaviour to
>> "succeed" later?
>
> Yes, assuming it is possible to fix.
>
>> Imagine that the gap between abc and def block in your example is mu=
ch
>> larger to exceed the number of pre-context lines of your second patc=
h
>> (usually 3), and imagine you are the "git apply --whitespace=3Dfix" =
program
>> you have updated to "fix" the preceived problem. =C2=A0You know you =
earlier
>> might have stripped some blank lines at the EOF, but there is nothin=
g that
>> tells you if you had only 3 blank lines, or you had even more. =C2=A0=
How many
>> blank lines will you be adding back?
>
> My original idea was to add back exactly the number of lines needed
> so that the context lines would match. That can be calculated from
> the line numbers of the last line of the pre-image and the line numbe=
r
> in the chunk and by scanning the chunk for blank context lines
> (both at the beginning and end of chunk). Since the blanks lines
> at the end will be stripped away anyway, I doesn't matter if I add
> back fewer lines than were there originally.

And if it were in the middle like your patch had? =20

Suppose the first patch in your example ended with 10 blank lines inste=
ad
of just one.  You apply it with --ws=3Dfix and end up with 3-liner file=
 with
a/b/c.  The sender of that patch then builds on top of his copy (still
with 10 blanks at EOF).  Perhaps the early part a/b/c might be changed =
to
a/b/c/1/2 or something.  And on top of that change, he adds new text at
the end of the file (after those 10 blank lines) with another patch, li=
ke
your example added d/e/f at the end after the gap.

The sender then chooses to cherry pick and gives you only the last patc=
h,
to add d/e/f, for whatever reason.  The change in the earlier part to a=
dd
1/2 after a/b/c was not suitable for public consumption yet, perhaps.  =
The
patch comes with 3 pre-context lines as usual, what you see begins with
three blank lines, and has an addition of d/e/f.

You have already stripped the blank lines at the end when you applied t=
he
original one; you do not know how many blank lines at the end you lost
when you applied it (and you do not _want_ to record that when applying
either).

You cannot go by the line numbers on the "@@ -l,k +m,n @@" header line =
you
see in the second patch you received.  On that line, only k and n are
reliable numbers (the must match the patch text).  l and m are unreliab=
le;
being able to apply even if the text you have at hand does not exactly
match l and m is the whole point of transmitting the change in the patc=
h
format.  The _only_ information you have usable at that point is that
there are _at least_ 3 blank lines before the addition, and perhaps the
fact that the hunk ends without post context lines.  The latter tells y=
ou
that it must apply at the end, but still doesn't tell you how many blan=
ks
you need to add back at EOF before applying the patch.

> Do you see any fatal flaws that I don't see?

I don't know---the above is what I already said in my previous message =
and
it already looked fatal enough to me.
