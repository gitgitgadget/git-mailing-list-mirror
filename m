From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] test patch hunk editing with "commit -p -m"
Date: Mon, 17 Mar 2014 11:53:41 -0700
Message-ID: <xmqqmwgoejwq.fsf@gitster.dls.corp.google.com>
References: <CA+SSzV1LcuTWMGrJrto3cJ13-MxgFsJP6z3zTYjHp=qZGPoraw@mail.gmail.com>
	<1394919750-28432-1-git-send-email-benoit.pierre@gmail.com>
	<1394919750-28432-3-git-send-email-benoit.pierre@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Benoit Pierre <benoit.pierre@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 19:53:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPcfW-0007xD-Mj
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 19:53:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbaCQSxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 14:53:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38231 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706AbaCQSxo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 14:53:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6894875194;
	Mon, 17 Mar 2014 14:53:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A8AAmRst2PX6nHICmgRLhhZYnJk=; b=rLmJTN
	ptgTLpigSMPmCWinc2FDMzlqYFj3ze6OUKXuU9IoQ9lKGrehaxAJp/b5/6HN9QVs
	Pbl5/BfP+abZBQaqr19BBh9FBr4se/XyR3n+4ObpZ6v4gTX9Vh1/N7oA0n4Uq7uC
	v7+ocjT4UOxCyZXXyIfnxsIWSMP7YJHVlsq0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OnGUgSDvOwpuwCQWtBidfh8en+Vnu1ed
	wM7pgpVD4uIF9zADOP5oc36wLpwfW9FD58CQhhSWpYCR0QinUsjKSGvqoIpgnv5X
	zyGoiEa9eB6mFw5aAUUFlAxgeNByf6w4iXAtZBgVYZ+2Q3EOHwyt9UT7fod724tO
	iSU8ynDIFOI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56EA275193;
	Mon, 17 Mar 2014 14:53:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A0E4375191;
	Mon, 17 Mar 2014 14:53:43 -0400 (EDT)
In-Reply-To: <1394919750-28432-3-git-send-email-benoit.pierre@gmail.com>
	(Benoit Pierre's message of "Sat, 15 Mar 2014 22:42:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7674A3D8-AE05-11E3-A708-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244265>

Benoit Pierre <benoit.pierre@gmail.com> writes:

> +test_expect_failure 'edit hunk "commit -p -m message"' '
> +	test_when_finished "rm -f editor_was_started" &&

Not just "when finished", run "rm -f" here to make sure that the
file does not exist.  Later other people may add new tests before
this test piece and affect the state of your throw-away working
tree, and you would want to protect yourself from their changes.

> +	echo more >>file &&
> +	echo e | env GIT_EDITOR="touch editor_was_started" git commit -p -m commit2 file &&

Avoid "touch" unless you are interested in the timestamp to be
updated.  Use ": >editor_was_started" or something like that when
you are only interested in "it was not there, now it is".

The same comment applies to the next one.

Thanks.

> +	test -r editor_was_started
> +'
> +
> +test_expect_failure 'edit hunk "commit --dry-run -p -m message"' '
> +	test_when_finished "rm -f editor_was_started" &&
> +	echo more >>file &&
> +	echo e | env GIT_EDITOR="touch editor_was_started" git commit -p -m commit3 file &&
> +	test -r editor_was_started
> +'
> +
> +test_done
