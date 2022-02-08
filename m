Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B3CC433EF
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 22:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387567AbiBHWZO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386601AbiBHU61 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 15:58:27 -0500
X-Greylist: delayed 90191 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 12:58:26 PST
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18425C0612C3
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 12:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1644353897;
        bh=fAdWBSiRcKSEWXo+/HMli+ZfHHHeroIL6yh9IyGPWZY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dzhnz9Fc9pnEbw8nZA5rKw2Ki3tdkda0z9yWV5j9GUFV1GqyRR5TXz5HC8ZywbfAO
         YTaHuu9Q5LRbHAd9TLqRFkUdGnNsfu+i9OhbE2nbjyr/rKJrKJOGpLdbY2v5FXai0Q
         CYWHi2lNA2tJVhTWFHth1WkxrQL8JKJvtRLS0K2c=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.27.158]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mvbiu-1o8ggR2AqM-00swwc; Tue, 08
 Feb 2022 21:58:17 +0100
Message-ID: <b49d396d-a433-51a4-2d19-55e175af571a@web.de>
Date:   Tue, 8 Feb 2022 21:58:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v2 1/6] archive: optionally add "virtual" files
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
 <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com>
 <49ff3c1f2b32b16df2b4216aa016d715b6de46bc.1644187146.git.gitgitgadget@gmail.com>
 <d1e333b6-3ec1-8569-6ea9-4abd3dee1947@web.de> <xmqqbkzigspr.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2202081406520.347@tvgsbejvaqbjf.bet>
 <xmqqbkzhdzib.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqbkzhdzib.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/00bIpfnb+OsZkSzCOGRjBfhT11BGA9kwsmaRFxsBH4/bXc+WNr
 fR3gVhPwOoy/1AAWUA3CLbOlY26LN9SagpzqqlfA6q2WAmhvhNGzNasjt/Z5eiDJ52jRLVV
 conLAVfZLbsHSGK+8AtgDk1pmYdLDswnQ2d+zf/k0uGuV3ifNT62euj74qLF/OPq6seg+R6
 edSLU7riDo47bIat2aH3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YHfHfKtJsbg=:OSjoor7wb7sCipjL7nJem/
 hNmSJrm/vGaMM/ZDKYtvDmRs1FuAFttSi3GZR+0SO4HXNe10Rp2XLbuGDlsR+dBuP6K48xKkc
 nPqEZLAY83tX6IfH8eUuk0txCha+HLZ1ikapTwBDo0cJKIvGB9a6A9e87uu8WLVZOnVZazDPD
 c0u6Df1TxPFFq6n+n8wsxZHAdu9HozU2N4oZKeuww383pk2YjhHu+YwhmgPCFNkLRQO7McJBB
 0KCo1SIj3pUE/TLIrigQ0zHCEedf1POj20S8e2LOMBqWjJn6TwoB2JjA1a7CLlcT1I6QbFFhH
 kwV/wbyiwrgOwH1FKDD1Epj0hG4w4/mhlb6H9dn+dhboqxreYv4NUDjulxqy7T5FLogjM0UWm
 P1WqYlcHpfnBJ+qNNvE3PlBkbNl1IE9Uw0OsS7MY/0+NTXyk2r+iQjfFIXGfu4HK62G0EqSfQ
 O0iSvltsvtDdGwWVVM7wLGcVRBsTkGLBbn8br8g7qD/hgeWa4IbBqai+8jILHC4EyVAf7PNRk
 2Xi328uXv8h5H5cqv4TKA1pGL1DaVYOmE8aKYCHnF1m7F71KYPZyRsD9aVPU2Rf4F810jffNP
 1LSqudItO24GrSNs/uulA4wTMa2OCCHlHA0L8RwpCMaj0VO3kcqJomI0C6KiSkca/ae3jcOkn
 VH65uACKd8PWk0c4ChnAqBvEMpY0yrr0PHx2qk5GY9sbJBCxLZpfPWNBcHb5JWPjuLepU3293
 WP0qcpZWA9Xaqirp5K68FLXaLLRXNyq9A8tSkRRcZtyD8ijp1GFYMxHichNA8PA86LeijBNpm
 XCYMtYCzGgZlVHgyy//r0Y/adGS3h+KyzggWmHupFABDxpE//AcoV3sxeUA3Udy72JNKeBCXe
 +z2qvD/upw1Z886z+bd0+yDullv0MvPwG+YAtYH2wSoDbAsPXpu7X3tmzjxbMTycYLAUa4yzt
 ZiwbjWlsLXiaNnPH/dsHS0O5HNGxlqXMF0Mw9TBSG6JyDTuNKmvTh60zhoiHA/3IjGdk5755q
 zWNdbyV/r1PERGNSx1Wl2owBHfDhKork6CjDCkS56gW0hXZEFD+LK4pWGwFwfq7jqw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.02.22 um 18:44 schrieb Junio C Hamano:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>>> We could use that option in Git's own Makefile to add the file named
