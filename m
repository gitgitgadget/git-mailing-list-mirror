From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] If `egrep` is aliased, temporary disable it in
 bash.completion
Date: Thu, 29 Nov 2012 09:33:53 -0800
Message-ID: <7vk3t4qpoe.fsf@alter.siamese.dyndns.org>
References: <20121129151418.GA19169@redhat.com>
 <7vpq2wqr3v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Adam Tkac <atkac@redhat.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 18:34:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te805-0007iF-10
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 18:34:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316Ab2K2Rd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 12:33:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64165 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751355Ab2K2Rd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 12:33:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35A9E9791;
	Thu, 29 Nov 2012 12:33:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wG52yKqMAEh0f3A/hQ+Uh/Sl/RY=; b=gMCMka
	/PivxPYYAcHRekKpnwoW7RhRkSyw8FZVoRlzYiGLrkAp15yQQI64z1FKGcJWoaGv
	tN8LjrKDLhuIKQ6yMU/LHNUl4olSVPC9DaLv2gEL8Wh3yaR/4gBBS3Niv3EmNUSs
	0jFSBTAAKcmMe7L2Py4ultrLtrf6XAV32sGik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FAEifEPEgyGmmdJysioZUcX6SiT9I/PW
	x3j4RgclIP377tjnYuXOEYjkDCTpZMvfIJ7p1ZRhTBK6e7DQCAqBD2L9oUGfJVzG
	ykAOOtWXRALCUQjsZZYisG76gU0GmoL1VYpPwivzu4RAESTcTdgMpxKyng/qWYaN
	1LKBF430VMw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F8FC9790;
	Thu, 29 Nov 2012 12:33:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 461A0978E; Thu, 29 Nov 2012
 12:33:55 -0500 (EST)
In-Reply-To: <7vpq2wqr3v.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 29 Nov 2012 09:03:00 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F2F961A8-3A4A-11E2-9E7A-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210850>

Junio C Hamano <gitster@pobox.com> writes:

> Adam Tkac <atkac@redhat.com> writes:
>
>> Subject: Re: [PATCH v2] If `egrep` is aliased, temporary disable it in bash.completion
>
> The code does not seem to do anything special if it is not aliased,
> though, so "If ..." part does not sound correct; perhaps you meant
> "just in case egrep is aliased to something totally wacky" or
> something?
>
> The script seems to use commands other than 'egrep' that too can be
> aliased to do whatever unexpected things.  How does this patch get
> away without backslashing them all, like
>
> 	\echo ...
>         \sed ...
>         \test ...
>         \: comment ...
> 	\git args ...
>
> and still fix problems for users?  Can't the same solution you would
> give to users who alias one of the above to do something undesirable
> be applied to those who alias egrep?
>
> Puzzled...

Sorry for having been more snarky than necessary (blame it to lack
of caffeine).  What I was trying to get at were:

 * I have this suspicion that this patch exists only because you saw
   somebody who aliases egrep to something unexpected by the use of
   it in this script, and egrep *happened* to be the only such
   "unreasonable" alias.  The reporter may not have aliased echo or
   sed away, or the aliases to these command *happened* to produce
   "acceptable" output (even though it might have been slightly
   different from unaliased one, the difference *happened* not to
   matter for the purpose of this script).

 * To the person who observes the same aliasing breakage due to his
   aliasing sed to something else, you would solve his problem by
   telling him "don't do that, then".  If that is the solution, why
   wouldn't it work for egrep?

 * The next person who aliased other commands this script uses in
   such a way that the behaviour of the alias differs sufficiently
   from the unaliased version, you will have to patch the file
   again, with the same backslashing.  This patch is not a solution,
   but a band-aid that only works for a particular case you
   *happened* to have seen.

 * A complete solution that follows the direction this patch
   suggests would involve backslashing *all* commands that can
   potentially aliased away.  Is that really the direction we would
   want to go in (answer: I doubt it)?  Is that the only approach to
   solve this aliasing issue (answer: I don't know, but we should
   try to pursue it before applying a band-aid that is not a
   solution)?

Is there a way to tell bash "do not alias-expand from here up to
there"?  Perhaps "shopt -u expand_aliases" upon entry and restore
its original value when we exit, or something?

IOW, something along this line?

 contrib/completion/git-completion.bash | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git i/contrib/completion/git-completion.bash w/contrib/completion/git-completion.bash
index 0b77eb1..193f53c 100644
--- i/contrib/completion/git-completion.bash
+++ w/contrib/completion/git-completion.bash
@@ -23,6 +23,14 @@
 #    3) Consider changing your PS1 to also show the current branch,
 #       see git-prompt.sh for details.
 
+if shopt -q expand_aliases
+then
+	_git__aliases_were_enabled=yes
+else
+	_git__aliases_were_enabled=
+fi
+shopt -u expand_aliases
+
 case "$COMP_WORDBREAKS" in
 *:*) : great ;;
 *)   COMP_WORDBREAKS="$COMP_WORDBREAKS:"
@@ -2504,3 +2512,8 @@ __git_complete gitk __gitk_main
 if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
 __git_complete git.exe __git_main
 fi
+
+if test -n "$_git__aliases_were_enabled"
+then
+	shopt -s expand_aliases
+fi
