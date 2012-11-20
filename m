From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] fix git-config with duplicate variable entries
Date: Tue, 20 Nov 2012 11:08:43 -0800
Message-ID: <7vsj84rt1g.fsf@alter.siamese.dyndns.org>
References: <CACBZZX4cu9XuS5AtduWrNeXNUeZ4rqDUzRdmyz2b3cXtmo1nqQ@mail.gmail.com>
 <20121022211505.GA3301@sigill.intra.peff.net>
 <CACBZZX5mOb7_i9r8AqNK5V3r-gVnzN+rkeY9xrhecGv1rS-anA@mail.gmail.com>
 <20121023223502.GA23194@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 20 20:09:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TatBt-0007F7-Lf
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 20:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925Ab2KTTIr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Nov 2012 14:08:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58675 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751868Ab2KTTIq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Nov 2012 14:08:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B2A7A469;
	Tue, 20 Nov 2012 14:08:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ZA4/rPbJCCNe
	vwmjz2v07Id8nMs=; b=Pr1oAIkkU6zfFVqAWFqmMj30kGpn6c08vjfXYRtmIuh9
	cDPJAwGbg80y+2HvawQbNNDxGAg3cEAKQGE9QTWxYts8duMAliJCcxDyNdKWgUN5
	Z89T8NU4dVajcnBVrh/UJV8OJAKaj0WS0svMyqwhZw9VAny3Gvul7ni1MTgyJnA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cYLe37
	v1m1VTO06SVtgi3K0PTXR3VhxJV5V8KmAMS/nTxQyajD30Pc6P7rta2TsiE5QdxK
	bwzUKl9Csou3brZVnIOEFifKBXWSwqRAjWmq3oetP1Bo7hzs9AAFRGz7IlX5vlQg
	rZaEXGTgC4rSXpUxmQmmfHb6RWXCVC87+9bHU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88DF1A468;
	Tue, 20 Nov 2012 14:08:45 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA6F3A467; Tue, 20 Nov 2012
 14:08:44 -0500 (EST)
In-Reply-To: <20121023223502.GA23194@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 23 Oct 2012 18:35:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B486B6FC-3345-11E2-8D3D-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210105>

Jeff King <peff@peff.net> writes:

> On Tue, Oct 23, 2012 at 04:13:44PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>
>> > It fails a few tests in t1300, but it looks like those tests are t=
esting
>> > for the behavior we have identified as wrong, and should be fixed.
>>=20
>> I think this patch looks good.
>
> Thanks. It had a few minor flaws (like a memory leak). I fixed those,
> updated the tests, and split it out into a few more readable commits.=
 In
> the process, I managed to uncover and fix a few other memory leaks in
> the area. I think this version is much more readable, and writing the
> rationale for patch 7 convinced me that it's the right thing to do.
> Another round of review would be appreciated.
>
>   [1/8]: t1300: style updates
>   [2/8]: t1300: remove redundant test
>   [3/8]: t1300: test "git config --get-all" more thoroughly
>   [4/8]: git-config: remove memory leak of key regexp
>   [5/8]: git-config: fix regexp memory leaks on error conditions
>   [6/8]: git-config: collect values instead of immediately printing
>   [7/8]: git-config: do not complain about duplicate entries
>   [8/8]: git-config: use git_config_with_options
>
> For those just joining us, the interesting bit is patch 7, which fixe=
s
> some inconsistencies between the "git-config" tool and how the intern=
al
> config callbacks work.


The way for the Porcelain scripts to mimick the internal "last one
wins" has been to grab values out of --get-all and do the "last one
wins" themselves, and I agree that a mode that frees them from
having to worry about it is a good *addition*.  I would even say
that if we were designing "git config" plumbing without existing
users, it would be the only sensible behaviour for "--get".

But "git config --get" users have been promised to get errors on
duplicate values so far, so I have to say this needs to come with a
big red sign about API breakage.

I would feel safer to introduce --get-one or something now, and
worry about migration as a separate step.
