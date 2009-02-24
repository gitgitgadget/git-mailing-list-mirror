From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How do I qualify paths in the .gitignore file w.r.t. the repo
 root  directory?
Date: Tue, 24 Feb 2009 09:33:26 -0800
Message-ID: <7vzlgbhh95.fsf@gitster.siamese.dyndns.org>
References: <e38bce640902232247t63a37f63x9f403fbda0744cfd@mail.gmail.com>
 <7v1vtomhz1.fsf@gitster.siamese.dyndns.org>
 <slrngq7e6c.iti.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 18:35:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc1BP-0004Nf-Qt
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 18:35:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760078AbZBXRdf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2009 12:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760085AbZBXRde
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 12:33:34 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34141 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760069AbZBXRdd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2009 12:33:33 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9A9262BD7A;
	Tue, 24 Feb 2009 12:33:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C694E2BD56; Tue,
 24 Feb 2009 12:33:28 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4147D59E-0299-11DE-A185-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111318>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> On 2009-02-24, Junio C Hamano <gitster@pobox.com> wrote:
>> I think you are looking for "/foo/".  From Documentation/gitignore.t=
xt:
>
> [lots of very clear and detailed explanation snipped for
> brevity...]
>
> I'd been sort of struggling with the part of 'man gitignore'
> that describes the rules for the exclusion patterns; it just
> didn't seem as clear as it could have been.  It's very
> accurate, but I (and I noticed a few others on irc) had to
> read very carefully to do anything moderately complex.

The existing documentation has an unfortunate history behind it and the
"if it ends with a slash it matches only directories" was bolted on as =
an
afterthought; see d6b8fc3 (gitignore(5): Allow "foo/" in ignore list to
match directory "foo", 2008-01-31).

> A few days ago, 'doener' (Bj=C3=83=C2=B6rn Steinbrink) came up with
> some much simpler rules that said the same thing, and --
> building on the insight that his rules gave me -- I came up
> with these:
>
> ----->8-----
>
> Note that rule 1 merely *modifies* rules 2 and 3, it does not
> supercede or preclude them.
>
> 1.  If you pattern ends with a slash, it matches only
>     directories (and their contents)
> 2.  If there is no slash otherwise, it matches that name, at
>     any depth in the tree
> 3.  If there is a slash anywhere else, it matches that name,
>     relative to the .gitignore (or $GIT_WORK_TREE if the
>     pattern is from one of the other pattern sources like
>     `.git/info/exclude` etc)
>
> The wildcards (`*` and `?`) do not match slashes, but otherwise
> the patterns are normal shell globs as defined by fnmatch(3) with
> the FNM_PATHNAME flag set.
>
> ----->8-----

Nicely written, except that as a non-native speaker I fear "otherwise" =
and
"anywhere else" _might_ leave ambiguity for a pattern that has slash on=
ly
at the end [*1*], but I dunno.  It certainly is much better than what I
wrote in the current documentation.

Please send it in a patch form (possibly addressing my ambiguity concer=
n
if it is real for other people) with a one-liner log message that says
"The existing documentation is unreadable even though it may be precise=
",
and I'll apply.

Thanks.

[Footnote]

*1* That is why I wrote "it is removed for the purpose of..." in the
description, even though I do agree that paragraph is hard to read.
Perhaps I should have said "it only matches directories.  The slash at =
the
end is ignored for the purpose of the following rules." which probably
would have flowed a bit more naturally.
