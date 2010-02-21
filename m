From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v3 01/12] Support showing notes from more than one
 notes tree
Date: Sat, 20 Feb 2010 19:06:52 -0800
Message-ID: <7viq9r478z.fsf@alter.siamese.dyndns.org>
References: <cover.1266703765.git.trast@student.ethz.ch>
 <34f0e6d201f6bddfc8f4f374493b1b54d60b82cd.1266703765.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Feb 21 04:37:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nj2A7-0004cB-7c
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 04:07:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756623Ab0BUDHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 22:07:08 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51236 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756308Ab0BUDHG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 22:07:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D3D579BB85;
	Sat, 20 Feb 2010 22:07:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XK8qni8+r3viwkc7uH2n3TIixU0=; b=qqIvkW
	KvRphuMWVuh3SyZv16rOwmT74LxCC6MX7zcZMH+HQRWrwkxbDofxr7orlOMDCgaw
	4IXH/IW0uct7Vrx04oRFqCCRPppB3YkaIj/WJic5Qh1jWGbonxpYnD4RX7mf5N8p
	FtkOUaPFT6GgZOpP5pQIAnD6dTOxoz1KwHdH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TK8gw5wjue6YaAzu0qTCDC6PR+ZrTjpZ
	qA+o3QDPBJ+XLwCGheBGoAHB/tPMhvsUq+6cs0zRhprEUoPgADYuG1KF2I1dnhUW
	09MYk+MQVgfZNGcP0yGLyGMZday3Mwj/OZbF9cUi+jvQJJo+ea9N+vrYGLZanqW6
	4SVpFOv5cKU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 88AD39BB83;
	Sat, 20 Feb 2010 22:07:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2225E9BB82; Sat, 20 Feb
 2010 22:06:54 -0500 (EST)
In-Reply-To: <34f0e6d201f6bddfc8f4f374493b1b54d60b82cd.1266703765.git.trast@student.ethz.ch> (Thomas Rast's message of "Sat\, 20 Feb 2010 23\:16\:22 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2DB459F2-1E96-11DF-89AE-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140581>

Thomas Rast <trast@student.ethz.ch> writes:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 4c36aa9..3c5cfec 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -517,7 +517,7 @@ core.notesRef::
>  	after the full SHA-1 of the commit they annotate.
>  +
>  If such a file exists in the given ref, the referenced blob is read, and
> -appended to the commit message, separated by a "Notes:" line.  If the
> +appended to the commit message, separated by a "Notes from <refname>:" line.  If the

I haven't looked at your code, but I think the output should be kept the
same when <refname> is "refs/notes/commits", and it probably is a good
idea to omit "refs/notes/" part.  E.g. "Notes (amlog):" for notes stored
in the refs/notes/amlog hierarchy.

> @@ -1300,6 +1300,17 @@ mergetool.keepTemporaries::
>  mergetool.prompt::
>  	Prompt before each invocation of the merge resolution program.
>  
> +notes.displayRef::
> +	When showing commit messages, also show notes which are stored
> +	in the given ref.  The ref may also be a glob, in which case

If this were a description that follows an example

	[notes]
		displayRef = <ref>

then the above sentences make sense, but otherwise "in the given ref" does
not make much sense.  "The ref may also be a glob" is a lot worse. A "ref"
is never be a glob.  You can specify what refs to display by setting the
_value_ of this variable to a glob.

    notes.displayRef::
        The refname in the notes namespace from which to show notes when
        showing commit messages.  The value of this variable can be set to
        a glob, in whch case ...

> +	...  If a ref
> +	does not exist, it will be skipped silently.

Hmph...  Even when it is not a globbing specification?  If I said

	[notes]
		displayRef = refs/notes/tr/*

and there is no notes in the tr/ hierarchy yet, I would appreciate if the
code doesn't complain, but if I said a more concrete

	[notes]
		displayRef = refs/notes/anlog

and there is no "anlog", because I meant "amlog" and the above was a typo,
I would appreciate if the code somehow lets me know about it.

> +static int notes_display_config(const char *k, const char *v, void *cb)
> +{
> +	if (!strcmp(k, "notes.displayref")) {
> +		string_list_add_refs_by_glob(&display_notes_refs, v);

Somebody in the callchain should say

	if (!v)
        	config_error_nonbool(k)

before you use v here.

I don't think string_list_insert() has a desirable property for this.
If I wrote

	[notes]
            displayRef = refs/notes/commit
            displayRef = refs/notes/amlog

I would expect that the normal notes come first and then notes from the
amlog tree, not in the alphabetical "amlog happens to sort before commit"
order.  If I used a glob, e.g. "refs/notes/tr/*", I am saying "all notes
in the tr/ namespace, I do not care about the particular order among them.
Just use something sensible", and it would make sense to use some stable
ordering, e.g. the order for_each_glob_ref() calls you back, but receiving
the data and calling string_list_insert() will destroy the order the user
gave you the configuration, no?

> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> index 90178f9..0dfff82 100755
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -98,7 +98,7 @@ Date:   Thu Apr 7 15:14:13 2005 -0700
>  
>      2nd
>  
> -Notes:
> +Notes from notes/commits:

Please don't.
