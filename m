From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Commiting automatically
Date: Sat, 25 Sep 2010 12:05:28 +0200
Message-ID: <AANLkTimpyTVe+OhYRhsV3H8TGahgsASOPAZRqwR=V6od@mail.gmail.com>
References: <loom.20100924T224155-693@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Sat Sep 25 12:16:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzRnl-0004Zk-Cb
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 12:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755445Ab0IYKFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 06:05:30 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50989 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754768Ab0IYKF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 06:05:29 -0400
Received: by qwh6 with SMTP id 6so2314152qwh.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 03:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=ouJ2n6GYEBVjCk1MllW4BbjDChEwAMsHypR0pwNnJ8E=;
        b=MIYfwFhU643dTi8YVaFvs1lD8weXbvj/+Dyw0SoP/kSJhJPfXEbX9NMx56mol9zJrG
         xsb4w+6DB62eYXo1c+eCsMTooAxv8OiGk6eCTnS7Y1Q62JE45MSKBtOVHEjHw27dMNcc
         jEQPh3oaiFjFOsvnicxrvGCS5qToqU3M2Lhao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=CPMifOJ3k3JZn4UCVNYjkj7bTBPU2nmcNbeQjVugbv0ABThCnyTUrxYkHaPfCkpCz9
         iEfeU2eVrHod9eaQJcBg9ES8Sm+GHm/DhBqaOxndfTy3n63fsDVyGps0RbcmCswXdDmD
         2LHjp/yOZB8jNfPangboyAyHZUwU2OsXUSA/c=
Received: by 10.224.53.200 with SMTP id n8mr3381468qag.190.1285409128209; Sat,
 25 Sep 2010 03:05:28 -0700 (PDT)
Received: by 10.229.87.212 with HTTP; Sat, 25 Sep 2010 03:05:28 -0700 (PDT)
In-Reply-To: <loom.20100924T224155-693@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157139>

On Fri, Sep 24, 2010 at 22:43, Maaartin <grajcar1@seznam.cz> wrote:
> I'm going to run periodically a process which uses the current working tree and
> I'd like to protocol what happens. As a part of the protocol I need the exact
> state of the working tree and that's what is git good for, right? But it must
> neither disturb my normal workflow nor interfere with my ordinal commits. I
> could probably use something like
...
> Even if there were no problems, it's not very nice. It uses an additional
> repository which is quite strange. Moreover, there's no way to find out how the
> saved working tree snapshot is related to existing ordinal commits.

Try using low-level git commands (the "plumbing").
Take a look at GIT_INDEX_FILE environment variable and
"git write-tree", "git commit-tree" and "git update-ref", in
addition to "git add".

I.e. (untested):

  $ (
  export GIT_INDEX_FILE=.git/myindex
  git add . &&
  tree=$(git write-tree) &&
  commit=$(date |git commit-tree $tree -p protocol) &&
  git update-ref -m autolog protocol $commit
  )
