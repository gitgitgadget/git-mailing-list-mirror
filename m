From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] attr: support quoting pathname patterns in C style
Date: Tue, 09 Nov 2010 16:07:29 -0800
Message-ID: <7vpquejb26.fsf@alter.siamese.dyndns.org>
References: <AANLkTinNctmWpshBeSTzZRm6+EJ=Cjdpoaj4Aon+52_b@mail.gmail.com>
 <1288878944-14066-1-git-send-email-pclouds@gmail.com>
 <7vvd4bu2pl.fsf@alter.siamese.dyndns.org>
 <15C4C111-824D-4657-B034-A1BE1DAD50D4@sb.org>
 <7v8w13r756.fsf@alter.siamese.dyndns.org>
 <626BD1B6-4DDF-457F-B430-F15C891710E2@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Marc Strapetz <marc.strapetz@syntevo.com>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Nov 10 01:07:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFyE9-0004Hk-Bi
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 01:07:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953Ab0KJAHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 19:07:44 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49484 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607Ab0KJAHn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 19:07:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4747C3BD3;
	Tue,  9 Nov 2010 19:07:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EUDbc5zZ73OloirCsOpDy10x8ME=; b=mw0n79
	ILJAg3Aabmpwjocp1DXWurFwKaBECnYxkEIFMh/DB3FTEHlzjx5NGbGgZ/h5ZXZT
	DeplqZTi4UdjE/b4koioTG9GV+cht27eI5PJdlIQoY6AV2JKGshFE/WS1IbqrA/I
	50e8prY0U7ObHSbk6yTySyZUiu66FS8qhTqD0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SHzZ2dHR2owQZ4kK0MlnWAnFaim7XAso
	DhldqoJHhwC3REnnskqYh2+Ls9n2tI0gb7YCuRKKKJO1noYn23kRCzN4dS0AG+um
	WenZ8h1iGBGCxyMJfHbB9oICYt3t0QqzI2Ob1qRzlOul0PEDvCJy89CU0pGVueAO
	EKQ2jq/Kn34=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E6C3C3BD2;
	Tue,  9 Nov 2010 19:07:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E62093BCC; Tue,  9 Nov 2010
 19:07:34 -0500 (EST)
In-Reply-To: <626BD1B6-4DDF-457F-B430-F15C891710E2@sb.org> (Kevin Ballard's
 message of "Mon\, 8 Nov 2010 13\:56\:01 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8948D356-EC5E-11DF-80AA-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161110>

Kevin Ballard <kevin@sb.org> writes:

> Basically what I'm trying to say is, we already break one particular
> "rather rare" setup.

Let's try again.  One particular "rather rare" setup never worked.  As it
is "rather rare", we do not really care that deeply to make that work.
Another particular "rather rare" setup used to work.  Even though we do
not really care that deeply to keep it working, is it worth breaking it?

> ... I would love to come up with a solution that supports both setups,
> but I don't know if one exists outside of using a config variable to
> control whether git attribute patterns support quoting (a solution I am
> not particularly fond of for this case).

Controlling this with a config would be a disaster.  It would mean that
the same version of updated git would interpret the same .gitattributes
file differently, and the situation will continue forever.  Compared to
that, the idea J6t brought up would be far easier to swallow.  Older
vintage of git will misbehave on "rather rare" paths upon seeing a cquoted
pattern (i.e. the pattern will not match the intended paths, and will
instead match "rather rare" paths that begin with dq) but that is no worse
than what we already have.  And newer vintages of git will interpret the
attribute file written with that magic exactly the same way everywhere,
regardless of the configuration setting.

Having said all that, I actually am in favor of using cquote.  It would
have been what we should have done in the first place.

My preference is to admit that we made a mistake of not using cquote when
we originally introduced .gitattributes, clearly state that the version of
git with this new backward incompatible feature will _break_ rare existing
setups if they had paths whose name begin with a dq and applied attributes
to them, and use cquote unconditionally, perhaps with a version bump.

I just didn't like the tone of saying "Nobody would have used such an
insane path anyway so we don't care".  I am Ok if our message is "Sorry,
this release would break if you used to rely on this; we think it is
unlikely and are hoping that most of you won't be affected".
