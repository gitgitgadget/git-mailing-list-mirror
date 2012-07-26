From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] builtin-commit.c: Not add duplicate S-o-b when commit
Date: Thu, 26 Jul 2012 15:15:24 +0800
Message-ID: <CANYiYbH0Jfk0LLp8HXVEamD0uRzM2OGJCE8W4h_UoDLh1pMVHA@mail.gmail.com>
References: <ee08efceaa3f015732a19d49eb96bdeeaaf3d609.1343282283.git.worldhello.net@gmail.com>
	<7vy5m781j5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 09:15:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuIIc-0007Ci-Nj
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 09:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250Ab2GZHP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 03:15:28 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:56727 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab2GZHPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 03:15:25 -0400
Received: by gglu4 with SMTP id u4so1614092ggl.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 00:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HmTKidnneHwn3i99B81dQwnGnyU9iKIm/pHJbTLjoUk=;
        b=EdVDlJsfDb5d1sYXnkrc0aXvKslU5Kun/+cEsP/o9m8xAtcJeCnxaQCaE4VxGWGfLc
         Wx8se6bjdfH3DwFHWrUIeN7U4hhbe+nnqvlEd/t/Za4RYkamEYQJrEBccpZQI/OSiBWD
         fdXFSQS9iRLS9v2dl2HB4PFQ62EQHHAP5W593ilvuSbO6UM7QLhjAqzjkTnyk4YUYT9N
         2FBCtQANMCwmBFTkPWHLE4P7ZpagYqfrDwXWQbsdkqqxK1zbFkIiPxmmuKmRShPtm1IE
         sQsV9odZr77/jSfTGC/6ZbrICxAwXeEAUxcLQhqIcytQ+hrlZ5plU5kEwqlCbat2T8Oi
         uSFQ==
Received: by 10.43.126.1 with SMTP id gu1mr27703649icc.6.1343286924482; Thu,
 26 Jul 2012 00:15:24 -0700 (PDT)
Received: by 10.50.237.38 with HTTP; Thu, 26 Jul 2012 00:15:24 -0700 (PDT)
In-Reply-To: <7vy5m781j5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202229>

2012/7/26 Junio C Hamano <gitster@pobox.com>:
> After stating the observation like the above, please make it a habit
> to say "which is bad because...", if you think it is a bad behaviour
> and the patch is about fixing it.

Indead before I start, I examine git-commit and git-am, and find
the behaviours of the two commands are different.

"git commit -s" checks the last line of the footer, while "git -am"
checks the last S-o-b. E.g. original commit X:

    commit log...

    Signed-off-by: A
    Signed-off-by: B
    Reported-by: C

When user B amend the commit, the amended commit Y looks like:

    commit log...

    Signed-off-by: A
    Signed-off-by: B
    Reported-by: C
    Signed-off-by: B

While if the original commit X send to user B by patch, and
user B run command "git am -s", the commit would be:

    Signed-off-by: A
    Signed-off-by: B
    Reported-by: C

So I guess duplicate S-o-b is not intentional.

I use an alias for commit:

    git config --global alias.ci "commit -s"

And will encounter duplicate S-o-b issues frequently, especially
format-patch/send-email workflow.

-- 
Jiang Xin
