From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] contrib/subtree: fix "subtree split" skipped-merge bug
Date: Wed, 9 Dec 2015 02:52:01 -0500
Message-ID: <CAPig+cSfkz=SNOn+8yP-QN8gJ0ej1wo3HW+y3NO+QvUCOP=+8A@mail.gmail.com>
References: <xmqqk2ook52u.fsf@gitster.mtv.corp.google.com>
	<1449620377-30479-1-git-send-email-davidw@realtimegenomics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Dave Ware <davidw@realtimegenomics.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 08:52:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6ZXl-0000DN-G8
	for gcvg-git-2@plane.gmane.org; Wed, 09 Dec 2015 08:52:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbbLIHwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2015 02:52:04 -0500
Received: from mail-vk0-f53.google.com ([209.85.213.53]:35154 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbbLIHwC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2015 02:52:02 -0500
Received: by vkha189 with SMTP id a189so38175923vkh.2
        for <git@vger.kernel.org>; Tue, 08 Dec 2015 23:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=FQPXp41ZHjz5L43WRUeqyOo9DP8UjDDlIjpOZb2WKJI=;
        b=A5gFsM6h2VMIteRQ3h5n2vGNZ1bkCL9ZTtADtf0DhBJWlc4TMhULpkTRtuoZyC9WvZ
         xTI9rUEIdWLYE15Wm7jDZhCNI/zzip83YgQQjMwQVKc3wEk1dDskdcTlzJ7xHw8IetN/
         5hFrSmUcJaRHAws5THhPfO2g+bPZUeA7J+yusZ7ePIXWdKJG5HKtwGMhfoNDQe+YEP6O
         ROIl8VCG33MmkkpXp7QmnKxSzhXqAE3QNMBVU1+z5eQbKxGco8qRSq81CDtDbr1SqkFE
         OA87kcodaBkcpx21Ulb8x4NIwzDG5eMC/SHGte2rgblmS6EiNiQp2Cq2tBfjM91LYQwW
         excw==
X-Received: by 10.31.52.82 with SMTP id b79mr3528454vka.84.1449647521921; Tue,
 08 Dec 2015 23:52:01 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 8 Dec 2015 23:52:01 -0800 (PST)
In-Reply-To: <1449620377-30479-1-git-send-email-davidw@realtimegenomics.com>
X-Google-Sender-Auth: q1-q96iGqu9vOsTyuUNw4_jlrjI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282188>

On Tue, Dec 8, 2015 at 7:19 PM, Dave Ware <davidw@realtimegenomics.com> wrote:
> 'git subtree split' can incorrectly skip a merge even when both parents
> act on the subtree, provided the merge results in a tree identical to
> one of the parents. Fix by copying the merge if at least one parent is
> non-identical, and the non-identical parent is not an ancestor of the
> identical parent.
>
> Also, add a test case which checks that a descendant can be pushed to
> its ancestor in this case.
>
> Signed-off-by: Dave Ware <davidw@realtimegenomics.com>
> ---
> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
> @@ -468,4 +468,56 @@ test_expect_success 'verify one file change per commit' '
>         ))
>  '
>
> +test_expect_success 'subtree descendent check' '

s/descendent/descendant/

> +       mkdir git_subtree_split_check &&
> +       (
> +               cd git_subtree_split_check &&
> +[...]
> +               git push . subtree_tip:subtree_branch
> +       )
> +       '

Style nit: don't indent closing quotation mark

>  test_done
> --
> 1.9.1
