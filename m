From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix 'No newline...' annotation in rewrite diffs.
Date: Sat, 04 Aug 2012 18:26:58 -0700
Message-ID: <7vobmq6sd9.fsf@alter.siamese.dyndns.org>
References: <85f291cec03411c61ddf8808e53621ae@imap.force9.net>
 <7vehnpc5ti.fsf@alter.siamese.dyndns.org>
 <551f7f77570c84017ae93988f9202854@imap.force9.net>
 <loom.20120804T230218-811@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Butcher <dev.lists@jessamine.co.uk>
X-From: git-owner@vger.kernel.org Sun Aug 05 03:27:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sxpcv-0002mF-W5
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 03:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141Ab2HEB1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Aug 2012 21:27:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55220 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754137Ab2HEB1D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2012 21:27:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65DD89376;
	Sat,  4 Aug 2012 21:27:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Q7axJ7Kd8qjq464WNUQmP4JIu3A=; b=QJCMnVIU6WFPx0nLTQzj
	Rck2cH+GjBCfoCYZ5DCShe1wSqtOvewzuC3usbbNJmLdTtqDBLgU6T4V7hq++Faj
	kVK4jwfiOYAgbIJsHecT3BDuwjXTNbcSI2aQxCxFAKCp06xlrzzSPduR5SsZ8kYn
	UqFXV2+jEGLsDs74GCF+7GQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=eVRpmH7Yv8cosc0sdP7b0m2kRo1GyUf2rkxuwixuSLnDzV
	j9n0FjUyMuASfJC5+AGU3jc2zjo/0TxUSYiMrw3c8YXN+s9K67g/Kft4OaYb0swg
	PGAn9rE+6FcXqtPdQxV5wHcsfCD6/ohPh/Df8v/3YnRjvrHg3EQWGxS9fWa6I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E1949375;
	Sat,  4 Aug 2012 21:27:01 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C9F39374; Sat,  4 Aug 2012
 21:27:00 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A76FC4F2-DE9C-11E1-9C31-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202900>

Adam Butcher <dev.lists@jessamine.co.uk> writes:

> When operating in --break-rewrites (-B) mode on a file with no newline
> terminator (and assuming --break-rewrites determines that the diff
> _is_ a rewrite), git diff previously concatenated the indicator comment
> '\ No newline at end of file' directly to the terminating line rather
> than on a line of its own.  The resulting diff is broken; claiming
> that the last line actually contains the indicator text.  Without -B
> there is no problem with the same files.
>
> This patch fixes the former case by inserting a newline into the
> output prior to emitting the indicator comment.
>
> A couple of tests have been added to the rewrite suite to confirm that
> the indicator comment is generated on its own line in both plain diff
> and rewrite mode.  The latter test fails if the functional part of
> this patch (i.e. diff.c) is reverted.
> ---

Thanks.  You need your sign-off immediately before the "---" line.

When the problem description at the beginning of a log message is
about the current status of the code (which is almost always the
case), it generally does not need to be clarified with "previously".

A (POSIXy technical term) for the last line that does not end with
the newline is "incomplete line", I think.

 Cf. http://pubs.opengroup.org/onlinepubs/9699919799/xrat/V4_xbd_chap03.html#tag_21_03_00_67

I'd describe this perhaps like so if I were doing this patch:

    Fix '\ No newline...' annotation in rewrite diffs

    When a file that ends with an incomplete line is expressed as a
    complete rewrite with the -B option, git diff incorrectly
    appends the incomplete line indicator "\ No newline at end of
    file" after such a line, rather than writing it on a line of its
    own (the output codepath for normal output without -B does not
    have this problem).  Add a LF after the incomplete line before
    writing the "\ No newline ..." out to fix this.

    Add a couple of tests to confirm that the indicator comment is
    generated on its own line in both plain diff and rewrite mode.

> diff --git a/t/t4022-diff-rewrite.sh b/t/t4022-diff-rewrite.sh
> index c00a94b..1b7ae9f 100755
> --- a/t/t4022-diff-rewrite.sh
> +++ b/t/t4022-diff-rewrite.sh
> @@ -66,5 +66,47 @@ test_expect_success 'suppress deletion diff with -B -D' '
>  	grep -v "Linus Torvalds" actual
>  '
>  
> +test_expect_success 'generate initial "no newline at eof" sequence file and 
> commit' '

Line-wrapped.

> +test_expect_success 'confirm that sequence file is considered a rewrite' '
> +
> +   git diff -B seq >res &&
> +   grep "dissimilarity index" res
> +'

Good thinking to make sure the condition to trigger the issue still
holds in the future.

> +# Full annotation string used to check for erroneous leading or
> +# trailing characters.  Backslash is double escaped due to usage
> +# within dq argument to grep expansion below.  
> +no_newline_anno='\\\\ No newline at end of file'
> +
> +test_expect_success 'no newline at eof is on its own line without -B' '
> +
> +	git diff seq >res &&
> +	grep "^'"$no_newline_anno"'$" res &&

I think it is sufficient to write this line as:

	grep "^$no_newline_anno$" res &&

The third parameter to test_expect_success function is inside a sq,
so it will have the above string as-is, with $no_newline_anno not
expanded, and then when the string is eval'ed, the variable is
visible to the eval.

So the above should be more like:

        # Full annotation string used to check for erroneous leading or
        # trailing characters.
        no_newline_anno='\\ No newline at end of file'

        test_expect_success 'no newline at eof is on its own line without -B' '
                git diff seq >res &&
                grep "^$no_newline_anno$" res &&

> +	grep -v "^.\\+'"$no_newline_anno"'" res &&
> +	grep -v "'"$no_newline_anno"'.\\+$" res

Converting these two the same way, we would get

	grep -v "^.\\+$no_newline_anno" res &&
	grep -v "$no_newline_anno.\\+$" res

but isn't this doubly wrong?

 (1) \+ to require "one-or-more", which is otherwise not supported
     in BRE, is a GNU extension.  It is simple to fix it by writing
     "^..*$no_newline_anno" to say "what we try to find appears
     somewhere not at the beginning of line".

 (2) The "grep -v" shows the lines that express all the additions
     and deletions prefixed with + and - as they do not match "the
     line has the marker misplaced in the middle of the line"
     criteria.  Doesn't grep return true in that case, as it found
     some matching lines, even if you had "\ No newline" in the
     middle of some lines?

As I already said, I do not think hardcoding the whole "No newline
at end of line" in this test is a good idea anyway, and because you
know the text being compared does not have any backslash in it, it
suffices to make sure that the only occurrence of a backslash is on
a single line and at the beginning, I think.

In other words,

	grep "^\\ " res && ! grep "^..*\\ " res

or something.

I'll tentatively queue a tweaked version on 'pu', but we would at
least want a sign-off.

Thanks.
