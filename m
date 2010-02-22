From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Adding test for `--keep-cr` for git-am.
Date: Mon, 22 Feb 2010 13:25:03 -0800
Message-ID: <7v1vgd9d5c.fsf@alter.siamese.dyndns.org>
References: <1266080362-24760-1-git-send-email-stefan.hahn@s-hahn.de>
 <20100213171132.GC14754@scotty.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
X-From: git-owner@vger.kernel.org Mon Feb 22 22:25:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjfmM-0005wF-It
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 22:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754474Ab0BVVZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 16:25:15 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53675 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753629Ab0BVVZN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 16:25:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 64D9D9CF48;
	Mon, 22 Feb 2010 16:25:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hfn5UPkwQhhmN1bfU2VoipG7KmY=; b=nxwVVN
	GUnwIL4GKTBqI+5lBX57ni6JVMhge7/cP0a83/DXe1wttDPUdteORNHXSen5LE6A
	rIEil3SWdFkxaWQOsE6YcB7BCwZb4nZTdczb3dal6r8w5AN0r1jdjuc1waafDVZi
	n0ZxkIXY8ucJwNoaV1k67RCSeVMjbbTIcfLwI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IYrgvWL4UTb3TGZxU8eZVL+QIHjyXKiL
	jloeu676fVs2DI8HkDrA1kvJroQ/4FmvVFaZe8O152QyrbK8iJcZ5j7GJ/xejEWQ
	hgugKJmLQ1rLPqtUkizBXRN0+UkawugHeKvJVnoVE1g0CtrnK1hZpqEUXf1MlT8u
	SMyKQMAehJQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4160F9CF45;
	Mon, 22 Feb 2010 16:25:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 40F8F9CF3D; Mon, 22 Feb
 2010 16:25:05 -0500 (EST)
In-Reply-To: <20100213171132.GC14754@scotty.home> (Stefan-W. Hahn's message
 of "Sat\, 13 Feb 2010 18\:11\:32 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C0426B98-1FF8-11DF-90D3-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140716>

"Stefan-W. Hahn" <stefan.hahn@s-hahn.de> writes:

> This test adds test for git-am dos line endings, the command sequence
> 'git format-patch ... | git am ...' and the configuration variable
> `am.keepcr`.
>
> Signed-off-by: Stefan-W. Hahn <stefan.hahn@s-hahn.de>
> ---
>  t/t4253-am-keep-cr-dos.sh |   68 +++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 68 insertions(+), 0 deletions(-)
>  create mode 100644 t/t4253-am-keep-cr-dos.sh
>
> diff --git a/t/t4253-am-keep-cr-dos.sh b/t/t4253-am-keep-cr-dos.sh
> new file mode 100644

This should be 100755, if this need to be a new separate test.

> index 0000000..a4f5f80
> --- /dev/null
> +++ b/t/t4253-am-keep-cr-dos.sh
> @@ -0,0 +1,68 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2010 Stefan-W. Hahn
> +#
> +
> +test_description='git-am mbox with dos line ending.
> +
> +'
> +. ./test-lib.sh
> +
> +# Three patches which will be added as files with dos line ending.
> +
> +cat > file1 <<\EOF
> +line 1
> +EOF
> +
> +cat > file2 <<\EOF
> +line 1
> +line 2
> +EOF
> +
> +cat > file3 <<\EOF
> +line 1
> +line 2
> +line 3
> +EOF
> +
> +test_expect_success 'setup repository with dos files' '
> +        append_cr <file1 >file
> +        git add file &&
> +        git commit -m Initial &&
> +        git tag start &&
> +        append_cr <file2 >file
> +        git commit -a -m Second &&
> +        git tag start2 &&
> +        append_cr <file3 >file
> +        git commit -a -m Third &&
> +	git format-patch -k --stdout start.. > format-patch.diff
> +'

Hmm, do I see a mixed indentation here?

> +test_expect_success 'mailsplit format-patch of dos files' '
> +        mkdir split &&
> +        git mailsplit -osplit format-patch.diff &&
> +        cat split/0001 split/0002 > mailsplit.diff &&
> +        test_must_fail test_cmp format-patch.diff mailsplit.diff
> +'
> +
> +test_expect_success 'mailsplit --keep-cr format-patch of dos files' '
> +        mkdir split2 &&
> +        git mailsplit --keep-cr -osplit2 format-patch.diff &&
> +        cat split2/0001 split2/0002 > mailsplit2.diff &&
> +        test_cmp format-patch.diff mailsplit2.diff
> +'

These seem to be mailsplit test; are they necessary?  mailsplit is an
internal implementation detail of am, and we might later want to change
what it does as long as the change does not affect what the calling am
ends up doing, but even with benign change the above two test would fail.

> +test_expect_success 'format-patch with dos files --keep-cr' '
> +        git checkout -b new start &&
> +	git format-patch -k --stdout start..master | git am --keep-cr -k -3 &&

If a long line bothers you, you can split the line at pipe like this:

	git format-patch -k --stdout start..master |
	git am --keep-cr -k -3 &&

Because the shell knows that you haven't finished your sentence yet when
it sees the pipe at the end of line, you do not need a backslash at the
end (the same goes for the && at the end).

> +        git diff master
> +'

"git diff" by default does not report presense or absense of difference
with its exit code.  A traditional way to check this is

	test -z "$(git diff master)"

You can choose to use a more modern

	git diff --exit-code master

> +test_expect_success 'format-patch with dos files config.mailsplit' '
> +        git config am.keepcr 1 &&
> +        git checkout -b new3 start &&
> +	git format-patch -k --stdout start..master | git am -k -3 &&
> +        git diff master
> +'

Two tests are lacking.

 - test that "git am" fails without --keep-cr nor configuration when fed a
   history with CRLF.

 - test that "am.keepcr" can be countermanded per "git am" invocation;

Also I think t4252 needs to be taught about this new option, as I think
you would want the second ('please continue') invocation in this sequence

	$ git am --keep-cr mbox
        ... oops, one does not apply
        ... goes to fix
        $ git am

to keep your CR in the payload.
