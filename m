From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 25/25] refs: break out ref conflict checks
Date: Sun, 08 Nov 2015 10:23:23 -0800
Message-ID: <xmqqziyo1hb8.fsf@gitster.mtv.corp.google.com>
References: <cover.1446534991.git.mhagger@alum.mit.edu>
	<3060e6410e8798064ef84cd31645021d1b84fbb9.1446534991.git.mhagger@alum.mit.edu>
	<1446670884.4131.42.camel@twopensource.com>
	<563AD452.2030301@alum.mit.edu>
	<1446740535.4131.50.camel@twopensource.com>
	<563CAC58.3070907@alum.mit.edu>
	<xmqq611f3umt.fsf@gitster.mtv.corp.google.com>
	<xmqqd1vm3e59.fsf@gitster.mtv.corp.google.com>
	<563ED7A0.7040007@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Nov 08 19:23:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvUcr-0002Bz-6g
	for gcvg-git-2@plane.gmane.org; Sun, 08 Nov 2015 19:23:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606AbbKHSXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2015 13:23:32 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52927 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751201AbbKHSXb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2015 13:23:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 75DB2276B4;
	Sun,  8 Nov 2015 13:23:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ViFGPdTAphPrX6MXxv3CgjUiQQQ=; b=gaeUmJ
	IhM+a8J3+R+kgmBJ1GHEyn4WbWX/d6Jfz5Scjhaei2XBAncUZPng8oA5UmzBYyCT
	mRQKSKQHEOWrn5SQP38agMFBEP/tTPbxxEwoqmFOcth9nHrTpbbw1dR02/O3sf9F
	l3faVPfYgOezodefoM58SzkW6d0yrT2rxLYxs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dt+Vq1AEnD5RjqLtTCgm+cLgHipgXSej
	NuqENuhXsJuG0S02uqSct1Szt97VR8M9a7ZdgxvzBS6HqQO/kP51Hpsv82f0oo3e
	z0pgNMGLiiUblXauEyl9nScKURlE8qhY4TygnBIyNPJgR+B/n/KoYrMpFNhCWHjf
	qmhP14lvaT0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6BE73276B3;
	Sun,  8 Nov 2015 13:23:25 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E8704276B1;
	Sun,  8 Nov 2015 13:23:24 -0500 (EST)
In-Reply-To: <563ED7A0.7040007@alum.mit.edu> (Michael Haggerty's message of
	"Sun, 08 Nov 2015 06:03:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CCB0B7B8-8645-11E5-9C33-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281041>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I hate to cause the maintainer extra work. I guess I was making two
> naive assumptions:
>
> * If we make the code-movement series simple and "obviously correct"
>   enough, then it could be merged pretty much straight through to
>   master.
>
> * If one or two topics conflict with the code movement, they could
>   be one-time rebased on top of the new master (I would be willing
>   to do this work).
>
> Maybe neither of these assumptions is valid.

It is sometimes necessary to declare "This is important, and it is
solid enough. Let's fast-track it.  Other people must work on top of
this." and make a project-wide decision to do so.  It was just that
was not doable within the time I had before I had to hand the tree
off.

You can still work with the other people involved (Lukas as the
ref-is-hidden topic contributor and Peff as the interim maintainer)
to make it happen, and I wouldn't be upset.

> I can see a few ways that we could make our series even more
> straightforward:
>
> 1. Leave refs.c in its original location (as suggested by Junio).
>    Optionally, it could be moved at a later date when this area is
>    quiescent.
>
> 2. Move content selectively from refs.c to refs/files-backend.c rather
>    than moving the whole file there and then moving content selectively
>    back to refs/refs.c.
>
> 3. Separate *all* of the non-obvious changes into a preparatory
>    patch series, to be followed by a separate patch series that *only*
>    moves code.

4. Move everything in the series as-is, *BUT* in each patch where
the series moved things to refs/refs.c from refs/files-backend.c,
move that back to refs.c instead.  No refs/refs.c anywhere in the
history or in the endgame.

I think having refs.h and refs.c at the toplevel for the public
interface, with refs/ hierarchy holding backend specifics, would be
a good organization for the endgame regardless of the conflicts with
in-flight topics, and 4. achieves that.  Perhaps you meant the same
thing as your 1.

As to the reordering of functions and structure defs, I am
reasonably sure that the order in the final refs/refs.c in your
series would be better thought-out than in the original refs.c, so
the "reorder stuff in refs.c" can be the first step before
everything is moved to refs/files-backend.c, perhaps?

Thanks.
