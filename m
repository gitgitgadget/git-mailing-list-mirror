From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-stash: add flag to skip "git reset --hard"
Date: Mon, 02 May 2016 11:42:46 -0700
Message-ID: <xmqqeg9kti6x.fsf@gitster.mtv.corp.google.com>
References: <57267BBE.9010707@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Tom Anderson <thomasanderson@google.com>
X-From: git-owner@vger.kernel.org Mon May 02 20:42:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axIo3-0003jU-QV
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 20:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbcEBSmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 14:42:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56360 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755051AbcEBSmu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 14:42:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E261F15638;
	Mon,  2 May 2016 14:42:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gln4kNQTvOx8zjTNaMO/dif5qso=; b=aWpolX
	kY4wilN8KwMhtTpKKPOVM5CKRBF2D4Yp6rMxJTYzVXgNBCBbUfeYxYq4zFI3VHKF
	pY5K4fag4GofQ6zizR7LMuhldaIqoaIJjvv15GJbpocGH4/MFfyBZVTZZjguSEoC
	VZKQoEmrI7kZZHWVW6BHvTKS5Tfw+Z7QXMUY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gtem53AB+djKNwBGNohqyieecxbPIchn
	szbZVfSo+wWuRK3fjC8GnD4ggC461cIyN63QSSE8tisx7YW98RDHhvx4iwQf8W0M
	Va0GLD+Kmk0A41G5gRr4kcm+NXO/AR8ZSTnvm9I3u2cwzlyrNh6SKMLohiCI7kEU
	hGnTi5OJy74=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D876615637;
	Mon,  2 May 2016 14:42:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3B3A615633;
	Mon,  2 May 2016 14:42:48 -0400 (EDT)
In-Reply-To: <57267BBE.9010707@google.com> (Tom Anderson's message of "Sun, 1
	May 2016 14:57:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AAC435F0-1095-11E6-9A87-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293264>

Tom Anderson <thomasanderson@google.com> writes:

> @@ -61,6 +61,9 @@ stashed and then cleaned up with `git clean`,
> leaving the working directory
>  in a very clean state. If the `--all` option is used instead then the
>  ignored files are stashed and cleaned in addition to the untracked files.
>  +
> +If the `--no-reset` option is used, `git reset --hard` is skipped and the
> +`--[no-]keep-index`, `--include-untracked`, and `--all` flags are ignored.
> ++

I am afraid that a reader who does not read git-stash.sh script
would not know what you are talking about.  They do not know (or
particularly care) where "git reset --hard", how often and for what
purpose.  They can tell that this option affects only "save",
because that is where it is described, but they would not know what
it means to "skip reset --hard", other than that they cannot use the
three features listed there.

It is unclear what problem you are trying to solve from this text,
and the log message's mention of mtime and rebuilding makes it
sound like an X-Y problem.

It could very well be that what you are trying to implement makes
perfect sense and the new option is named with a stress on a wrong
aspect (i.e. named after what it uses to achieve things, rather than
saying what you are trying to achieve).

The workhorse used in "git stash save" (which is what you are
touching) is "git stash create", and that is only responsible for
recording a new stash entry without touch the working tree.  Is that
what you are after, perhaps?
