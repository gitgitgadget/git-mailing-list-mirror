From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] diff --stat: report chmoded binary files like text
 files
Date: Tue, 01 May 2012 11:27:14 -0700
Message-ID: <7vvckf92pp.fsf@alter.siamese.dyndns.org>
References: <1335892215-21331-1-git-send-email-zbyszek@in.waw.pl>
 <1335892215-21331-4-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mj@ucw.cz
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Tue May 01 20:27:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPHnH-00054n-8o
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 20:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756259Ab2EAS1S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 14:27:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38396 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754238Ab2EAS1R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2012 14:27:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB4916E66;
	Tue,  1 May 2012 14:27:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=x1g7DWFsCt/3
	sFf+4Fm/KDCgTUM=; b=lgtd/hPIjOKekM7URV8xk7z9GDED32TDDAwg8DAmN35Z
	iP8O3VJUp/mafRMSWw8sKRHWz2UoQT/IXmuquX4hCF2Q2FJG8YNUv710hbDYUbR8
	IAHUYQP0JVofdHZNEbPUg6mTxQennnqdww8KaVqKMCBEujevxrL3NsHW3pjbMWg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ui4czg
	KI3zd2CvtWtJeNwL6KRhn47BUV1cve4JI7LkBLmisNifl3xvnpvmqPRM3M4RnluE
	UcQ2/c5HLcFC144xpiMBmM+q/cT8qo6lYsv3t4bxFkXZ2TERedlctMnDPi7L0iZ6
	KXPmt5E34urRttobqQxg89uCU7r0ieBoKZvWw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1CF96E65;
	Tue,  1 May 2012 14:27:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0CA036E64; Tue,  1 May 2012
 14:27:15 -0400 (EDT)
