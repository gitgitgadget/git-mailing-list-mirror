From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v11 11/13] tag.c: use 'ref-filter' APIs
Date: Mon, 17 Aug 2015 12:00:31 -0700
Message-ID: <xmqq1tf1eo4w.fsf@gitster.dls.corp.google.com>
References: <1439661643-16094-12-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 21:00:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRPeA-0000H4-TZ
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 21:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbbHQTAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 15:00:34 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35749 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbbHQTAd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 15:00:33 -0400
Received: by pdob1 with SMTP id b1so3297122pdo.2
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 12:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=6IzANtiZ/7FuR2tp8uVxiph7F4zg0LegPxTK0KvvMtQ=;
        b=m3oJPNwZ1cXrHr1UcMjQr6r4WWnq0H46z2FxGm7NE4RXqC5jkeYIsi+yucxRCs8rX1
         WGruA0rS4s1wFrvzpHog/2a0h3Ljz/FGOD9AnQ+y8zGpfS3X97bQxQJR4wuGZ3qK5qll
         6wpuMFrXBN+qSvaUIylPggQGVdZH/k9LN0VUrCh+S28GCQYNF+a7UuV6GT6cZ9mndQ82
         GIXjr3N8CJvDeQ3WVT3tP/1MTPlqb7sfKiatmQA5G0qcyKD5dOQMiZXQbhkjJkCLtCzC
         e35SAGD4l9uyosBgOTUPsrjXrJpjsu7e+Xg5wVrjSl5NisPEcboBsNLwZlKWLoCZ9fOx
         BVJg==
X-Received: by 10.70.42.110 with SMTP id n14mr5290013pdl.133.1439838033067;
        Mon, 17 Aug 2015 12:00:33 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4db:7e94:b576:3da])
        by smtp.gmail.com with ESMTPSA id bu1sm15510690pdb.35.2015.08.17.12.00.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Aug 2015 12:00:31 -0700 (PDT)
In-Reply-To: <1439661643-16094-12-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Sat, 15 Aug 2015 23:30:41 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276073>

Karthik Nayak <karthik.188@gmail.com> writes:

> We improve the sorting option provided by 'tag.c' by using the sorting
> options provided by 'ref-filter'. This causes the test 'invalid sort
> parameter on command line' in t7004 to fail, as 'ref-filter' throws an
> error for all sorting fields which are incorrect. The test is changed
> to reflect the same.
> ...
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index d31788c..1f066aa 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -1462,13 +1462,7 @@ test_expect_success 'invalid sort parameter on command line' '
>  
>  test_expect_success 'invalid sort parameter in configuratoin' '
>  	git config tag.sort "v:notvalid" &&
> -	git tag -l "foo*" >actual &&
> -	cat >expect <<-\EOF &&
> -	foo1.10
> -	foo1.3
> -	foo1.6
> -	EOF
> -	test_cmp expect actual
> +	test_must_fail git tag -l "foo*" >actual
>  '

You don't have to redirect the output to "actual", then.
