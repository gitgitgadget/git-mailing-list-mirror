From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Cherry-pick dangles and forgets helpful advice in next
Date: Wed, 23 May 2012 15:44:18 -0700
Message-ID: <7vipfmzfel.fsf@alter.siamese.dyndns.org>
References: <4FBD4904.9090000@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Thu May 24 00:44:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXKIQ-0007vs-It
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 00:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417Ab2EWWoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 18:44:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45352 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753002Ab2EWWoW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 18:44:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D91268056;
	Wed, 23 May 2012 18:44:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+E+ita2JhbEeRq57fx7Gm8acWUI=; b=DfKBvn
	1LXP5p6OEgkTG+oA+YJ5Ax/cu3XrLd7pT8Ntlm+2ES/x2XfBAB1QNl9OgAFiEGdj
	cH9gOhDUdv4A+7cZlwWuGLMr+gLHfwpQ/y9e/Xx9SU7ocmO9+Q2fq8J0ib4oTWCo
	rvyhb7GIGNor6ttKjEptGU9Y8Fca0ClKlUfNI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EerhtPkjv/YHsgA5W4cXCLFiiXrFvi6i
	1BAitAvnVdgq2BgKayGLeGo/s2VoAv2BwxUKgpXbiHD9EUehrYluzV6e7++Fn7V5
	gwNq3xQv/uBoPQfc+ALcjSjzbahlMNPHkXpa/6/opWUNuywkWWIoMrViibtjt7Lr
	FlP5crrp9uU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0F4B8054;
	Wed, 23 May 2012 18:44:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 531D18053; Wed, 23 May 2012
 18:44:20 -0400 (EDT)
In-Reply-To: <4FBD4904.9090000@cisco.com> (Phil Hord's message of "Wed, 23
 May 2012 16:31:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D5E2D962-A528-11E1-8A4F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198332>

Phil Hord <hordp@cisco.com> writes:

> In git.git 'master' when I cherry-pick a commit which is eventually
> empty, git gives me a friendly description of my supposed error, leaves
> my cherry-pick "pending" and exits with an error code.
>
>
> $ git cherry-pick a0aff2d                          
> # On branch master
> nothing to commit (working directory clean)
> The previous cherry-pick is now empty, possibly due to conflict resolution.
> If you wish to commit it anyway, use:
>
>     git commit --allow-empty
>
> Otherwise, please use 'git reset'
>
> In 'next' this is broken.  Now git does not tell me anything and it does
> not exit with an error code.

There probably is something else that is broken in _your_ build.  The test
t3505.2 is about failing an attempt to cherry-pick an empty commit:

        test_expect_success 'cherry-pick an empty commit' '
                git checkout master && {
                        git cherry-pick empty-branch^
                        test "$?" = 1
                }
        '

If I insert an "exit" immediately after this test and run the test with
"-i -v" option, it ends like this:

    $ make && cd t && sh t3505-cherry-pick-empty.sh -i -v
    ...
    ok 1 - setup

    expecting success:
            git checkout master && {
                    git cherry-pick empty-branch^
                    test "$?" = 1
            }

    Switched to branch 'master'
    Already up-to-date!
    # On branch master
    nothing to commit (working directory clean)
    The previous cherry-pick is now empty, possibly due to conflict
    resolution.
    If you wish to commit it anyway, use:

        git commit --allow-empty

    Otherwise, please use 'git reset'
    ok 2 - cherry-pick an empty commit

    FATAL: Unexpected exit with code 0

It does fail with non-zero exit code (it might be better to test with
test_expect_failure, but that is a minor point here), and we see the error
message.
