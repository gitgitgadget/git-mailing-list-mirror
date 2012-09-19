From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv7] clone --single: limit the fetch refspec to fetched
 branch
Date: Wed, 19 Sep 2012 16:26:08 -0700
Message-ID: <7vzk4legrz.fsf@alter.siamese.dyndns.org>
References: <7vfw6fm7xb.fsf@alter.siamese.dyndns.org>
 <1348073136-8842-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 01:26:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TETeu-0007BZ-Kn
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 01:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844Ab2ISX0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 19:26:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59415 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752785Ab2ISX0L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 19:26:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 855F9971E;
	Wed, 19 Sep 2012 19:26:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OllQYyXcZpw0HjwV45o+akjjja0=; b=RCEocF
	4AhAi7INrzSfMxgYVHMroUVJp3y2j17pHNKKwxYMGOVPfwPjgGwrZZKnwO7XQ28f
	+8JX2+utIYNp+ZOoGdXRBYAb3hqv0wVb+2KVFU7fZX1BLu9o2ejwp/yV0a7nUc/9
	t+IPhFhrpci+9NuZzHtIDxicGk/7pNGIwsCbk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nfMscB2/CZjjcUEHp4sFyiO3K9O5QoUj
	EPyfu9LvflgkGYRv0pBy9P7EEVzpYQqqI+stRmqxKId2SrT3TSQSC/mZ9w4UlNYl
	iVx6PJ1+ZKMmQYsjopcZs37qwY90Qq8StfqQowdzjPMHG9mxkWrj/3KgpFL+lq8J
	sdgQfmGizGI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73C95971D;
	Wed, 19 Sep 2012 19:26:10 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CBAFA971C; Wed, 19 Sep 2012
 19:26:09 -0400 (EDT)
In-Reply-To: <1348073136-8842-1-git-send-email-ralf.thielow@gmail.com> (Ralf
 Thielow's message of "Wed, 19 Sep 2012 18:45:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 64D11E32-02B1-11E2-8054-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206009>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> diff --git a/t/t5709-clone-refspec.sh b/t/t5709-clone-refspec.sh
> new file mode 100755
> index 0000000..69a0779
> --- /dev/null
> +++ b/t/t5709-clone-refspec.sh
> @@ -0,0 +1,155 @@
> +#!/bin/sh
> +
> +test_description='test refspec written by clone-command'
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	# Make two branches, "master" and "side"
> + ...
> +	# explicit --single with tag
> +	git clone --single-branch --branch two . dir_tag &&
> +
> +	# advance both "master" and "side" branches
> +	git checkout side &&
> +	echo five >file &&
> +	git commit -a -m five &&
> +	git checkout master &&
> +	echo six >file &&
> +	git commit -a -m six
> +'
> +
> + ...
> +test_expect_success '--single-branch with explicit --branch with tag fetches updated tag' '
> +	git tag -d two && git tag two &&

Curious.  Was it insufficient to update this tag at the end of the
"setup" process like everybody else where

	# advance both "master" and "side" branches

happens?

Not that it is wrong to do this, but it looked somewhat
inconsistent.
