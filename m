From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3703: add test cases for pathspec magic
Date: Sat, 07 May 2011 11:56:46 -0700
Message-ID: <7vwri2wd8x.fsf@alter.siamese.dyndns.org>
References: <1304764507-27547-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 07 20:57:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QImgt-0003kg-Ki
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 20:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755981Ab1EGS5B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 May 2011 14:57:01 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51712 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755418Ab1EGS5A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 May 2011 14:57:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1E2194288;
	Sat,  7 May 2011 14:59:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6fz0/Lpx7IQd
	Ptr20vvw1jSNufk=; b=n8s9vkZQQlvHD4zNOwrosVwbmfQscm9AzFDd6wNPpDEK
	hWq3Wz28yU6+ocHiaqEaSKMA8v+rqho/qFmkHBlQBN7b0jwwGYSNgIxtw3FInpzj
	r6QJU4ZASBI40AOpk90SioBMOuU/q5aFx8WyEujYSzxqYuvkSOtZK9+FLw/G2u8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=TtnmWC
	CaZ9XbqXcaSwNRV8WADfQ7qWLnFYCtQlt729rurzXboPNv7PAqbKGUaZN5Q5Rriv
	iaLDmt9dPm5pkVsjFkyIDYJWceahxVW/kXZtEwiwAFGXx98lWg8JqCJ3r7V1mgdc
	ZQEtt+LoY7rW7LTWokWHlwtOko6O0Duv8hnE0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A19D34287;
	Sat,  7 May 2011 14:59:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2D11F4286; Sat,  7 May 2011
 14:58:53 -0400 (EDT)
In-Reply-To: <1304764507-27547-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 7 May
 2011 17:35:07 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 11AA6048-78DC-11E0-8879-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173061>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> That was the intention, but it raises a question: what do we do if a
> file happens to have the same name with the given magic pathspec, as
> in the last two tests?

I would have expected that in such a case the user would pass a "\:" or
even ":::" to match the file ":", and "\:(rubbish)" to match the file
":(rubbish)".  The whole ":" is special thing comes from the observatio=
n
that a path that begins with a colon is rare, so it is Ok to require th=
e
user to do some more work (typing an extra backslash) when he really wa=
nts
to match with such a thing.

A script that takes a pathname that is meant to be a literal from the u=
ser
in its variable $x would pass ":(noglob)$x" when it wants to be strict.=
  A
script that lets the user say whatever and wants to pass would just pas=
s
"$x" along the callchain.

I do not expect this to be an issue in practice, though.  Have you seen=
 a
script that tries to quote all the possible globbing characters in "$x"
before calling into git with the current codebase without this magic?
