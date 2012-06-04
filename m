From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv7 2/4] t7512-status-help.sh: better advices for git
 status
Date: Mon, 04 Jun 2012 16:12:07 -0700
Message-ID: <7vpq9er7so.fsf@alter.siamese.dyndns.org>
References: <1338748217-16440-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338830399-31504-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338830399-31504-2-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 05 01:12:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbgRc-0000jt-Hu
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 01:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761163Ab2FDXML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 19:12:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49357 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761131Ab2FDXMK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 19:12:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE4568D88;
	Mon,  4 Jun 2012 19:12:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NNEuMtRRkW6zp0QXJuApXchpls8=; b=smWIW6
	zjk93HN4lAjj97oUW+c6z4yAsMnjIXrIxisCzN2mQFN5ZW0nBEYys/OCJaHvitQg
	Y7m456ZA9vjEMYlG/WF+RDdS9K6yyrwQDT8mRPGDShxGpyLvzQgSVHfEr/1d9Zbc
	ZkOibf0WRDdH+o0FDUTFR6CimnuLI++F/ANmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wb/tdNTUW6ZbZjdX+fhH0IuAShbMTZ29
	A3IcYYeQpe7+sSLr7bTnsVZG6ifqP2S+4ypEnK4UWPjgmXzvKybnef/QPgeiUzLO
	vfNBidG8Qhrrqrcy0pmZ+F7t+zmTFSYzn0jbelSY6aJZaZ4q0wKcmMRXadleEFqu
	1E+Civqwr3s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D09CF8D86;
	Mon,  4 Jun 2012 19:12:09 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 301A48D85; Mon,  4 Jun 2012
 19:12:09 -0400 (EDT)
In-Reply-To: <1338830399-31504-2-git-send-email-Lucien.Kong@ensimag.imag.fr>
 (Kong Lucien's message of "Mon, 4 Jun 2012 19:19:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B5922A98-AE9A-11E1-AD88-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199195>

Kong Lucien <Lucien.Kong@ensimag.imag.fr> writes:

> +test_description='git status advices'
> +
> +. ./test-lib.sh
> +
> +. "$TEST_DIRECTORY"/lib-rebase.sh
> +
> +set_fake_editor
> +
> +test_expect_success 'status when conflicts unresolved' '
> +	test_commit init main.txt init &&
> +	git branch second_branch &&
> +	test_commit on_master main.txt on_master &&
> +	git checkout second_branch &&
> +	test_commit on_second_branch main.txt on_second_branch &&
> +	test_must_fail git merge master &&
> +	cat >expected <<-\EOF &&
> +	# On branch second_branch
> +	# You have unmerged paths.
> +	#   (fix conflicts and run "git commit")
> +	#
> +	# Unmerged paths:
> +	#   (use "git add/rm <file>..." as appropriate to mark resolution)
> +	#
> +	#	both modified:      main.txt
> +	#
> +	no changes added to commit (use "git add" and/or "git commit -a")
> +	EOF
> +	git status --untracked-files=no >actual &&
> +	test_cmp expected actual
> +'

OK.

> +test_expect_success 'status when conflicts resolved before commit' '
> +	test_when_finished "
> +		git commit -m "end_merge" &&
> +		git checkout master &&
> +		git branch -D second_branch &&
> +		echo >main.txt
> +	" &&

I do not think this is a good idea.  The previous one may have
failed before even reaching "git merge" that was supposed to fail,
or "git merge" may have succeeded by mistake.

If you are assuming that all tests succeed when we didn't introduce
any bug to Git, and when breakages happen the developer should only
look at the first breakage, then it is better not to pretend as if
you are prepared for some tests in the sequence to fail by giving a
clean slate to later tests.

For these two tests, I think it is much simpler and cleaner to
organize them by

 (1) have code to prepare two branches in the first test, tag the
     tip of second one, and assume this test won't break;

 (2) move the remainder of the first test, starting with the merge
     of master that is expected to fail, into a separate one; and

 (3) begin the third test (the second one in your patch) with:

 	git reset --hard $that_tag_you_added_to_the_tip_of_second &&
	test_must_fail git merge master &&

     so that it begins from the state the test expects it to begin
     in, even if the previous test somehow merged master cleanly by
     mistake.

> +test_expect_success 'status when rebase in progress before resolving conflicts' '
> +	test_commit one_rebase main.txt one &&
> +	test_commit two_rebase main.txt two &&
> +	test_commit three_rebase main.txt three &&
> +	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
> +	cat >expected <<-\EOF &&
> +	# Not currently on any branch.
> +	# You are currently rebasing.
> +	#   (fix conflicts and then run "git rebase --continue")
> +	#   (use "git rebase --skip" to skip this patch)
> +	#   (use "git rebase --abort" to check out the original branch)
> +	#
> +	# Unmerged paths:
> +	#   (use "git reset HEAD <file>..." to unstage)
> +	#   (use "git add/rm <file>..." as appropriate to mark resolution)
> +	#
> +	#	both modified:      main.txt
> +	#
> +	no changes added to commit (use "git add" and/or "git commit -a")
> +	EOF
> +	git status --untracked-files=no >actual &&
> +	test_cmp expected actual
> +'
> +
> +
> +test_expect_success 'status when rebase in progress before rebase --continue' '
> +	test_when_finished "git rebase --abort" &&

Likewise.  If anything, "git rebase --abort" belongs to the previous
test that tried to run "git rebase".
