From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Joining historical repository using grafts or replace
Date: Thu, 30 Oct 2014 17:54:54 +0100
Message-ID: <CAP8UFD3_fAWRdxQgAbfxYZSzrmy1Aza=nuZh-uSJsKOdRj+LVA@mail.gmail.com>
References: <CA+POfmvCiNBF=P-OvQBTROVhaLtOdgNTDgPNyS=97bupSGk=4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Dmitry Oksenchuk <oksenchuk89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 17:56:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xjt11-0004HC-Nk
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 17:56:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161107AbaJ3Qy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 12:54:59 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:51213 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759794AbaJ3Qy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 12:54:56 -0400
Received: by mail-ig0-f180.google.com with SMTP id h3so5530611igd.1
        for <git@vger.kernel.org>; Thu, 30 Oct 2014 09:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yM57zhhlz3GI0ta3v748KvNuiJgA9hcmGJNH1hUL3Ww=;
        b=rJvEXZ4z/x+aVWa3mdaNZ7ErE3NxM8AvhF6+HQv4w8zbU6Skyt/SJ0L5hq31k/3NHL
         43Zek5F4HZa1elYbnEAKAAku1k+RDQ2Exl3BpqCpZc/ZVsomEkoM7S23XEb1v5zWtRZJ
         FUuqjtphwP+Gmlo7xBJMTDB+GoVdbbdH5D3d4j29BDICC3gJK6QMSvlae/btQNx960Uy
         JvbOH6tgz2wBHYxyB6Ck1LkLVV2My/hvJcfNzz7umYvV8UCheYeVFcWZbYWthmrif7zW
         hL5CjZsQ6lfw4BLU9rfrKyX0P9z3L0xdqfQCDAD8QkZXQNzU+ZfPaJFzvA7MGC2hrQb5
         64sA==
X-Received: by 10.107.128.146 with SMTP id k18mr4285346ioi.69.1414688094953;
 Thu, 30 Oct 2014 09:54:54 -0700 (PDT)
Received: by 10.50.250.179 with HTTP; Thu, 30 Oct 2014 09:54:54 -0700 (PDT)
In-Reply-To: <CA+POfmvCiNBF=P-OvQBTROVhaLtOdgNTDgPNyS=97bupSGk=4g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Oct 30, 2014 at 4:39 PM, Dmitry Oksenchuk <oksenchuk89@gmail.com> wrote:
> Hello,
>
> We're in the middle of conversion of a large CVS repository (20 years,
> 70K commits, 1K branches, 10K tags) to Git and considering two
> separate Git repositories: "historical" with CVS history and "working"
> created without history from heads of active branches (10 active
> branches). This allows us to have small fast "working" repository for
> developers who don't want to have full history locally and ability to
> rewrite history in "historical" repository (for example, to add
> parents to merge commits or to fix conversion mistakes) without
> affecting commit hashes in "working" repository (the hashes can be
> stored in bug tracker or in the code).

This might be a good idea. Did you already test that the small
repository is really faster than the full repository?

> The first idea was to use grafs to join branch roots in "working"
> repository with branches in "historical" repository like in linux
> repository but it seems that grafts are known as a "horrible hack" (
> http://marc.info/?l=git&m=131127600030310&w=2
> http://permalink.gmane.org/gmane.comp.version-control.git/177153 )
>
> Since Git 1.6.5 "replace" can also be used to join the histories by
> replacing branch roots in "working" repository with branch heads in
> "historical" repository.
>
> Both grafts and replace will be used locally. Grafts is a bit easier
> to distribute (simple copying, replaces should be created via bash
> script).

First, you might want to have a look at:

http://git-scm.com/book/en/v2/Git-Tools-Replace

as it looks like it describes your use case very well.

> Are there any disadvantages of using grafts and replace? Will both of
> them be supported in future versions of Git?

My opinion is that grafts have no advantage compared to replace refs.

Once you have created your replace refs, they can be managed like
other git refs, so they are easier to distribute.

Basically if you want to get the full history on a computer you just need to do:

git fetch 'refs/replace/*:refs/replace/*'

Best,
Christian.
