From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/5] Documentation: add git-log --merges= option and log.merges config. var
Date: Sun, 05 Apr 2015 14:41:07 -0700
Message-ID: <xmqq8ue6cky4.fsf@gitster.dls.corp.google.com>
References: <1428110521-31028-1-git-send-email-koosha@posteo.de>
	<1428110521-31028-3-git-send-email-koosha@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Koosha Khajehmoogahi <koosha@posteo.de>
X-From: git-owner@vger.kernel.org Sun Apr 05 23:42:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YesIs-0000rV-Lx
	for gcvg-git-2@plane.gmane.org; Sun, 05 Apr 2015 23:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590AbbDEVlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2015 17:41:11 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64659 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752582AbbDEVlK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2015 17:41:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B342467A4;
	Sun,  5 Apr 2015 17:41:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1ZSS6jo7boDjBQz9xrsXFaxYYJI=; b=BAhL7S
	80BZd3hK9mKSvIziMc5nM192rCzxjhCxOGv0sfm+ffYDAg2ZCnsS8zP4S5Qj7VEW
	kZ3ck9C6AUK1DXsbNfQWlD1K8JegpLHl7iT2vkW7qksrbC1QXfpmR5jZv2nYg7gO
	qg4LGeE1zTaw1r+ZiUtM0qeqC3j8hWGxSX2Uo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xT4MGdufdDbpMqIln4F/Xy/mU3bchiiO
	C4KvXPLJqX8o81GKWjt0TC0CUPLZiSZ59Q1zJoUBNv6dlBlUoV8MobVPGUTPqYtY
	zYt6TOfCl9BlOaByyI7EtBhrBVkT80iXCxaSCIZuTUHMWYSErfM+QqPlXcdATZRt
	WrrhBGDc95g=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 74741467A3;
	Sun,  5 Apr 2015 17:41:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EAC3E467A2;
	Sun,  5 Apr 2015 17:41:08 -0400 (EDT)
In-Reply-To: <1428110521-31028-3-git-send-email-koosha@posteo.de> (Koosha
	Khajehmoogahi's message of "Sat, 4 Apr 2015 03:21:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 788D619A-DBDC-11E4-968E-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266821>

Koosha Khajehmoogahi <koosha@posteo.de> writes:

> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index f620ee4..0bb2390 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -96,12 +96,24 @@ if it is part of the log message.
>  --remove-empty::
>  	Stop when a given path disappears from the tree.
>  
> +--merges={show|hide|only}::
> ++
> +--
> +`show`: show both merge and non-merge commits
> +
> +`hide`: only show non-merge commits; same as `--max-parents=1`
> +
> +`only`: only show merge commits; same as `--min-parents=2`
> +
> +If `--merges=` is not specified, default value is `show`.
> +--
> ++
> +

I am not sure if the "default value is `show`" is something we would
even want to mention like this.  It does not tell the whole story
and may even confuse the users, who did

	git log --merge
	git log --max-parent=...

but did not say any "--merges=<something>".

I think the importat point we want to teach users is that this is an
option to use when you want to limit what is output (and by default,
we show all but nothing else in the manpage says we hide things,
so...).  And it would be beneficial to highlight that 'show' is only
there to defeat an unusual log.merges setting in users' config.

Also the formatting of this part looks rather unusual.  I would have
expected that these three items to be listed as a true AsciiDoc
enumeration, not three hand-crafted enumration-looking separate
paragraphs.

Taking both points together, we may want to do something more like
this, perhaps?

--merges={show|hide|only}::

	Limit the output by type of commits.

	`hide`;;
		Hide merge commits from the output.

	`only`;;
		Hide non-merge commits from the output (i.e showing
		only merge commits).

	`show`;;
		Do not hide either merge or non-merge commits.  This
		is primarily useful when the user has non-standard
		setting of `log.merges` configuration variable that
		needs to be overriden from the command line.


Thanks.
