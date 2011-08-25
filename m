From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] check-ref-format --print: Normalize refnames that start
 with slashes
Date: Thu, 25 Aug 2011 13:42:49 -0700
Message-ID: <7v39gpjk8m.fsf@alter.siamese.dyndns.org>
References: <7v39gpmk3x.fsf@alter.siamese.dyndns.org>
 <1314299964-21866-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, cmn@elego.de
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Aug 25 22:42:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwglM-0003D5-LJ
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 22:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754293Ab1HYUmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 16:42:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64581 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754142Ab1HYUmw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 16:42:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 737624569;
	Thu, 25 Aug 2011 16:42:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=LdhAVuLHYRqUzzPalpi1LzWBwsE=; b=fAk8X2I+eivb10mjqm0s
	2MOXZMKfRWpi+RNu2Vu95m+JkDpkxjisvPsTjZ8wMdR3XRARK4usHzj1AjMO1BIX
	bWOCRakA7nqtTTw9u0Ut+2g2RR/IyPFyrGqDJe5fZq/Njj6Q8uZGrlxnYnevqTs4
	+lF0Dujvf5aqyHPKgjvrhsg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=FJNLZ2puxcwlLvZkWDhTPtd3fqDXuk26jPmed8lWWVh1Hp
	lJVIMaSfsIfOlT/TMvUw9Bt3uXPyS5aIM/i/78J5Q6exdzewBdZrQw7bJW2MKg0k
	uPCMQnGI18VMza5TrQ6Qkhpjm20PSoCHB8JojGQC9xJNLuV2/0Vk209lJtVUA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A2644568;
	Thu, 25 Aug 2011 16:42:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5CF74567; Thu, 25 Aug 2011
 16:42:50 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CCA0CC5A-CF5A-11E0-ACB9-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180114>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> And add tests that such refnames are accepted and normalized
> correctly.

Thanks. I think this is a bit simpler, though...

 builtin/check-ref-format.c  |    4 +---
 t/t1402-check-ref-format.sh |    1 -
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git b/builtin/check-ref-format.c a/builtin/check-ref-format.c
index 7118021..0723cf2 100644
--- b/builtin/check-ref-format.c
+++ a/builtin/check-ref-format.c
@@ -21,10 +21,8 @@ static const char builtin_check_ref_format_usage[] =
 static void collapse_slashes(char *dst, const char *src)
 {
 	char ch;
-	char prev = '\0';
+	char prev = '/';
 
-	while (*src == '/')
-		src++;
 	while ((ch = *src++) != '\0') {
 		if (prev == '/' && ch == prev)
 			continue;
diff --git b/t/t1402-check-ref-format.sh a/t/t1402-check-ref-format.sh
index e6fafb2..7563043 100755
--- b/t/t1402-check-ref-format.sh
+++ a/t/t1402-check-ref-format.sh
@@ -31,7 +31,6 @@ valid_ref 'heads/foo@bar'
 invalid_ref 'heads/v@{ation'
 invalid_ref 'heads/foo\bar'
 
-
 test_expect_success "check-ref-format --branch @{-1}" '
 	T=$(git write-tree) &&
 	sha1=$(echo A | git commit-tree $T) &&
