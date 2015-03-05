From: Francis Moreau <francis.moro@gmail.com>
Subject: Possible bug with git-rebase and post-rewrite hook
Date: Thu, 05 Mar 2015 14:55:12 +0100
Message-ID: <54F86040.8060205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 05 14:55:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTWFG-0005RH-M9
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 14:55:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754733AbbCENzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 08:55:16 -0500
Received: from mail-wi0-f172.google.com ([209.85.212.172]:44176 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbbCENzP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 08:55:15 -0500
Received: by wivr20 with SMTP id r20so6929800wiv.3
        for <git@vger.kernel.org>; Thu, 05 Mar 2015 05:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=ODnh2y1JSN6xT1+AaQPgAFVan20amB/B0RrYs463PNQ=;
        b=RBxBi7IcY7bXNKK46Eo8SLXJVu79WRiHKnGWOnOM3jcsE/a071QvLxubt0zRx/zwto
         ILsx+Tvxr7ysxFQ4/uEAYmPxKV/McLZpMsbU/Yaf9n3n/EB1hp83FlngOx3vkWjU9J76
         Pb20cZhO0A6I9hEGd0nqkl5ndcMEZrGIAkyIagr1FPPg/8bJFRjEhOicxKp/BJNL+krq
         4rdfEweXi9OmpzEKbLkKPb5xQNLiuYTFkAzMRNdefaviSLagJgRZZKEOGNkBCWs2VO2R
         ZeF+kjHiE4036i8xo3QVR5Tq1/L6tPFc6sVAyaqT+3f2yTiuXoxsLrgpW/w4UwKwMhgw
         lXOw==
X-Received: by 10.181.13.146 with SMTP id ey18mr66835577wid.84.1425563713910;
        Thu, 05 Mar 2015 05:55:13 -0800 (PST)
Received: from [192.168.0.10] (gem13-1-78-228-1-221.fbx.proxad.net. [78.228.1.221])
        by mx.google.com with ESMTPSA id kr5sm10649027wjc.1.2015.03.05.05.55.13
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2015 05:55:13 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264834>

Hi,

I have a suspect case which happens when rebasing a branch.

I'm using the post-rewrite hook and during certain circumstance, my hook
is called by git-rebase with wrong parameters: <old-sha1> argument is
not related to <new-sha1> one.

This actually happens when git-rebase stops and reports:

  The previous cherry-pick is now empty, possibly due to conflict
  resolution.
  If you wish to commit it anyway, use:

      git commit --allow-empty

  Otherwise, please use 'git reset'
  rebase in progress; onto 2889531
  You are currently rebasing branch 'foo' on '2889531'.


If I decide to skip it by doing 'git rebase --continue' then I get the
issue when my hook is run.

BTW, I find that the message is not really clear since it tells me to
run 'git-reset' in the case I want to ignore this empty commit. I'm not
sure that 'git-reset' is really helping in that case (my index is clean)
but 'git rebase --continue' would have been more appropriate IMHO.

If I do 'git commit --allow-empty' then there's no issue when the hook
is run.

Thanks.
