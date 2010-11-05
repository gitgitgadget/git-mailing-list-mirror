From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: fix misnested -l and --contains in
 git-tag synopsis
Date: Fri, 05 Nov 2010 09:51:54 -0700
Message-ID: <7vzktnu311.fsf@alter.siamese.dyndns.org>
References: <1288783029-11226-1-git-send-email-philip@foolip.org>
 <7vmxpovq0r.fsf@alter.siamese.dyndns.org>
 <AANLkTikXM4BjRHOeS=3mirr9=YRW8sdaHFt05D-9BDxL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Philip =?utf-8?Q?J=C3=A4genstedt?= <philip@foolip.org>
X-From: git-owner@vger.kernel.org Fri Nov 05 17:52:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEPWO-0002u1-Tb
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 17:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753595Ab0KEQwE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Nov 2010 12:52:04 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50632 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522Ab0KEQwD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Nov 2010 12:52:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5D7682DB6;
	Fri,  5 Nov 2010 12:52:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BlZwuasT8cdE
	Xqi/t5cX0+FHjVY=; b=SyHWfwI59ZivzAvFgnJtOZNTlBGWNfqRdLHYVxLQxDne
	KPPuMssHChwQ0WURtNUviYdzg6T7shjxegee4ZQhsURtOAFXNQ+SSXSmaC0u+5V1
	uBF2H/M/cbVRFiJjlA0qIyQ7p2cCho7z9D8J7ycuAPoO3x7riAlIk+nBH7CEW10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jrXPq4
	DbghXnWa8QWhzEWMwimn4pC8P9q2fmfXe3HaPU5H4qz0f+jgbmz4g7maDg218Sja
	7rA2pbrKm6+J3urXaR945W15tr2s9PvvzhBh8jx6mW9Insb86VIJe5SgWjdVPEnd
	wPYsI1VgjTtPvy3CpIdPim0vf7EkYX0Weq68o=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3E4842DB4;
	Fri,  5 Nov 2010 12:52:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2B6F32DB3; Fri,  5 Nov 2010
 12:51:58 -0400 (EDT)
In-Reply-To: <AANLkTikXM4BjRHOeS=3mirr9=YRW8sdaHFt05D-9BDxL@mail.gmail.com>
 ("Philip =?utf-8?Q?J=C3=A4genstedt=22's?= message of "Fri\, 5 Nov 2010
 10\:28\:12 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 032E701E-E8FD-11DF-A2FC-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160818>

Philip J=C3=A4genstedt <philip@foolip.org> writes:

> ... they do in fact interact in some non-obvious way or if -l <patter=
n>
> --contains <commit> means something different from -l --contains
> <commit> <pattern>, it would be great if that were made more clear.

There is no difference; at least there shouldn't be any, and if there a=
re,
you found a bug in the implementation.

Let's try to see if I can explain it better.

"git tag" command operates in four modes:

 - "Creating" is the default mode.
 - "Verifying" is triggered with the -v option.
 - "Deleting" is triggered with the -d option.
 - "Listing" is triggered with the -l option.

In "Listing" mode, you can limit which ones are shown by adding <patter=
n>
at the end [*1*]; "--contains <commit>" can also be used to limit.  You
can change how tags are shown by "-n <lines>" option.

Absense of -v, -d, or -l options does not automatically mean "Creating"
mode; when it is clear from other options that "Listing" is requested, =
we
do so without "-l".  When you have "--contains <commit>", for example, =
it
is obvious that you want a listing.  The same if you have "-n1".

[Footnote]

*1* I think allowing <pattern> anywhere on the command line but at the =
end
is actually a bug.

Even though it can be argued that it does not _hurt_ not to refuse such=
 a
command line (i.e. the command would do something useful), it appears t=
o
me that it did hurt in this particular case by giving a false impressio=
n
that somehow "-l" takes an optional <pattern> argument by allowing othe=
r
options after "-l <pattern>" is given.

Arguably, it is the same kind of "usability measure" as our dwimming in=
to
listing mode without "-l" when we can infer the intent of the user from
other options, but I think we sometimes overdo usability measures to th=
e
point that they negatively affect the learning curve of users.

I also think allowing only one <pattern> is a bug.  The command should
filter the tags by union of <pattern>s, just like how pathspec works.
