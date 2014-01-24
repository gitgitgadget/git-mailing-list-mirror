From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 6/9] Pass directory indicator to match_pathspec_item()
Date: Fri, 24 Jan 2014 16:22:58 -0500
Message-ID: <CAPig+cRW5Fz62Qk22qiUo85jmqVK0Hvbb6v2GxK7V+wS+S8_qw@mail.gmail.com>
References: <1390483326-32258-1-git-send-email-pclouds@gmail.com>
	<1390570836-20394-1-git-send-email-pclouds@gmail.com>
	<1390570836-20394-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	pawel.sikora@agmk.net, Jens Lehmann <Jens.Lehmann@web.de>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 24 22:23:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6oDR-0005WC-3S
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 22:23:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913AbaAXVXA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jan 2014 16:23:00 -0500
Received: from mail-la0-f53.google.com ([209.85.215.53]:57452 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397AbaAXVW7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jan 2014 16:22:59 -0500
Received: by mail-la0-f53.google.com with SMTP id e16so2937665lan.40
        for <git@vger.kernel.org>; Fri, 24 Jan 2014 13:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=x95v5uxe11kcuCMBQoFZ1eT9u7UDJPUeGwYSnjhYTns=;
        b=ixcfRUOJne8tnXn5hc2LDEj3/clQeDCNQS0JKc7inqVU8x67osISNTWBpd5wLjzTaq
         pOPRyp6Tlip4/SMeyKg3gS/LEMOjHBbYfA7Et5H7AVE2IDCR7ITVufVLfaG4teIveq0u
         I3OKnjWjR/A5u+PZG35baXQyP8oz2IilgJrqUy+zjvLihxM74yQ/lafe0YlaSjhqOZh9
         lUnbQ+ivJ5xH0XvPZDzazoaJdn+L5kyp2dyDYzPGRQUkRAd1aS92+fONvG4YqTX8SAcQ
         OMNqP12W8pda9aowv3WNW2Ojj9Zerfb7I6ZgQpR5b6ZhG2oWi/n2p+MP2vfmTwqzAJ/s
         uteA==
X-Received: by 10.112.138.233 with SMTP id qt9mr9881752lbb.34.1390598578504;
 Fri, 24 Jan 2014 13:22:58 -0800 (PST)
Received: by 10.114.81.106 with HTTP; Fri, 24 Jan 2014 13:22:58 -0800 (PST)
In-Reply-To: <1390570836-20394-7-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: IDFkM4QPW0Z3X7k7oQeytSXapr8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241043>

On Fri, Jan 24, 2014 at 8:40 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
> index af5134b..167af53 100755
> --- a/t/t4010-diff-pathspec.sh
> +++ b/t/t4010-diff-pathspec.sh
> @@ -110,4 +110,21 @@ test_expect_success 'diff-tree -r with wildcard'=
 '
>         test_cmp expected result
>  '
>
> +test_expect_success 'setup submodules' '
> +       test_tick &&
> +       git init submod &&
> +       ( cd submod && test_commit first; ) &&

Unnecessary semicolon might confuse the reader into thinking something
unusual is going on here.

> +       git add submod &&
> +       git commit -m first &&
> +       ( cd submod && test_commit second; ) &&

Ditto.

> +       git add submod &&
> +       git commit -m second
> +'
> +
> +test_expect_success 'diff-cache ignores trailing slash on submodule =
path' '
> +       git diff --name-only HEAD^ submod >expect &&
> +       git diff --name-only HEAD^ submod/ >actual &&
> +       test_cmp expect actual
> +'
> +
>  test_done
