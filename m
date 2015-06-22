From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 04/19] for-each-ref: add '--points-at' option
Date: Mon, 22 Jun 2015 18:38:18 -0400
Message-ID: <CAPig+cRzZDa4LyEpzVcODYCdwxoHPRJ3hqjEvSWdBsKi3Ti7nA@mail.gmail.com>
References: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
	<1434919705-4884-1-git-send-email-karthik.188@gmail.com>
	<1434919705-4884-4-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 00:38:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7AMO-0002j3-JW
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 00:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbbFVWi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 18:38:26 -0400
Received: from mail-yh0-f41.google.com ([209.85.213.41]:34170 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbbFVWiT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 18:38:19 -0400
Received: by yhnv31 with SMTP id v31so82297323yhn.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 15:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=R+/FKytdMgaAsG9P8Fqm3TUCDryjwbeG9nYHOyqKbCs=;
        b=hGFaI8i1Vjprl2zIhjJ3LEcQW+2ojRzk+b1j9ay4M0bJjYZNFWVUFWNYbF5IJ/pGAG
         JiprCGC/JNL/VQgjZ1oGoQbvQSrloUU041okUrwkfeZ9djwa17igrIH0FPce+svdX0xo
         pXazphO/zlHk0ondacsNW33jHIJBYtNJCB0Zo4cuzjQPa+FQVYpyUe9X0DXrRocL/lW6
         GtClksvNu2hTbtehzqgRsGv7hfhsFcAz5ukp92N17VUQ3BFZbn1GWlATjQvN+dihsbmG
         UDHrt6vw5cD4EAuFRV1R+os8nvHUjRMhNfmarfaL88rLnNJzjqnvBhy0vZ8feI95uHob
         O3Yg==
X-Received: by 10.129.70.137 with SMTP id t131mr39159496ywa.4.1435012698319;
 Mon, 22 Jun 2015 15:38:18 -0700 (PDT)
Received: by 10.37.36.214 with HTTP; Mon, 22 Jun 2015 15:38:18 -0700 (PDT)
In-Reply-To: <1434919705-4884-4-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: fE0WJ9I7uZ_XDlLGkHVoTPf75mU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272430>

On Sun, Jun 21, 2015 at 4:48 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Add the '--points-at' option provided by 'ref-filter'. The
> option lets the user to pick only refs which point to a particular
> commit.
>
> Add documentation and tests for the same.
>
> Based-on-patch-by: Jeff King <peff@peff.net>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/t/t6301-for-each-ref-filter.sh b/t/t6301-for-each-ref-filter.sh
> index b1fa8d4..67de3a7 100755
> --- a/t/t6301-for-each-ref-filter.sh
> +++ b/t/t6301-for-each-ref-filter.sh
> @@ -16,4 +16,24 @@ test_expect_success 'setup some history and refs' '
>         git update-ref refs/odd/spot master
>  '
>
> +test_expect_success 'filtering with --points-at' '
> +       cat >expect <<-\EOF &&
> +       refs/heads/master
> +       refs/odd/spot
> +       refs/tags/three
> +       EOF
> +       git for-each-ref --format="%(refname)" --points-at=master >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'check signed tags with --points-at' '
> +       cat >expect <<-\EOF &&
> +       refs/heads/side
> +       refs/tags/four
> +       refs/tags/signed-tag four
> +       EOF
> +       git for-each-ref  --format="%(refname) %(*subject)" --points-at=side >actual &&

s/for-each-ref\s+/for-each-ref /

> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.4.3.439.gfea0c2a.dirty
