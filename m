From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] mailmap: Testing the single letter name case.
Date: Sat, 13 Jul 2013 22:38:27 -0400
Message-ID: <CAPig+cRQ5yVYjY==5P+kKJycdHDp9avzcxHvZj34GJ3oBAcesg@mail.gmail.com>
References: <1373665135-32484-2-git-send-email-gitster@pobox.com>
	<1373700020-30436-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Jul 14 04:38:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyCD2-0001E3-V0
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 04:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215Ab3GNCia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jul 2013 22:38:30 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:43829 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192Ab3GNCi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jul 2013 22:38:29 -0400
Received: by mail-lb0-f173.google.com with SMTP id v1so8601002lbd.4
        for <git@vger.kernel.org>; Sat, 13 Jul 2013 19:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=z7iIxvgAaCXMr23iHXZ4Qg+239mEIhitYLr2fi0FKO0=;
        b=Uux5KbfPRcC4pQfbk8OfFlzQDYc29m81iicggYlIOnFKkslVUvGaUaIC1aU3eAmPLe
         wDXzqMrlST6CYr+6m5oNWQNKMNVMg0cxsvLl7+5cMbEAtYD6E1OwWsUSaNq13UlnNdCY
         9oAtEgB3vuA3JOemBtZvGpDElF2HuNIKnqECCXd1+E2xaa1M20KcN7ek3AahUGAWTpFY
         +IlTT4aSM7fpOwoDp5yiExQHphU2zDpH+EvT4wmVxOV92IEaKPgyEBrYN7iIUltoX+am
         MoGhV+B8S9Ctt3NxeUqkL8uEf2LBoBSsCMogu/sNfnHM8YKVJcnTVTZLdxrni4tQPESk
         VoOw==
X-Received: by 10.112.19.162 with SMTP id g2mr22105968lbe.9.1373769507999;
 Sat, 13 Jul 2013 19:38:27 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Sat, 13 Jul 2013 19:38:27 -0700 (PDT)
In-Reply-To: <1373700020-30436-1-git-send-email-stefanbeller@googlemail.com>
X-Google-Sender-Auth: woYaJV7-gaiuaf0q7DcNxO6-PnE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230299>

On Sat, Jul 13, 2013 at 3:20 AM, Stefan Beller
<stefanbeller@googlemail.com> wrote:
> This is a regression test for a66e77eab70a08938fdc2227b7ada0f0465c6991
>
> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
> ---
>  t/t4203-mailmap.sh | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
> index 842b754..9ec87a2 100755
> --- a/t/t4203-mailmap.sh
> +++ b/t/t4203-mailmap.sh
> @@ -409,4 +409,45 @@ test_expect_success 'Blame output (complex mapping)' '
>         test_cmp expect actual.fuzz
>  '
>
> +# Regression test
> +# Using a single letter name to check for off-by-one errors in parse_name_and_email
> +test_expect_success 'check mapping for short names' '
> +       echo one >two &&
> +       git add two &&
> +       git commit --author "A <shortname@company.xx>" -m "eighth" &&
> +
> +       echo two >> two &&

s/>> />>/

> +       git add two &&
> +       git commit --author "A <ShortName@company.xy>" -m "nineth" &&
> +
> +       echo "A <ShortName@company.xy> <shortname@company.xx>" >> .mailmap &&

s/>> />>/

> +       git shortlog HEAD -e >actual

Broken &&-chain: s/actual/actual &&/

> +
> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> 1.8.3.2.776.gfcf213d
>
