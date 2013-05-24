From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] diffcore-pickaxe doc: document -S and -G properly
Date: Fri, 24 May 2013 10:31:18 -0700
Message-ID: <7v38tcb7yx.fsf@alter.siamese.dyndns.org>
References: <1369391635-13056-1-git-send-email-artagnon@gmail.com>
	<1369391635-13056-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 24 19:31:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufvpu-0007Gg-N5
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 19:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756112Ab3EXRbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 13:31:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46071 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755882Ab3EXRbV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 13:31:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC06420249;
	Fri, 24 May 2013 17:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h++NU7WiXSR0Pn9EY5BWT+bFthQ=; b=uBJhUI
	zXhRFivMa8yl9D5tltLtZXGK5OtEAOiDp1q86zWoFPQ8s1WYqxPq1zcjs2vwwcjj
	5IR1/SggejMR45Hn0tG27uuVTBxlxMBJ7X2Pho9lMuHJ7c4EjmwHstncyzv1HEbH
	IiAzAwfKsyqqBk8WcBK1ug9sNSC1++0uIgrsA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fbLfWF/2FtdGgC9s1pBZkN7otRHfTRWe
	F2PvO4bGWTjeSMdvpPQAK8P2hcEVrYk2fhqMubZ4nw4tB76pTD8820lRmTnWGP/I
	tbhZvUThuk4/wWEOASXTMaoFOO/pZXiBrdHGqgVN2O6YKkDeFo7EAi5EqYws7Nrp
	nreq2XDHBD4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3F0720248;
	Fri, 24 May 2013 17:31:20 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B8E6E20243;
	Fri, 24 May 2013 17:31:19 +0000 (UTC)
