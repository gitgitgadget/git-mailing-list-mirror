From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/WIP PATCH 10/11] t5544: add a test case for the new protocol
Date: Wed, 27 May 2015 01:34:39 -0400
Message-ID: <CAPig+cS3ySggj48o0SK3wNROjBJgohLScG3Xtp2aaR9OXpoPiw@mail.gmail.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
	<1432677675-5118-11-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 27 07:34:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxTzJ-0007gV-Vr
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 07:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbbE0Fek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 01:34:40 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:35725 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbbE0Fek (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 01:34:40 -0400
Received: by igbyr2 with SMTP id yr2so76512652igb.0
        for <git@vger.kernel.org>; Tue, 26 May 2015 22:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=//OKUJVE16yNcZUpF0JumM+E0HJJ+kA7jKQs54ZCwEI=;
        b=FeE//Qp+UMSL/a4ENBT7ogpM+Zv1JN4kUEEFYXOA8+VZcDUqmPWa4gps0xh2RvxOTg
         82TZAESvJ2NA0Z6AZXfzhx6ekfv4hgQ20wGFuMwYk5mP3d78g9PtCBV6nxqsIO8hzIBC
         Dw24hQOE8cAVdPfF+E0buqSfCbn3eL4lJnzNgKmiEoItSvOTj7E4BnRsULS0w7azxJfE
         tuKbiylZeJEWP9ygJckFQD22csneMyd/9Gy4Kf4pMnPhFh6kbBLTrKXWpqgksZQVBHf7
         lwKwdrxELWxe7iVSxwJdMOqX1QqAywBMsEdUMyDDszBVlqSJmhXP+fYoKf9xtvT3Fhpy
         C32g==
X-Received: by 10.42.146.202 with SMTP id k10mr1404306icv.34.1432704879608;
 Tue, 26 May 2015 22:34:39 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Tue, 26 May 2015 22:34:39 -0700 (PDT)
In-Reply-To: <1432677675-5118-11-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: m6YYoUqI64GPJATzLUpBsAcz7gg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270014>

On Tue, May 26, 2015 at 6:01 PM, Stefan Beller <sbeller@google.com> wrote:
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

Broken &&-chain.

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
