From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Fix multi-glob assertion in git-svn
Date: Fri, 08 Aug 2008 02:41:10 -0700
Message-ID: <7vk5erete1.fsf@gitster.siamese.dyndns.org>
References: <20080808084025.GA8718@untitled>
 <1218184918-9135-1-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Marcus Griep <marcus@griep.us>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Aug 08 11:42:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KROUI-0004LK-4j
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 11:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753544AbYHHJlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 05:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753065AbYHHJlS
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 05:41:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48601 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352AbYHHJlR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 05:41:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8068959E1C;
	Fri,  8 Aug 2008 05:41:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DA95E59E1B; Fri,  8 Aug 2008 05:41:12 -0400 (EDT)
In-Reply-To: <1218184918-9135-1-git-send-email-normalperson@yhbt.net> (Eric
 Wong's message of "Fri, 8 Aug 2008 01:41:56 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 25A00D38-652E-11DD-B354-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91644>

Eric Wong <normalperson@yhbt.net> writes:

> From: Marcus Griep <marcus@griep.us>
>
> Fixes bad regex match check for multiple globs (would always return
> one glob regardless of actual number).
>
> [ew: fixed a bashism in the test and some minor line-wrapping]

Thanks both.

> +test_expect_success 'test disallow multi-globs' '
> ...
> +	cd tmp &&
> +		echo "try try" >> tags/end/src/b/readme &&
> +		poke tags/end/src/b/readme &&
> +		svn commit -m "try to try"
> +		cd .. &&

Do you want to ignore exit code from 'svn commit -m' here?

In any case, I'd want to see "temporarily work in subdirectory" done in a
subshell when applicable, so that we won't have to worry about where we
are when we later add more tests, like this:

	(
        	cd tmp &&
                echo "try try" >>tags/end/src/b/readme &&
                poke tags/end/src/b/readme &&
                svn commit -m "try to try" &&
	) &&

> +	test_must_fail git-svn fetch three 2> stderr.three &&
> +	cmp expect.three stderr.three

s/cmp/test_cmp/;
