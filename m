From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 03/21] t/test-lib-functions.sh: generalize test_cmp_rev
Date: Sun, 10 Apr 2016 20:07:32 -0400
Message-ID: <CAPig+cSQtnk3wXg6agkHPgYzV-gV_cWv8G0rUO9NZCFxsZC5EA@mail.gmail.com>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
	<1460294354-7031-4-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Mon Apr 11 02:08:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apPOv-0007Q5-VF
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 02:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718AbcDKAH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 20:07:59 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:33670 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652AbcDKAH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 20:07:57 -0400
Received: by mail-ig0-f196.google.com with SMTP id nt3so9334187igb.0
        for <git@vger.kernel.org>; Sun, 10 Apr 2016 17:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=wK8HtEIcTkqLVc063tkOZe+bHmP9BassCNaby6sD2vQ=;
        b=XVH2OmtFT3xDQAA0Ho8KP0kzMkwQZDFCk/LtGWcpbRml59ZWnJVbsUTG6fe/ZOniqb
         CYq6nE2bJGCXFDCn+74D+FRxilfXOu0iJNjTQu2CBZ8b26jmHdsbMgjn/fAq0dIGgfcY
         HjQ0WWD1yVLwAtWJ/TeO5Dsk6LCz2Q4K9uZBwNozwz7iHOZ689MpPlPmIeRdZ62zn7ve
         VNb0ZSHLjkF03sYJd5Q77HRB5XwNTaMW59kNM5HK6wG1PJvI5YEhMIj4fOse9urN7gzA
         gQXQYPWYR+nIt3C9Agks2cBy2RhM/aV9GqmiWZS3CtdqxQ1daJ3aKa9upqzpUGet5Kd6
         KvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=wK8HtEIcTkqLVc063tkOZe+bHmP9BassCNaby6sD2vQ=;
        b=EUdhOfFsEHJmw2aoJMyrakzMnP8nvL7M/Wu0nUua7+d1xvtKpgg4Hfi2XEZqWzEYj5
         hL+QHFe7TFYqikj0EQcbpreIKmqFgmO5ke0Iw87ic0qwhv3NsGrCsN+U/6nZJ0xSvWaM
         Wb2NcjzNWHR/Onyn5FCSKIA+fl9skOuDP3PgQWwpIMgh2TlSqxo2CuvikPjkpDXJ22bO
         82TfNpkLkXuCaL1kxwujIsrkhtSAKqHuqJ8E+d2w07tEDMsFvjr6NYAqK/r91V12zqRd
         sFDKSsX1C9XLj3RO1qzKVS9SRmR5xWgiERuU43RW2EuUfG9L+6gTmWytWJ6Pyjwd3CtZ
         5rXQ==
X-Gm-Message-State: AOPr4FVAoha8l9kQWNWPHce0h+XfqiaYHciUplbRnQMFru4E3823KU6iKpvxH99+vI7mfOkYDrOdGb7H99lXuA==
X-Received: by 10.50.205.42 with SMTP id ld10mr11609488igc.17.1460333252529;
 Sun, 10 Apr 2016 17:07:32 -0700 (PDT)
Received: by 10.79.139.2 with HTTP; Sun, 10 Apr 2016 17:07:32 -0700 (PDT)
In-Reply-To: <1460294354-7031-4-git-send-email-s-beyer@gmx.net>
X-Google-Sender-Auth: Ttr6pytckmIdZs78qFrhkzn6UrQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291195>

On Sun, Apr 10, 2016 at 9:18 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
> test_cmp_rev() took exactly two parameters, the expected revision
> and the revision to test. This commit generalizes this function
> such that it takes any number of at least two revisions: the
> expected one and a list of actual ones. The function returns true
> if and only if at least one actual revision coincides with the
> expected revision.
>
> While at it, the side effect of generating two (temporary) files
> is removed.
>
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> @@ -711,11 +711,17 @@ test_must_be_empty () {
> -# Tests that its two parameters refer to the same revision
> +# Tests that the first parameter refers to the same revision
> +# of at least one other parameter
>  test_cmp_rev () {
> -       git rev-parse --verify "$1" >expect.rev &&
> -       git rev-parse --verify "$2" >actual.rev &&
> -       test_cmp expect.rev actual.rev
> +       hash1="$(git rev-parse --verify "$1")" || return
> +       shift
> +       for rev
> +       do
> +               hash2="$(git rev-parse --verify "$rev")" || return
> +               test "$hash1" = "$hash2" && return 0
> +       done
> +       return 1
>  }

The original code printed helpful diagnostic information when the
comparison failed, but the new code does not. Is this intentional?
