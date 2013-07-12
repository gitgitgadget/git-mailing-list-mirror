From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/4] add a testcase for checking case insensitivity of mailmap
Date: Fri, 12 Jul 2013 18:51:56 -0400
Message-ID: <CAPig+cS-AGTa7DUZKsy2cq6Pd0LFV_4BBFsCVd+CGZ+xWpVh5w@mail.gmail.com>
References: <1373665135-32484-1-git-send-email-gitster@pobox.com>
	<1373665135-32484-5-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 13 00:52:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxmCG-0001Rp-5W
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jul 2013 00:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757896Ab3GLWwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 18:52:07 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:39521 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757890Ab3GLWv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 18:51:58 -0400
Received: by mail-lb0-f175.google.com with SMTP id r10so7903490lbi.6
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 15:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=yhSh2yf9WXj2QXYvp12jiW4jKKAvVbMh8bujLzClWtE=;
        b=TvcBkjktnLWbn0s9RIMPjoksOrTYsFUfIAlgnwmpYUZeoh5fEjwyf0j4yFur3Xc00p
         uJCKrqR+7o6E8y6xjTK7NW+zeqjVumJ9Dm1tJ9yJS2ApgGWl1QjV+XH9oMcLBzPrS3jW
         KoQ8gOcjpm5gAYL3wn3iJ5ye3LhKWdSJettkwlBkBPbbFMYU/cV443wabvUbXxCismjg
         cMcIK2fpWljZB8r0HJqpAP7q8/mqgu/EvOzZyjGqzCI6wrcUwdjYCvFVoCzBPtFuiDWm
         6FwHZzGu9vdBmDLB/sOHSG4i7VobOxn4CrKjP/afDaxAwy9I0v6iZ38gmQpYK+ZE3mn9
         L/vw==
X-Received: by 10.112.77.164 with SMTP id t4mr19919701lbw.52.1373669516537;
 Fri, 12 Jul 2013 15:51:56 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Fri, 12 Jul 2013 15:51:56 -0700 (PDT)
In-Reply-To: <1373665135-32484-5-git-send-email-gitster@pobox.com>
X-Google-Sender-Auth: IQmwBsrEKgeNYTJDp27Txo9HDPQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230265>

On Fri, Jul 12, 2013 at 5:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> From: Stefan Beller <stefanbeller@googlemail.com>
>
> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t4203-mailmap.sh | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
> index 842b754..07152e9 100755
> --- a/t/t4203-mailmap.sh
> +++ b/t/t4203-mailmap.sh
> +test_expect_success 'Test case sensitivity of Names' '
> +       # do a commit:
> +       echo "asdf" > test1
> +       git add test1
> +       git commit -a --author="A <A@example.org>" -m "add test1"
> +
> +       # commit with same name, but different email
> +       # (different capitalization does the trick already,
> +       # but here I am going to use a different mail)
> +       echo "asdf" > test2
> +       git add test2
> +       git commit -a --author="A <changed_email@example.org>" -m "add test2"
> +
> +       # Adding the line to the mailmap should make life easy, so we know
> +       # it is the same person
> +       echo "A <A@example.org> <changed_email@example.org>" > .mailmap
> +
> +       git shortlog -sne HEAD >actual && test_cmp expect actual
> +'

I forgot to mention that the &&-chain is broken (missing) in the
entire test (except for the last line).