>>>> "version", which contains $GIT_VERSION.  Hmm, but it also contains a
>>>> terminating newline, which would be a bit tricky (but not impossible)=
 to
>>>> add.  Would it make sense to add one automatically if it's missing (e=
.g.
>>>> with strbuf_complete_line)?  Not sure.
>>>
>>> I do not think it is a good UI to give raw file content from the
>>> command line, which will be usable only for trivial, even single
>>> liner files, and forces people to learn two parallel option, one
>>> for trivial ones and the other for contents with meaningful size.
>>
>> Nevertheless, it is still the most elegant way that I can think of to
>> generate a diagnostic `.zip` file without messing up the very things th=
at
>> are to be diagnosed: the repository and the worktree.
>
> Puzzled.  Are you feeding contents of a .zip file from the command
> line?

Kind of.  Command line arguments are built and handed to write_archive()
in-process.  It's done by patch 3 and extended by 5 and 6.

The number of files is relatively low and they aren't huge, right?
Staging their content in the object database would be messy, but $TMPDIR
might be able to take them with a low impact.  Unless the problem to
diagnose is that this directory is full -- but you don't need a fancy
report for that. :)

Currently there is no easy way to write a temporary file with a chosen
name.  diff.c would benefit from such a thing when running an external
diff program; currently it adds a random prefix.  git archive --add-file
also uses the filename (and discards the directory part).  The patch
below adds a function to create temporary files with a chosen name.
Perhaps it would be useful here as well, instead of the new option?

> I was mostly worried about busting command line argument limit by
> trying to feed too many bytes, as the ceiling is fairly low on some
> platforms.

Command line length limits don't apply to the way scalar uses the new
option.

> Another worry was that when <contents> can have
> arbitrary bytes, with --opt=3D<path>:<contents> syntax, the input
> becomes ambiguous (i.e. "which colon is the <path> separator?"),
> without some way to escape a colon in the payload.

The first colon is the separator here.

> For a single-liner, --add-file-with-contents=3D<path>:<contents> would
> be an OK way, and my comment was not a strong objection against this
> new option existing.  It was primarily an objection against changing
> the way to add the 'version' file in our "make dist" procedure to
> use it anyway.
>
> But now I think about it more, I am becoming less happy about it
> existing in the first place.
>
> This will throw another monkey wrench to Konstantin's plan [*] to
> make "git archive" output verifiable with the signature on original
> Git objects, but it is not a new problem ;-)
>
>
> [Reference]
>
> * https://lore.kernel.org/git/20220207213449.ljqjhdx4f45a3lx5@meerkat.lo=
cal/

I don't see the conflict: If an untracked file is added to an archive
using --add-file, --add-file-with-content, or ZIP or tar then we'd
*want* the verification against a signed commit or tag to fail, no?  A
different signature would be required for the non-tracked parts.

Ren=C3=A9


=2D-- >8 ---
Subject: [PATCH] tempfile: add mks_tempfile_dt()

Add a function to create a temporary file with a certain name in a
temporary directory created using mkdtemp(3).  Its result is more
sightly than the paths created by mks_tempfile_ts(), which include
a random prefix.  That's useful for files passed to a program that
displays their name, e.g. an external diff tool.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 tempfile.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tempfile.h | 13 +++++++++++
 2 files changed, 76 insertions(+)

diff --git a/tempfile.c b/tempfile.c
index 94aa18f3f7..2024c82691 100644
=2D-- a/tempfile.c
+++ b/tempfile.c
@@ -56,6 +56,20 @@

 static VOLATILE_LIST_HEAD(tempfile_list);

