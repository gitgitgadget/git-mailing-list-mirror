From: Junio C Hamano <junkio@cox.net>
Subject: Re: Quick question: end of lines
Date: Wed, 01 Mar 2006 01:01:38 -0800
Message-ID: <7vwtfelerx.fsf@assigned-by-dhcp.cox.net>
References: <f898cca90602281032n6603bf14q@mail.gmail.com>
	<46a038f90602281215n259066b1qe2e6421625b82e75@mail.gmail.com>
	<f898cca90602281612n777a4f17m@mail.gmail.com>
	<46a038f90603010031g31f8bc33xd3f45f2e19950c78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 01 10:01:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FENDN-0000X2-MC
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 10:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWCAJBm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 04:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWCAJBm
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 04:01:42 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:49919 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S964801AbWCAJBm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 04:01:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060301085823.IKJT17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Mar 2006 03:58:23 -0500
To: "Emmanuel Guerin" <emmanuel@guerin.fr.eu.org>
In-Reply-To: <46a038f90603010031g31f8bc33xd3f45f2e19950c78@mail.gmail.com>
	(Martin Langhoff's message of "Wed, 1 Mar 2006 21:31:52 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16967>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> On 3/1/06, Emmanuel Guerin <emmanuel@guerin.fr.eu.org> wrote:
>> What I begin to realize is that the only possibility probably lies in
>> using a tool that converts the modified files "on the fly" before
>> commits. I just want to make sure that no other solution was found by
>> others facing a similar problem.
>
> Perhaps a pre-commit hook? Read the documentation (and search the list
> archives). I'm pretty sure you can do newline cleanup before commit or
> at least newline checks before commits.
>
> There's always the option of filing a bug in MS's bugzilla ;-)

You can use .git/hooks/pre-commit hook in the repository the
editor that munges line-termination, to fix things up.

The hook is called with GIT_INDEX_FILE set to the appropriate
index file, so you could "git-diff-index --cached --name-only
HEAD" to obtain the list of files being committed, sanitize the
working tree files and update-index them again before returning
true from the hook.

This is a silly example to standardize on uppercase.

        git-diff-index --cached --name-only HEAD |
        xargs sh -c '
                while case "$#" in 0) break ;; esac
                do
                        perl -p -i -e "\$_ = uc(\$_)" "$1"
                        git-update-index "$1"
                        shift
                done
        ' dummy
        exit 0
