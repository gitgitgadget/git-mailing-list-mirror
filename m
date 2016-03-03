From: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
Subject: Re: [PATCH v3] fetch-pack: fix object_id of exact sha1
Date: Thu, 3 Mar 2016 20:35:54 -0300
Message-ID: <CABaesJ+5B9WEqJQsK5s+WFczWMfvBgTx6UmVwjAL-WAf55zJUw@mail.gmail.com>
References: <CABaesJK+zuuYAJ6YaEugLMFywMqE8V0W1=_4mJPGDAnfT9yXJg@mail.gmail.com>
 <1456798376-29904-1-git-send-email-gabrielfrancosouza@gmail.com> <20160301045453.GB19272@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 04 00:36:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abcn4-0003Da-Vy
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 00:36:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbcCCXgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 18:36:15 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:35461 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbcCCXgO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 18:36:14 -0500
Received: by mail-ig0-f170.google.com with SMTP id hb3so6974247igb.0
        for <git@vger.kernel.org>; Thu, 03 Mar 2016 15:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4OQ75Z95RktCeZZQww8o9mvBTPAMVX8ba1+0jWpw1Ko=;
        b=J06s4oac9LOdB0eku/qMRJ9FbwF6Wuno3x+jLd5zhz2SDJHIm6eI1XaHg1cjXWmocw
         pdI0zgY9dEfHagQneX+2A4QIjPzafmMi8WmsK1l/CmtenewsKYMwifMPwKS0JKT1eupq
         bBdpLuGVJ1K3mXNVuZDsar5W3rf+0Fnu3zeIej8Qz1cOq46M20zfivuhO2bvbcQE0M/X
         QpB1K9wGxcLbUj/PeFaFZ/a9JLb8OVjMaIsw/QbEJ16hEUqTjj4pHDWiwOlEkCFiqV9e
         FxoRZDu3yAScJdyO795rHOQmGnh6raPaI13Cxz88RaepjPeURtH/nM1EMow4txWkDroR
         Wo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4OQ75Z95RktCeZZQww8o9mvBTPAMVX8ba1+0jWpw1Ko=;
        b=Nn4ZCSEfJp8kBJJCIDVY74ntqbMdxVRsgo4x9mr3bBtbD9eVNJ6QreIBA8yZMaYJrO
         Ssgdtzj2Y4mYv9ZOYThc+pXKYETAv7Uq9CA7yApJaJNVjvnVIwBi7K3pzRlYeUtMwu26
         8pCHAR2cmZ3xuSyRyrAlZHhjCKkAgMKjXYKsL/rWwq7z7LFCBEakMXsMZaL9mk810u0a
         GgP96EMTuy1KocqL1XFjbZjKawESq8ark6oRyjkRRac7EatLN9SRRquJRlWRQzbDi7sk
         cNAwbme07SNeXnebWTcGOFYs5H+ezLMVCAICYeQy+jC2zuvqlxlaSMu0KFsJRBLk60LK
         w5JA==
X-Gm-Message-State: AD7BkJLGHYzVDDyI4savLbJcVFTEB0yJYMfd1LPqnfbtq15cqgOUUpTCJ4N12r+gTpOdx+wMu1RxV7tksK1t4A==
X-Received: by 10.50.92.5 with SMTP id ci5mr540918igb.70.1457048173616; Thu,
 03 Mar 2016 15:36:13 -0800 (PST)
Received: by 10.50.79.233 with HTTP; Thu, 3 Mar 2016 15:35:54 -0800 (PST)
In-Reply-To: <20160301045453.GB19272@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288225>

On Tue, Mar 1, 2016 at 1:54 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Feb 29, 2016 at 11:12:56PM -0300, Gabriel Souza Franco wrote:
>
>> Commit 58f2ed0 (remote-curl: pass ref SHA-1 to fetch-pack as well,
>> 2013-12-05) added support for specifying a SHA-1 as well as a ref name.
>> Add support for specifying just a SHA-1 and set the ref name to the same
>> value in this case.
>>
>> Signed-off-by: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
>> ---
>>
>> I did keep the oid variable because ref is uninitialized at that point,
>> and this means having to copy either name or old_oid afterwards anyway.
>
> Oh, right. That's why we had the variable in the first place (even in
> the original, we could otherwise have gone without the extra variable).
>
>>  builtin/fetch-pack.c | 16 +++++++++++++---
>>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> The code looks good to me. Do we need documentation or test updates?
>
> Here's a test that can be squashed in. For documentation, it looks like
> we don't cover the "<sha1> <ref>" form at all. That's maybe OK, as it's
> mostly for internal use by remote-http (though fetch-pack _is_ plumbing,
> so perhaps some other remote-* could make use of it). But perhaps we
> should document that "<sha1>" should work.

Thanks for providing a test, I hadn't looked up those yet. For
documentation, should
it be on the same patch or a new one? Also, I'm not exactly sure how
to word that <refs>...
can also contain a hash instead of a ref.

>
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index e5f83bf..9b9bec4 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -531,6 +531,20 @@ test_expect_success 'shallow fetch with tags does not break the repository' '
>                 git fsck
>         )
>  '
> +
> +test_expect_success 'fetch-pack can fetch a raw sha1' '
> +       git init hidden &&
> +       (
> +               cd hidden &&
> +               test_commit 1 &&
> +               test_commit 2 &&
> +               git update-ref refs/hidden/one HEAD^ &&
> +               git config transfer.hiderefs refs/hidden &&
> +               git config uploadpack.allowtipsha1inwant true
> +       ) &&
> +       git fetch-pack hidden $(git -C hidden rev-parse refs/hidden/one)
> +'
> +
>  check_prot_path () {
>         cat >expected <<-EOF &&
>         Diag: url=$1