In-Reply-To: <1369391635-13056-3-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Fri, 24 May 2013 16:03:55 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BEF99CD8-C497-11E2-9531-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225385>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> The documentation of -S and -G is very sketchy.  Completely rewrite the
> sections in Documentation/diff-options.txt and
> Documentation/gitdiffcore.txt.
>
> References:
> 52e9578 ([PATCH] Introducing software archaeologist's tool "pickaxe".)
> f506b8e (git log/diff: add -G<regexp> that greps in the patch text)
>
> Inputs-from: Phil Hord <phil.hord@gmail.com>
> Co-authored-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/diff-options.txt | 38 +++++++++++++++++++++++++++++--------
>  Documentation/gitdiffcore.txt  | 43 ++++++++++++++++++++++++------------------
>  2 files changed, 55 insertions(+), 26 deletions(-)
>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 104579d..2835eef 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -383,14 +383,36 @@ ifndef::git-format-patch[]
>  	that matches other criteria, nothing is selected.
>  
>  -S<string>::
> -	Look for differences that introduce or remove an instance of
> -	<string>. Note that this is different than the string simply
> -	appearing in diff output; see the 'pickaxe' entry in
> -	linkgit:gitdiffcore[7] for more details.
> +	Look for differences that change the number of occurrences of
> +	the specified string (i.e. addition/deletion) in a file.
> +	Intended for the scripter's use.
> ++
> +It is especially useful when you're looking for an exact block of code
> +(like a struct), and want to know the history of that block since it
> +first came into being: use the feature iteratively to feed the
> +interesting block in the preimage back into `-S`, and keep going until
> +you get the very first version of the block.

OK, even though I would not say "especially" nor "useful" if I were
writing it, as it is the only use case it was designed for.

>  -G<regex>::
> +	Look for differences whose patch text contains added/removed
> +	lines that match <regex>.
> ++
> +To illustrate the difference between `-S<regex> --pickaxe-regex` and
> +`-G<regex>`, consider a commit with the following diff in the same
> +file:
> ++
> +----
> ++    return !regexec(regexp, two->ptr, 1, &regmatch, 0);
> +...
> +-    hit = !regexec(regexp, mf2.ptr, 1, &regmatch, 0);
> +----
> ++
> +While `git log -G"regexec\(regexp"` will show this commit, `git log
> +-S"regexec\(regexp" --pickaxe-regex` will not (because the number of
> +occurrences of that string did not change).
> ++
> +See the 'pickaxe' entry in linkgit:gitdiffcore[7] for more
> +information.

OK.

>  --pickaxe-regex::
> -	Make the <string> not a plain string but an extended POSIX
> -	regex to match.
> +	Treat the <string> given to `-S` as an extended POSIX regular
> +	expression to match.

OK.

> diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
> index 568d757..ef4c04a 100644
> --- a/Documentation/gitdiffcore.txt
> +++ b/Documentation/gitdiffcore.txt
> @@ -222,26 +222,33 @@ version prefixed with '+'.
>  diffcore-pickaxe: For Detecting Addition/Deletion of Specified String
>  ---------------------------------------------------------------------
>  
> -This transformation is used to find filepairs that represent
> -changes that touch a specified string, and is controlled by the
> --S option and the `--pickaxe-all` option to the 'git diff-*'
> -commands.
> -
> -When diffcore-pickaxe is in use, it checks if there are
> -filepairs whose "result" side and whose "origin" side have
> -different number of specified string.  Such a filepair represents
> -"the string appeared in this changeset".  It also checks for the
> -opposite case that loses the specified string.
> -
> -When `--pickaxe-all` is not in effect, diffcore-pickaxe leaves
> -only such filepairs that touch the specified string in its
> -output.  When `--pickaxe-all` is used, diffcore-pickaxe leaves all
> -filepairs intact if there is such a filepair, or makes the
> -output empty otherwise.  The latter behaviour is designed to
> -make reviewing of the changes in the context of the whole


> +There are two kinds of pickaxe: the S kind (corresponding to 'git log
> +-S') and the G kind (mnemonic: grep; corresponding to 'git log -G').

This is good as the beginning of a second paragraph or the second
sentence of the first paragraph.  This patch loses the description
of the general purpose of this machinery that should come at the
very beginning of the section (the original had a very good ut valid
only back when we had only -S; my "how about this" text did not have
a good one).

For example, the "rename" is about taking one set of filepairs and
expressing (some of) them as renames or copies by merging a deletion
filepair and a creation filepair into a rename-modify filepair, or
turning a creation filepair into a copy-modify filepair by finding a
preimage.  What does this transformation do?

Again here is my attempt for that missing first paragraph:

	This transformation limits the set of filepairs to those
	that change specified strings between the preimage and the
	postimage in a certain way.

        -S<block of text> and -G<regex> options are used to specify
	different ways these strings are sought.  Without
	--pickaxe-all, only the filepairs matching the given
	criterion is left in the output; all filepairs are left in
	the output when --pickaxe-all is used and if at least one
	filepair matches the given criterion.

but I do not have enough time now to condense the above down to a
readable paragraph of reasonable length (I expect that the ideal
final form would be like 5-6 lines at most).

> +"-S<block of text>" detects filepairs whose preimage and postimage
> +have different number of occurrences of the specified block of text.
> +By definition, it will not detect in-file moves.  Also, when a
> +changeset moves a file wholesale without affecting the interesting
> +string, rename detection kicks in as usual, and `-S` omits the
> +filepair (since the number of occurrences of that string didn't change
> +in that rename-detected filepair).

I am not sure why it is necessary to say anything about what the
previous step (diffcore-rename) might have done.  The input of this
(or any other) step in the diffcore pipeline is a preimage-postimage
filepairs, and to this transformation the filename does not matter.
Whether a file was moved (either "wholesale", implying nothing
changed, or renamed with modification at the same time) without
touching the block of text, or a file did not get involved in any
renaming, the only thing that matters is what the preimage and the
postimage in a filepair has (or does not have).

> + The implementation essentially
> +runs a count, and is significantly cheaper than the G kind.  When used
> +with `--pickaxe-regex`, treat the <block of text> as an extended POSIX
> +regular expression to match, instead of a literal string.

Sure.  Is "essentially runs a count" needed, though?  The reader has
just read "number of occurrences of the specified block of text" so
it would be obvious that the implementation counts.  It may be true
that it is significantly cheaper, but because they serve different
purposes, I am not sure it is worth saying.  It is like saying that
a hammer is significantly faster to drive a nail into wood than a
screwdriver to drive a screw into wood, without saying "nail" and
"screw".  It only invites readers to use a hammer to drive a screw.

> +"-G<regular expression>" detects filepairs whose textual diff has an
> +added or a deleted line that matches the given regular expression.
> +This means that it can detect in-file (or what rename-detection
> +considers the same file) moves.

"it can" sounds as if it is always a merit, which is probably not
what you wanted to imply.

When you are trying to see how a particular line came into the
shape, you would want to know what the previous shape of it was, but
a literal move will also be shown, which is a noise for the purpose
of digging.

> +The implementation runs diff twice
> +and greps, and this can be quite expensive.

Unlike the "count" one above which was obvious, the "runs diff and
greps hence expensive" part is worth saying.

> +When `-S` or `-G` are used without `--pickaxe-all`, only filepairs
> +that match their respective criterion are kept in the output.  When
> +`--pickaxe-all` is used, if even one filepair matches their respective
> +criterion in a changeset, the entire changeset is kept.  This behavior
> +is designed to make reviewing changes in the context of the whole
>  changeset easier.

OK.

>  
> -
>  diffcore-order: For Sorting the Output Based on Filenames
>  ---------------------------------------------------------
