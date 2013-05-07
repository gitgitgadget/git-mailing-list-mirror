From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 1/7] shorten_unambiguous_ref(): Allow shortening
 refs/remotes/origin/HEAD to origin
Date: Wed, 8 May 2013 00:03:35 +0200
Message-ID: <CALKQrgdaXOjXFeWSpGtgqKhALqpRN0L7VEMbNf+93UJEBTD9ig@mail.gmail.com>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
	<1367711749-8812-2-git-send-email-johan@herland.net>
	<7vy5bsq9m9.fsf@alter.siamese.dyndns.org>
	<CALKQrgcoz-+5Kb-Y1Ui9LhE=+pvcRUdAS+iRWXAfsYnV6+k34w@mail.gmail.com>
	<7vy5bqiij3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 08 00:03:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZpzA-0005tr-F7
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 00:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451Ab3EGWDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 18:03:42 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:64075 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746Ab3EGWDl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 18:03:41 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UZpz1-0007iz-Uv
	for git@vger.kernel.org; Wed, 08 May 2013 00:03:39 +0200
Received: from mail-oa0-f46.google.com ([209.85.219.46])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UZpz1-000JPR-IC
	for git@vger.kernel.org; Wed, 08 May 2013 00:03:39 +0200
Received: by mail-oa0-f46.google.com with SMTP id h2so1311023oag.5
        for <git@vger.kernel.org>; Tue, 07 May 2013 15:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=TPOdFv/gv3VN/V1d/TknAzrTkaFLqNt0ccpdxYmXzes=;
        b=kdHoT2m2EWJVGup6QfeSKu/ivg2pwshz8Xr6fY5VgAYgCiS5HnFT66EJUyxa11E+k4
         5nDb+KNL7O+kE3XqC7Sl6Pth+StCpGLCqT/h79HRlPEnbRaIUyXP43g/f3TEH+k6VlWw
         GaqKoVC8DAw3vx1dEwoshvXcs17ZYIAA1DDyV+ng5ubNlVlQRYpBlMsXG7sA14UgVXHx
         qW2uopEQxQowiZmhntlV4K4LhCL5lkmK85K9TgEQ/SMITyuJlKIvLM1t1yy9j+mzQ/7V
         au0N+R2o3Kvkj+VsevfiQNYy6W48Q9E1RHTs3qNAKz79NSh1/vx5bxYSpB4NQW3Cz/Y2
         crHQ==
X-Received: by 10.60.134.241 with SMTP id pn17mr1111026oeb.140.1367964215840;
 Tue, 07 May 2013 15:03:35 -0700 (PDT)
Received: by 10.182.129.110 with HTTP; Tue, 7 May 2013 15:03:35 -0700 (PDT)
In-Reply-To: <7vy5bqiij3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223617>

On Tue, May 7, 2013 at 11:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>> On Mon, May 6, 2013 at 7:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> It is interesting that this bug has stayed so long with us, which
>>> may indicate that nobody actually uses the feature at all.
>>
>> I don't know if people really care about whether
>> "refs/remotes/origin/HEAD" shortens to "origin/HEAD" or "origin". I'm
>> guessing that people _do_ depend on the reverse - having "origin"
>> expand into "refs/remotes/origin/HEAD", so we probably cannot rip out
>> the "refs/remotes/%.*s/HEAD" rule altogether...
>
> Oh, no doubt about that reverse conversion.
>
> The real reason nobody cared about refs/remotes/origin/HEAD is that
> nobody sane has anything but non-symbolic ref there.  Your t1514
> does this:
>
>         ...
>         git update-ref refs/master master_d &&
>         test_commit master_e

...oops, I see I forgot the trailing && on this line. Do you want a
resend, or fix up yourself?

>         git update-ref refs/remotes/origin/HEAD master_e &&
>         ...
>
> Nowhere in the set-up sequence, you see anything that does
>
>         git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/master
>
> or any other branch we copied from the remote.

Correct. I first did a "git remote set-head origin master", but
quickly discovered that rev-parse resolved the symref as part of
--abbrev-ref, so I had to fake up a non-symref to trigger the
shortening logic I wanted to test.

> And the shortening is done after dereferencing the symbolic ref.
> Because of this, refs/remotes/origin/HEAD usually resolves to
> origin/master, not origin.
>
>  t/t1514-rev-parse-shorten-unambiguous-ref.sh | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/t/t1514-rev-parse-shorten-unambiguous-ref.sh b/t/t1514-rev-parse-shorten-unambiguous-ref.sh
> index fd87ce3..556ad16 100755
> --- a/t/t1514-rev-parse-shorten-unambiguous-ref.sh
> +++ b/t/t1514-rev-parse-shorten-unambiguous-ref.sh
> @@ -76,4 +76,11 @@ test_expect_success 'shortening refnames in loose mode' '
>         test_shortname refs/tags/master loose tags/master master_c
>  '
>
> +test_expect_success 'shortening is done after dereferencing a symref' '
> +       git update-ref refs/remotes/frotz/master master_e &&
> +       git symbolic-ref refs/remotes/frotz/HEAD refs/remotes/frotz/master &&
> +       test_shortname refs/remotes/frotz/HEAD strict frotz/master master_e &&
> +       test_shortname refs/remotes/frotz/HEAD loose frotz/master master_e
> +'
> +
>  test_done

True. I'm not sure whether that's a feature or a bug in --abbrev-ref,
probably a feature.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
