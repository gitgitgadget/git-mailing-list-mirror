From: Lex Spoon <lex@lexspoon.org>
Subject: Re: [PATCHv1 3/3] git-p4: fixing --changes-block-size handling
Date: Sun, 7 Jun 2015 12:33:20 -0400
Message-ID: <CALM2SnbVY1baAONo3o2gb2NS+rDSsyhkPffP5EJZKU1MDA7q9w@mail.gmail.com>
References: <1433672505-11940-1-git-send-email-luke@diamand.org>
	<1433672505-11940-4-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sun Jun 07 18:33:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1dVm-0004Fw-99
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jun 2015 18:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbbFGQdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2015 12:33:22 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36374 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbbFGQdU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2015 12:33:20 -0400
Received: by pabqy3 with SMTP id qy3so79331926pab.3
        for <git@vger.kernel.org>; Sun, 07 Jun 2015 09:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=TVQ/oRcQFjN2Mlr6UfnTrfaXcF3VXrEdyD8WYRG1nAM=;
        b=Kj3T8HF5nZxMtJvVb+o2+bhVR4Zf631lFYZzRb5A+iF0GncXzjhq39OahXIeimzNWU
         4ACkNAqQmKVadGwDwy9maPxNSrjwCYr5AkNsQ0gLrnKy3/quMHtFpVsbMGBVbopsWz/T
         mDFZ0x0UsVe+4QyQyqshOmD3z4ZhrzvN9S0PBxzGv3gqlU442BC05/LSyeFUPWScV2BX
         y+shHVBZH0O1xyqIZNi9SegcVXyRysnTJMkhUdw2JCykQkpa0/1KpEWbKDqNmZXtDDor
         Z/AlIC7A45+q2V+w/wtBRivQkCQwHKR6Wx9iRX2Dl1ZqBKl7YRUQAFpyGdKrKP7PRS0D
         iClA==
X-Received: by 10.68.209.227 with SMTP id mp3mr22470844pbc.100.1433694800319;
 Sun, 07 Jun 2015 09:33:20 -0700 (PDT)
Received: by 10.70.25.132 with HTTP; Sun, 7 Jun 2015 09:33:20 -0700 (PDT)
In-Reply-To: <1433672505-11940-4-git-send-email-luke@diamand.org>
X-Google-Sender-Auth: fhIOffTJtOFICApWOhAw1zXl8KQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270974>

The implementation looks fine, especially given the test cases that
back it up. I am only curious why the block size is set to a default
of None. To put it as contcretely as possible: is there any expected
configuration where None would work but 500 would not? We know there
are many cases of the other way around, and those cases are going to
send users to StackOverflow to find the right workaround.

Dropping the option would also simplify the code in several places.
The complex logic around get_another_block could be removed, and
instead there could be a loop from start to mostRecentCommit by
block_size. Several places that check "if not block_size" could just
choose the other branch.

Lex Spoon
