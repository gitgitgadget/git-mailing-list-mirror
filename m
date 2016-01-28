From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] stash--helper: implement "git stash--helper"
Date: Thu, 28 Jan 2016 15:06:27 -0800
Message-ID: <xmqqr3h1l2x8.fsf@gitster.mtv.corp.google.com>
References: <BLU436-SMTP27D65F59A444FA678FFD8AA5DA0@phx.gbl>
	<0000015289f33df4-d0095101-cfc0-4c41-b1e7-6137105b93fb-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthias Asshauer <mha1993@live.de>
X-From: git-owner@vger.kernel.org Fri Jan 29 00:06:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOve6-0006Qt-UR
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 00:06:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbcA1XGc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2016 18:06:32 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56103 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750716AbcA1XGa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2016 18:06:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 90E223E6DA;
	Thu, 28 Jan 2016 18:06:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fdjxiJNzNfZ/
	YKueTB9e0CAGuDY=; b=EC5V5FIFAMkUgp7xdiw5GrVxX3cGauYtn8JbbZ6f2lXD
	58kuAVMxCCMCih/phxWwUIMUXwjXdln/aKNlHoXxlpFX+to/vGizxcRzXYftdW6H
	6DJHwwPgRQetSTYdbM6l1kYcOpqP/FLsFqwbUqQrWHg6tMlHneHpyxS3N41H3Ss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=SnS/eB
	AQIivNEXq+nvDe2EZluXO553QVAFpCLEjGenZFKbEg7b+X5f1ro30Gzteq/hUcHU
	5QdbjMECc6xaHsk0ENgdKDB0dSK9fv1jEhPxgikvuVVaBQfwLqxcCUu4r2uFOZt7
	/C3amzkiHvZn5e2PKIt/fFyz4HtkahcZlkyXc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 886353E6D9;
	Thu, 28 Jan 2016 18:06:29 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E17A03E6D2;
	Thu, 28 Jan 2016 18:06:28 -0500 (EST)
