From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFCv2 14/16] t5544: add a test case for the new protocol
Date: Tue, 2 Jun 2015 20:16:16 -0400
Message-ID: <CAPig+cTEK5FEBZVqRg1SJEWG77r3-7TZ0hgpuUFfD5FW0dDbKg@mail.gmail.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
	<1433203338-27493-15-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 02:16:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzwM2-0000M2-3H
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 02:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbbFCAQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 20:16:18 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:38718 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbbFCAQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 20:16:16 -0400
Received: by igblz2 with SMTP id lz2so2231716igb.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 17:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=toEy0p36gN+unKaunuyrhMGCGKBHR3Oq91W2ryAzo28=;
        b=obb1LhNJ7fD+zzNkQ9KVAOv7gEJe7XTp1gei+l3ca0nTfldvJHm4V/pNk5TAc5nCC5
         K8OO6BBzIL1V5fKcOoTaUpV6Z3UtE0K3uDtWrLnfaLtC0S9gqT+pms1ZERr1rMhfwYY1
         MJ0N5Ga4YvsDDlU+oFKKr/+0s9+JpWBPN0l62xYPeOXan7gwojyvVCZfXdAy5BlmSUWS
         l+Myxk3211AghMB/t1tdkDa/kIYXKzRB7iHbkw93jJ5VHuFeM6j+N/lafeUH2VP7QUYw
         62BQSWqEvR9IVb6sBbmPrt4dH7anCo7DeEro9ESDTvqY0QLD/u8kdW7VCSPZ7UMOs980
         04Cw==
X-Received: by 10.43.135.5 with SMTP id ie5mr38100949icc.78.1433290576101;
 Tue, 02 Jun 2015 17:16:16 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Tue, 2 Jun 2015 17:16:16 -0700 (PDT)
In-Reply-To: <1433203338-27493-15-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: byv03XYiff2C_nNUVs-9K6Gnyl4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270622>

On Mon, Jun 1, 2015 at 8:02 PM, Stefan Beller <sbeller@google.com> wrote:
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/t/t5544-fetch-2.sh b/t/t5544-fetch-2.sh
> new file mode 100755
> index 0000000..beee46c
> --- /dev/null
> +++ b/t/t5544-fetch-2.sh
> @@ -0,0 +1,40 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2015 Stefan Beller
> +#
> +
> +test_description='Testing version 2 of the fetch protocol'
> +
> +. ./test-lib.sh
> +
> +mk_repo_pair () {
> +       rm -rf client server &&
> +       test_create_repo client &&
> +       test_create_repo server &&
> +       (
> +               cd server &&
> +               git config receive.denyCurrentBranch warn
> +       ) &&
> +       (
> +               cd client &&
> +               git remote add origin ../server

Broken &&-chain (still[1]).

[1]: http://article.gmane.org/gmane.comp.version-control.git/270014

> +               git config remote.origin.transportversion 2
> +       )
> +}
> +
> +test_expect_success 'setup' '
> +       mk_repo_pair &&
> +       (
> +               cd server &&
> +               test_commit one
> +       ) &&
> +       (
> +               cd client &&
> +               git fetch origin master
> +       )
> +'
> +
> +# More to come here, similar to t5515 having a sub directory full of expected
> +# data going over the wire.
> +
> +test_done
> --
> 2.4.1.345.gab207b6.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
