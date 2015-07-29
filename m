From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 02/10] ref-filter: add option to pad atoms to the right
Date: Wed, 29 Jul 2015 15:29:25 -0400
Message-ID: <CAPig+cS4zVT2=kuV3yc860vp4fKrqzvM_phyNngSUho9zTzStA@mail.gmail.com>
References: <CAOLa=ZR6_2NBB4v0Ynq391=8Jk2RZON6R0YG=HKUNwKx249b7Q@mail.gmail.com>
	<1438065211-3777-1-git-send-email-Karthik.188@gmail.com>
	<1438065211-3777-2-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"christian.couder@gmail.com" <christian.couder@gmail.com>,
	"Matthieu.Moy@grenoble-inp.fr" <Matthieu.Moy@grenoble-inp.fr>,
	"gitster@pobox.com" <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 21:29:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKX2h-00077M-6c
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 21:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895AbbG2T31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 15:29:27 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:33527 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153AbbG2T30 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 15:29:26 -0400
Received: by ykba194 with SMTP id a194so16690430ykb.0
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 12:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=veHdJKMGreLxlxo329Pro78kmAqr2gNlmkPJ74SOM7U=;
        b=VqrxNdDJIXEqMuS60tYqAzSAS0F/o6eIsia4j8xwh2wicDLjlGy2IStP3bnesfq3WJ
         NpzA3HBh/lAmteemwDM5KW2uOvmqgP9W/x9kYMk6jwrOt4+nG9XXLCwI6Kt/+vyi6aTb
         Jc+CjazzPkZ6IV6QP1VWY6hn09rn9PgLVFE0wdMvtkaBkssZZ0XoTp4humZVZbHTh5/U
         hk1BNpCNo6Wopds7cuZsBsDzeYx35ejw4Kzb2dIRbByMlpIz48y0K3MJ5X11oQUOSY8L
         U0nEQHNfeuKZm6IGNoBVsbDsbiaV2+t2VaPjkByWQaCq1bOjJO6q0nd7peWqoz+kFz5i
         Ekqg==
X-Received: by 10.170.196.4 with SMTP id n4mr46472252yke.127.1438198165976;
 Wed, 29 Jul 2015 12:29:25 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Wed, 29 Jul 2015 12:29:25 -0700 (PDT)
In-Reply-To: <1438065211-3777-2-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: Z_LGIJqZ9aqf1o2gee2_cJCWybs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274943>

On Tuesday, July 28, 2015, Karthik Nayak <karthik.188@gmail.com> wrote:
> Add a new atom "padright" and support %(padright:X) where X is a
> number.  This will align the succeeding atom value to the left
> followed by spaces for a total length of X characters. If X is less
> than the item size, the entire atom value is printed.
>
> Add tests and documentation for the same.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index 505a360..19ac480 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -81,4 +81,20 @@ test_expect_success 'filtering with --contains' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'padding to the right using `padright`' '
> +       cat >expect <<-\EOF &&
> +       refs/heads/master|refs/heads/master        |refs/heads/master|
> +       refs/heads/side|refs/heads/side          |refs/heads/side|
> +       refs/odd/spot|refs/odd/spot            |refs/odd/spot|
> +       refs/tags/double-tag|refs/tags/double-tag     |refs/tags/double-tag|
> +       refs/tags/four|refs/tags/four           |refs/tags/four|
> +       refs/tags/one|refs/tags/one            |refs/tags/one|
> +       refs/tags/signed-tag|refs/tags/signed-tag     |refs/tags/signed-tag|
> +       refs/tags/three|refs/tags/three          |refs/tags/three|
> +       refs/tags/two|refs/tags/two            |refs/tags/two|
> +       EOF
> +       git for-each-ref --format="%(refname)%(padright:25)|%(refname)|%(refname)|" >actual &&

This fails to test the important case when the atom length is greater
than the padright value (in which case no padding should be done, and
the atom text should extend beyond the 'padright' column).

> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.4.6
