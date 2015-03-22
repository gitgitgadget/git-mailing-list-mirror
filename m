From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2/GSoC/RFC] fetch: git fetch --deepen
Date: Sun, 22 Mar 2015 15:15:20 -0400
Message-ID: <CAPig+cSSQaMyW4fbb0guBqJ---VAG8m4trt2a52qLYAANT01og@mail.gmail.com>
References: <1426251846-1604-1-git-send-email-dongcan.jiang@gmail.com>
	<39ef84113d77ee6fa371ac2f23bbb0ef321323ba.1427031746.git.dongcan.jiang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Dongcan Jiang <dongcan.jiang@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 20:15:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZlLJ-0004u9-RP
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 20:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbbCVTPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 15:15:21 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:35498 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbbCVTPV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 15:15:21 -0400
Received: by ykfs63 with SMTP id s63so63253776ykf.2
        for <git@vger.kernel.org>; Sun, 22 Mar 2015 12:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=qlfG7fSIyH8zuvSvklbMCo9fM4+to7aNU48jn1F5QRg=;
        b=IJZamlxsiC9ytAaFg1RVEEoA5ZWWPpJl9rjDd1R9mHPPdiZ+KGr0XbPxMx/fdVhifN
         /FJuAtOnwxntWlKo/9cHcxKTkTWlSFfOVAbQy/E4Uk3lXV1qA3CiX3jTIAbCGuQ3OpIZ
         CoAewl5HqeD7hlrTmDKucJ5QhZjgb0Q+1bzAtq/8gKf7t95jjCFMIzoGQkUyd/TXYErP
         I0aR8H5vjkcXGQSV15Kzv78HngKRuMdN8N8acUubcu5blAoiPP6G2viemcjIrNqp4WKU
         lWUY9aqarkKDSIxuAQsdAk7oYhG968ltkWhyvcuVMRd/ZGZiyI+wOxkgvSiPQzX1jpp0
         zB9A==
X-Received: by 10.170.194.7 with SMTP id l7mr68457614yke.91.1427051720569;
 Sun, 22 Mar 2015 12:15:20 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Sun, 22 Mar 2015 12:15:20 -0700 (PDT)
In-Reply-To: <39ef84113d77ee6fa371ac2f23bbb0ef321323ba.1427031746.git.dongcan.jiang@gmail.com>
X-Google-Sender-Auth: -a5j7AiDPdksUAynW4gh7lbW320
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266084>

On Sun, Mar 22, 2015 at 11:24 AM, Dongcan Jiang <dongcan.jiang@gmail.com> wrote:
> This patch is just for discusstion. An option --deepen is added to
> 'git fetch'. When it comes to '--deepen', git should fetch N more
> commits ahead the local shallow commit, where N is indicated by
> '--depth=N'. [1]
> Signed-off-by: Dongcan Jiang <dongcan.jiang@gmail.com>
> ---
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index d78f320..3b960c8 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -708,4 +708,16 @@ test_expect_success 'fetching a one-level ref works' '
>         )
>  '
>
> +test_expect_success 'fetching deepen' '
> +       git clone . deepen --depth=1 && (

Quoting Junio[1]: "...make sure tests serve as good examples, tests
should stick to 'options first and then arguments'..."

> +               cd deepen &&
> +               git fetch .. foo --depth=1

See [1].

> +               git show foo
> +               test_must_fail git show foo~
> +               git fetch .. foo --depth=1 --deepen

See [1].

> +               git show foo~
> +               test_must_fail git show foo~2

Mentioned previously[2]: Broken &&-chain throughout this test.

> +       )
> +'
> +
>  test_done

[1]: http://article.gmane.org/gmane.comp.version-control.git/265248
[2]: http://article.gmane.org/gmane.comp.version-control.git/265419
