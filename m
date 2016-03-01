From: Stefan Beller <sbeller@google.com>
Subject: Re: bug: git submodule add fails when .git is a symlink
Date: Tue, 1 Mar 2016 13:49:37 -0800
Message-ID: <CAGZ79kbV9y6nDuBgqLbzQ=xaroG_uF8RF6gqzk=unJ-9rrtvfw@mail.gmail.com>
References: <20160301204218.GA4083@kitenet.net>
	<CAGZ79kY6Lf6u0=s8J_cqRNFsry4nu2SdL0GZ2gkFsu6gBrB65Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joey Hess <id@joeyh.name>
X-From: git-owner@vger.kernel.org Tue Mar 01 22:49:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aasAt-0005kT-Cn
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 22:49:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbcCAVtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 16:49:40 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:36001 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbcCAVti (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 16:49:38 -0500
Received: by mail-ig0-f175.google.com with SMTP id xg9so28343236igb.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 13:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=FsPP1gHjmhj/Qh7LnsiWM2vmCe1SET27GcPStAN+Jcs=;
        b=J/UlIe+/Az9WmLl5zCe5uYD2ZjSy8ndww7yM5jB/8WfLvoZYoprrFc7VNCsopBNCbG
         PQFZHZA7xzDmXEK2B25SKzbmGnH+gN8i5B1ktjYf0gqKhHs/zaHsSPs9U7HJlEZ7TFoE
         gUSj+3dugZpAVDWPsNGEzk+MRi32Kow1l3NbBmq0RD5WggoQiVdvtY03FYAmvxEdShBQ
         DJz33ncE9+LE6m2DAIDYJCFFFbBg4XiQbfnOvkdTf3DRjQ3IiKSzxE4S06r1wQ35rnM0
         kqFuZnozeK8tUqcP29RpGhPgZ6SZTIBZrzBk4D0yQ7mUae7u4YEKwk9r53ZPHUaf1ftS
         UKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=FsPP1gHjmhj/Qh7LnsiWM2vmCe1SET27GcPStAN+Jcs=;
        b=bwIK2AIn6K8O7PJh4lPhGCCnOVNT8ZwOPaqkTr7lPUPdN3iw5RGqNoNmK/1o4jTzE1
         ZI+hyw1yWRb4pkIsZ2QSuslFqu5fyTpeWZF1I+weryN/G1I5LquECyZN0Jxq9zNxQ2tZ
         B/cs61i/sXOSa+kEseVkU6BABF2v0mmDXoZSv9kzwn3CibdZ3vGV1BKHTgZOp+Lqh+pM
         03x6vYM5y85lvAEutbWdNVKhKLf5YBUxSLa8edZtURlZAp5dcS3Aal9W5npks4Nw6xeo
         DJStFctYHOFNj/OjPPMUwQ/RSH+ZMN92GMt9KlnHRqQ8Bcf9uCo04OkKJjTNJdBWGpGR
         /j5A==
X-Gm-Message-State: AD7BkJIff2J7dDrZNUDgsIY8Kysl2saUPJCFcMKZ+BqkeALty5ljACASChbOpUCafeKSXH3R6mw245/+GmaGV/dH
X-Received: by 10.50.132.42 with SMTP id or10mr1315845igb.85.1456868977444;
 Tue, 01 Mar 2016 13:49:37 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Tue, 1 Mar 2016 13:49:37 -0800 (PST)
In-Reply-To: <CAGZ79kY6Lf6u0=s8J_cqRNFsry4nu2SdL0GZ2gkFsu6gBrB65Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288068>

On Tue, Mar 1, 2016 at 1:39 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Mar 1, 2016 at 12:42 PM, Joey Hess <id@joeyh.name> wrote:
>>         git init gitdir
>>         mkdir worktree
>>         cd worktree
>>         ln -s ../gitdir/.git .git
>>         git submodule add /any/git/repo sub
>>
>>         fatal: Could not chdir to '../../../sub': No such file or directory
>>
>> Fairly sure this is a bug..
>
> Which version(s) of Git do you use?

To elaborate on that: Starting in 2.7 parts of the submodule stuff
has been rewritten in C, in 2.8 even more and there is more in flight for
 > 2.8.

However your bug is also to be found in 2.6, which doesn't contain any
recent rewrites, so it is a rather long standing bug, I would presume.

As a workaround for now:

    echo "gitdir: ../gitdir/.git" > .git

instead of the symbolic link in your example (works in 2.6 and also in
2.8.0-rc0)

Thanks,
Stefan
