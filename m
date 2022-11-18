Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2C9C41535
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 13:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242073AbiKRNRB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 08:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241817AbiKRNQr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 08:16:47 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA417EBC7
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 05:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668777393; bh=quLUexws7JPqnOSlWlfLjbhl6cD4aUkulZMYv3TIC3c=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=sH61rHaLMV/uHIsJ/IyhVB3q/YQoyGW33jZ1rCM9BnuVzLCTXtUZpCa4287rweukz
         Q2oTsd0WDQVq2+3SWh1X21Ow1SRckukDYqXhZc3P0Ed8wJmX92GivZsDJqSbC9wHom
         Uw9QqGY9yBNuosLfVzQAgLHbYU7CVqtRix6Clq5FAYgWA6lkE+xPqJdNOlsDvQp9mb
         Zu0+ig0DpPm93Tg9BIF2QNnlf00RAuSR07hSxxWUlWofrkSxN/S8QMwY9xY++8Lw44
         5xjeVI331wb353YTdt+ZSiL0kUqKhXLhXpAHSIaPQN+ODUVLyVCZuDlNzqG6uulXOH
         MiSC6OT46SOhw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.29.212.27] ([89.1.212.70]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M72oB-1oruta1zXr-008d49; Fri, 18
 Nov 2022 14:16:33 +0100
Date:   Fri, 18 Nov 2022 14:16:32 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     phillip.wood@dunelm.org.uk
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] range-diff: support reading mbox files
In-Reply-To: <dfe0190c-1d2e-804a-5312-877b7b2f5822@dunelm.org.uk>
Message-ID: <06ro81n5-7sn1-070r-6747-5n77262o822p@tzk.qr>
References: <pull.1420.git.1668536405563.gitgitgadget@gmail.com> <dfe0190c-1d2e-804a-5312-877b7b2f5822@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OnWIIDLhgjUm7M7sKH4FsQi1D0n8FyjIarg/S6/I6Rp+eqyKMEa
 P+jr/qR+0FWlLNujpsZ2D3zekLjT5aQ85B7Y1NXQbzqPd7+05ZNhW0r0uaqmzNOAw09XKFd
 IiW2h1lnGsQEn00fZXZUYFKof+sicpuUwhnOXAMMjvMT4RUQSPZYioIpFUNBQhWmkdjupmS
 Cjgu5uLfHypXhO0SqKHMQ==
UI-OutboundReport: notjunk:1;M01:P0:uCKi69yhNgQ=;pV6VsaBs+4nQ/hyT18UZ/8n/MpC
 LgPlou6aY62gm5QuqHOLR2pNZEKxvdEqxuUXVF2ZVaTnfY/fGXLIAx0zVinK5chRst2PyRMHh
 midfNJCzUA+NEgmPOg/8jspmB2Q4FU0OhqybG0oQ+jcVji0rQRSjqiSs/oj4OYES/eU6lsk5O
 f0rd+9Aybm43tYmwiMEnY2OMP5CPnriYvsBYleU0tK2z4D2KNsAxmTRNH/zuKr+uGWtisVBWd
 o5ctHF6+ynY+jFF/JnNzi5APAmsg7U4mXgGHi3TXpwk/uIcMvat/cklOBv94Gpw63KYQeyILf
 4KksCncDXFigxrwpasDSIUWRLob/A8zge0opfUuI7UibcnklnPXUrkOWcRy5SeeWR/m2+Q6un
 0/bkJK0BkUXFhAq8yS5AXE293AZAoNyOcwxvMCltY6TD6+fnW8rF6zvM2DvK9LcAwDCSBq1fL
 buNr19rAFsqd2p/g8VmF3ks+vPBSjj8VswIKy8FvzF6I40ipqpbD+uLPhAC33avp5NdO5bW4i
 Uzyq92cnx1h5aln4kzEr5X9I6qQp9x/MQngQGIdBnwyxH75mAffGvQnCm0QvYUfREMIavJjsk
 4o2qK3DqvCfhlfFfWC1UuBVJ/XiP2UyxrFIklw7GDOs1a/wAyMwyEAPp/4J3MwFjGKFHbIOaH
 Tnc7NmNAGLEW6hpgiQl25PAEGNTg7ieHmNtvPrUqElZNhvOfTNKsW8NslkIFgX5UGruoJMem5
 Yc490n9hXEyYU8/U7JQafZhr/Rqlbg96tZru8PcZKsV93P9QUqopHBlS3/T9b0VYXbMPLLc/J
 MNVc/PL5aTyIoLMHmaoF2vX4Pm9KTVCtH6ZRZJ68oTOqkzsKqBoolq2b4Sq5TnqzWmToJCbjv
 95DOFwzLvkYTXwql08Uk2SiDd4kjPzV7xakBp72ekq323E3LhvrzfdrjqGvUnwyf+Vt5GuKxy
 g+/NtA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 16 Nov 2022, Phillip Wood wrote:

