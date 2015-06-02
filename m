From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 3/3] read_loose_refs(): treat NULL_SHA1 loose
 references as broken
Date: Tue, 2 Jun 2015 10:28:35 -0700
Message-ID: <CAGZ79kZG95HB-siR_jMORPuqcL2J_YEwg0VPHE=8XN7gWD4JkA@mail.gmail.com>
References: <1433260647-18181-1-git-send-email-mhagger@alum.mit.edu>
	<1433260647-18181-4-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Anders Kaseorg <andersk@mit.edu>, Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 02 19:28:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzpzW-0002OG-8d
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 19:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759489AbbFBR2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 13:28:38 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33398 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759372AbbFBR2g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 13:28:36 -0400
Received: by qkhg32 with SMTP id g32so104966040qkh.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 10:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PEDuWTZcjRkfd4ZLCKKNjU0WRLWgv5JkwgiTisWvS/s=;
        b=e4T79pRO7KBML4YNZzRb4sMSnZ0YeyVpRmhlN0SEqlC1YOWojcJ6BVyPg5mq8TppZQ
         Z3M8hM1xDfpUgYGDdpt6rOeFQ9M6Kks7yaVF1GJ84hqAfZcVZ6sTXW2p7r6uPPSNZtAq
         xZX8l8ZBGrMkYLbtiNAWfccri2L5UZEREo+ahaicFpe8s4CogYaTZmqiPHaMDA1VYlId
         5AMmFDkvQYKHWS9u0qHs64BNkwmSoHx8m61Xu2rf1hMorc37WPttL53E9U++VCPQz/en
         Dr9VfKMZ54NYm0mQ3yPrBB/f6Q5C2RYTG4cGglXOQmOYkuTTC1mmC1ocEft/Tbe26vcC
         R2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=PEDuWTZcjRkfd4ZLCKKNjU0WRLWgv5JkwgiTisWvS/s=;
        b=l4lU6srug8Rh5P3ihelhCtcgAdhCEpCvZJpI07g0JVpfanZ2seggYo0aIzA1dmjxMp
         jguynOBAQrWHMZ00X4qBK3wFFJkN+Omh/vTX7uJpTGeUror2CP8Pa6NnQbeKP9wezU7a
         p9AlgBoy5E5np1qQzAUDiOv0DSSKtFiRzGwwTy4U1dgv6r5jxQdt4JrxRgsW6zyvqoty
         YMquHK7HWu+p4q4Zp3tSTcFSFxmwgGeEAp9W7HWQos2GukSheLvqnM9IdhKa7CKU7R6P
         mMpNSbY42Q3qOmDzY0Rk7KyBcN72tS1RbzW/mo9fNsBjpqfzoAX5+mTE0i3z+eOATBgD
         er2A==
X-Gm-Message-State: ALoCoQklK7etFQ5ZF9ovCxD+fooWrxp4OAbUDtMPA78uBtGFS4cYdsCWPiBai4l00IUrnyb4W7wV
X-Received: by 10.55.19.197 with SMTP id 66mr50056836qkt.24.1433266115468;
 Tue, 02 Jun 2015 10:28:35 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Tue, 2 Jun 2015 10:28:35 -0700 (PDT)
In-Reply-To: <1433260647-18181-4-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270567>

On Tue, Jun 2, 2015 at 8:57 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> NULL_SHA1 is never a valid value for a reference. If a loose reference
> has that value, mark it as broken.
>
> Why check NULL_SHA1 and not the nearly 2^160 other SHA-1s that are
> also invalid in a given repository? Because (a) it is cheap to test
> for NULL_SHA1, and (b) NULL_SHA1 is often used as a "SHA-1 is invalid"

I don't quite agree with the reasoning here. Just because it's cheap doesn't
mean it's right. ;) But I fully agree with (b) so this still makes sense.


> value inside of Git client source code (not only ours!), and
> accidentally writing it to a loose reference file would be an easy
> mistake to make.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c                         | 7 +++++++
>  t/t6301-for-each-ref-errors.sh | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/refs.c b/refs.c
> index 47e4e53..c28fde1 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1321,6 +1321,13 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
>                                 hashclr(sha1);
>                                 flag |= REF_ISBROKEN;
>                         }
> +
> +                       if (!(flag & REF_ISBROKEN) && is_null_sha1(sha1)) {

Why do we do the extra check for !(flag & REF_ISBROKEN) here?

> +                               /* NULL_SHA1 is never a valid reference value. ...

... *by our definition*, because we believe it helps detecting
errors/mistakes in the future.

*/
> +                               hashclr(sha1);

While this code looks consistent to the rest around, at closer inspection
this feels a bit redundant to me. If is_null_sha1(sha1) is true, then
hashclr(sha1); doesn't change the state. Or did I miss a subtle side effect?

> +                               flag |= REF_ISBROKEN;
> +                       }
> +
>                         if (check_refname_format(refname.buf,
>                                                  REFNAME_ALLOW_ONELEVEL)) {
>                                 hashclr(sha1);
> diff --git a/t/t6301-for-each-ref-errors.sh b/t/t6301-for-each-ref-errors.sh
> index 72d2397..cdb67a0 100755
> --- a/t/t6301-for-each-ref-errors.sh
> +++ b/t/t6301-for-each-ref-errors.sh
> @@ -24,7 +24,7 @@ test_expect_success 'Broken refs are reported correctly' '
>         test_cmp broken-err err
>  '
>
> -test_expect_failure 'NULL_SHA1 refs are reported correctly' '
> +test_expect_success 'NULL_SHA1 refs are reported correctly' '
>         r=refs/heads/zeros &&
>         echo $ZEROS >.git/$r &&
>         test_when_finished "rm -f .git/$r" &&
> --
> 2.1.4
>