+static void remove_template_directory(struct tempfile *tempfile,
+				      int in_signal_handler)
+{
+	if (tempfile->directorylen > 0 &&
+	    tempfile->directorylen < tempfile->filename.len &&
+	    tempfile->filename.buf[tempfile->directorylen] =3D=3D '/') {
+		strbuf_setlen(&tempfile->filename, tempfile->directorylen);
+		if (in_signal_handler)
+			rmdir(tempfile->filename.buf);
+		else
+			rmdir_or_warn(tempfile->filename.buf);
+	}
+}
+
 static void remove_tempfiles(int in_signal_handler)
 {
 	pid_t me =3D getpid();
@@ -74,6 +88,7 @@ static void remove_tempfiles(int in_signal_handler)
 			unlink(p->filename.buf);
 		else
 			unlink_or_warn(p->filename.buf);
+		remove_template_directory(p, in_signal_handler);

 		p->active =3D 0;
 	}
@@ -100,6 +115,7 @@ static struct tempfile *new_tempfile(void)
 	tempfile->owner =3D 0;
 	INIT_LIST_HEAD(&tempfile->list);
 	strbuf_init(&tempfile->filename, 0);
+	tempfile->directorylen =3D 0;
 	return tempfile;
 }

@@ -198,6 +214,52 @@ struct tempfile *mks_tempfile_tsm(const char *filenam=
e_template, int suffixlen,
 	return tempfile;
 }

+struct tempfile *mks_tempfile_dt(const char *directory_template,
+				 const char *filename)
+{
+	struct tempfile *tempfile;
+	const char *tmpdir;
+	struct strbuf sb =3D STRBUF_INIT;
+	int fd;
+	size_t directorylen;
+
+	if (!ends_with(directory_template, "XXXXXX")) {
+		errno =3D EINVAL;
+		return NULL;
+	}
+
+	tmpdir =3D getenv("TMPDIR");
+	if (!tmpdir)
+		tmpdir =3D "/tmp";
+
+	strbuf_addf(&sb, "%s/%s", tmpdir, directory_template);
+	directorylen =3D sb.len;
+	if (!mkdtemp(sb.buf)) {
+		int orig_errno =3D errno;
+		strbuf_release(&sb);
+		errno =3D orig_errno;
+		return NULL;
+	}
+
+	strbuf_addf(&sb, "/%s", filename);
+	fd =3D open(sb.buf, O_CREAT | O_EXCL | O_RDWR, 0600);
+	if (fd < 0) {
+		int orig_errno =3D errno;
+		strbuf_setlen(&sb, directorylen);
+		rmdir(sb.buf);
+		strbuf_release(&sb);
+		errno =3D orig_errno;
+		return NULL;
+	}
+
+	tempfile =3D new_tempfile();
+	strbuf_swap(&tempfile->filename, &sb);
+	tempfile->directorylen =3D directorylen;
+	tempfile->fd =3D fd;
+	activate_tempfile(tempfile);
+	return tempfile;
+}
+
 struct tempfile *xmks_tempfile_m(const char *filename_template, int mode)
 {
 	struct tempfile *tempfile;
@@ -316,6 +378,7 @@ void delete_tempfile(struct tempfile **tempfile_p)

 	close_tempfile_gently(tempfile);
 	unlink_or_warn(tempfile->filename.buf);
+	remove_template_directory(tempfile, 0);
 	deactivate_tempfile(tempfile);
 	*tempfile_p =3D NULL;
 }
diff --git a/tempfile.h b/tempfile.h
index 4de3bc77d2..d7804a214a 100644
=2D-- a/tempfile.h
+++ b/tempfile.h
@@ -82,6 +82,7 @@ struct tempfile {
 	FILE *volatile fp;
 	volatile pid_t owner;
 	struct strbuf filename;
+	size_t directorylen;
 };

 /*
@@ -198,6 +199,18 @@ static inline struct tempfile *xmks_tempfile(const ch=
ar *filename_template)
 	return xmks_tempfile_m(filename_template, 0600);
 }

+/*
+ * Attempt to create a temporary directory in $TMPDIR and to create and
+ * open a file in that new directory. Derive the directory name from the
+ * template in the manner of mkdtemp(). Arrange for directory and file
+ * to be deleted if the program exits before they are deleted
+ * explicitly. On success return a tempfile whose "filename" member
+ * contains the full path of the file and its "fd" member is open for
+ * writing the file. On error return NULL and set errno appropriately.
+ */
+struct tempfile *mks_tempfile_dt(const char *directory_template,
+				 const char *filename);
+
 /*
  * Associate a stdio stream with the temporary file (which must still
  * be open). Return `NULL` (*without* deleting the file) on error. The
=2D-
2.35.1
