From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 3/4] refs: make refs/worktree/* per-worktree
Date: Thu, 13 Aug 2015 13:15:28 -0400
Message-ID: <CAPig+cRM-J-5SHJ9JVsHPR+B2Y05nwFrRQWsd0M56pm9jS-mTQ@mail.gmail.com>
References: <1439416645-19173-1-git-send-email-dturner@twopensource.com>
	<1439416645-19173-3-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 19:15:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPw6I-00018T-CK
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 19:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526AbbHMRPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 13:15:31 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:33990 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935AbbHMRP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 13:15:29 -0400
Received: by ykdt205 with SMTP id t205so47121394ykd.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 10:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Bes89Jy35eUdkHj5G2gITGEgquZnSbZQ3E9jwG5aYBI=;
        b=CkNsRN6mEwzFGiZ0x7MmJ3adEJSj8vaJLqc1FOUhUC2KTxr/1NIyJ1c8iZdaVxQNW7
         zTh5QERApRPuKZyoGgUUhpZ8hcVZDck88fHJQQatwc/OYBrJZpD0QlYjF9oh0/cUoK9r
         7OZnOAoMSQ4FN9I+2U2qSsJPbGEWaVL9FNaCQPBx9zMXzbKCfjsREU4wQPDn4R9N+oGJ
         ZxD7LMWbeOPoVLmh6lZ2Rr2qVOXsRQ3YEe7qoARyt15NjKu7HMbljB94Z2H12Qc+8K6U
         pGKIuhb6VzXuVTt26cUcjwktVnKhX9d/XLhjUW5ysEK0fio82tgz+SQy0wfzjcLOh/Th
         tVbA==
X-Received: by 10.170.233.10 with SMTP id z10mr39853324ykf.71.1439486128876;
 Thu, 13 Aug 2015 10:15:28 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Thu, 13 Aug 2015 10:15:28 -0700 (PDT)
In-Reply-To: <1439416645-19173-3-git-send-email-dturner@twopensource.com>
X-Google-Sender-Auth: CuGJTfKp4beESLxCegqpfi1L2Cg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275864>

On Wed, Aug 12, 2015 at 5:57 PM, David Turner <dturner@twopensource.com> wrote:
> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> index 93605f4..28e6dff 100755
> --- a/t/t0060-path-utils.sh
> +++ b/t/t0060-path-utils.sh
> +test_expect_success 'handle per-worktree refs in refs/worktree' '
> +       git commit --allow-empty -m "initial commit" &&
> +       git worktree add -b branch worktree &&
> +       (
> +               cd worktree &&
> +               git commit --allow-empty -m "test commit"  &&
> +               git for-each-ref | test_must_fail grep refs/worktree &&

s/test_must_fail/!/

>From t/README:

   On the other hand, don't use test_must_fail for running regular
   platform commands; just use '! cmd'.  We are not in the business
   of verifying that the world given to us sanely works.

> +               git update-ref refs/worktree/something HEAD &&
> +               git rev-parse refs/worktree/something >../worktree-head &&
> +               git for-each-ref | grep refs/worktree/something
> +       ) &&
> +       test_path_is_missing .git/refs/worktree &&
> +       test_must_fail git rev-parse refs/worktree/something &&
> +       git update-ref refs/worktree/something HEAD &&
> +       git rev-parse refs/worktree/something >main-head &&
> +       ! test_cmp main-head worktree-head
> +'
