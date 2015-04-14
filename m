From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/4] stash -p: demonstrate failure of split with mixed y/n
Date: Tue, 14 Apr 2015 16:46:15 -0400
Message-ID: <CAPig+cQSyjNSxixEOVjR1CTTzPfT5kT9sbdGMLa1n3K_1zEHfA@mail.gmail.com>
References: <vpq7ftfkpue.fsf@anie.imag.fr>
	<1429011168-23216-1-git-send-email-Matthieu.Moy@imag.fr>
	<1429011168-23216-5-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Apr 14 22:46:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yi7iw-0007Yi-2g
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 22:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754763AbbDNUqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 16:46:18 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:35563 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754451AbbDNUqR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 16:46:17 -0400
Received: by lbbuc2 with SMTP id uc2so18557740lbb.2
        for <git@vger.kernel.org>; Tue, 14 Apr 2015 13:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=jM2F1mNyuEtIW5VwxaPApY+AabOZ1RYXccEF+pw+eBA=;
        b=BcfaigrkGr9FLrDZb1TbuPnEfnQuK/8SWBqZ0NpdusBmiIyKQsRQuIx8ja/8KoFOIw
         wr9nZRTPjoJtM0uMaDXN0Wz8DRAEtwOg2JuD2k1jQkdASxcRMGhB7bRLCu/xOepJGEvG
         PbDmp/iqNIrSXpQMea56LjIy68N7mBtBYt9GqqC9SoMk6IOrDN+Zjq3OPu9r+bm0PHU0
         zTCGNQftbDBoykfl2QZ6v2ZZeXX7uv+HPu81HFq8YX5Z2eP3kNzB6X+FP+sWfnpD9hwN
         ZJTMuCJCT5Wzldr8BtOY4oJIjwIj+UQVBEg4BJE9d5OdsUzmRf9e21zC76G+XBFw+2jc
         rKcA==
X-Received: by 10.112.168.102 with SMTP id zv6mr20712978lbb.45.1429044375682;
 Tue, 14 Apr 2015 13:46:15 -0700 (PDT)
Received: by 10.114.25.193 with HTTP; Tue, 14 Apr 2015 13:46:15 -0700 (PDT)
In-Reply-To: <1429011168-23216-5-git-send-email-Matthieu.Moy@imag.fr>
X-Google-Sender-Auth: wglNJFW8FVf07dmXFJ8xYcdAZKM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267162>

On Tue, Apr 14, 2015 at 7:32 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> diff --git a/t/t3904-stash-patch.sh b/t/t3904-stash-patch.sh
> index 0f8f47f..6f053ff 100755
> --- a/t/t3904-stash-patch.sh
> +++ b/t/t3904-stash-patch.sh
> @@ -81,4 +81,30 @@ test_expect_success 'none of this moved HEAD' '
>         verify_saved_head
>  '
>
> +test_expect_failure 'stash -p with split hunk' '
> +       git reset --hard &&
> +       cat >test <<-\EOF &&
> +       aaa
> +       bbb
> +       ccc
> +       EOF
> +       git add test &&
> +       git commit -m "initial" &&
> +       cat >test <<-\EOF &&
> +       aaa
> +       added line 1
> +       bbb
> +       added line 2
> +       ccc
> +       EOF
> +       for a in s n y q
> +       do
> +               echo $a
> +       done |

Simplified:

    printf '%s\n' s n y q |

> +       test_might_fail git stash -p 2>error &&
> +       ! test_must_be_empty error &&
> +       grep "added line 1" test &&
> +       ! grep "added line 2" test
> +'
> +
>  test_done
> --
> 2.4.0.rc1.42.g9642cc6