In-Reply-To: <0000015289f33df4-d0095101-cfc0-4c41-b1e7-6137105b93fb-000000@eu-west-1.amazonses.com>
	(Matthias Asshauer's message of "Thu, 28 Jan 2016 20:36:05 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C3631EC2-C613-11E5-B47E-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285042>

Matthias Asshauer <mha1993@live.de> writes:

> From: Matthias A=C3=9Fhauer <mha1993@live.de>
>
> This patch implements a new "git stash--helper" builtin plumbing
> command that will be used to migrate "git-stash.sh" to C.
>
> We start by implementing only the "--non-patch" option that will
> handle the core part of the non-patch stashing.
>
> Signed-off-by: Matthias A=C3=9Fhauer <mha1993@live.de>
> ---
>  Makefile                |  2 ++
>  builtin.h               |  1 +
>  builtin/stash--helper.c | 13 ++++++++++
>  git.c                   |  1 +
>  stash.c                 | 65 +++++++++++++++++++++++++++++++++++++++=
++++++++++
>  stash.h                 | 11 +++++++++

Hmph, why not have everything inside builtin/stash--helper.c?  I do
not quite see a point of having the other two "library-ish" looking
files.

Also I personally feel that it would be easier to review when
these two patches are squashed into one.  I had to go back and forth
while reading the "non-patch" C function to see what logic from the
scripted version it is trying to replace.

> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> new file mode 100644
> index 0000000..542e782
> --- /dev/null
> +++ b/builtin/stash--helper.c
> @@ -0,0 +1,13 @@
> +#include "../stash.h"
> +#include <string.h>
> +
> +static const char builtin_stash__helper_usage[] =3D {
> +	"Usage: git stash--helper --non-patch <tmp_indexfile> <i_tree>"
> +};
> +
> +int cmd_stash__helper(int argc, const char **argv, const char *prefi=
x)
> +{
> +	if (argc =3D=3D 4 && !strcmp("--non-patch", argv[1]))
> +		return stash_non_patch(argv[2], argv[3], prefix);
> +	usage(builtin_stash__helper_usage);
> +}

This is meant to replace this sequence:

	git read-tree --index-output=3D"$TMPindex" -m $i_tree &&
	GIT_INDEX_FILE=3D"$TMPindex" &&
	export GIT_INDEX_FILE &&
	git diff --name-only -z HEAD -- >"$TMP-stagenames" &&
	git update-index -z --add --remove --stdin <"$TMP-stagenames" &&
	git write-tree &&
	rm -f "$TMPindex"

And outside of this section of the script, $TMPindex is never looked
at after this part finishes (which is obvious as the last thing the
section does is to remove it).  As you are rewriting this whole
section in C, you should wonder if you can do it without using a
temporary file in the filesystem at all.

> diff --git a/stash.c b/stash.c
> new file mode 100644
> index 0000000..c3d6e67
> --- /dev/null
> +++ b/stash.c
> @@ -0,0 +1,65 @@
> +#include "stash.h"
> +#include "strbuf.h"
> +
> +static int prepare_update_index_argv(struct argv_array *args,
> +	struct strbuf *buf)
> +{
> +	struct strbuf **bufs, **b;
> +
> +	bufs =3D strbuf_split(buf, '\0');
> +	for (b =3D bufs; *b; b++)
> +		argv_array_pushf(args, "%s", (*b)->buf);
> +	argv_array_push(args, "--");
> +	strbuf_list_free(bufs);
> +
> +	return 0;
> +}
> +
> +int stash_non_patch(const char *tmp_indexfile, const char *i_tree,
> +	const char *prefix)
> +{
> +	int result;
> +	struct child_process read_tree =3D CHILD_PROCESS_INIT;
> +	struct child_process diff =3D CHILD_PROCESS_INIT;
> +	struct child_process update_index =3D CHILD_PROCESS_INIT;
> +	struct child_process write_tree =3D CHILD_PROCESS_INIT;
> +	struct strbuf buf =3D STRBUF_INIT;
> +
> +	argv_array_push(&read_tree.args, "read-tree");
> +	argv_array_pushf(&read_tree.args, "--index-output=3D%s", tmp_indexf=
ile);
> +	argv_array_pushl(&read_tree.args, "-m", i_tree, NULL);
> +
> +	argv_array_pushl(&diff.args, "diff", "--name-only", "-z", "HEAD", "=
--",
> +		NULL);
> +
> +	argv_array_pushl(&update_index.args, "update-index", "--add",
> +		"--remove", NULL);
> +
> +	argv_array_push(&write_tree.args, "write-tree");

Honestly, I had high hopes after seeing the "we are rewriting it in
C" but I am not enthused after seeing this.  I was hoping that the
rewritten version would do this all in-core, by calling these
functions that we already have:

 * read_index() to read the current index into the_index;

 * unpack_trees() to overlay the contents of i_tree to the contents
   of the index;

 * run_diff_index() to make the comparison between the result of the
   above and HEAD to collect the paths that are different (you'd use
   DIFF_FORMAT_CALLBACK mechanism to collect paths---see wt-status.c
   for existing code that already does this for hints);

 * add_to_index() to add or remove paths you found in the previous
   step to the in-core index;

 * write_cache_as_tree() to write out the resulting index of the
   above sequence of calls to a new tree object;

 * sha1_to_hex() to convert that resulting tree object name to hex
   format;

 * puts() to output the result.


Actually, because i_tree is coming from $(git write-tree) that was
done earlier on the current index, the unpack_trees() step should
not even be necessary.

The first three lines of the scripted version:

	git read-tree --index-output=3D"$TMPindex" -m $i_tree &&
	GIT_INDEX_FILE=3D"$TMPindex" &&
	export GIT_INDEX_FILE &&

are creating a new file $TMPindex on the filesystem while preserving
the cached stat info when it can, which is a glorified version of:

	cp -p $GIT_INDEX_FILE $TMPindex

In fact, versions of "git stash" before 3ba2e865 (stash: copy the
index using --index-output instead of cp -p, 2011-03-16) simply
did a "cp -p".

A C rewrite that works all in-core does not even need to write out a
temporary; it can just read the current index and do various things
up to writing the contents of the in-core index as a tree, and the
result would be correct as long as you do not forget *NOT* to write
the in-core index out to $GIT_INDEX_FILE.
