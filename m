From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH for maint] git-completion: fix zsh support
Date: Fri, 6 May 2011 00:27:45 -0500
Message-ID: <20110506052744.GA15132@elie>
References: <20110505185907.GD1377@goldbirke>
 <1304625144-5206-1-git-send-email-felipe.contreras@gmail.com>
 <20110505232503.GA7507@elie>
 <7v7ha44ej8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 07:28:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIDa6-00007R-56
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 07:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923Ab1EFF15 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 May 2011 01:27:57 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37714 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400Ab1EFF14 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2011 01:27:56 -0400
Received: by iwn34 with SMTP id 34so2411952iwn.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 22:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=w1unt3P8P/u+YREMYPXHZYrgZolT4JO+tfo/WrEdnxc=;
        b=KoQyIpEI4QIKSEeVit+qO84UsDU8rS9Db4Za6JF5XD9tUS6h4NrHVQ65TtOS4PF2G8
         Ntxs51UEAgpsghgnr+spVwivLqGVI26FEXmlecn9rMok+hTL949qX36apGAo4D9R5q9q
         jkTBIQ0ZYdlZSQxzz5jB78729CUENLsbVO27Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=kNvqoDNe25kl7qf2ebVtLmGv4hyxv9Bgfhg244qfkRiPl2TK5o+or7zutdQX5I3wkc
         u2LyS5MMHH0Q2dJ4KvtmZolOC+/b9ZZZ1p8T5FjkvulADhtNKPi/zu89PWYpyGnku67U
         Unn9dhGgrhNNrBfBA3QOzn1CcqUFiUcRwnzv0=
Received: by 10.42.133.1 with SMTP id f1mr2145353ict.129.1304659676235;
        Thu, 05 May 2011 22:27:56 -0700 (PDT)
Received: from elie (adsl-76-206-232-100.dsl.chcgil.sbcglobal.net [76.206.232.100])
        by mx.google.com with ESMTPS id ww2sm1109827icb.3.2011.05.05.22.27.54
        (version=SSLv3 cipher=OTHER);
        Thu, 05 May 2011 22:27:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v7ha44ej8.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172943>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Maybe simplest would be to use Szeder's fix + make the zsh version o=
f
>> _get_comp_words_by_ref not overwrite "words" at all?
>
> I do not use zsh myself, but it appears to me that these three-patch
> series can graduate and if real zsh users find problems after using i=
t
> they can be fixed independenty in-tree.
>
> Would that risk too many patch ping-pong among zsh users on 'master'?
> The "don't declare 'local words' in zsh" patch seems to be the right
> work-around for the peculiar semantics of "words" array, at least to =
me.

G=C3=A1bor's patches already work.  I don't think they will cause break=
age
or patch ping-pong.

I was trying to imagine Felipe's objection and all I could think of
was that it is not so appealing that _get_comp_words_by_ref is not
actually writing to "words".  For example, the following on top of
sg/completion-updates (=3D 3bee6a4) will print a greeting and the words
being completed when you press tab, rather than <foo> <bar> <baz>:

-- >8 --
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -469,7 +469,8 @@ _get_comp_words_by_ref ()
 			prev=3D${COMP_WORDS[COMP_CWORD-1]}
 			;;
 		words)
-			words=3D("${COMP_WORDS[@]}")
+			words=3D(foo bar baz)
+			echo >&2 Greetings
 			;;
 		cword)
 			cword=3D$COMP_CWORD
@@ -2614,6 +2615,9 @@ _git ()
=20
 	local cur cword prev
 	_get_comp_words_by_ref -n =3D: cur words cword prev
+
+	printf >&2 "WORDS: <%s>\n" "${words[@]}"
+
 	while [ $c -lt $cword ]; do
 		i=3D"${words[c]}"
 		case "$i" in
-- 8< --

In practice it works great since "words" already has the right
content, but maybe the "typeset -h" suggestion was motivated by a
desire to have something easier to explain.

I don't think that's a very strong reason to prevent the fix from
graduating, though I suppose I would be happy to see something like
the following on top at some point.

-- 8< --
Subject: completion: do not pretend to assign to special variable $word=
s on zsh

The special variable $words already has essentially the same meaning
as bash's COMP_WORDS on zsh.  While assigning one to the other appears
to work okay, as a no-op, that is actually an illusion --- the value
of $words can be changed in the _get_comp_words_by_ref function where
it is assigned, but after that function returns, $words is back to
normal.

Guard against future breakage by adding a comment mentioning this and
removing the redundant assignment.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/completion/git-completion.bash |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 10c1b83..8dfd97f 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -469,7 +469,10 @@ _get_comp_words_by_ref ()
 			prev=3D${COMP_WORDS[COMP_CWORD-1]}
 			;;
 		words)
-			words=3D("${COMP_WORDS[@]}")
+			# Nothing to do --- zsh's $words already contains
+			# the list of words being completed (and if we
+			# try to assign to it, the value wouldn't propagate
+			# from this function anyway).
 			;;
 		cword)
 			cword=3D$COMP_CWORD
--=20
1.7.5.1
