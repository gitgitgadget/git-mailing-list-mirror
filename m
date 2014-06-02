From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 2.0.0 regression? request pull does not seem to find head
Date: Mon, 2 Jun 2014 14:36:01 -0700
Message-ID: <CA+55aFyuj=B4jhc9vPkxHotSgJnRXMj_P_QkHCt-TKXtj8tOFQ@mail.gmail.com>
References: <20140602210131.GA17171@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 23:36:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrZtp-00020H-2V
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 23:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbaFBVgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 17:36:04 -0400
Received: from mail-vc0-f175.google.com ([209.85.220.175]:64393 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbaFBVgD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 17:36:03 -0400
Received: by mail-vc0-f175.google.com with SMTP id id10so5787537vcb.20
        for <git@vger.kernel.org>; Mon, 02 Jun 2014 14:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=m1UgrbiBqN61BbqJ/JRIp9CA9tjrGZtggdjw8sGxOxQ=;
        b=mTtP+osmg8C+MC4zR7xaNgExv2fX8EecAQ+VjUNfsX5HRSxxa+up9laZFwUoH4QJwD
         YlA+o++/QuJQAfRUwfyXeITb8oe7FgEgVGYBaDP0WvFR1FQUZHgfRMfMWK4M3eIHUn+S
         xOXYoKRIZGCLMdEaagpmUJUjhYgpuqS167Z1kCuT1Luggk57F5/WZFFHIBNKoz0NyEmZ
         6rxJvJO1gDxjj1/Obmp4lVDkuhxuRJvpTUuuaqyCtcHjYoeFV65PuWsY+hBdn+dmYD9T
         BPxv04fjUtezndMLh1EpqeK0/lkYCy92zfIbQUmSmo5ZeeZdFJQD8xUMzUF3dMcBw6cM
         CJVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=m1UgrbiBqN61BbqJ/JRIp9CA9tjrGZtggdjw8sGxOxQ=;
        b=KHxYVlgqeI3KDGbc7Q1IUjdV57dQNQvr2Q61iXc68X+BNq0Axm3hlJnZDhyyhl3Ss9
         n4t7WRWDb5ZGISJAxEtodV8JBf9jXqzPdR/qfKrJ6GiX0zc1HgBZmro9tPN5CVOWkMc9
         L/93XHmpRbqnIRRVlPnyGaaWozVvbOmst+Rew=
X-Received: by 10.58.207.74 with SMTP id lu10mr32027301vec.15.1401744962111;
 Mon, 02 Jun 2014 14:36:02 -0700 (PDT)
Received: by 10.220.13.16 with HTTP; Mon, 2 Jun 2014 14:36:01 -0700 (PDT)
In-Reply-To: <20140602210131.GA17171@redhat.com>
X-Google-Sender-Auth: AVtc1s9FTwwRzrjd82RpsAZi0Kg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250601>

On Mon, Jun 2, 2014 at 2:01 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> [mst@robin linux]$ git request-pull net-next/master  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git net-next
> warn: No match for commit 2ae76693b8bcabf370b981cd00c36cd41d33fabc found at git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
> warn: Are you sure you pushed 'net-next' there?

git request-pull is clearly correct. There is no "net-next" in that
public repository.

It *used* to be that request-pull then magically tried to fix it up
for you, which in turn resulted in the guess not being right, like
pointing to the wrong branch that just happened to have the same SHA1,
or pointing to a branch when it _should_ have pointed to a tag.

Now, if you pushed your local "net-next" branch to another branch name
(I can find a branch name called "vhost-next" at that repository, then
you can *tell* git that, using the same syntax you must have used for
the push.

So something like

  git request-pull net-next/master
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
net-next:vhost-next

should work so that git doesn't end up having to guess (and
potentially guessing wrong).

But it may actually be a simpler driver error, and you wanted to use
"vhost-next", and that "net-next" was actually incorrect?

       Linus
