From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 01/16] test-lib: make test_expect_code a test command
Date: Sun, 03 Oct 2010 17:54:18 -0700
Message-ID: <7vfwwmdbgl.fsf@alter.siamese.dyndns.org>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
 <1286136014-7728-2-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, avarab@gmail.com, jrnieder@gmail.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 02:54:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2ZK8-00044C-7w
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 02:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580Ab0JDAyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 20:54:31 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63748 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425Ab0JDAya (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 20:54:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BDD8DB90D;
	Sun,  3 Oct 2010 20:54:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e9cdBn67o+kqLxzAjAFOqGg3o0Y=; b=Gbl6Tn
	hUsp0hO/gN7c3y2bQp8graSDzFpfJHpUKoJJzv/RiZnKC/87wgzrcviq2LBHb066
	ejdaGfxZaRvDwpub7zQZYOQQNBi8MzYzOGDpC0xYiyLYn3ifxyW23uRzzsE1kAsE
	5x2d6KzO/g9jhjHIR3hr9TsGDPSHhsXbY9Z08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bKzqxcx1mJg4+eUnRkBGoKRVsY8eNYfv
	Ztq2RIYaGrcmpxkiVlTYL4fMA2/c6lhMlGyE5ANlLEyC9QNYKUtOUNbfSwGDG9Kf
	sQY4plf49ydus8mB01sE8m+AG+h8kehGgO+ITZ6zl4o8PMYvuM9lWMZJ6NJeawvD
	wwsV2eZoWV4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 388DADB907;
	Sun,  3 Oct 2010 20:54:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D21EDB900; Sun,  3 Oct
 2010 20:54:20 -0400 (EDT)
In-Reply-To: <1286136014-7728-2-git-send-email-newren@gmail.com> (Elijah
 Newren's message of "Sun\,  3 Oct 2010 13\:59\:59 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EEEA3274-CF51-11DF-9777-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157956>

Elijah Newren <newren@gmail.com> writes:

> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index f688bd3..c2f5f8d 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -130,22 +130,57 @@ test_expect_success 'tests clean up after themselves' '
> ...
> +#!$SHELL_PATH
> +
> +test_description='Failing tests with cleanup commands'
> +
> +# Point to the t/test-lib.sh, which isn't in ../ as usual
> +TEST_DIRECTORY=\"$TEST_DIRECTORY\"

Do we know at this point that the string in $TEST_DIRECTORY can safely be
quoted by just a simple dq pair?  I don't think so--isn't the leading part
of that string whatever the user can choose (i.e. $(cwd))?

This seems sloppy.

> +. \"\$TEST_DIRECTORY\"/test-lib.sh

Once you get the right value in TEST_DIRECTORY, this one is correct.
