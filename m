From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/9] fetch: fetch submodules in parallel
Date: Mon, 31 Aug 2015 11:56:04 -0700
Message-ID: <xmqqtwrfuw1n.fsf@gitster.mtv.corp.google.com>
References: <1440724495-708-1-git-send-email-sbeller@google.com>
	<1440724495-708-8-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
	johannes.schindelin@gmx.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 20:56:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWUFY-00075w-M0
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 20:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992AbbHaS4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 14:56:07 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35908 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428AbbHaS4G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 14:56:06 -0400
Received: by pabpg12 with SMTP id pg12so15341024pab.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 11:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=i5AiKZUgUF1q4iKoRFP4XqZ82/SgVplhQVUsnFpAQvE=;
        b=NxMGagdA+9nwCMXV3ABx8ANRXn9VCYvcigas7FLKGwWxRWvS4gDCx5MFs2DZE6uBD/
         6ShvdBMrZy9NR1/iwmN/jbAcCjhrksGcevMP7AYSwW7/KKV34y6a6pgiF5ZK82Fgde1L
         gWgnXpw3hZLGkLsExbS/JzAWUMiCz9lYdRSdauRueITB3chLEaHuzLKIYlXE8k/9QhHG
         Z0YaqRgr8EVQqtsh9VI5c7Rnl285QOU8aln00kPrW5z0/z4ahSgZT24g0Rog2Jf5bs8V
         99V+vJ5xoK0x7SA09IWFEcO0Ufz4OW/QCSrpDf2rIUkFYDea+IB2OxMKWpzRed6jq0Ld
         NvLQ==
X-Received: by 10.66.163.161 with SMTP id yj1mr37544898pab.34.1441047366097;
        Mon, 31 Aug 2015 11:56:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1937:16f4:ede1:6d38])
        by smtp.gmail.com with ESMTPSA id hs11sm15442477pdb.12.2015.08.31.11.56.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 31 Aug 2015 11:56:05 -0700 (PDT)
In-Reply-To: <1440724495-708-8-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 27 Aug 2015 18:14:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276911>

Stefan Beller <sbeller@google.com> writes:

> +static void destroy_output_mutex()

static void destroy_output_mutex(void)

> +{
> +	pthread_mutex_destroy(&output_mutex);
> +}
> +
> +#else
> +#define set_output_mutex()
> +#define destroy_output_mutex()
> +#define lock_output_mutex()
> +#define unlock_output_mutex()
> +#endif
> +
> +static struct submodule_parallel_fetch *submodule_parallel_fetch_create()

static struct submodule_parallel_fetch *submodule_parallel_fetch_create(void)
