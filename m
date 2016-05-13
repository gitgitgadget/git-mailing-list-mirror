From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug report: Duplicate CRLF rewrite warnings on commit
Date: Fri, 13 May 2016 09:43:48 -0700
Message-ID: <xmqqinyhaoxn.fsf@gitster.mtv.corp.google.com>
References: <20160513134953.GE2345@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri May 13 18:43:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1GBw-0007wb-WE
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 18:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763AbcEMQnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 12:43:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56028 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752058AbcEMQnw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 12:43:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D2F6197A7;
	Fri, 13 May 2016 12:43:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hZcgUoFmsp5Xz93eojddT5rsvUs=; b=uih7fO
	cGz/TCVNodnG5D1lPh5fdhewcM7RSDjBCF13A1Fwc5NwKy1DPgE6XkqVsZVAkPGg
	x/yQNLaf9Qdt7M7eH2VGseayfwfU0DKwUKzNYobLOt5FqD8P4UNKVeSNABcLbr+z
	i6HmxZWtUUAXJphIg5ypD2DuYf/OdSBXW4i8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NG4YJBR3x0Bq/8KNtyJhSyQYKrwgvedp
	vI8YxzArgSLthhnE9Ph7hRuYJHeYv6AZsUJX+3wa7PYdmoGTvqI5NX+lGZkC0MMS
	oqzepYzVAidOhikaM2yyqn36sGxqet3NASlu2VCxLaHUQmNIJZsnIfjbVuds+GEC
	OW4AvZWZXrA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 93E1A197A6;
	Fri, 13 May 2016 12:43:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EE052197A2;
	Fri, 13 May 2016 12:43:49 -0400 (EDT)
In-Reply-To: <20160513134953.GE2345@dinwoodie.org> (Adam Dinwoodie's message
	of "Fri, 13 May 2016 14:49:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DE9270F8-1929-11E6-9683-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294543>

Adam Dinwoodie <adam@dinwoodie.org> writes:

> If you use .gitattributes to enable CRLF->LF rewriting, then commit a
> file that would have its line endings rewritten, the "CRLF will be
> replaced by LF" warning is printed several times over; I'd expect it to
> be printed only once.
>
> There's a test case in t0020 -- "safecrlf: print warning only once" --
> that checks the warning is only printed once when using `git add`, but
> nothing that seems to check the same thing on `git commit`.  The
> unnecessary multiple warnings seem to have existed since at least v1.6.0
> (the warnings appear to have been added in v1.5.5 in 21e5ad5, but I
> couldn't get that to build on my current box), and I'm seeing them on my
> Cygwin box's build of the current next branch (d10caa2) and on my CentOS
> box's v2.8.1 release.

Torsten, I know you are not heavily invested in "commit" codepath,
but since you've been actively touching the CRLF area, I wonder
perhaps you might be interested in taking a look?

>
> Example:
>
>     $ git init
>     Initialized empty Git repository in /home/Adam/test/.git/
>
>     $ echo '* text' >.gitattributes
>
>     $ echo 'lf-terminated line' >text
>
>     $ git add .gitattributes text && git commit -m 'Initial commit'
>     [master (root-commit) 9a18d39] Initial commit
>      2 files changed, 2 insertions(+)
>      create mode 100644 .gitattributes
>      create mode 100644 text
>
>     $ echo 'crlf-terminated line' | unix2dos >text
>
>     $ git add text  # Single CRLF warning as expected
>     warning: CRLF will be replaced by LF in text.
>     The file will have its original line endings in your working directory.
>
>     $ git commit -m 'CRLF'  # Should have one CRLF warning, actually get two
>     warning: CRLF will be replaced by LF in text.
>     The file will have its original line endings in your working directory.
>     [master 4a8b1cb] CRLF
>     warning: CRLF will be replaced by LF in text.
>     The file will have its original line endings in your working directory.
>      1 file changed, 1 insertion(+), 1 deletion(-)
>
> (Tangentially: what's the accepted practice for submitting failing test
> scripts?  I've written a short test case to add to t0020 that shows this
> bugged behaviour, but I've got the vague impression from past emails
> that leading with the patch email adding the failing test case is not
> the expected way to do things on this list...)
>
> Cheers,
>
> Adam
