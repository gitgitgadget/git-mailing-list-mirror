From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] peel_onion(): add support for <rev>^{tag}
Date: Tue, 3 Sep 2013 15:03:14 -0400
Message-ID: <CAPig+cRQP5CGz_1ckf5Qr6HcB+OvWHNPtGQ8RxWdqTZK0fRo2w@mail.gmail.com>
References: <1378229853-21236-1-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 21:03:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGvsy-0000He-9N
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 21:03:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933343Ab3ICTDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 15:03:22 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:35541 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932930Ab3ICTDT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 15:03:19 -0400
Received: by mail-la0-f54.google.com with SMTP id ea20so4950783lab.41
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 12:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ckvIr/tTC8dN0MdoAhF700PI9PHMm5gDxJzrHqbfUTc=;
        b=t52XRM31Yam0kK5RZT33YnyZWaBPmlqxJ9pwEwDGHij7eXfBE/tj4ghlQ0X3IvfWtg
         AnB7PTxPvRhe1p4R1PIwg8P/QNw8vEIpvfa+H44Ch5mqEaQsOK0Lcif6a2dQKB4Fhx7s
         NOzdn8AezqewnGbAOtDD5qajXUplDAyPg9FrvKa5+W7JeyYbB3P9Ptwz76Nxb0BVgFg6
         WJwUUbSBFe0YDfOweLfy/HeGoMh7AtH5lJjpRdzKeACWEDOiYYaeGoEZLbld3DkQVQEp
         VeHGexh6oUifgM5paWsKps/GD3iUvSpSBJ6yhH1vpMgHV0ohe6o4q6ZQh1twi/lE3w0U
         JqMw==
X-Received: by 10.152.8.12 with SMTP id n12mr27689501laa.10.1378234994763;
 Tue, 03 Sep 2013 12:03:14 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Tue, 3 Sep 2013 12:03:14 -0700 (PDT)
In-Reply-To: <1378229853-21236-1-git-send-email-rhansen@bbn.com>
X-Google-Sender-Auth: ImchKrnxBgce6nSHTMd6u9ohdm8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233759>

On Tue, Sep 3, 2013 at 1:37 PM, Richard Hansen <rhansen@bbn.com> wrote:
> diff --git a/t/t1511-rev-parse-caret.sh b/t/t1511-rev-parse-caret.sh
> index eaefc77..5771cbd 100755
> --- a/t/t1511-rev-parse-caret.sh
> +++ b/t/t1511-rev-parse-caret.sh
> @@ -54,6 +61,26 @@ test_expect_success 'ref^{tree}' '
>         test_must_fail git rev-parse blob-tag^{tree}
>  '
>
> +test_expect_success 'ref^{tag}' '
> +       echo $BLOB_TAG_SHA1 >expected &&
> +       git rev-parse --verify blob-tag^{tag} >actual &&
> +       test_cmp expected actual &&
> +       echo $TREE_TAG_SHA1 >expected &&
> +       git rev-parse --verify tree-tag^{tag} >actual &&
> +       test_cmp expected actual &&
> +       echo $COMMIT_TAG_SHA1 >expected &&
> +       git rev-parse --verify commit-tag^{tag} >actual &&
> +       test_cmp expected actual &&
> +       echo $TAG_TAG_SHA1 >expected &&
> +       git rev-parse --verify tag-tag^{tag} >actual &&
> +       test_cmp expected actual &&
> +       test_must_fail git rev-parse --verify $BLOB_SHA1^{tag} &&
> +       test_must_fail git rev-parse --verify $TREE_SHA1^{tag} &&
> +       test_must_fail git rev-parse --verify $COMMIT_SHA1^{tag} &&
> +       test_must_fail git rev-parse --verify rev^{tag} &&
> +       true
> +'

The unnecessary trailing "&& true" is unusual. Such form is not used
elsewhere in this file, or in any script in the test suite.

> +
>  test_expect_success 'ref^{/.}' '
>         git rev-parse master >expected &&
>         git rev-parse master^{/.} >actual &&
> --
> 1.8.4
