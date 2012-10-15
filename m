From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/12] Add git-check-ignore sub-command
Date: Mon, 15 Oct 2012 15:31:20 -0700
Message-ID: <7vlif7v03r.fsf@alter.siamese.dyndns.org>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282486-4646-1-git-send-email-pclouds@gmail.com>
 <1350282486-4646-12-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 00:31:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNtCC-0003sS-6E
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 00:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603Ab2JOWbY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 18:31:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64412 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752237Ab2JOWbX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Oct 2012 18:31:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE8308DCC;
	Mon, 15 Oct 2012 18:31:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=aLVRsLxeL/EP
	ebPG8lxiFNDTkbA=; b=i6JP5iWPOvVPSzx0TJdXW+qKr5RXrYyRqcsk1FM8C3L2
	nn5PbOtCCjWL1rDinG7crfUI+mxw/unSjxdEPL6QBnCwWWPOEJmkvrOrCp2qAuJA
	KjHg7E06Qp+LD2Ya957SL9FrwwxKGswIo1DJLR1rAjm5o4ny2ixxkSUvuLvGwLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=m61Q8u
	sB78tc17MNKGij1AJhhcNMJD/JIlqAL9JlSpNjyEOCZQMZmf3jeJmHzKalkXU5BY
	U+ywSyXfpRIwC5LKuLDL2C5AH0pMtYYBJbkRHGzsx+WdWG57Aml/IddWCZSAmvHD
	q0nBlqMRIRwiSILf1dQlI6c8i5VzPsVhcQLTg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB8608DCB;
	Mon, 15 Oct 2012 18:31:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3F148DC9; Mon, 15 Oct 2012
 18:31:21 -0400 (EDT)
In-Reply-To: <1350282486-4646-12-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 15 Oct
 2012 13:28:06 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0BD0BCEA-1718-11E2-8B6D-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207783>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +For each pathname given via the command-line or from a file via
> +`--stdin`, this command will list the first exclude pattern found (i=
f
> +any) which explicitly excludes or includes that pathname.  Note that
> +within any given exclude file, later patterns take precedence over
> +earlier ones, so any matching pattern which this command outputs may
> +not be the one you would immediately expect.

"The first exclude pattern" is very misleading, isn't it?  For
example, with these in $GIT_DIR/info/exclude, I would get:

	$ cat -n .git/info/exclude
	  1 *~
          2 Makefile~
	$ git check-ignore -v Makefile~
	.git/info/exclude:2:Makefile~	Makefile~

which is the correct result (the last one in a single source decides
the fate of the path), but it hardly is "first one found" and the
matching pattern in the output would not be something unexpected for
the users, either.

The reason it is "the first one found" is because the implementation
arranges the loop in such a way that it can stop early when it finds
a match---it simply checks matches from the end of the source.

But that is not visible to end-users, and they will find the above
description just wrong, no?


> +OUTPUT
> +------
> +
> +By default, any of the given pathnames which match an ignore pattern
> +will be output, one per line.  If no pattern matches a given path,
> +nothing will be output for that path; this means that path will not =
be
> +ignored.
> +
> +If `--verbose` is specified, the output is a series of lines of the =
form:
> +
> +<source> <COLON> <linenum> <COLON> <pattern> <HT> <pathname>
> +
> +<pathname> is the path of a file being queried, <pattern> is the
> +matching pattern, <source> is the pattern's source file, and <linenu=
m>
> +is the line number of the pattern within that source.  If the patter=
n
> +contained a `!` prefix or `/` suffix, it will be preserved in the
> +output.  <source> will be an absolute path when referring to the fil=
e
> +configured by `core.excludesfile`, or relative to the repository roo=
t
> +when referring to `.git/info/exclude` or a per-directory exclude fil=
e.
> +
> +If `-z` is specified, the output is a series of lines of the form:
> +

Hmph... the remainder of the paragraph seems to have been chopped off.

> +EXIT STATUS
> +-----------
> +
> +0::
> +	One or more of the provided paths is ignored.
> +
> +1::
> +	None of the provided paths are ignored.
> +
> +128::
> +	A fatal error was encountered.
> +
> +SEE ALSO
> +--------
> +linkgit:gitignore[5]
> +linkgit:gitconfig[5]
> +linkgit:git-ls-files[5]
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