> On 15/11/2022 18:20, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Internally, the `git range-diff` command spawns a `git log` process an=
d
> > parses its output for the given commit ranges.
> >
> > This works well when the patches that need to be compared are present =
in
> > the local repository in the form of commits.
> >
> > In scenarios where that is not the case, the `range-diff` command is
> > currently less helpful.
> >
> > The Git mailing list is such a scenario: Instead of using Git to
> > exchange commits, the patches are sent there as plain-text and no comm=
it
> > range can be specified to let `range-diff` consume those patches.
> >
> > Instead, the expectation is to download the mails, apply them locally
> > and then use `range-diff`. This can be quite cumbersome e.g. when a
> > suitable base revision has to be found first where the patch applies
> > cleanly.
>
> That's a good motivation for this change.

Side note (potentially fun to know): A couple of weeks ago, I wanted to
work on this because I was asked to review a new patch series iteration on
the Git mailing list (I forgot which one it was, precisely), which came
without a range-diff, and I wanted to download both iterations using a
variation of
https://github.com/git-for-windows/build-extra/blob/HEAD/apply-from-lore.s=
h
and then use the mbox mode of `range-diff` on them. Unfortunately, I ran
out of time back then (it's a common theme for me these days), and the
patch series (rightfully) advanced to `next` without my review, and I let
this here patch slide.

> > +static inline int strtost(char const *s, size_t *result, const char *=
*end)
> > +{
> > +	unsigned long u;
> > +	char *p;
> > +
> > +	errno =3D 0;
> > +	/* negative values would be accepted by strtoul */
> > +	if (*s =3D=3D '-')
> > +		return -1;
>
> I think it is right to treat the input as untrusted and so look for malf=
ormed
> hunk headers. However This test is not sufficient for that, we expect a =
digit
> so I think
>
> 	if (!isdigit(*s))
> 		return -1;
>
> would be safer. The use of strtoul() looks good as we set errno to zero =
before
> the call and check both errno and endp afterwards.

Good point. As you might have guessed, this function is a copy/edit of
existing code, in this instance `strtoul_ui()`.

I have made the change you suggested.

>
> > +	u =3D strtoul(s, &p, 10);
> > +	if (errno || p =3D=3D s)
> > +		return -1;
> > +	if (result)
> > +		*result =3D u;
> > +	*end =3D p;
> > +
> > +	return 0;
> > +}
> > +
> > +static int parse_hunk_header(const char *p,
> > +			     size_t *old_count, size_t *new_count,
> > +			     const char **end)
> > +{
> > +	size_t o =3D 1, n =3D 1;
> > +
> > +	if (!skip_prefix(p, "@@ -", &p) ||
> > +	    strtost(p, NULL, &p) ||
> > +	    (*p !=3D ' ' && (*p !=3D ',' || strtost(p + 1, &o, &p))) ||
>
> It took me a minute to understand the double negatives but it is correct=
ly
> checking if we have ' ' or ',<digits>'

I actually hesitated when I wrote this, and only kept the code as-is
because I remembered how often Junio uses double negatives and thought it
would be a good joke to do the same here. Joke's obviously on me, though.

I've hence changed it to:

	    /* The range is -<start>[,<count>], defaulting to count =3D 1 */
	    !(*p =3D=3D ' ' || (*p =3D=3D ',' && !strtost(p + 1, &o, &p))) ||

and

	    /* The range is * +<start>[,<count>], * defaulting to count =3D 1 */
	    !(*p =3D=3D ' ' || (*p =3D=3D ',' && !strtost(p + 1, &n, &p))) ||

>
> > +	    !skip_prefix(p, " +", &p) ||
> > +	    strtost(p, NULL, &p) ||
> > +	    (*p !=3D ' ' && (*p !=3D ',' || strtost(p + 1, &n, &p))) ||
> > +	    !skip_prefix(p, " @@", &p))
> > +		return -1;
> > +
> > +	*old_count =3D o;
> > +	*new_count =3D n;
> > +	*end =3D p;
> > +
> > +	return 0;
> > +}
> > +
> > +static inline int find_eol(const char *line, size_t size)
> > +{
> > +	char *eol;
> > +
> > +	eol =3D memchr(line, '\n', size);
> > +	if (!eol)
> > +		return size;
> > +
> > +	if (eol !=3D line && eol[-1] =3D=3D '\r')
> > +		eol[-1] =3D '\0';
> > +	else
> > +		*eol =3D '\0';
> > +
> > +	return eol + 1 - line;
>
> We return the offset to the start of the next line, not the length of th=
e
> line. This will be important later.

You're right. I changed the name to `find_next_line()` and added an
informative comment on top of the function.

>
> > +}
> > +
> > +static int read_mbox(const char *path, struct string_list *list)
> > +{
> > +	struct strbuf buf =3D STRBUF_INIT, contents =3D STRBUF_INIT;
> > +	struct strbuf long_subject =3D STRBUF_INIT;
> > +	struct patch_util *util =3D NULL;
> > +	enum {
> > +		MBOX_BEFORE_HEADER,
> > +		MBOX_IN_HEADER,
> > +		MBOX_IN_COMMIT_MESSAGE,
> > +		MBOX_AFTER_TRIPLE_DASH,
> > +		MBOX_IN_DIFF
> > +	} state =3D MBOX_BEFORE_HEADER;
> > +	char *line, *current_filename =3D NULL;
> > +	int len;
> > +	size_t size, old_count =3D 0, new_count =3D 0;
> > +	const char *author =3D NULL, *subject =3D NULL;
> > +
> > +	if (!strcmp(path, "-")) {
> > +		if (strbuf_read(&contents, STDIN_FILENO, 0) < 0)
> > +			return error_errno(_("could not read stdin"));
> > +	} else if (strbuf_read_file(&contents, path, 0) < 0)
> > +		return error_errno(_("could not read '%s'"), path);
> > +
> > +	line =3D contents.buf;
> > +	size =3D contents.len;
> > +	for (; size > 0; size -=3D len, line +=3D len) {
>
> size is unsigned so we're effectively testing 'size !=3D 0' which means =
if we're
> off by one somewhere we'll have an undetected buffer overflow. Using a s=
igned
> type wouldn't prevent the buffer overflow but it would limit its extent.

`contents.len` is of type `size_t`, though, and I'd like to stay
consistent.

I did remove the misleading `> 0` from the condition, though.

>
> > +		const char *p;
> > +
> > +		len =3D find_eol(line, size);
>
> Here len is not the length of line if it originally ended "\r\n".
>
> > +		if (state =3D=3D MBOX_BEFORE_HEADER) {
> > +			if (!skip_prefix(line, "From ", &p))
> > +				continue;
> > +
> > +			util =3D xcalloc(1, sizeof(*util));
> > +			if (get_oid_hex(p, &util->oid) < 0)
> > +				oidcpy(&util->oid, null_oid());
> > +			util->matching =3D -1;
> > +			author =3D subject =3D NULL;
> > +
> > +			state =3D MBOX_IN_HEADER;
>
> I wondered if there should there be a `continue;` here but I think it pr=
obably
> needs to "fall-through" to the MBOX_IN_HEADER handling below. A comment =
to
> clarify that would be helpful.

You're absolutely correct, there totally should be a `continue` here: we
saw a `From `, and in the `MBOX_IN_HEADER` we look for either an empty
line, the `From:` header or the `Subject:` header, so we know that the
current line cannot match, no need to fall through.

>
> > +		}
> > +
> > +		if (starts_with(line, "diff --git ")) {
> > +			struct patch patch =3D { 0 };
> > +			struct strbuf root =3D STRBUF_INIT;
> > +			int linenr =3D 0;
> > +			int orig_len;
> > +
> > +			state =3D MBOX_IN_DIFF;
> > +			old_count =3D new_count =3D 0;
> > +			strbuf_addch(&buf, '\n');
> > +			if (!util->diff_offset)
> > +				util->diff_offset =3D buf.len;
> > +			line[len - 1] =3D '\n';
>
> Here the line will still be NUL terminated if it originally ended "\r\n"=
 which
> presumably messes up the call to parse_git_diff_header() below. I have n=
ot
> checked if parse_git_diff_header() can handle "\r\n" when it is parsing =
the
> rest of the diff header.

I changed it locally to reinstate the `\r\n`, only to figure out that
almost the entire `apply.c` machinery totally falls over CR/LF line
endings.

I changed the code to detect a Carriage Return and error out if one is
detected.

>
> > +			orig_len =3D len;
> > +			len =3D parse_git_diff_header(&root, &linenr, 1, line,
> > +						    len, size, &patch);
> > +			if (len < 0) {
> > +				error(_("could not parse git header '%.*s'"),
> > +				      orig_len, line);
> > +				free(util);
> > +				free(current_filename);
> > +				string_list_clear(list, 1);
> > +				strbuf_release(&buf);
> > +				strbuf_release(&contents);
> > +				strbuf_release(&long_subject);
> > +				return -1;
> > +			}
> > +
> > +			if (patch.old_name)
> > +				skip_prefix(patch.old_name, "a/",
> > +					    (const char **)&patch.old_name);
> > +			if (patch.new_name)
> > +				skip_prefix(patch.new_name, "b/",
> > +					    (const char **)&patch.new_name);
>
> I think this is fine for now but we might want to support other prefixes=
 in
> the future. If it is not a copy or rename then the filename can be deduc=
ed by
> finding the common tail of patch.old_name and patch.new_name and strippi=
ng
> anything before the first '/'. If it is a copy or rename then I suspect =
there
> is no prefix (though I've not checked)

Since `skip_prefix()` does not do anything if there is no match, I think
it is sane to err by not stripping anything unless the expected `a/` and
`b/` prefixes are seen.

>
> > +			strbuf_addstr(&buf, " ## ");
> > +			if (patch.is_new > 0)
>
> `patch.is_now` and `patch.is_delete` are booleans like `patch.is_rename`=
 so we
> don't need the '> 0'

Good catch.

>
> > +				strbuf_addf(&buf, "%s (new)", patch.new_name);
> > +			else if (patch.is_delete > 0)
> > +				strbuf_addf(&buf, "%s (deleted)",
> > patch.old_name);
> > +			else if (patch.is_rename)
> > +				strbuf_addf(&buf, "%s =3D> %s", patch.old_name,
> > patch.new_name);
> > +			else
> > +				strbuf_addstr(&buf, patch.new_name);
> > +
> > +			free(current_filename);
> > +			if (patch.is_delete > 0)
> > +				current_filename =3D xstrdup(patch.old_name);
> > +			else
> > +				current_filename =3D xstrdup(patch.new_name);
> > +
> > +			if (patch.new_mode && patch.old_mode &&
> > +			    patch.old_mode !=3D patch.new_mode)
> > +				strbuf_addf(&buf, " (mode change %06o =3D>
> > %06o)",
> > +					    patch.old_mode, patch.new_mode);
> > +
> > +			strbuf_addstr(&buf, " ##\n");
> > +			util->diffsize++;
> > +		} else if (state =3D=3D MBOX_IN_HEADER) {
> > +			if (!line[0]) {
> > +				state =3D MBOX_IN_COMMIT_MESSAGE;
> > +				/* Look for an in-body From: */
> > +				if (size > 5 && skip_prefix(line + 1, "From:
> > ", &p)) {
>
> The "size > 5" seems a bit unnecessary as we're using skip_prefix()

Right!

>
> > +					size -=3D p - line;
> > +					line +=3D p - line;
>
> This is good, we're accounting for reading the next line.
>
> > +					len =3D find_eol(line, size);
> > +
> > +					while (isspace(*p))
> > +						p++;
> > +					author =3D p;
> > +				}
> > +				strbuf_addstr(&buf, " ## Metadata ##\n");
> > +				if (author)
> > +					strbuf_addf(&buf, "Author: %s\n",
> > author);
> > +				strbuf_addstr(&buf, "\n ## Commit message
> > ##\n");
> > +				if (subject)
> > +					strbuf_addf(&buf, "    %s\n\n",
> > subject);
> > +			} else if (skip_prefix(line, "From: ", &p)) {
> > +				while (isspace(*p))
> > +					p++;
> > +				author =3D p;
> > +			} else if (skip_prefix(line, "Subject: ", &p)) {
> > +				const char *q;
> > +
> > +				while (isspace(*p))
> > +					p++;
> > +				subject =3D p;
> > +
> > +				if (starts_with(p, "[PATCH") &&
> > +				    (q =3D strchr(p, ']'))) {
> > +					q++;
> > +					while (isspace(*q))
> > +						q++;
> > +					subject =3D q;
> > +				}
> > +
> > +				if (len < size && line[len] =3D=3D ' ') {
> > +					/* handle long subject */
> > +					strbuf_reset(&long_subject);
> > +					strbuf_addstr(&long_subject, subject);
> > +					while (len < size && line[len] =3D=3D ' ')
> > {
> > +						line +=3D len;
> > +						size -=3D len;
> > +						len =3D find_eol(line, size);
> > +						strbuf_addstr(&long_subject,
> > line);
>
> Looks good
>
> > +					}
> > +					subject =3D long_subject.buf;
> > +				}
> > +			}
> > +		} else if (state =3D=3D MBOX_IN_COMMIT_MESSAGE) {
> > +			if (!*line)
>
> Not a big issue elsewhere you've used "!line[0]"
> Style: there should be braces on this branch.

Fixed on both accounts.

> [... addressed in follow-up mail...]
>
> I think this is a useful addition, it could perhaps benefit from more te=
sts
> though. Having tests for bad input, "\r\n" line endings and getting the =
author
> from a From: header as well as an in-body From: line would give a bit mo=
re
> reassurance about how robust the parser is.

Good point, I've augmented the test case a bit more.

Thank you again. It is a real pleasure to receive these constructive
reviews from you that pay so much attention to detail, and always lead to
a clear path forward.

Thanks!
Dscho
