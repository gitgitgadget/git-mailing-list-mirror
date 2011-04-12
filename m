From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: don't pass on the --quiet flag
Date: Tue, 12 Apr 2011 11:56:20 -0700
Message-ID: <7vk4ezpacr.fsf@alter.siamese.dyndns.org>
References: <7v8vvgv5dm.fsf@alter.siamese.dyndns.org>
 <4DA36D95.6060108@windriver.com>
 <1302622538-7535-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue Apr 12 20:56:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9ilR-0002iu-KQ
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 20:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623Ab1DLS4c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2011 14:56:32 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54677 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187Ab1DLS4b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2011 14:56:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 398B5390F;
	Tue, 12 Apr 2011 14:58:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=LrVCbtKZ8CtI
	YTN3vzAcjGYbnNw=; b=oNitp2X13bDj5+Iys3amn0rE6jFiKzMDb3xKFMbsIbh6
	na1YUsTkqvy0eQbX1RK4e7y2ZN9FrL/opngs1JAirr7ZC8lNDabJy034HgDVxqMQ
	jzGlIlv+r5U0fKdWgPw2uv/yPfJ1m+SKc19pyATeq0s+A273f9LIy6zBqAHfiiE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cRLTqi
	BRAeFQZqGEDBD7Kzv1hb4iFDocM75PpPw2DscpEY1A71eVNh3jp0AHcHbRZ9G6Wb
	Q0T5+T8FOG3n1XTsaEloHGn2wqpx+1hQsgF/Kr//KPMjZtuT5XIC2djx3wkbqZAK
	UaIXbyrvs0CYIufE6mPQ3y+erW4K6djoUE9rg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 07A84390D;
	Tue, 12 Apr 2011 14:58:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D61993906; Tue, 12 Apr 2011
 14:58:19 -0400 (EDT)
In-Reply-To: <1302622538-7535-1-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Tue, 12 Apr 2011 17:35:38
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D78376A6-6536-11E0-892F-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171412>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

>> A patch to make --quiet not to squelch the patch output, and instead
>> silence any progress output would be a good addition.
>
> Something like this? I guess the only use case would be together with
> -o.

When the user gives -q without giving -o to a new or an empty directory=
,
the user deserves to get what was asked on the command line, so I would=
n't
worry about this particular case.  For a casual user, it is perfectly a
sensible thing to say "I'll eyeball; I don't have other files whose nam=
es
begin with [0-9]{4}- in my working tree" and I don't think we need safe=
ty
against doing that.

I however wonder if we should audit other commands in the "log" family =
to
see what they do when "--quiet" is given.  I know what they do currentl=
y
is whatever they happen to do for a nonsense request, and in no way is =
a
designed behaviour.  We simply did never think about that case.

=46or example, what should "git show master^2 next^2" do with "--quiet"=
?  Of
course the standard way to squelch diff output in the output from "show=
"
is to use "-s" (coming from "git diff-tree"), but giving "--quiet" shou=
ld
at least be a no-op.
