From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: Apply commits from one branch to another branch (tree structure
 is different)
Date: Fri, 14 Mar 2014 16:37:01 -0400
Message-ID: <CADgNjan2SQXXfYfMP0sk5tqY_=c68=y0dfANF_KFaPQpzNG3yA@mail.gmail.com>
References: <CAD6G_RTZaaYBP0MrmRYhce2v+A+WwvY=97Do3LoWW-SYzkHM2g@mail.gmail.com>
	<CADeaMWpw4gx00QpUJ7u49sQvu7KbhvhH14TMdHXBRXq4wCNDZA@mail.gmail.com>
	<CAD6G_RSmpfhTr_qtdaChR9TqMZgn8BAuSNDmK5B3HJDZMyoM1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Brandon McCaig <bamccaig@gmail.com>
To: Jagan Teki <jagannadh.teki@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 21:37:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOYqt-0002KS-MY
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 21:37:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748AbaCNUhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 16:37:04 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:59365 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754643AbaCNUhD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 16:37:03 -0400
Received: by mail-wg0-f45.google.com with SMTP id l18so2664801wgh.16
        for <git@vger.kernel.org>; Fri, 14 Mar 2014 13:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=s7lEwHiYBdAxXWL3AykBNPMFgb+7M0hdoR6rQvMVvPw=;
        b=j0pixp8VAnYnsruejXrYzgJmTk4lktCbfr+oTMHYdCx4csrFgYu+EyWjh/PtYtG2Bs
         rsJvRRqiVTlPqvzbReQUHp1D86/p1wj+nrQYy734GvtfbwCzEGUWZFj/vsnyLdhmEspV
         R2JbSkC+cUhX5Qk5IALMh/2DxnJryyzBUWZvEXZpQ4a2IUEKcBwLA5jiqiv/hl14BN+I
         jOcw5aSVfuOvau3OUlYgUGwaodOjYTNTgypJofUrAaDDHuz/BnaZe09QgSSTBMYC87qW
         6vcmnLNhDlQslD6l1vFZdVNl4ogOAxjtEr/tupxyVqUVJvbsmgcDWfo1RoJPaGLimsiy
         eSzg==
X-Received: by 10.194.190.10 with SMTP id gm10mr3633157wjc.55.1394829421798;
 Fri, 14 Mar 2014 13:37:01 -0700 (PDT)
Received: by 10.194.81.65 with HTTP; Fri, 14 Mar 2014 13:37:01 -0700 (PDT)
In-Reply-To: <CAD6G_RSmpfhTr_qtdaChR9TqMZgn8BAuSNDmK5B3HJDZMyoM1Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244107>

On Fri, Mar 14, 2014 at 4:01 PM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
> On Sat, Mar 15, 2014 at 12:48 AM, Andrew Wong <andrew.kw.w@gmail.com> wrote:
>> On Fri, Mar 14, 2014 at 1:39 PM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
>>> Suppose developer send 10 patches on branch1 where are changes in terms
>>> of <dir>_<version>/ then I need to apply on my local repo branch1, till now
>>> is fine then I need to apply same 10 patches on to my branch2 where source
>>> tree <dir> which is quite question here how can I do.
>>
>> You might be able to use the subtree option in recursive merge. Try
>> something like:
>>
>>     git cherry-pick -X subtree=foo <commit>
>>
>> This tells git to apply the changes to the "foo" directory in your
>> current branch (branch2).
>
> How do I do this?
>
> Suppose I'm in branch1 with two commits on foo_v2 and I need to apply them
> on branch2 where in foo.

Since this uses cherry-pick, the changes that you want to apply have
to be on branch1 already.

Let's say your branch1 looks like:
    --A--B--C--D
and branch2 looks like:
    --1--2--3--4

And you want to apply commits B and C on branch2, but they modify
"foo_v1/" on branch1. You can tell git to apply the commits onto the
directory "foo/" on branch2:
    git checkout branch2    # make sure you're on branch2
    git cherry-pick -X subtree=foo B C    # pick the commits

If there's no conflict, the commits should apply cleanly, and your
branch2 would become like:
    --1--2--3--4--B'--C'
