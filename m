From: Christian Couder <christian.couder@gmail.com>
Subject: Re: how to recovery corrupted git blob
Date: Thu, 26 Dec 2013 10:32:19 +0100
Message-ID: <CAP8UFD201zWb4nnzG+n7xjr+7Q+8CyzG_z+AavCFT=AAjMgm6g@mail.gmail.com>
References: <1388046906300-7601221.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Yvonne Leroy <articulation7@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 26 10:32:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vw7J3-0006y7-Kd
	for gcvg-git-2@plane.gmane.org; Thu, 26 Dec 2013 10:32:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728Ab3LZJcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Dec 2013 04:32:21 -0500
Received: from mail-vb0-f43.google.com ([209.85.212.43]:48709 "EHLO
	mail-vb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897Ab3LZJcU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Dec 2013 04:32:20 -0500
Received: by mail-vb0-f43.google.com with SMTP id p6so4203680vbe.30
        for <git@vger.kernel.org>; Thu, 26 Dec 2013 01:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LZPYYZmsb7FfUbw9eQDTOKwq2zkzDDQljHYew1XwXo4=;
        b=lhdlmUVmJRNk9ffQuytADiZCWuEFGy17FGi4AbiEd0wb2s2s3T+tLOvBwsaw8Gh3y/
         ufZSjA7aQ+gMEAFwqTkkYk3Qkcu94wUGgr+K7t8kEtq/Vpu7cEf4FrP/d9/V6f8V1vmk
         DmtIgeiZWfmCUvj/1ey0YDqWXqmMWko1ek2umNoP3oTVymF9conZLabE7+e8nz8gbj2B
         B+NXbBo47iCx/l4SAgRs+OedK+zHfHmo2FedDmcB0a36Va4Q+hpy8poZo/XUOk2DaQvb
         FYJE4mGXBC976gIpTGidkOfVtJDJpWJQa8b3rq0Ut8phzj019U/tJ0syR8UW0p0AjtIY
         daVQ==
X-Received: by 10.221.40.10 with SMTP id to10mr1166495vcb.22.1388050340014;
 Thu, 26 Dec 2013 01:32:20 -0800 (PST)
Received: by 10.58.253.136 with HTTP; Thu, 26 Dec 2013 01:32:19 -0800 (PST)
In-Reply-To: <1388046906300-7601221.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239687>

Hi,

On Thu, Dec 26, 2013 at 9:35 AM, Yvonne Leroy <articulation7@gmail.com> wrote:
>
> 1- at the beginning, with "git fsck --full", it showed:

[...]

> missing blob e187557d07857b974ea51e3ea962ac120cfc9488

[...]

> commit e415bb6d51ee05d60055d89f2bf63ccb32f4c12c
> Author: Yvonne Leroy <articulation7@gmail.com>
> Date:   Sun Dec 15 23:40:39 2013 +0800
>
>     index on master: ec5e609 list
>
> :100644 100644 595691a... e187557... M  project5/css/style.css

The above show you that the previous version of the blob was 595691a.
But in the output you showed there was no line with something like:

> :100644 100644 e187557... <newversion>... M  project5/css/style.css

So we know the previous version but not the subsequent version of that file.

Could you check again that there is no subsequent version with something like:

git log --raw --all --full-history -- project5/css/style.css | grep e187557

?

[...]

> 5-here is my problem,how can I looking at those older and newer
> versions(Could someone point me to which commands I should look at? Still
> new to git:))

You can use "git cat-file blob 595691a" to look at the previous version.

> so that I can use the next step    git hash-object -w <recreated-file>
> and could someone tell me what should I do with <recreated-file>,is it still
> project5/css/style.css ?

If "git hash-object -w <recreated-file>" results in
e187557d07857b974ea51e3ea962ac120cfc9488
then it means that the missing blob was successfully rewritten into
your git repo, so everything should be fine after that.
To make sure you can run "git fsck" again.

Note that you are trying to recreate the missing blob, but in my
opinion before trying to do that you should probably try to find the
missing blob in another repo. The log above showed that the missing
blob was created on the 15th of December (Sun Dec 15 23:40:39 2013
+0800). Haven't you pushed your repo somewhere since that day? If you
did push, it's probably easier to get the missing blob from where you
pushed.

Regards,
Christian.
