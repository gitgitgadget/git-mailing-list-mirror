From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t4055 failure: see error
Date: Tue, 02 Oct 2012 12:00:40 -0700
Message-ID: <7vy5jo7l7r.fsf@alter.siamese.dyndns.org>
References: <7667682A-3BDB-484F-A3E4-0E5826FD2076@cs.rochester.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Charles Gernhardt <gernhard@cs.rochester.edu>
X-From: git-owner@vger.kernel.org Tue Oct 02 21:02:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ7ik-0006gJ-1Z
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 21:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752273Ab2JBTBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 15:01:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55878 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752050Ab2JBTAn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 15:00:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B62CC9F3A;
	Tue,  2 Oct 2012 15:00:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P5W53pNXBlGVEc28z7yN6Ol2H/A=; b=qDlSIY
	Io+ENtQao0kLyLroF9whGTamhd0mC91qT13m36Mta9qElwBLBZi7TaM2bCNHdRp5
	lZyNXzB4K9+lEcwS/sw/zBUnUoqKhhoohT9yCURBtjaAhD1O2noUYo1J3k0VSKD5
	ajL8vCOaqxpEmmA3MQKi+dEvtEdfEDPLLuqzI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pi98TRXa7WBNTz8cqJ06LRXTmb+8RKAT
	3diL0Sf4qOGf/UnUU3vPMsRB+WbpaAiOPPWt/3ldz74AIpyTwxhSts9KOHuBy791
	2bDJsYtUkQ4EmCJTOmq/BqDCPWS+xI96npeHaPH9rqXfUdwppYXKlNDJ4lXyY7c6
	s2rfTvZUhbA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CA4B9F39;
	Tue,  2 Oct 2012 15:00:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 05D079F35; Tue,  2 Oct 2012
 15:00:41 -0400 (EDT)
In-Reply-To: <7667682A-3BDB-484F-A3E4-0E5826FD2076@cs.rochester.edu> (Brian
 Charles Gernhardt's message of "Tue, 2 Oct 2012 08:18:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 767963E4-0CC3-11E2-916D-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206834>

Brian Charles Gernhardt <gernhard@cs.rochester.edu> writes:

> Another problem caused by BSD v GNU sed, I think.
>
> 	git cat-file blob HEAD:x |
> 	sed "/preline/a\
> 	ADDED" >x &&

Actually, I think what is happening is that inside "", the backslash
at the end of line is eaten by the shell together with that end of
line, so it is not BSD vs GNU, but it simply is that my quoting was
wrong.

This (disregarding the previous "TARGET" patch) may be a smaller fix.

 t/t4055-diff-context.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/t/t4055-diff-context.sh w/t/t4055-diff-context.sh
index 3527686..0f2dd40 100755
--- c/t/t4055-diff-context.sh
+++ w/t/t4055-diff-context.sh
@@ -28,7 +28,7 @@ test_expect_success 'setup' '
 	git commit -m initial &&
 
 	git cat-file blob HEAD:x |
-	sed "/preline/a\
+	sed "/preline/a\\
 	ADDED" >x &&
 	git update-index --add x &&
 	git commit -m next &&
