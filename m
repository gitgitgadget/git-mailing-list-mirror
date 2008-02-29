From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add test for git rebase --abort
Date: Fri, 29 Feb 2008 15:26:01 -0800
Message-ID: <7v63w7bb06.fsf@gitster.siamese.dyndns.org>
References: <1204322927-22407-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Mar 01 00:26:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVEcx-0001Jw-1r
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 00:26:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbYB2X0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 18:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760672AbYB2X0S
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 18:26:18 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52156 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758617AbYB2X0S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 18:26:18 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9FB5732C2;
	Fri, 29 Feb 2008 18:26:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id ED72E32C0; Fri, 29 Feb 2008 18:26:11 -0500 (EST)
In-Reply-To: <1204322927-22407-1-git-send-email-mh@glandium.org> (Mike
 Hommey's message of "Fri, 29 Feb 2008 23:08:47 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75590>

Mike Hommey <mh@glandium.org> writes:

>  The failing test is the third. I don't have enough knowledge in git-rebase
>  to write an appropriate fix, but the problem seems to be in
>  move_to_original_branch, where testing head_name doesn't seem appropriate.

Please mark such an "expected to succeed but fails due to
suspected bug" with test_expect_failure.

> +test_expect_success 'rebase --abort' '
> +	! git rebase master &&

When making sure "git frotz" refuses gracefully (instead of
segfault-and-burn), please say "test_must_fail git frotz".

> +# In case previous test failed
> +git reset --hard pre-rebase >&3 2>&4
> +rm -rf .dotest # Should be changed whenever rebase stop using .dotest

Have this kind of clean-up at the very beginning of the next
test.  Test writers should not have to learn about file
descriptors 3 and 4.

        Side note.  As a test framework extension, we might want
        to add 4th parameter to test_expect_{success,failure}
        that specifies a clean-up to be made regardless of the
        outcome of the test.

> +test_expect_success 'rebase --abort after --skip' '
> +	! git rebase master &&
> +	! git rebase --skip &&
> +	test $(git rev-parse HEAD) = $(git rev-parse master) &&
> +	sh -x ../../git-rebase --abort &&
> +	test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase)
> +'

I take that "sh -x ../../" is not for inclusion in the official
release.
