From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in test-lib.sh: test_create_repo() / RFC
Date: Mon, 20 Apr 2009 22:32:49 -0700
Message-ID: <7vocuqbmgu.fsf@gitster.siamese.dyndns.org>
References: <49EC8BE6.2030709@drmicha.warpmail.net>
 <20090421030638.GE14479@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 21 07:35:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw8dq-0006uZ-Rl
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 07:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbZDUFc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 01:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbZDUFc4
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 01:32:56 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49114 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbZDUFc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 01:32:56 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D451C10325;
	Tue, 21 Apr 2009 01:32:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E241610323; Tue,
 21 Apr 2009 01:32:50 -0400 (EDT)
In-Reply-To: <20090421030638.GE14479@coredump.intra.peff.net> (Jeff King's
 message of "Mon, 20 Apr 2009 23:06:38 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DD4BF08E-2E35-11DE-80BD-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117089>

Jeff King <peff@peff.net> writes:

> On Mon, Apr 20, 2009 at 04:51:18PM +0200, Michael J Gruber wrote:
>
>> Problem:
>> Since a6d63b7 (test-lib: avoid assuming that templates/ are in the
>> GIT_EXEC_PATH, 2009-02-04), test_create_repo() assumes to be called from
>> a directory such that `pwd`/../templates/blt/ contains templates for
>> git-init.
>> 
>> Several tests (see below) call test_create_repo() from a different
>> directory, which means the repo is created without any of the default
>> files (and that a mv .git/hooks .git/hooks-disabled later in the
>> function errors out). Now, for most tests this probably doesn't matter
>> at all but it's not nice.
>
> If I am understanding it correctly, I think this is simply a bug
> introduced by a6d63b7, and the fix is maint-worthy.
>
> And I think the right fix is:
>
>> - Simply use $(TEST_DIRECTORY)/../templates/blt/. Nice and easy. But
>> uses the templates from the git repo containing t/ even when testing
>> against and installed git (just like now, for most of the tests).
>
> The original code (before a6d63b7) used $(GIT_EXEC_PATH), since it
> handily pointed to "$(TEST_DIRECTORY)/.." (and I didn't check, but I
> suspect that line predates $(TEST_DIRECTORY) entirely). So I think this
> is just doing what the a6d63b7 should have done in the first place,
> instead of using `pwd` to guess at the top-level location.
>
> One thing to consider: we now have code to test an installed version of
> git. Should it be using the vanilla hooks from the source directory, or
> should it be using the regular templates? I think that question is
> orthogonal to the bug you mention, though -- the current code is trying
> to use the hooks from the source directory, but it is just failing to do
> so; by fixing it, you certainly won't be breaking the
> test-installed-version case.

Yup, I think that is the right approach.
