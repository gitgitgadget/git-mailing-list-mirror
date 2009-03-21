From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 13/16] t3700: Skip a test with backslashes in pathspec
Date: Sat, 21 Mar 2009 16:14:20 -0700
Message-ID: <7v3ad6cvub.fsf@gitster.siamese.dyndns.org>
References: <cover.1237667830.git.j6t@kdbg.org>
 <6acd113f60d1b0e7926386f3aebe5d72ad362034.1237667830.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Mar 22 00:16:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlAQ6-00062b-K5
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 00:16:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753690AbZCUXOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 19:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752790AbZCUXOa
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 19:14:30 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59732 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbZCUXO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 19:14:29 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3059D85EF;
	Sat, 21 Mar 2009 19:14:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9093085E6; Sat,
 21 Mar 2009 19:14:22 -0400 (EDT)
In-Reply-To: <6acd113f60d1b0e7926386f3aebe5d72ad362034.1237667830.git.j6t@kdbg.org>
 (Johannes Sixt's message of "Sat, 21 Mar 2009 22:26:36 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 057B546C-166E-11DE-97F9-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114091>

Johannes Sixt <j6t@kdbg.org> writes:

> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  t/t3700-add.sh |    2 +-
>  t/test-lib.sh  |    2 ++
>  2 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> index dc17d9f..050de42 100755
> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -222,7 +222,7 @@ test_expect_success POSIXPERM 'git add (add.ignore-errors = false)' '
>  	! ( git ls-files foo1 | grep foo1 )
>  '
>  
> -test_expect_success 'git add '\''fo\[ou\]bar'\'' ignores foobar' '
> +test_expect_success BSLASHPSPEC "git add 'fo\\[ou\\]bar' ignores foobar" '
>  	git reset --hard &&
>  	touch fo\[ou\]bar foobar &&
>  	git add '\''fo\[ou\]bar'\'' &&

I do not think the justification for this change is explained well enough.

The test prepares a file whose name consists of "ef, oh, bra, oh, you,
ket, bee, ei and are" (no backslashes), and passes a filespec that quotes
bra and ket with backslash so glob won't misinterpret as if we are asking
to add "ef oh followed by either oh or you followed by bee ei are".  There
is no path that has a backslash in it involved.

If this does not work on Windows, there is something else going on.  Is it
that the shell eats one level of backslash too much or something?
