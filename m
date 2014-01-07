From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] stash: handle specifying stashes with spaces
Date: Tue, 07 Jan 2014 14:29:03 -0800
Message-ID: <xmqqiotvbf4g.fsf@gitster.dls.corp.google.com>
References: <1389082935-16159-1-git-send-email-oystwa@gmail.com>
	<xmqq7gabeiqo.fsf@gitster.dls.corp.google.com>
	<87ob3nphc5.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
	git@vger.kernel.org
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Tue Jan 07 23:29:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0f96-0002Ua-NZ
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 23:29:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754589AbaAGW3J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jan 2014 17:29:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34278 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753596AbaAGW3H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jan 2014 17:29:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC6D26151A;
	Tue,  7 Jan 2014 17:29:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PC2sjqoMsVob
	XLlA7MP9wO5Jwtk=; b=gdG11ijaWB2OzfUmJ5f5tUzKXDRx7EaCjwlvaqyJCDum
	P8lNdmjVafpqCqkNzHcmDYY1wgt+DGPrJFHFZDn/wS4fEIeBLhg6odqbOgljKVsq
	LfJ4fFb0h3g9L0FmHIhCDW35Qyc7naHVxUg4MoLrxEwIQsArzWLxs1pGqIngPg0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=C6TMtn
	aQEKD6sCDVL7ZLyYBE7aHr1mEwAJodDEjoskXWkiC9cs4tKGDc8so4L/QS3FLjHw
	2WPfKPXshuyEOYx7RaiWI9hCUIODPbFkN1KBdjwcBojIi1anw2EOzHAIcFn9l2gD
	R0lCh7OnWmIFchk8JBayOkFmLJrAqHhrrsPkQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DEA661519;
	Tue,  7 Jan 2014 17:29:06 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E16E261518;
	Tue,  7 Jan 2014 17:29:05 -0500 (EST)
In-Reply-To: <87ob3nphc5.fsf@thomasrast.ch> (Thomas Rast's message of "Tue, 07
	Jan 2014 23:17:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1E396B68-77EB-11E3-A7AB-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240176>

Thomas Rast <tr@thomasrast.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> =C3=98ystein Walle <oystwa@gmail.com> writes:
>>
>>> +	git stash &&
>>> +	test_tick &&
>>> +	echo cow > file &&
>>> +	git stash &&
>>> +	git stash apply "stash@{Thu Apr 7 15:17:13 2005 -0700}" &&
>>
>> This is brittle.  If new tests are added before this, the test_tick
>> will give you different timestamp and this test will start failing.
>>
>> Perhaps grab the timestamp out of the stash that was created [...]
>
> Hmm, now that I stare at this, why not simply use something like
>
>   git stash apply "stash@{ 0 }"
>
> It seems to refer to the same as stash@{0} as one would expect, while
> still triggering the bug with unpatched git-stash.

Yeah, that is fine as well.  For the record, here is what I
tentatively queued.

-- >8 --
=46rom: =C3=98ystein Walle <oystwa@gmail.com>
Date: Tue, 7 Jan 2014 09:22:15 +0100
Subject: [PATCH] stash: handle specifying stashes with $IFS

When trying to pop/apply a stash specified with an argument
containing IFS whitespace, git-stash will throw an error:

    $ git stash pop 'stash@{two hours ago}'
    Too many revisions specified: stash@{two hours ago}

This happens because word splitting is used to count non-option
arguments. Make use of rev-parse's --sq option to quote the arguments
for us to ensure a correct count. Add quotes where necessary.

Also add a test that verifies correct behaviour.

Helped-by: Thomas Rast <tr@thomasrast.ch>
Signed-off-by: =C3=98ystein Walle <oystwa@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-stash.sh     | 14 +++++++-------
 t/t3903-stash.sh | 12 ++++++++++++
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 1e541a2..f0a94ab 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -358,7 +358,7 @@ parse_flags_and_rev()
 	i_tree=3D
 	u_tree=3D
=20
-	REV=3D$(git rev-parse --no-flags --symbolic "$@") || exit 1
+	REV=3D$(git rev-parse --no-flags --symbolic --sq "$@") || exit 1
=20
 	FLAGS=3D
 	for opt
@@ -376,7 +376,7 @@ parse_flags_and_rev()
 		esac
 	done
=20
-	set -- $REV
+	eval set -- $REV
=20
 	case $# in
 		0)
@@ -391,13 +391,13 @@ parse_flags_and_rev()
 		;;
 	esac
=20
-	REV=3D$(git rev-parse --quiet --symbolic --verify $1 2>/dev/null) || =
{
+	REV=3D$(git rev-parse --quiet --symbolic --verify "$1" 2>/dev/null) |=
| {
 		reference=3D"$1"
 		die "$(eval_gettext "\$reference is not valid reference")"
 	}
=20
-	i_commit=3D$(git rev-parse --quiet --verify $REV^2 2>/dev/null) &&
-	set -- $(git rev-parse $REV $REV^1 $REV: $REV^1: $REV^2: 2>/dev/null)=
 &&
+	i_commit=3D$(git rev-parse --quiet --verify "$REV^2" 2>/dev/null) &&
+	set -- $(git rev-parse "$REV" "$REV^1" "$REV:" "$REV^1:" "$REV^2:" 2>=
/dev/null) &&
 	s=3D$1 &&
 	w_commit=3D$1 &&
 	b_commit=3D$2 &&
@@ -408,8 +408,8 @@ parse_flags_and_rev()
 	test "$ref_stash" =3D "$(git rev-parse --symbolic-full-name "${REV%@*=
}")" &&
 	IS_STASH_REF=3Dt
=20
-	u_commit=3D$(git rev-parse --quiet --verify $REV^3 2>/dev/null) &&
-	u_tree=3D$(git rev-parse $REV^3: 2>/dev/null)
+	u_commit=3D$(git rev-parse --quiet --verify "$REV^3" 2>/dev/null) &&
+	u_tree=3D$(git rev-parse "$REV^3:" 2>/dev/null)
 }
=20
 is_stash_like()
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index debda7a..5b79b21 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -673,4 +673,16 @@ test_expect_success 'store updates stash ref and r=
eflog' '
 	grep quux bazzy
 '
=20
+test_expect_success 'handle stash specification with spaces' '
+	git stash clear &&
+	echo pig >file &&
+	git stash &&
+	stamp=3D$(git log -g --format=3D"%cd" -1 refs/stash) &&
+	test_tick &&
+	echo cow >file &&
+	git stash &&
+	git stash apply "stash@{$stamp}" &&
+	grep pig file
+'
+
 test_done
--=20
1.8.5.2-419-g5ca323a
