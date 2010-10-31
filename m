From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 04/10] t1502 (rev-parse --parseopt): test exit code from "-h"
Date: Sun, 31 Oct 2010 02:35:49 -0500
Message-ID: <20101031073549.GE11483@burratino>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
 <1286136014-7728-16-git-send-email-newren@gmail.com>
 <20101031014654.GC29456@burratino>
 <7vr5f73umz.fsf@alter.siamese.dyndns.org>
 <20101031072640.GA11483@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	avarab@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 31 08:36:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCSSV-0005Jt-8G
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 08:36:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008Ab0JaHgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 03:36:01 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64414 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442Ab0JaHgB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 03:36:01 -0400
Received: by gyg4 with SMTP id 4so2657599gyg.19
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 00:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=kzIbw8yG5bA0iQNyiWv6bD7A2O/dtwJ3mRKWeyRULyY=;
        b=fP9SvAxav2qUyzjdwagIP6Qh6dYwQ4ZNUxGt02HvdWnYINA0kLq8HFNhTSviEcaNAS
         pKXqFtyucgBlnzpft8e+3LNxMyRiIeHOs4PIOe3sdYXuRgtVb3b80r+JoGN0FHS9aYP4
         H6Aa/yhjaJnHPFEnAbox7d/zaEbcjSdOn/iR0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=H14olpa1FGW/WN8k2fH28E4UN416DrqcWrSOWh3sRoTqFwiq3jJVsmSZeOIhIhcqA1
         QEFpQ1lxVHmQX0XENaQHgBM8vSHo3Ccg+1E9TkK2PNbfMyZRsEYr9UIOdxrPTmhUQMZy
         CUOATqukE1O3VByv1dkUheMsMW+NX1kvBAisg=
Received: by 10.150.53.7 with SMTP id b7mr118711yba.0.1288510559447;
        Sun, 31 Oct 2010 00:35:59 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id q14sm5062826ybk.7.2010.10.31.00.35.56
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 31 Oct 2010 00:35:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101031072640.GA11483@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160423>

rev-parse --parseopt exits with code 129 (usage error) when asked
to dump usage with -h on behalf of another command.  Scripts can
take advantage of this to avoid trying to parse usage information
as though it were the regular output from some git command.

Noticed with an &&-chaining tester.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t1502-rev-parse-parseopt.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index b3195c4..1efd7f7 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -40,7 +40,7 @@ extra1    line above used to cause a segfault but no longer does
 EOF
 
 test_expect_success 'test --parseopt help output' '
-	git rev-parse --parseopt -- -h > output < optionspec
+	test_expect_code 129 git rev-parse --parseopt -- -h > output < optionspec &&
 	test_cmp expect output
 '
 
-- 
1.7.2.3.557.gab647.dirty
