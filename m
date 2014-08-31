From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 22/32] checkout: support checking out into a new working directory
Date: Sun, 31 Aug 2014 11:49:17 +0700
Message-ID: <CACsJy8CpGhLN58GyJa_3-PDqNqYUCshPEGDr8-pKngad+-oAdg@mail.gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
 <1409387642-24492-23-git-send-email-pclouds@gmail.com> <70985AC885404243A2B95F534083A0E9@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Aug 31 06:50:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNx5T-0004bm-4y
	for gcvg-git-2@plane.gmane.org; Sun, 31 Aug 2014 06:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbaHaEtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2014 00:49:49 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:54794 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbaHaEts (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2014 00:49:48 -0400
Received: by mail-ie0-f169.google.com with SMTP id tr6so4710851ieb.0
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 21:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3kf9CT1ZH5R9+PD97+MsqpCt/L2y+FZDJTnTiu7oLT4=;
        b=kWQSO3j2oT+XK7EBBv0Bim4uaWPE4em1K+GS+wk8Qbu7Rk1G+GBLbkUclb0cYCSAvb
         zilZL8ZVTgnO4qc640sQggRUQG6sxkhE016Uk5pNhLabkddUoa02+YB04ImoChCrQni1
         FhhhRfTvI9XsSSPTmQv8bVd0IjjN9uPLaPtsUtUKykR1344Xo0WNQjjfv7kBRjDYoRWl
         AlAYTmIMyYgtomJ4j4j184iWRWpBup0wQiWxaVhB1YmREZv/1iR1BFfp/ZHpggbQ5LCE
         +cvTgfOWr2oWiZhw7ziV7kQvudmIPqcDlJuiRRdaZR7Ko8088G6pK1j5ShTMDzS7Wyy3
         44ZQ==
X-Received: by 10.42.109.79 with SMTP id k15mr3706871icp.42.1409460587531;
 Sat, 30 Aug 2014 21:49:47 -0700 (PDT)
Received: by 10.107.13.80 with HTTP; Sat, 30 Aug 2014 21:49:17 -0700 (PDT)
In-Reply-To: <70985AC885404243A2B95F534083A0E9@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256279>

On Sun, Aug 31, 2014 at 3:50 AM, Philip Oakley <philipoakley@iee.org> wrote:
>> @@ -225,6 +225,13 @@ This means that you can use `git checkout -p` to
>> selectively discard
>> edits from your current working tree. See the ``Interactive Mode''
>> section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
>>
>> +--to=<path>::
>> + Check out a new branch in a separate working directory at
>
>
> Is this actually a 'new' branch? Perhaps s/new //. More below.

Only when -b is also used. Will fix.

>> +All checkouts share the same repository. Linked checkouts see the
>> +repository a bit different from the main checkout. When the checkout
>> +"new" reads the path $GIT_DIR/HEAD for example, the actual path
>
>
> I was caught out by "new" (in quotes) here. I see that the commit msg in
> patch 24 uses 'new-branch', while in patch 30 <new> is used. Is this "new"
> (above) refering to the branch name (or detatched head), or a nmemonic for
> the path? The use of "new working directory" in the previous paragraph is a
> well qualified use of new, so I'm looking to ensure that it's well qualified
> here.
>
> My immediate reaction was that a consistent use of <new> in the three
> patches may be all that's needed

It's probably clearer if I start that paragraph with "git checkout
--to <somewhere> <branch>" then "new" is replaced with "<branch>". The
thing is, each checkout needs a unique id, and this id is usually the
branch name to be checked out. But after worktree creation, even if
the user switches branch, the id remains the same.

>> +returned could be $GIT_DIR/repos/new/HEAD. This ensures checkouts
>
>
> surely s/could/would/? or have I misunderstood?

It's ../repos/new/...if the directory with the same name does not
exist. If it does, a number will follow after 'new' to make it unique,
e.g. ../repos/new1/... Perhaps this paragraph could be rewritten like
this

All checkouts share the same repository. Linked checkouts see the
repository a bit different from the main checkout. When you perform
the command

------------
git checkout --to <some-location> <some-branch>
------------

The checkout at <some-location> will have a unique id that is also the
branch name (e.g. "<some-branch>"). A number may be appended to the id
to make it unique. All worktree-specific files of this new checkout
are in $GIT_DIR/repos/<unique-id> of the main checkout. So "HEAD"
inside the linked checkout will be resolved to
"$GIT_DIR/repos/<some-branch>/HEAD", while "HEAD" from the main
checkout remains "$GIT_DIR/HEAD".
-- 
Duy
