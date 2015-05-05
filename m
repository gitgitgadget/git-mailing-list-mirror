From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 01/18] t1404: new tests of D/F conflicts within ref transactions
Date: Tue, 5 May 2015 01:12:39 -0400
Message-ID: <CAPig+cQabRiiMhNyYJM4_bZsQ4OTfrSbJ51XAido3V49baLhHA@mail.gmail.com>
References: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
	<1430483158-14349-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 05 07:13:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpVAB-0008WS-Pt
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 07:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256AbbEEFMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 01:12:41 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:36644 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbbEEFMk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 01:12:40 -0400
Received: by obbkp3 with SMTP id kp3so68035289obb.3
        for <git@vger.kernel.org>; Mon, 04 May 2015 22:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=yYOOQ2LzoUYSkaPY7yk6wUDPcFRJ2jOOGde4tdwMDAg=;
        b=KwZzQmy67m3MrPqSGXC7O8NvG2KVIdDcuuZBVGk2QgFvvLxNbVoud8phZfKvruXGOj
         H159eW2wYR31PNnuyr32cS+EAArTJGEgy3DmdKB1ED23MNvJQNC/tJygsBGcC1evHxvH
         hhNTYXG+0+o/8IHEpvVgdzV5Y4GkGE3KYT0VomxgwGgvUOGNuSvHvmPjtrma0xSRgCgk
         +GjgnkB26ZX+MOsOWpJNjMY7zwRpF5yaSM1DSO33CY0JAER17wEHNj//UEZ+K0iZpp9c
         nLtjJG4NlBGGG97hWA+Cdgo1o5tVGAHwIONdeYbGz1tsrobNeGo2bMsayKAUPdBia3Dg
         eL8g==
X-Received: by 10.107.31.134 with SMTP id f128mr32157043iof.19.1430802759333;
 Mon, 04 May 2015 22:12:39 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Mon, 4 May 2015 22:12:39 -0700 (PDT)
In-Reply-To: <1430483158-14349-2-git-send-email-mhagger@alum.mit.edu>
X-Google-Sender-Auth: MuKCdJlVFY8aEfBCbcb3KdAr4pI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268384>

On Fri, May 1, 2015 at 8:25 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Add some tests of D/F conflicts (as in, the type of directory vs. file
> conflict that exists between references "refs/foo" and "refs/foo/bar")
> in the context of reference transactions.
> [...]
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  t/t1404-update-ref-df-conflicts.sh | 107 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
>  create mode 100755 t/t1404-update-ref-df-conflicts.sh
>
> diff --git a/t/t1404-update-ref-df-conflicts.sh b/t/t1404-update-ref-df-conflicts.sh
> new file mode 100755
> index 0000000..2fc2ac6
> --- /dev/null
> +++ b/t/t1404-update-ref-df-conflicts.sh
> @@ -0,0 +1,107 @@
> +#!/bin/sh
> +
> +test_description='Test git update-ref with D/F conflicts'
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +
> +       git commit --allow-empty -m Initial

Broken &&-chain.

> +       C=$(git rev-parse HEAD)
> +
> +'