In-Reply-To: <1335892215-21331-4-git-send-email-zbyszek@in.waw.pl> ("Zbigniew
 =?utf-8?Q?J=C4=99drzejewski-Szmek=22's?= message of "Tue, 1 May 2012 19:10:14
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4734AF70-93BB-11E1-9EA2-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196723>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> Binary files chmoded without content change were reported as if they
> were rewritten. At the same time, text files in the same situation
> were reported as "unchanged". Let's treat binary files like text file=
s
> here, and simply say that they are unchanged.
>
> For text files, we knew that they were unchanged if the numbers of
> lines added and deleted were both 0. For binary files this metric doe=
s
> not make sense and is not calculated, so a new way of conveying this
> information is needed. A new flag is_unchanged is added in struct
> diffstat_t that is set if the contents of both files are identical.
> For consistency, this new flag is used both for text files and binary
> files.
>
> Output of --shortstat is modified in the same way.
>
> Reported-by: Martin Mare=C5=A1 <mj@ucw.cz>
> Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
> ---
>  diff.c               |   28 +++++++++++++++++-----------
>  t/t4006-diff-mode.sh |    8 +-------
>  2 files changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 7da16c9..6eb2946 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1299,6 +1299,7 @@ struct diffstat_t {
>  		unsigned is_unmerged:1;
>  		unsigned is_binary:1;
>  		unsigned is_renamed:1;
> +		unsigned is_unchanged:1;

The name is somewhat misleading, as a filepair that consists of two blo=
bs
with the same contents with different mode bits is still "changed", and
you are trying to say that they have the same contents.

> @@ -1471,7 +1472,7 @@ static void show_stats(struct diffstat_t *data,=
 struct diff_options *options)
>  		struct diffstat_file *file =3D data->files[i];
>  		uintmax_t change =3D file->added + file->deleted;
>  		if (!data->files[i]->is_renamed &&
> -			 (change =3D=3D 0)) {
> +		    data->files[i]->is_unchanged) {

I am not sure if all these hunks are needed.  If you are going to show
only "  Bin\n" for a filepair with the same binary contents, perhaps it=
 is
simpler to set added/deleted fields of such a filepair to 0?  Then most=
 of
the hunks in this patch can disappear, no?

> @@ -2379,6 +2383,8 @@ static void builtin_diffstat(const char *name_a=
, const char *name_b,
>  		return;
>  	}
> =20
> +	data->is_unchanged =3D hashcmp(one->sha1, two->sha1) =3D=3D 0;

Please write it as "!hashcmp(a, b)", not "hashcmp(a, b) =3D=3D 0".

In any case, how about doing it like this instead?

 diff.c               |   38 +++++++++++++++++++++++---------------
 t/t4006-diff-mode.sh |    8 +-------
 2 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/diff.c b/diff.c
index 22288b0..338ef41 100644
--- a/diff.c
+++ b/diff.c
@@ -1583,8 +1583,12 @@ static void show_stats(struct diffstat_t *data, =
struct diff_options *options)
 		if (data->files[i]->is_binary) {
 			fprintf(options->file, "%s", line_prefix);
 			show_name(options->file, prefix, name, len);
-			fprintf(options->file, "  Bin ");
-			fprintf(options->file, "%s%"PRIuMAX"%s",
+			fprintf(options->file, "  Bin");
+			if (!added && !deleted) {
+				putc('\n', options->file);
+				continue;
+			}
+			fprintf(options->file, " %s%"PRIuMAX"%s",
 				del_c, deleted, reset);
 			fprintf(options->file, " -> ");
 			fprintf(options->file, "%s%"PRIuMAX"%s",
@@ -1657,17 +1661,16 @@ static void show_shortstats(struct diffstat_t *=
data, struct diff_options *option
 		return;
=20
 	for (i =3D 0; i < data->nr; i++) {
-		if (!data->files[i]->is_binary &&
-		    !data->files[i]->is_unmerged) {
-			int added =3D data->files[i]->added;
-			int deleted=3D data->files[i]->deleted;
-			if (!data->files[i]->is_renamed &&
-			    (added + deleted =3D=3D 0)) {
-				total_files--;
-			} else {
-				adds +=3D added;
-				dels +=3D deleted;
-			}
+		int added =3D data->files[i]->added;
+		int deleted=3D data->files[i]->deleted;
+
+		if (data->files[i]->is_unmerged)
+			continue;
+		if (!data->files[i]->is_renamed && (added + deleted =3D=3D 0)) {
+			total_files--;
+		} else {
+			adds +=3D added;
+			dels +=3D deleted;
 		}
 	}
 	if (options->output_prefix) {
@@ -2377,8 +2380,13 @@ static void builtin_diffstat(const char *name_a,=
 const char *name_b,
=20
 	if (diff_filespec_is_binary(one) || diff_filespec_is_binary(two)) {
 		data->is_binary =3D 1;
-		data->added =3D diff_filespec_size(two);
-		data->deleted =3D diff_filespec_size(one);
+		if (!hashcmp(one->sha1, two->sha1)) {
+			data->added =3D 0;
+			data->deleted =3D 0;
+		} else {
+			data->added =3D diff_filespec_size(one);
+			data->deleted =3D diff_filespec_size(two);
+		}
 	}
=20
 	else if (complete_rewrite) {
diff --git a/t/t4006-diff-mode.sh b/t/t4006-diff-mode.sh
index 392dfef..693bfc4 100755
--- a/t/t4006-diff-mode.sh
+++ b/t/t4006-diff-mode.sh
@@ -46,18 +46,12 @@ test_expect_success '--shortstat output after text =
chmod' '
=20
 test_expect_success '--stat output after binary chmod' '
 	test_chmod +x binbin &&
-	cat >expect <<-EOF &&
-	 binbin |  Bin 1024 -> 1024 bytes
-	 1 file changed, 0 insertions(+), 0 deletions(-)
-	EOF
+	echo " 0 files changed" >expect &&
 	git diff HEAD --stat >actual &&
 	test_cmp expect actual
 '
=20
 test_expect_success '--shortstat output after binary chmod' '
-	cat >expect <<-EOF &&
-	 1 file changed, 0 insertions(+), 0 deletions(-)
-	EOF
 	git diff HEAD --shortstat >actual &&
 	test_cmp expect actual
 '
