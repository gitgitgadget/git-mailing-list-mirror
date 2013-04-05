From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 7/7] sha1_file: write ref_name to link object
Date: Fri, 5 Apr 2013 12:33:21 +0530
Message-ID: <CALkWK0m5q7gW0LPdJVWbZTkTnHrFBYyfRxFMnRMtyuSePtLL9Q@mail.gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com> <1365100243-13676-8-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 05 09:04:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UO0hV-0006dN-M7
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 09:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161537Ab3DEHEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 03:04:04 -0400
Received: from mail-ia0-f182.google.com ([209.85.210.182]:41551 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482Ab3DEHED (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 03:04:03 -0400
Received: by mail-ia0-f182.google.com with SMTP id u8so2937094iag.13
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 00:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=PosrxZuMWjQehkwiMLMUO/e2Vp++x54h5MjKfZ1Vhl4=;
        b=lItF90l+A8WxaGHX65wjwTMiJxi6YyxVseI5FQ/PhCkbquutjmfAFq/J9r9x3YlLmo
         iJNSx9FJ2Sc3maQW4rYNcQwVIcDPT/KXm281A4x5kG9NupF9yHgD78Wlrhn2T9UU9VfD
         /eTblOd4KgRpYHtR2GuaKn+8CVJZix8JwMvOwJIGme+GGsQPEsO83WJwmwFFI9UPVH1k
         P5PYk+C1+u+E5uGjEvwH2V40Ntoue4dOOUj0IW0u9+fpjcO+dvmiMBAl3bKxazhAwkyh
         ByAqMzhx1UA3DIWaK5D0pnY46Z3I1tOnuNE3/5r0SbubLEB3ueaTxA6iv1xPIW6e37Ey
         JUAg==
X-Received: by 10.50.117.3 with SMTP id ka3mr399937igb.107.1365145441992; Fri,
 05 Apr 2013 00:04:01 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Fri, 5 Apr 2013 00:03:21 -0700 (PDT)
In-Reply-To: <1365100243-13676-8-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220151>

Ramkumar Ramachandra wrote:
> Great.  Now, we just have to write refs/modules/<branch>/* at
> commit-time.

Actually, we have to update things in refs/modules/ everytime we
update things in refs/heads/.  In the case of a 'git branch -M' for
example, refs/heads/<oldname> is rewritten to refs/heads/<newname>:
similarly, refs/modules/<oldname>/ needs to be moved to
refs/modules/<newname>/.

There is one special case worth mentioning.  Let's say I'm committing
changes to link objects to a detached HEAD, b8bb3f.  Then, I write
refs/modules/b8bb3f/ at commit-time.  A subsequent 'checkout -b' that
updates refs/heads/<newbranch> will just have to move
refs/modules/b8bb3f/ to refs/modules/<newbranch>/.

The caveat is that I might commit to the detached HEAD and leave it
hanging around until the next gc.  So, gc will need to remove
refs/modules/b8bb3f/ too, but that's not a pressing issue at the
moment.
