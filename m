From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8 v6] diff --stat: use the full terminal width
Date: Wed, 22 Feb 2012 11:41:12 -0800
Message-ID: <7vr4xmac6f.fsf@alter.siamese.dyndns.org>
References: <1329775034-21551-1-git-send-email-zbyszek@in.waw.pl>
 <7v4nuljcnk.fsf@alter.siamese.dyndns.org> <4F42E4C2.7070801@in.waw.pl>
 <7vr4xois3l.fsf@alter.siamese.dyndns.org> <4F436C5D.7070606@in.waw.pl>
 <7v1upogd6w.fsf@alter.siamese.dyndns.org> <4F44D084.7030308@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	pclouds@gmail.com, j.sixt@viscovery.net
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Wed Feb 22 20:41:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0I40-0005qC-2a
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 20:41:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094Ab2BVTlP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Feb 2012 14:41:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56016 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752479Ab2BVTlO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Feb 2012 14:41:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 408AF7B71;
	Wed, 22 Feb 2012 14:41:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=3QM7wU8EWdl+C7J/FgoJgK74c
	AE=; b=S5V2un0Xk9oxt5V1tgY4ySVeAVfPJIgAl3OwsPE+BsRaX3Ww6HQNWToyV
	Lix+zEap1JCvLe+OJ93XlRDrmWThtYDQyOojmJYwCnWu+tQ7N0nXNtnC3aan1fQA
	lC+7g0IloqqKDqF+T/kY9xHptb4UU6cnKzPA46zvKLlB0lVnV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=Kz0iT9UYBA8LbWGE7CG
	XuSfNgcwaTKhQIb7ViwsoN2Qbqj0S8bJcf+F37bAdMLpoGQ877wIEY5V3JvTqc+k
	aVicqWL4JpsYKm6T4EnpTvmA84fG+w5wPWDHROxR+aVAO85eugYjhFMs3YMa9HTN
	uVmjCX0t8HzHlI0Nnq8fS/M4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 376817B6E;
	Wed, 22 Feb 2012 14:41:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D6A27B6D; Wed, 22 Feb 2012
 14:41:13 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2DACF936-5D8D-11E1-9317-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191273>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> by "scales monotonically with the change count" I meant with two
> different commits.

Because of the scaling, the same 300-line change to the same file will =
be
shown with different number of +- depending on the amount of change to
other files in the same commit.  It is not something we should be worri=
ed
about to begin with, unless you are going to read all commits in advanc=
e
and find necessary length of the name part, and also maxchange across
these commits to align things across commits, which of course would not
mesh well with our desire to stream output whenever possible.

>  [7.3/8] limit graph part to 40 columns

Read the problem you are trying to solve again (from your 3/8):

>> If commits changing a lot of lines are displayed in a wide terminal
>> window (200 or more columns), and the +- graph would use the full
>> width, the output would look bad. Messages wrapped to about 80 colum=
ns
>> would be interspersed with very long +- lines.

If your name part needs only 10-20 columns and you are used to seeing
graph bars that are 60-70 columns long on your standard 80-column
terminal, you may see it ugly if the same short names are followed by
graph bars that are 180-190 columns (i.e. "very long +-"), when the
messages still fit 80 columns on the standard terminal, which is a widt=
h
that can comfortably be scanned with horizontal movement of human eyes.=
  I
would understand that concern, although I do not personally think it is=
 a
big deal.

Imagine if your name part were 125 columns wide (200 * 5/8), and also
imagine you drew the same graph bars as before, i.e. using 60-70 column=
s.
That line will fill almost the full terminal width, and will extend bey=
ond
the right edge of the message block, but you are not showing "very long=
 +-
lines" anymore.  The length of the line comes mostly from overly long
names, carrying more information than before (because your patch lets u=
s
show larger parts of such a long name on wider terminal), and without=20
losing much information from the graph part.

Now imagine if your patch only needed 10-20 columns for the names, and =
you
are showing the same change on an 80-column terminal with your 40-colum=
n
cap.  You will introduce a new problem with "very short +-" lines inste=
ad,
as the "diff --stat" block will be much shorter than the surrounding te=
xt.

You fixed a bug in the original partitioning with 1/8, which was caused=
 by
a code that capped the length of the graph part too early before taking
the width necessary to show the name into account; the bug resulted in =
a
graph that did not fill the allotted space fully to the right, even tho=
ugh
the user wanted to give full width to the graph.

The ugliness avoidance against "very long +-" becomes an issue only on
wide terminals; doing the same 40-column cap on non-wide terminals is t=
o
re-introduce the same "cap the graph width too early, ending up with a
graph that is narrower than desired" bug you fixed.  Why do you keep
insisting on that broken approach?

It might be just the matter of raising the artificial cap to much highe=
r
than 40-column (say, 80-column).  A possible alternative may be to decl=
are
that the perceived ugliness is the user's problem of having overly wide
terminal in the first place and do without any such cap.

Either is fine, but regressing output on 80-column terminal when showin=
g a
patch with short filenames and large changes is unacceptable, not becau=
se
I personally use 80-col terminal myself (I don't---mine is a bit wider =
but
not 200), but because it changes behaviour from the old code without an=
y
good justification to do so.
