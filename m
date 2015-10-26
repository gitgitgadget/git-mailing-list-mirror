From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] sh-setup: explicitly mark CR as a field separator
Date: Mon, 26 Oct 2015 11:31:39 -0700
Message-ID: <xmqq8u6piir8.fsf@gitster.mtv.corp.google.com>
References: <cover.1445777347.git.johannes.schindelin@gmx.de>
	<cover.1445782122.git.johannes.schindelin@gmx.de>
	<2b089201404299257f23b3931499ea16202f0f65.1445782122.git.johannes.schindelin@gmx.de>
	<vpqlhaqas8g.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Chad Boles <chadbo@microsoft.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Philip Oakley <philipoakley@iee.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Oct 26 19:31:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqmYi-0001zd-Ly
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 19:31:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804AbbJZSbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 14:31:48 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58971 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752076AbbJZSbr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 14:31:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6496E26146;
	Mon, 26 Oct 2015 14:31:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KgO1cn34s7Pp6k5SgZdkoGHYXYI=; b=S93KEc
	AgnktnTG0hwH884YrFBuyLJYdaWHZxrl+Tt23t2dilYiMEz5Z0a/FyQfhVYFpAjN
	mtMQ4DmpesloAFYwGrC6+fEw10f79TTQrhYzASdk6glcdMXHyQ3SDRNjHBCuGelH
	V9xFEldeFNwL8/ogWp/xWX2tb8QfKksyN1Jd8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nK/w9cMuJ9z9CvqFQ6hKYvviRJwVP3GR
	fY8WLuqH4JyqdbC+cjel79i9t8fWo908UTA+Q3JBBGFnK//O+HjB+QbIaoP5ojuj
	MVhK87M/F7H7UKG2uHwyT6lCXdCjWFKCu7POd4HwFCzfIHjMmnnDzl77UlODGBO5
	+L6PofkvrL0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5CA7B26145;
	Mon, 26 Oct 2015 14:31:41 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B16DB26141;
	Mon, 26 Oct 2015 14:31:40 -0400 (EDT)
In-Reply-To: <vpqlhaqas8g.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Mon, 26 Oct 2015 10:34:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CCDCD4FA-7C0F-11E5-A078-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280205>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
>> This is the correct thing to do, really: we already specify LF as
>> field separator.
>
> I'm almost convinced that this is the right thing to do in the long run
> ("almost" because I'm not sure, not because I have arguments against). I
> agree with Junio that the commit message should be more convincing, but
> indeed, accepting LF and not CR is strange.

If there were a single character that denotes CRLF, I'd say that
including such a character in IFS would make sense on a system with
CRLF EOL convention.  But that is not the case.

On a platform with LF EOL convention, having LF in IFS makes sense,
due to two reasons.

 * read is not the only user of IFS.  Expressing "list of things"
   (pre bashism "shell array" days) by concatenating elements into a
   single string variable, separated with LF, and later iterating
   over them is a very common use case, e.g.

	LF='
        '
	list="$thing1"
	list="$list$LF$thing2"
	list="$list$LF$thing3"
        ...

	IFS=$LF
	for thing in $list
        do
        	...

   And including LF by default in IFS, especially when "things" can
   contain SP/HT, is handy.

 * It does not hurt on a platform with LF EOL convention to include
   LF in IFS, because you cannot have a "lone LF" in the middle of a
   line.  Presence of a single LF alone will terminate the current
   line and the bytes that follow it will be a next line.

No similarity argument can be made for a lone CR on a platform that
uses CRLF EOL convention.  A "lone CR" can appear in the middle of a
line without terminating the current line, as only a CR that is
immediately followed by a LF is the end of line, so you cannot make
the "It does not hurt" argument for including CR to IFS.  If you
have a variable in which "A^MB" is there, "set $variable" would
split them into two and assign B to $2, which is not what the
scripts would expect.

> However, is this the right thing to do in the maintainance branch? It
> does fix the issue, but does so in a rather intrusive way, so I'd need
> more arguments to be convinced that this is safe to merge in maint.

If this were the "right" thing in general for shell scripts on
systems with CRLF EOL convention, the implementation of the shell
language on such a platform would be doing that upon startup (or
upon "unset IFS"), and we wouldn't be having this discussion.  Don't
you think it is strange that individual applications like Git have
to set IFS to include CR?  I see it as a strong sign that this is
not a correct thing to do.

Intrusive does not begin to describe it.

I think the "right" thing for a shell implementation on a CRLF
platform to do is twofold.

 * Read
   http://pubs.opengroup.org/onlinepubs/9699919799/utilities/read.html
   and notice that the operation is defined as a two-step process.
   It is supposed to read an input line and then "The terminating
   <newline> (if any) shall be removed from the input".  And then
   "the result shall be split into fields" (at IFS boundaries).

   As POSIX does not say <newline> has to be a single octet with
   value 10 (the same way you are allowed to show CRLF when you call
   printf("\n")), a shell implementation would read CRLF terminated
   lines, and remove the terminating CRLF before doing the field
   splitting using IFS.

   This is why I said in my message to Dscho that IFS does not get
   into the picture.

 * Implement the "field splitting" (at IFS boundaries) with a small
   twist.  When the script/user included '\n' in IFS, split at LF
   but remove CR if there is one that immediately precedes the LF.

The latter would help if you did the previous "read is not the only
user of IFS" example like this instead:

        LF=$(printf '\n.')
        LF=${LF%.}
	list="$thing1"
	list="$list$LF$thing2"
	list="$list$LF$thing3"
        ...

	IFS=$LF
	for thing in $list
        do
        	...

and the platform 'printf' gave CRLF for "\n" (newline), resulting
the list to be concatenated with CRLF, not LF.

And this is why I asked Dscho if the shell is done correctly _for_
the platform.

> Sorry for being negative, and especially sorry since I'm partly guilty
> for the breakage. I just want to be sure that we don't break anything
> while repairing it (we already introduced this breakage while repairing
> another one...).

Something along the line of the following would be tolerable, even
though I think in the longer term, not just in Git land but in the
larger ecosystem to use POSIXy tools on Windows, the best solution
is to fix the shell so that it matches the expectation of the users
of its platform.

I say "something along the line of" here because I do not know how
the problematic shell behaves on the assignment command that stuffs
a lone CR into a variable.  It _might_ need a similar protection
against the shell feature "the last EOL is removed from the result
of command expansion", as I did in the above example, depending on
how incoherent the implementation is.  The implementation seems to
accept CRLF and LF in shell scripts proper just fine, but apparently
its implementation of "read" does not honor such platform EOL
convention, which caused this issue, and I don't know what it does
in the codepath that implements command expansion.

 git-rebase--interactive.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c42ba34..8f13a35 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -881,6 +881,7 @@ check_commit_sha () {
 check_bad_cmd_and_sha () {
 	retval=0
 	lineno=0
+	cr=$(printf "%c" 13)
 	while read -r command rest
 	do
 		lineno=$(( $lineno + 1 ))
@@ -888,6 +889,10 @@ check_bad_cmd_and_sha () {
 		"$comment_char"*|''|noop|x|exec)
 			# Doesn't expect a SHA-1
 			;;
+		"$cr")
+			# Windows port of shell not stripping the newline
+			# at the end of an empty line correctly.
+			;;
 		pick|p|drop|d|reword|r|edit|e|squash|s|fixup|f)
 			if ! check_commit_sha "${rest%%[ 	]*}" "$lineno" "$1"
 			then
