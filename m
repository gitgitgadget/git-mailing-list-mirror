From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] fast-import: let importers retrieve blobs
Date: Fri, 03 Dec 2010 12:17:57 -0800
Message-ID: <7vsjyeobka.fsf@alter.siamese.dyndns.org>
References: <1287147256-9457-1-git-send-email-david.barr@cordelta.com>
 <20101128194131.GA19998@burratino> <20101128194501.GD19998@burratino>
 <201012031130.06008.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Dec 03 21:18:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POc5I-0000s2-SZ
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 21:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753178Ab0LCUSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 15:18:18 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879Ab0LCUSR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 15:18:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 447592EA6;
	Fri,  3 Dec 2010 15:18:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OJtDPoid2jSZMrvd8mWNaRYx1CE=; b=fbOj7f
	XkbJo9cwE6rbDQc8vjijCHvo6eSWE12m7A9+bQBhpfTvj788ipwWWDrq1F/PG/Lc
	/lDxcMqxIIBNLFQtj3gL9l1Zctj/RuIgvKNbR1SEPpSuf9LfLNBsYys92c43SYed
	SOvrGGLU0tl+G69UdJwL0/noCjhLMRW8h6I9o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Eh82ejYwdoo0JuxXQpcEKxfWY9m3x2sa
	fI29qFuwt+QbJhHsxIrjNEHCcNVzHHxvWD7gfXhH5NrkUSwSRTzr6MCUXfgNksK2
	PlnvctjBWFz68DQYpGXy7wo4Ec48C7ZR6wRQx06lJyisyWugyYeCRAdtxxQXD4aa
	nfL6WxHxMn0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ABFE82E90;
	Fri,  3 Dec 2010 15:18:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3BF232E8F; Fri,  3 Dec 2010
 15:18:18 -0500 (EST)
In-Reply-To: <201012031130.06008.trast@student.ethz.ch> (Thomas Rast's
 message of "Fri\, 3 Dec 2010 11\:30\:05 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7DA11C88-FF1A-11DF-B28F-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162843>

Thomas Rast <trast@student.ethz.ch> writes:

> But from the tests I get back
>
>   dd: opening `/dev/stdin': No such file or directory
>   error: git-fast-import died of signal 13
>   not ok - 110 R: copy using cat-file
>
> In any case I cannot see a reason to use this construct: 'dd' reads
> from stdin by default, so you could just leave away the option.

Thanks for testing and reporting.
-- >8 --
Subject: t9300: remove unnecessary use of /dev/stdin

We really shouldn't be using these funny /dev/* files that did not exist
in V7 UNIX in our tests when we do not have to.

Output from

    $ git grep -n -e /dev/ --and --not -e /dev/null t/

tells us that, aside from use of /dev/urandom in apache.conf used in http
tests, "dd if=/dev/stdin" added recently to t/t9300-fast-import.sh are the
only offenders, so removing them should be straightforward.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 t/t9300-fast-import.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index d615d04..055ddc6 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1794,7 +1794,7 @@ test_expect_success PIPE 'R: copy using cat-file' '
 
 	read blob_id type size <&3 &&
 	echo "$blob_id $type $size" >response &&
-	dd if=/dev/stdin of=blob bs=$size count=1 <&3 &&
+	dd of=blob bs=$size count=1 <&3 &&
 	read newline <&3 &&
 
 	cat <<EOF &&
@@ -1845,7 +1845,7 @@ test_expect_success PIPE 'R: print blob mid-commit' '
 		EOF
 
 		read blob_id type size <&3 &&
-		dd if=/dev/stdin of=actual bs=$size count=1 <&3 &&
+		dd of=actual bs=$size count=1 <&3 &&
 		read newline <&3 &&
 
 		echo
@@ -1880,7 +1880,7 @@ test_expect_success PIPE 'R: print staged blob within commit' '
 		echo "cat-blob $to_get" &&
 
 		read blob_id type size <&3 &&
-		dd if=/dev/stdin of=actual bs=$size count=1 <&3 &&
+		dd of=actual bs=$size count=1 <&3 &&
 		read newline <&3 &&
 
 		echo deleteall
