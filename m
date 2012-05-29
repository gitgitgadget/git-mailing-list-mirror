From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] clone --local fixes
Date: Tue, 29 May 2012 10:43:32 -0700
Message-ID: <7vhauy6fy3.fsf@alter.siamese.dyndns.org>
References: <20120526034226.GA14287@sigill.intra.peff.net>
 <7vsjemp20j.fsf@alter.siamese.dyndns.org>
 <20120528053602.GA11174@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Emeric Fermas <emeric.fermas@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 29 19:43:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZQSV-000210-KM
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 19:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419Ab2E2Rng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 May 2012 13:43:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54937 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751380Ab2E2Rnf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2012 13:43:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA4EA829D;
	Tue, 29 May 2012 13:43:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A6SwcgZS58l6CE5DLG7BlFdtNUQ=; b=wcXBTe
	j9KkQEr2GNzqku0x3ZX08QJzY5r+ARH9z8G/SR1vFZjGdB5T9j86Cw36oDyeSesf
	s/zxfqpYaJ2PUDU/+J72OkWijlGOOMpwSCiU4zcwNYl74awd1Bmgmjp8WxQ3cZPt
	IrzzNmKY34RF1PEH4chRYimqa4wY+kvGKxdmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NL8MrvLbdNrWm6V3MwdHp0xPTEORH0OQ
	IagEqytN+APmGy+vr4bxUSbcU8YyLloV3WGTKDuxYo885Rz8HsJV7tSZDsmHGb/U
	yTut64Ei7VNAr8iTNZtculQsy+J11wL3RmymgEsfwOKUZUFWENx0Hk/So73Uf2+Z
	aHgYCAFEfTM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FC41829C;
	Tue, 29 May 2012 13:43:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1DFDC8299; Tue, 29 May 2012
 13:43:34 -0400 (EDT)
In-Reply-To: <20120528053602.GA11174@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 28 May 2012 01:36:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CFFB0A4C-A9B5-11E1-9B27-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198742>

Jeff King <peff@peff.net> writes:

> I think it depends on the definition of "--local". If it means "when we
> are cloning without a URL, turn on the local optimizations", then yes,
> "file://" should not work. If it means "turn on local optimizations if
> this destination supports it", then it should.

It has meant the former since the day --local was introduced, and
the semi-deprecation at 3d5c418 (git-clone: aggressively optimize
local clone behaviour., 2007-08-01) didn't change it, either.

> The current behavior is ambiguous as to whether it is the first case, or
> whether it is the second, and it was simply buggy. The history you gave
> argues that the original intent was the former. But to me that is much
> less important than what is useful and least surprising to users.

Changing it would make it even more confusing to people who started
using Git before mid 2007, though.  That is why I am for deprecating
(and eventually removing) "--local".

It is not like we do not have a way to force "local" behaviour.
Just give a local pathname and "local" behaviour will kick in; if
you do not want "local" behaviour, give network URL or file:// URL.
If there were no old scripts, there is no reason to have "--local"
in the supported options list of the command.

Having said all that, because the conclusion above is "we need to
keep --local for now for old scripts, and its behaviour for sane
case should not change", there are some glitches we may want to
address for people who try to use "--local" without knowing that it
no longer is necessary to use it if you live in modern age.  For
example:

 $ git clone --local $URL

does not error out, when $URL does not name a repository in the
local filesystem. I think that *can* be changed without breaking old
scripts.  We usually probe to see if $URL is a pathname of a local
repository, and then fall back to transports, but we should error
out when --local is explicitly asked for, instead of falling back.

> There are basically three sane behaviors for "git clone --local
> file://":
>
>   1. --local is silently ignored, because it means "if we are local,
>      turn on optimizations" (though it has a horrible name, in that case)

That is my first preference; "--local" started as an opt-in
experiment until it turns out to be useful and became no-op because
of 3d5c418, and for the purpose of that experiment, "--local" was
perfectly a good name.  It is a no-op now.

>   2. it's an error; you should not use --local with a URL

And this is my first preference for a longer time deprecation plan
(see above).

>   3. it should use local optimizations (because file:// is local)

Hrm.  "file://" has always been a way to say "do not use local
optimization".  Doesn't it feel simply insane to invent "--local
file://" as a way to say "even though the second word on this
command line tells you not to use the local optimization, by adding
this newly redefined --local option, I am telling you to use the
local codepath after all"?  Instead, I would prefer to see us just
finish the deprecation that started long time ago.
