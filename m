From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] t7510: check %G* pretty-format output
Date: Mon, 16 Jun 2014 17:50:14 -0400
Message-ID: <CAPig+cSYETVgS0EPzFbBpEywaWg8k1Yh18rX_8JhJq=Cq5n0WQ@mail.gmail.com>
References: <20140616201311.GA26829@sigill.intra.peff.net>
	<20140616202611.GA29716@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 16 23:50:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwenH-0007tk-8Z
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 23:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755880AbaFPVuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 17:50:16 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:41419 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbaFPVuP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 17:50:15 -0400
Received: by mail-yk0-f176.google.com with SMTP id 131so4610031ykp.21
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 14:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=AAT7vMqjdWYFlnFnE6+0LhOTwh9OgWb2yEVYIYHg/60=;
        b=jkj3tGxsfB9f6bMiV4yCj304eznarzNdq1Acl/1Rpn+n90npjjryxw381c5faHd2mh
         Qo3ItBWK0eBWKx2T4f6xRsZ7u+J0QQd2FezmGgux5gPijAWUj8d3fjuxVgd4n1zuVAMP
         yzfn/3TXzbaUEBtoaT+tnWpxEQsGC14hDpIb4fFEQ9GaC0fvaArnmFKVleVIsxdVGMyf
         jnS0xofqpjVXyQolfi0tLdRw4z2XnmXUu7SGpNFw7sXCz3TViz3J9kpbbAa9iWxScNWL
         Ut4odRraYDg6lJNVdcmpfOIQkKVPKwAk1DWHD5Lnj708VcsrJpBEmDvnZi+/gnp2j44G
         vv/Q==
X-Received: by 10.236.66.139 with SMTP id h11mr38634007yhd.30.1402955415003;
 Mon, 16 Jun 2014 14:50:15 -0700 (PDT)
Received: by 10.170.36.19 with HTTP; Mon, 16 Jun 2014 14:50:14 -0700 (PDT)
In-Reply-To: <20140616202611.GA29716@sigill.intra.peff.net>
X-Google-Sender-Auth: gR1CLhErL-RcyM0_Aq2R-zg8nCQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251825>

On Mon, Jun 16, 2014 at 4:26 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jun 16, 2014 at 04:13:11PM -0400, Jeff King wrote:
>
>> It doesn't look like we have any tests of "%G*" and friends at all. :(
>
> Maybe we can add this:
>
> -- >8 --
> Subject: t7510: check %G* pretty-format output
>
> We do not check these along with the other pretty-format
> placeholders in t6006, because we need signed commits to
> make them interesting. t7510 has such commits, and can
> easily exercise them in addition to the regular
> --show-signature code path.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I explicitly avoided "%GG" here, as its exact format is dependent on
> gpg (and the current date). I don't know that it is worth the
> complexity to test, as the interesting parts are already parsed from it
> and exposed in the other placeholders.
>
>  t/t7510-signed-commit.sh | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
> index 5ddac1a..2f96937 100755
> --- a/t/t7510-signed-commit.sh
> +++ b/t/t7510-signed-commit.sh
> @@ -76,6 +76,42 @@ test_expect_success GPG 'detect fudged signature' '
>         ! grep "Good signature from" actual1
>  '
>
> +test_expect_success GPG 'show good signature with custom format' '
> +       cat >expect <<-\EOF

Broken &&-chain (and in tests below).

> +       G
> +       13B6F51ECDDE430D
> +       C O Mitter <committer@example.com>
> +       EOF
> +       git log -1 --format="%G?%n%GK%n%GS" master >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success GPG 'show bad signature with custom format' '
> +       cat >expect <<-\EOF
> +       B
> +       13B6F51ECDDE430D
> +       C O Mitter <committer@example.com>
> +       EOF
> +       git log -1 --format="%G?%n%GK%n%GS" $(cat forged1.commit) >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success GPG 'show lack of signature with custom format' '
> +       cat >expect <<-\EOF
> +       N
> +
> +
> +       EOF
> +       git log -1 --format="%G?%n%GK%n%GS" seventh-unsigned >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'unused %G placeholders are passed through' '
> +       echo "%GX %G" >expect &&
> +       git log -1 --format="%GX %G" >actual &&
> +       test_cmp expect actual
> +'
> +
>  test_expect_success GPG 'detect fudged signature with NUL' '
>         git cat-file commit master >raw &&
>         cat raw >forged2 &&
> --
> 2.0.0.566.gfe3e6b2
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
