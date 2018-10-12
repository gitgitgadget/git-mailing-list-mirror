Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57DA21F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 14:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbeJLVyu (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 17:54:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37657 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbeJLVyu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 17:54:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id 185-v6so13172424wmt.2
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 07:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6v3Ll8DgA9M/JEtj4SSBYXeYCGVDoR+dK1TgC3kPXFw=;
        b=eqqvKh+yLs3XS5MsxOHaKaZHqwati/RRl0Z9b3PlPEdDAO/QyRZJyZcfZlc/b7CDW5
         UZKoZ2mNfA+MbWmDe9ZJxJZmA+3Fjp84Y6QlW7/8bMobAaw5mSRkBZMwJ7SPKujBtixY
         GSyODoZHTa8GY1jgVhEIAlTf8THEDCokk4kXIccGaqCBKo7X7ucuD8oBjQDfBvwg2igr
         zaBqHY+mi3/ubSpHsibXkmsXQwOj6YT8WW9v0IQ/uq4VNqLtflx/Mobagz0Ppx1bly62
         t2m59V9QkDsqlDc5x3mgmYsRrhbkkuW2nLFeMWk58/dbsOFF445o8bamvh1Yco8otbwf
         IFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6v3Ll8DgA9M/JEtj4SSBYXeYCGVDoR+dK1TgC3kPXFw=;
        b=SEA3Hwd72yikjZHCx5yrU1n1WIyoxKbxRkf61RwMR3+ipol8nsNq/CAfWdHrj9ujY4
         eP/qgo30DxMq4OEXpvBSlyTGdc35twVwWCD41GSWDoAnRJOgkNLIFpdQ5Kig2kKybdI7
         GCQr3vOQOSK+KfjkG5Uic55hNgAt/HEmBa6oFsSge/8Ie0NGq/uD2gLyqsuAecgS6fs+
         MUtaQeOqEGrrUnX9gAd3fplypepFRWloWI9y1Qyz7eSJW/TQeVFnwOW6ZnRHxELLmfKn
         BxemAw9qyCD9c5I9fKAuKsOadqgokC23BkGTQ9okrc6Y9f8XBNXqLnWOErQdrtL5vUNy
         5T8g==
X-Gm-Message-State: ABuFfoi2arLmNXvXRBzoUWg8q6mKnDZN4JenGiR1G/yBgOLwPcNAUY/M
        2x1/HeHMcaYP7TIhJllRz84=
X-Google-Smtp-Source: ACcGV62iwZV9DmooA0pWqiAFCAQGxvRFK3SaGl+KiV6IlX9SNvEaiIHGnF/BUeFPe7j1p9/FlPEtbA==
X-Received: by 2002:a1c:89cd:: with SMTP id l196-v6mr5253889wmd.7.1539354128764;
        Fri, 12 Oct 2018 07:22:08 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 12-v6sm2230575wms.11.2018.10.12.07.22.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 07:22:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Roger Strain <rstrain@swri.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] subtree: performance improvement for finding unexpected parent commits
References: <20181012135218.14439-1-rstrain@swri.org>
Date:   Fri, 12 Oct 2018 23:22:06 +0900
In-Reply-To: <20181012135218.14439-1-rstrain@swri.org> (Roger Strain's message
        of "Fri, 12 Oct 2018 08:52:18 -0500")
Message-ID: <xmqqmurj9re9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Roger Strain <rstrain@swri.org> writes:

> After testing a previous patch at larger scale, a performance issue was
> detected when using git show to locate parent revisions, with a single
> run of the git show command taking 2 seconds or longer in a complex repo.
> When the command is required tens or hundreds of times in a run of the
> script, the additional wait time is unaccepatable. Replacing the command
> with git rev-parse resulted in significantly increased performance, with
> the command in question returning instantly.
>
> Signed-off-by: Roger Strain <rstrain@swri.org>
> Thanks-to: Junio C Hamano <gitster@pobox.com>

That usually is spelled as "Helped-by:".

Will queue.  Thanks.

I still find it disturbing not to know why "show -s --format=..."
takes measurable time, though.  "-s" means "we do not need any diff
output", so it ought to be comparable to "git cat-file commit $rev"
with some formatting, but apparently your repository is making Git
spend a lot more than that.  Puzzled...

> ---
>  contrib/subtree/git-subtree.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 1c157dbd9..147201dc6 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -633,7 +633,7 @@ process_split_commit () {
>  	else
>  		# processing commit without normal parent information;
>  		# fetch from repo
> -		parents=$(git show -s --pretty=%P "$rev")
> +		parents=$(git rev-parse "$rev^@")
>  		extracount=$(($extracount + 1))
>  	fi
