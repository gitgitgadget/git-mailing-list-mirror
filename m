From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 04/11] for-each-ref: add '--points-at' option
Date: Mon, 29 Jun 2015 10:46:19 -0700
Message-ID: <xmqqioa6be6s.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZRHoFgELMtxbZpfTvu5-S7nMTguiuOiMQDnoOs3tHXb8A@mail.gmail.com>
	<1435222633-32007-1-git-send-email-karthik.188@gmail.com>
	<1435222633-32007-4-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 19:46:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9d8g-0008Jv-CQ
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 19:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753304AbbF2Rqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 13:46:34 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:33434 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850AbbF2RqV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 13:46:21 -0400
Received: by igcur8 with SMTP id ur8so43149707igc.0
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 10:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=LkQtoJp4AXRUqfaW4k1Wu0GBNgPI5QfVeqmQkzp1Tus=;
        b=Z5p6RbSUmXd3hznlAUzB1Y1x1slH38myjO+gNYt0bL4PXmZ0PD1qjRVSYKSNL3VgK3
         T1Ml9sZRVjykVualoZnLXwmmX0Sms8UIdDHEeQWElr8DzFSEe/8ks9JPrMqrrElTDRwk
         tdtHbOxwEkWkS30Y7CPNgOs3+12saIH2Kdn386bUKqsejJavb+HvcLAvLrasd3DwFY/N
         paRWlkhB2R+eGhGMSQkKmylRW1s9MOHwxCPPylOv2hdQMKDzpuTbvvSVczU55ZafHar7
         IeJuxqh2wI6WicekVi83ENbOyTAd91m557PTRmzYAwJTOaNBCO+kRVD7PybMwlDL6EHT
         bbrg==
X-Received: by 10.50.43.227 with SMTP id z3mr17130540igl.12.1435599981225;
        Mon, 29 Jun 2015 10:46:21 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:946c:210:22fc:378d])
        by mx.google.com with ESMTPSA id e69sm28169952ioe.11.2015.06.29.10.46.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jun 2015 10:46:20 -0700 (PDT)
In-Reply-To: <1435222633-32007-4-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Thu, 25 Jun 2015 14:27:06 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272979>

Karthik Nayak <karthik.188@gmail.com> writes:

> Add the '--points-at' option provided by 'ref-filter'. The option
> lets the user to pick only refs which point to a particular
> commit.

It somehow feels strange that the option name is points-at and all
the explanation (like the above and also in the doc) talks about
pointing to an object.  Not limited to this patch but the previous
one had the same, I think.

> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index b1fa8d4..7269a66 100644
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -16,4 +16,24 @@ test_expect_success 'setup some history and refs' '
>  	git update-ref refs/odd/spot master
>  '
>  
> +test_expect_success 'filtering with --points-at' '
> +	cat >expect <<-\EOF &&
> +	refs/heads/master
> +	refs/odd/spot
> +	refs/tags/three
> +	EOF
> +	git for-each-ref --format="%(refname)" --points-at=master >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'check signed tags with --points-at' '
> +	cat >expect <<-\EOF &&
> +	refs/heads/side
> +	refs/tags/four
> +	refs/tags/signed-tag four
> +	EOF
> +	git for-each-ref --format="%(refname) %(*subject)" --points-at=side >actual &&
> +	test_cmp expect actual
> +'

This shows that we would want to add a "annotated doubly" tag in the
preparation step 01/11; the expected outcome is that it will not
show in the output, I think.

Thanks.
