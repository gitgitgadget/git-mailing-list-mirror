From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] rebase -i: respect core.abbrev for real
Date: Mon, 19 Jan 2015 17:43:52 -0500
Message-ID: <CAPig+cQcYXzRwHMRcKQJf-mWq7d9Kgp7KndnEhFs4_mwgLpiiA@mail.gmail.com>
References: <1421677248-137853-1-git-send-email-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 23:43:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDL38-0006Eo-47
	for gcvg-git-2@plane.gmane.org; Mon, 19 Jan 2015 23:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbbASWny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2015 17:43:54 -0500
Received: from mail-yk0-f180.google.com ([209.85.160.180]:46603 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbbASWnx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2015 17:43:53 -0500
Received: by mail-yk0-f180.google.com with SMTP id 9so15625840ykp.11
        for <git@vger.kernel.org>; Mon, 19 Jan 2015 14:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=9JjXuqIyOgsZovGbk6jYKFzcwXzHPXolPivFey2EuNQ=;
        b=PP1ALjqa+cxP4dOOEzq4vlRzU1eFaGh/OPLHlxfGpga+/yF4LuVvwjvam3dtRL/iBx
         QzCBnXg4oBkfdRa6BtMW892FWLYMgfOc1G0t5HT3woFORdbAUAYqAmJvGGLEFVFVUEVE
         Tq34O9v0b/RrHwQM3olHJNUJ32tz+5Mt8d28coGW80+7D0isY2qcVrML0R7kqV1G6VxR
         XVkTdZLiyMK6iFtVeuqLn2QAzwAMPOWFncDQSyNdeFsD73X6wKl5c3pyNhhUyGvAeaNf
         PgOI/cQo1oBUGNapA2yhEY7NZZt7Z2z9VOqVZFWyGhtssLE9UPtihfLjkuxjftDOywX0
         dfjw==
X-Received: by 10.236.89.172 with SMTP id c32mr19899653yhf.180.1421707432690;
 Mon, 19 Jan 2015 14:43:52 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Mon, 19 Jan 2015 14:43:52 -0800 (PST)
In-Reply-To: <1421677248-137853-1-git-send-email-kirill.shutemov@linux.intel.com>
X-Google-Sender-Auth: PkFt68LSZ2vq8mEA86XS2KKA6HY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262644>

On Mon, Jan 19, 2015 at 9:20 AM, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
> I have tried to fix this before: see 568950388be2, but it doesn't
> really work.
>
> I don't know how it happend, but that commit makes interactive rebase to
> respect core.abbrev only during --edit-todo, but not the initial todo
> list edit.
>
> For this time I've included a test-case to avoid this frustration again.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 8197ed29a9ec..a8ffc24ce46b 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1039,4 +1039,11 @@ test_expect_success 'short SHA-1 collide' '
>         )
>  '
>
> +test_expect_success 'respect core.abbrev' '
> +       git config core.abbrev 12 &&
> +       set_cat_todo_editor &&
> +       test_must_fail git rebase -i HEAD~4 >todo-list 2>&1

Broken &&-chain.

> +       test 4 = $(grep -c "pick [0-9a-f]\{12,\}" todo-list)
> +'
> +
>  test_done
> --
> 2.1.4
