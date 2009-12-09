From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Add a "fix" command to "rebase --interactive"
Date: Tue, 08 Dec 2009 22:16:25 -0800
Message-ID: <7vaaxsvfie.fsf@alter.siamese.dyndns.org>
References: <cover.1259934977.git.mhagger@alum.mit.edu>
 <4B192701.4000308@drmicha.warpmail.net> <vpqfx7qocwl.fsf@bauges.imag.fr>
 <7vws12r5v2.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0912041945161.21557@intel-tinevez-2-302>
 <20091205062708.6117@nanako3.lavabit.com>
 <7vd42t6f9i.fsf@alter.siamese.dyndns.org>
 <20091208121314.6117@nanako3.lavabit.com>
 <7viqchhl7h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 07:16:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIFr1-0007Co-15
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 07:16:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203AbZLIGQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 01:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbZLIGQh
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 01:16:37 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36415 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbZLIGQg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 01:16:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3B7B9A5FB5;
	Wed,  9 Dec 2009 01:16:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6i+/mca4psT2Afri/bFIFx6t0o0=; b=u7b8Re
	NURwHVH+OUKnTesNUroNnDRHaMd1gWEDKG/Z4JxZo5OC/uymz+C2ydG58IHgiOgO
	/hsJWsrntHwYY25KO4Fnu2bQ28hOScCHTBXsyqic27uHOge4GJw1SyDjemFeVNDF
	lv8C1SlwA0Hlcs+GwMCK5AL/+BF78/z31sXj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nntYg9ijeOKlH4oh18K9nMHFw0cpxfMi
	fju3ht2xckogSwsh7gPqtx/Eb5Dd27fAtMW5eaJQE7YyHcxIiC5d2McCiAEQNMnL
	DCDQoe1LYS1kR/NZXcQgtL2pMy8cI7yBg67Ty7TNBnJRVI4wh6bN5HPF0hqNEKNA
	nqDQXd4TJRQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D2B3AA5FB4;
	Wed,  9 Dec 2009 01:16:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 376A1A5FB1; Wed,  9 Dec 2009
 01:16:26 -0500 (EST)
In-Reply-To: <7viqchhl7h.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue\, 08 Dec 2009 01\:24\:50 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 67587B52-E48A-11DE-81CC-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134942>

Junio C Hamano <gitster@pobox.com> writes:

> Nanako Shiraishi <nanako3@lavabit.com> writes:
>
>> @@ -519,6 +521,43 @@ get_saved_options () {
>>  	test -f "$DOTEST"/rebase-root && REBASE_ROOT=t
>>  }
>>  
>> +# Rearrange the todo list that has both "pick sha1 msg" and
>> +# "pick sha1 !fixup/!squash msg" appears in it so that the latter
>> +# comes immediately after the former, and change "pick" to
>> +# "fixup"/"squash".
>> +rearrange_squash () {
>> +	sed -n -e 's/^pick \([0-9a-f]*\) !\(squash\) /\1 \2 /p' \
>> +		-e 's/^pick \([0-9a-f]*\) !\(fixup\) /\1 \2 /p' \
>> +		"$1" >"$1.sq"
>> +	test -s "$1.sq" || return
>> +
>> +	sed -e '/^pick [0-9a-f]* !squash /d' \
>> +		-e '/^pick [0-9a-f]* !fixup /d' \
>> +		"$1" |
>> +	(
>> +		used=
>> +		while read pick sha1 message
>> +		do
>> +	...
>> +		done >"$1.rearranged"
>> +	)
>> +	cat "$1.rearranged" >"$1"
>> +	rm -f "$1.sq"
>> +}
>
> The logic to move the lines seem to have been improved since the last
> round, which is good.  I've amended this to remove "$1.rearranged" as well.

Actually I think the logic in the version from the June is more correct;
doesn't this version drop commits that are marked as "squash! <message>"
but with a misspelled <message> part?  I think your old version, when it
didn't find a matching one in early part, left such an unmatched "fixup"
in place.

Here is a fix-up patch I think should be squashed in.  I added a test to
make sure that a mismatching "squash!" is kept in place.  Please double
check for sanity.

Thanks.

 git-rebase--interactive.sh   |   38 ++++++++++++++++----------------------
 t/t3415-rebase-autosquash.sh |   15 +++++++++++++++
 2 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c68cc5b..935e9e1 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -531,29 +531,23 @@ rearrange_squash () {
 		"$1" >"$1.sq"
 	test -s "$1.sq" || return
 
-	sed -e '/^pick [0-9a-f]* squash! /d' \
-		-e '/^pick [0-9a-f]* fixup! /d' \
-		"$1" |
-	(
-		used=
-		while read pick sha1 message
+	used=
+	while read pick sha1 message
+	do
+		case " $used" in
+		*" $sha1 "*) continue ;;
+		esac
+		echo "$pick $sha1 $message"
+		while read squash action msg
 		do
-			echo "$pick $sha1 $message"
-			while read squash action msg
-			do
-				case " $used" in
-				*" $squash "*)
-					continue ;;
-				esac
-				case "$message" in
-				"$msg"*)
-					echo "$action $squash $action! $msg"
-					used="$used$squash "
-					;;
-				esac
-			done <"$1.sq"
-		done >"$1.rearranged"
-	)
+			case "$message" in
+			"$msg"*)
+				echo "$action $squash $action! $msg"
+				used="$used$squash "
+				;;
+			esac
+		done <"$1.sq"
+	done >"$1.rearranged" <"$1"
 	cat "$1.rearranged" >"$1"
 	rm -f "$1.sq" "$1.rearranged"
 }
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index f7a0f7a..b63f4e2 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -55,4 +55,19 @@ test_expect_success 'auto squash' '
 	test 2 = $(git cat-file commit HEAD^ | grep first | wc -l)
 '
 
+test_expect_success 'misspelled auto squash' '
+	git reset --hard base &&
+	echo 1 >file1 &&
+	git add -u &&
+	test_tick &&
+	git commit -m "squash! forst"
+	git tag final-missquash &&
+	test_tick &&
+	git rebase --autosquash -i HEAD^^^ &&
+	git log --oneline >actual &&
+	test 4 = $(wc -l <actual) &&
+	git diff --exit-code final-missquash &&
+	test 0 = $(git rev-list final-missquash...HEAD | wc -l)
+'
+
 test_done
