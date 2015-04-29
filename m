From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v9 5/5] t1006: add tests for git cat-file --allow-unkown-type
Date: Wed, 29 Apr 2015 17:16:11 -0400
Message-ID: <CAPig+cSXB1fyRGTtuOGsxiBnAhVwS2DydLmVYmq-+47EAa-7-g@mail.gmail.com>
References: <5540D397.8020104@gmail.com>
	<1430312065-23443-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 23:16:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnZL7-0005kF-3o
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 23:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbbD2VQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 17:16:13 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:34154 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbbD2VQM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 17:16:12 -0400
Received: by iget9 with SMTP id t9so115693377ige.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 14:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=2bVVkQqJvBXV+w0eTxLAHqNwWSJvs1IxrYb2mkAGz+s=;
        b=NxXufmOKTf1/YYzfxpdtjhCWDd+srcuFKW/S5ezKHo1rFx/6RvnZtQkfZiBD2Y0AQn
         o68AYFIHi4OQ2j76ZJOv2ND4t40p6O6YU3HrT9feYlcVZ+Y949WT4KAPOa6+2Z/c89iz
         lvQxmYwTfevOt5Q3SpVtgqDWeKKzMTB33AJ1aDdPs6zjvC9wcW9oTkrn6guQAovloyLK
         WzF2JR3MuOVGo+D2u9K8qS0+eLqeqgj1/L6bLDqCgyy75DHXk+KO419LrNqlUXfiJ/fx
         Hql38JjkOOND3OSp+dMt5ecYoBSgUOk7hTWPoGrjbohhUQCnjvlEAmZKlgeL6MGHz04G
         avJA==
X-Received: by 10.42.250.70 with SMTP id mn6mr5929824icb.78.1430342171542;
 Wed, 29 Apr 2015 14:16:11 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Wed, 29 Apr 2015 14:16:11 -0700 (PDT)
In-Reply-To: <1430312065-23443-1-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: 3x6eV3EacA7r_TjFbbsw6SNUw6Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268005>

On Wed, Apr 29, 2015 at 8:54 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index ab36b1e..8362019 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -47,6 +47,18 @@ $content"
>         test_cmp expect actual
>      '
>
> +    test_expect_success "Type of $type is correct using --allow-unkown-type" '
> +       echo $type >expect &&
> +    git cat-file -t --allow-unkown-type $sha1 >actual &&

Somehow the indentation got botched here and in the remaining tests
you added. This issue is new since v8.

> +       test_cmp expect actual
> +    '
> +
> +    test_expect_success "Size of $type is correct using --allow-unkown-type" '
> +       echo $size >expect &&
> +    git cat-file -s --allow-unkown-type $sha1 >actual &&
> +       test_cmp expect actual
> +    '
> +
>      test -z "$content" ||
>      test_expect_success "Content of $type is correct" '
>         maybe_remove_timestamp "$content" $no_ts >expect &&
> @@ -296,4 +308,21 @@ test_expect_success '%(deltabase) reports packed delta bases' '
>         }
>  '
>
> +bogus_type="bogus"
> +bogus_content="bogus"
> +bogus_size=$(strlen "$bogus_content")
> +bogus_sha1=$(echo_without_newline "$bogus_content" | git hash-object -t $bogus_type --literally -w --stdin)
> +
> +test_expect_success "Type of broken object is correct" '
> +       echo $bogus_type >expect &&
> +    git cat-file -t --allow-unkown-type $bogus_sha1 >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success "Size of broken object is correct" '
> +       echo $bogus_size >expect &&
> +    git cat-file -s --allow-unkown-type $bogus_sha1 >actual &&
> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.4.0.rc1.250.g565e85b
