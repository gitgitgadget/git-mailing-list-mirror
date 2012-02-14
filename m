From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] git-p4: add initial support for RCS keywords
Date: Tue, 14 Feb 2012 14:58:00 -0800
Message-ID: <7vvcn93tvr.fsf@alter.siamese.dyndns.org>
References: <1329258835-17223-1-git-send-email-luke@diamand.org>
 <1329258835-17223-2-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>,
	Eric Scouten <eric@scouten.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue Feb 14 23:58:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxRK5-0006D3-Va
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 23:58:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932618Ab2BNW6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 17:58:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56231 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932117Ab2BNW6D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 17:58:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D4317919;
	Tue, 14 Feb 2012 17:58:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YWxCA9HSTeG3hryw4u0jbAKILZ8=; b=idSnoT
	bT/O+MZ6HJli+TlKJ8yDoDJqn//GPUxnaYhDY8h7orL/iWM0s/6lGuF502FM2lW5
	htB8Lqru8FPF6CtcEiuTMsSvFdaC55HyQ1T8e/4ztyzSx8k9+zNZJTjeT2wFIijL
	LS46ushFGQY4LPIlPXWVUKqFEXC6DGTBTLyYI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L7AbcaKL+8Sm1PBTG9Cc3uoDE5REk8P1
	DA0szv2+3ECORxcyktBYUyzE8fRtQp1JInGe+z1Cjiy1xb93evvi/tGat2T2bhuk
	si4iMGHt190iqkqKzHQxLoQqx74RT19HFdAomVTmBMqoGH/3ZYYt759mD010fxEX
	JWTkEGZqKvs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 031497918;
	Tue, 14 Feb 2012 17:58:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 850797916; Tue, 14 Feb 2012
 17:58:02 -0500 (EST)
In-Reply-To: <1329258835-17223-2-git-send-email-luke@diamand.org> (Luke
 Diamand's message of "Tue, 14 Feb 2012 22:33:55 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5910E530-575F-11E1-9428-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190792>

It seems that this seems to have been further refactored by introducing a
couple of new helper functions.  I'll replae what was queued in 'pu' with
this, with the following minor fix-ups.

Thanks.

 t/t9810-git-p4-rcs.sh |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t9810-git-p4-rcs.sh b/t/t9810-git-p4-rcs.sh
index 77eebd2..3013bab 100755
--- a/t/t9810-git-p4-rcs.sh
+++ b/t/t9810-git-p4-rcs.sh
@@ -201,7 +201,7 @@ test_expect_success 'cleanup after failure 2' '
 	)
 '
 
-create_kw_file() {
+create_kw_file () {
 	cat <<\EOF >"$1"
 /* A file
 	Id: $Id$
@@ -226,7 +226,7 @@ test_expect_success 'add kwfile' '
 	)
 '
 
-p4_append_to_file() {
+p4_append_to_file () {
 	f=$1 &&
 	p4 edit -t ktext "$f" &&
 	echo "/* $(date) */" >>"$f" &&
@@ -248,7 +248,7 @@ test_expect_success 'cope with rcs keyword expansion damage' '
 		old_lines=$(wc -l <kwfile1.c) &&
 		perl -n -i -e "print unless m/Revision:/" kwfile1.c &&
 		new_lines=$(wc -l <kwfile1.c) &&
-		expr $new_lines == $old_lines - 1 &&
+		test $new_lines = $(($old_lines - 1)) &&
 
 		git add kwfile1.c &&
 		git commit -m "Zap an RCS kw line" &&
@@ -278,12 +278,12 @@ test_expect_success 'cope with rcs keyword file deletion' '
 		p4 add -t ktext kwdelfile.c &&
 		p4 submit -d "Add file to be deleted" &&
 		cat kwdelfile.c &&
-		grep -q 1 kwdelfile.c
+		grep 1 kwdelfile.c
 	) &&
 	"$GITP4" clone --dest="$git" //depot &&
 	(
 		cd "$git" &&
-		grep -q Revision kwdelfile.c &&
+		grep Revision kwdelfile.c &&
 		git rm -f kwdelfile.c &&
 		git commit -m "Delete a file containing RCS keywords" &&
 		git config git-p4.skipSubmitEdit true &&
