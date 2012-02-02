From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/4] completion: couple of cleanups
Date: Thu, 02 Feb 2012 11:48:08 -0800
Message-ID: <7v39atvwxz.fsf@alter.siamese.dyndns.org>
References: <1328145320-14071-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 20:48:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt2dk-0005sW-II
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 20:48:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757363Ab2BBTsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 14:48:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44395 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756949Ab2BBTsK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 14:48:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1187C6D3E;
	Thu,  2 Feb 2012 14:48:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5px0+zBfHK7GVs3l7FSmDpN9axk=; b=C/IsNG
	19E6JjyGb82WEkV+xmmGZ3TyXqxzARGPTYJNAanxQZrC7k7qwQ88LQWUZE6dMbuy
	l2SYFUOAL79WJmoRLdlTjnrDr3+R6o+6rINKgrZKKIRl8DpXnsKsQmP2xf5tlJ/c
	JP5U2pG1C+5KD9jaOLqBjnpJW78P00kfVd53w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WU3wqSCTsJGKhv3QTz8IFr8SZHDx4Ykw
	yCwkG59AdWtILDEHlW1JXf7aCqlccLykacrj2YW+83/36xz0285mnWn7ju7yNCMz
	52rFDUftEf17vJbt3gMXkevxBMJSEMO3r86biDUUV1EE/keLIOP7N1IzDRWNfNOp
	QyYt865k31w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0877F6D3D;
	Thu,  2 Feb 2012 14:48:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 73A306D3C; Thu,  2 Feb 2012
 14:48:09 -0500 (EST)
In-Reply-To: <1328145320-14071-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Thu, 2 Feb 2012 03:15:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D54E5520-4DD6-11E1-B29E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189683>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Felipe Contreras (4):
>   completion: be nicer with zsh
>   completion: simplify __git_remotes
>   completion: remove unused code
>   completion: simplify __gitcomp*

My understanding is that the two patches relayed by Jonathan cover the
first three entries, so here is my attempt to reconstruct the last one
without seeing a single bit from the v3 series ;-)


-- >8 --
From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] completion: simplify __gitcomp and __gitcomp_nl implementations

These shell functions are written in an unnecessarily verbose way;
simplify their "conditionally use $<number> after checking $# against
<number>" logic by using shell's built-in conditional substitution
facilities.

Also remove the first of the two assignments to IFS in __gitcomp_nl
that does not have any effect.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash |   19 +++----------------
 1 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8dd4e44..1ce1d6e 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -495,11 +495,8 @@ fi
 # 4: A suffix to be appended to each possible completion word (optional).
 __gitcomp ()
 {
-	local cur_="$cur"
+	local cur_="${3-$cur}"
 
-	if [ $# -gt 2 ]; then
-		cur_="$3"
-	fi
 	case "$cur_" in
 	--*=)
 		COMPREPLY=()
@@ -524,18 +521,8 @@ __gitcomp ()
 #    appended.
 __gitcomp_nl ()
 {
-	local s=$'\n' IFS=' '$'\t'$'\n'
-	local cur_="$cur" suffix=" "
-
-	if [ $# -gt 2 ]; then
-		cur_="$3"
-		if [ $# -gt 3 ]; then
-			suffix="$4"
-		fi
-	fi
-
-	IFS=$s
-	COMPREPLY=($(compgen -P "${2-}" -S "$suffix" -W "$1" -- "$cur_"))
+	local IFS=$'\n'
+	COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}"))
 }
 
 __git_heads ()
-- 
1.7.9.172.ge26ae
