From: Tomi Belan <tomi.belan@gmail.com>
Subject: Re: [BUG?] git-subtree behavior when the -P tree is removed and recreated
Date: Sun, 21 Oct 2012 23:18:08 +0200
Message-ID: <CACUV5odffQoCxr=hTuP+S+DU4+6qD7y=YkTCN3iRr7rjar1bLQ@mail.gmail.com>
References: <CACUV5ofmuUku=byR1_+Cq+g0SdzqZbH1Z1tPfQf4eNABVyYb_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 21 23:22:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ2yO-00005L-GO
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 23:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754561Ab2JUVSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 17:18:40 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33525 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754257Ab2JUVSj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 17:18:39 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so1874768obb.19
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 14:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=B7D0swLR//O1Le1YgOyUrZ7CEmACIXAU5ntdqbG1Yds=;
        b=z4/KaI8ZvoJ5F9hG95SuvZ3nDQ1p0jioPVJ15/uNGnJP8HKuL/QgKc1sPKAiPbWgta
         qHse2Dcylv/On/zhtBmjZTst8ElUwj6SshFwSd4iTWb56FlPjzyMfijEQlW3Q/isqWam
         FOjyyG45uwbZh4BhPDl/U7frpl0s6NjD5q61ZsYdpjWOujVxaDyDTKcIj/rFtcKd0tV+
         z5OVWap2E6vkcZVWsPD9MhIdJ6UakhRocOrEU5CK+ilScacwjdN20mIug6zrQkm4wZgq
         SbEHkGZ1z6u+YCwF4NICDUSmkARaHi1p7w0GYERa9cyujWaI9PZQgYFDsouqwOjRKgC+
         aTWg==
Received: by 10.60.26.136 with SMTP id l8mr6494326oeg.52.1350854319261; Sun,
 21 Oct 2012 14:18:39 -0700 (PDT)
Received: by 10.76.173.198 with HTTP; Sun, 21 Oct 2012 14:18:08 -0700 (PDT)
In-Reply-To: <CACUV5ofmuUku=byR1_+Cq+g0SdzqZbH1Z1tPfQf4eNABVyYb_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208150>

This probably got lost in the mail. Could somebody familiar with
git-subtree take a look?
Tomi

On Sat, Oct 13, 2012 at 3:47 PM, Tomi Belan <tomi.belan@gmail.com> wrote:
>
> Hello folks,
>
> I think I might've found a bug in git-subtree: I have a repository
> containing a directory "foo". I'd like to use its code in other
> projects, so I want to split it off into its own repository with
> git-subtree. But it doesn't work as it should. I found out that long
> ago, my repository contained an unrelated directory also called "foo"
> which has since been deleted.
>
> Steps to reproduce (after installing git-subtree from contrib):
> git init repo
> cd repo
> mkdir foo; touch foo/v1
> git add -A .; git commit -m v1
> rm -rf foo; touch v2
> git add -A .; git commit -m v2
> mkdir foo; touch foo/v3
> git add -A .; git commit -m v3
> git subtree split -P foo -b splitfoo --annotate="split "
>
> What should happen: Either (A) splitfoo only contains "split v3", or
> (B) splitfoo contains "split v1" and "split v3"
>
> What happens instead: The parent of "split v3" is "v2", so splitfoo's
> full history is: "v1" -> "v2" -> "split v3".
>
> Git version: 1.7.12.2
>
> Bonus questions:
> - which is the intended behavior, (A) or (B)?
> - if it's (B), how do I convince git-subtree to do (A) once this bug
> gets fixed? (I might be getting too far ahead of myself here...)
>
> Tomi
