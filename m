From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] rebase --preserve-merges: ignore "merge.log" config
Date: Wed, 21 Aug 2013 16:22:27 -0400
Message-ID: <CAPig+cTWgaMLLUBEetAQnNG2U34d8YgYPSSNds4oFim4uB=2WA@mail.gmail.com>
References: <1377110937-13439-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 22:22:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCEvL-00014E-KP
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 22:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781Ab3HUUWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 16:22:30 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:57568 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765Ab3HUUW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 16:22:28 -0400
Received: by mail-lb0-f182.google.com with SMTP id v20so1008144lbc.13
        for <git@vger.kernel.org>; Wed, 21 Aug 2013 13:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=9TkJqI5dCmiex44VtF+LlDYKk1bSHrlCr0mrcmmMwKw=;
        b=ZrEb0HU+EQvNTzNYjG2QxAG6AgDFeVyzltcs3/QJgAR49xkJV6xhT+TtbWMSVGGemC
         oYUo/cNsADIKgUaNRInm1vm1edwT7760NWFkOFIISmThq3Za9Vs9rvUI+cddRvX3C9UM
         5faCuuF51tkOHGv3LfoQ3JcO3NfSF2dUfnlM1XyULCkX0VefGD/8wy0T7rSXoGOYgBX/
         0xrnrGkWaFh1/iEBnTIvO9uM1NAPndNeep2bysRZ/THuITb+fSaJv6lMt8knqGz/Fduu
         jXjQ2ONloz8zC8xnOi4zz3Mmi/6cE8zgy5wS6K0O75HHYE+kxaKW1jYRJhxwd6XhvS0q
         Pjaw==
X-Received: by 10.112.89.100 with SMTP id bn4mr8512695lbb.16.1377116547194;
 Wed, 21 Aug 2013 13:22:27 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Wed, 21 Aug 2013 13:22:27 -0700 (PDT)
In-Reply-To: <1377110937-13439-1-git-send-email-ralf.thielow@gmail.com>
X-Google-Sender-Auth: nVzWt4MWXlUK90GgFS2no8kSbZM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232725>

On Wed, Aug 21, 2013 at 2:48 PM, Ralf Thielow <ralf.thielow@gmail.com> wrote:
> When "merge.log" config is set, "rebase --preserve-merges"
> will add the log lines to the message of the rebased merge
> commit.
>
> A rebase should not modify a commit message automatically.
>
> Teach "git-rebase" to ignore that configuration by passing "--no-log"
> to the git-merge call.
>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
> diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
> index 2e0c364..2454811 100755
> --- a/t/t3409-rebase-preserve-merges.sh
> +++ b/t/t3409-rebase-preserve-merges.sh
> @@ -96,4 +108,17 @@ test_expect_success 'rebase -p preserves no-ff merges' '
>         )
>  '
>
> +test_expect_success 'rebase -p ignores merge.log config' '
> +       (
> +       cd clone4 &&
> +       git fetch &&
> +       git -c merge.log=1 rebase -p origin/topic &&
> +       cat >expected <<-\EOF &&
> +
> +       EOF

This might be clearer with a simple 'echo' instead of 'cat' with heredoc:

  echo >expected &&

> +       git log --format="%b" -1 >current
> +       test_cmp expected current
> +       )
> +'
> +
>  test_done
> --
> 1.8.4.rc4.dirty
