From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RESEND PATCH v3] Configurable hyperlinking in gitk
Date: Tue, 11 Oct 2011 15:13:16 -0700
Message-ID: <7vfwizdvnn.fsf@alter.siamese.dyndns.org>
References: <20110917022903.GA2445@unpythonic.net>
 <4E7467B7.1090201@gmail.com> <m3hb49sn26.fsf@localhost.localdomain>
 <20110922013101.GB26880@unpythonic.net>
 <20111011183722.GA26646@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Marc Branchaud <marcnarc@xiplink.com>,
	Chris Packham <judge.packham@gmail.com>
To: Jeff Epler <jepler@unpythonic.net>,
	Paul Mackerras <paulus@samba.org>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 00:13:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDkZk-0002S8-Ii
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 00:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215Ab1JKWNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 18:13:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64734 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750865Ab1JKWNT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 18:13:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02F726040;
	Tue, 11 Oct 2011 18:13:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aqdx4GQeLRt137HaYEdGW3w8teU=; b=xVI2J0
	j+Qw0T7xyyNV/UvrXYvj5LLBI+nohnPAXyHWAjtv5nmNj/WKi7jBe7pArRRINejs
	5YKb54H8bHEcqs/sv+Ng9o+0ZR4tmVk7k66mPMuj1YhAEeoezVTAk+zk3IAULAQP
	DafpQ2ToNkVJ0GVTj1mdoMzRJR1KWdTgv9qpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tu0zTFhUrjCpPXeAhdwf7N+DwYCFJ5fv
	RNPX6LVTktNwmSDlsOvU8ZZoffBe6Hz0chOL0haQjJqFtXVmsaI0l/xebfxVM1kr
	SWJxl1YC6jnhCh+WrrrVMrKDKyvF339sL/t4FYx/TuvsRc5HOKG/zGFWwmj/va+G
	ayI7Iad6zac=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED435603F;
	Tue, 11 Oct 2011 18:13:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 565FD603E; Tue, 11 Oct 2011
 18:13:18 -0400 (EDT)
In-Reply-To: <20111011183722.GA26646@unpythonic.net> (Jeff Epler's message of
 "Tue, 11 Oct 2011 13:37:23 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 391CAC12-F456-11E0-A5CD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183331>

Jeff Epler <jepler@unpythonic.net> writes:

> I'm aware of no problems with this patch, and a number of people have
> commented that it is useful to them.

Hmmm, "didn't generate any discussion" does not mesh very well with "a
number of people are happy". Which one should I trust?

>  * Documented that these are POSIX EREs; hopefully that's OK.  I see
>    in CodingGuidelines that in git itself "a subset of BREs" are used,
>    so maybe even this is too much power.  And hopefully tcl's
>    re_syntax really is close enough to an ERE superset that this isn't
>    a terrible lie about the initial implementation either.

I think it is better to be honest and say these are fed to the native
regexp engine of Tcl somewhere in the documentation.

Declaring "these are POSIX EREs" invites a user to expect they truly
are. When the pattern the user wrote triggers a strange Tcl extension to
cause unexpected things to match, the documentation needs to help the user
to understand why. I understand the longer-term wish to reuse these in
gitweb and elsewhere, but it becomes even more important that it is
clearly documented that these "regexp" are fed to native regexp engines of
Tcl and Perl depending on the program that they are used in. Unless the
documentation spells it out, the user will not be able to decide how to
work the implementation around, avoiding constructs that would behave
differently between Tcl and Perl.

Doesn't tcl have/use pcre these days, by the way? If we envision that this
will be shared with gitweb, perhaps using that might be a better option to
reduce potential confusion.

>  * Added a Signed-Off-By, since I've had a number of positive feedbacks
>    and the only problems I've heard of (since patch v2) are the ones
>    related to 'eval' in git-web--browse.

By the way, "This patch is good" does not have anything to do with signing
off a patch.

Paul wanted to keep gitk sources separately available from the rest of the
git. After all, that is how gitk project started. Even after 5569bf9 (Do a
cross-project merge of Paul Mackerras' gitk visualizer, 2005-06-22), we
kept it so that git://git.kernel.org/pub/scm/gitk/gitk was the primary
project to make changes to gitk, and git.git pulled from it (it is an
assymmetric pull, as gitk cannot pull from git without contaminating its
history with the changes to the rest of git).

I do not know how motivated Paul is to keep gitk part separated in its own
project these days. I do not think the /pub/scm/gitk/gitk repository has
been re-populated yet. Assuming that it will eventually come back on-line,
could you send the gitk part of this change to Paul (i.e. the diff header
of your patch should read "diff --git a/gitk b/gitk") and another separate
patch to Documentation/ part?

Paul, if you are orphaning gitk, I do _not_ mind start taking patches that
touch gitk myself directly into git tree.

But I would still need reviewers who are motivated and interested in
enhancing and maintaining gitk.

> +linkify.<name>.regexp::
> +	Specify a regular expression in the POSIX Extended Regular Expression
> +	syntax defining a class of strings to automatically convert to
> +	hyperlinks.  This regular expression many not span multiple lines.
> +	You must also specify 'linkify.<name>.subst'.

Saying "You must ..." without explicitly saying "why" is a bad style. If
the reader already _knows_ the .regexp is used to supply captured
substring to the corresponding .subst, then it is obvious that whenever
you have .regexp you need a matching .subst, but that is not even
explained here.

How about this?

	A string that matches this regexp is converted to a hyperlink
	using the value of corresponding `linkify.<name>.subst` variable.
	The regular expression is passed to the regexp engine of Tcl (in
	gitk) or Perl (in gitweb).

> +linkify.<name>.subst::
> +	Specify a substitution that results in the target URL for the
> +	related regular expression.  Back-references like '\1' refer
> +	to capturing groups in the associated regular expression.
> +	You must also specify 'linkify.<name>.regexp'.

Likewise.

	A string matched the value of the corresponding
	`linkify.<name>.regexp` variable is rewritten to this URL. The
	value of this variable can contain back-references like `\1` to
	refer to capturing groups in the associated regular expression.
