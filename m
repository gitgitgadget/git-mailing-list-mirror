From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow multiple merges to invalid HEAD
Date: Sun, 03 Apr 2011 00:07:04 -0700
Message-ID: <7vlizrg6ef.fsf@alter.siamese.dyndns.org>
References: <1301813216-19507-1-git-send-email-tnachen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Timothy Chen <tnachen@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 09:07:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6HPM-00018n-SM
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 09:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825Ab1DCHHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 03:07:17 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55276 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815Ab1DCHHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 03:07:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C6FB02995;
	Sun,  3 Apr 2011 03:09:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AmTql+DHW9XFNaZGedKby3ndSVc=; b=oSHpMG
	TI9F2V/8M8T1OeBKKtvvaeR4Mn7c1Gd97M2O9K/TDIPY+QT7StEocc3c5zeCUYw/
	NKG0vNxEQ1xgH4Vz0tA0vnYh69ocQ6Dy6tinPi3ve32PNBT4a4t+OfF+oZaqGPiL
	Aeiko0LS+XjzgcPBzw5Re0+p8BFumFcYyoO8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=idvV7UrjYowQWYu2w1lwxG/2fhhVFMXI
	awkYE5i6WnK+MlpwwMvQmzHaUhB0r/8IrIjIJ7Kl2Q5721OeSXGfODKMgoLClddO
	l/ZrZISpqXKQcrtmL+7teVTjxXWUyvD5RJs3v+mDo6Dnwcw4kJe4HfljS4UgpbRp
	vxUV6tlcQNQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8B68C2994;
	Sun,  3 Apr 2011 03:09:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8AFBD2993; Sun,  3 Apr 2011
 03:08:57 -0400 (EDT)
In-Reply-To: <1301813216-19507-1-git-send-email-tnachen@gmail.com> (Timothy
 Chen's message of "Sat, 2 Apr 2011 23:46:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3FFE1A92-5DC1-11E0-816D-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170681>

Timothy Chen <tnachen@gmail.com> writes:

> Subject: Re: [PATCH] Allow multiple merges to invalid HEAD

I thought somebody already suggested to reword "invalid HEAD" to something
more sensible, like "unborn branch", but I may be misremembering things...

> Currently git merge only allows one branch when current HEAD
> is not yet pointing to a valid commit.
>
> This patch will allow multiple branches to be passed in,
> and first updates current HEAD to the first branch's head then subsequently
> merge the rest of the branches.
> ---

Missing sign-off.

What's the point of being able to do this in the first place?

The _only_ reason "git pull $there $branch" into an unborn branch exists
is because it feels like

	$ git clone $there $directory

could be broken down as this command sequence:

	$ mkdir $directory
        $ cd $directory
        $ git init
        $ git remote add origin $there
	$ git fetch
        $ git pull $there ;# or "git merge origin/master"

And all the above steps actually do work, except for the last step and
that is why we added the "pull into emptiness" hack.

Even though it does a very different thing at the mechanical level, having
the hack helps these two sequences (a single "clone" vs the "init/remote
add/fetch/merge") that are conceptually similar to behave the same.

I however don't think of a halfway sane rationale similar to why we have
"merge one into emptiness" to justify this patch.  It very much feels like
"because I can make things more complex", not "because this is an often
desired missing feature that is a major pain point".
