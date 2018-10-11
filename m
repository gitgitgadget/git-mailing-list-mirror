Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01FF71F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 06:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbeJKNn6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 09:43:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56138 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeJKNn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 09:43:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id 206-v6so7707005wmb.5
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 23:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bFVfjauKy/wB+7WBTfZ//6sv9lDGSc0czvIHFu1R8CM=;
        b=KGcQaKKSYlYlQLG1LipXwTCQFpiAYDgiPAcXBlIv5r3jUJM33BF5bJr8cjLQVw8LCY
         94kwHWUGijNDppIxwoXlKRcgNTfz+/o32DjddFHdrFn2G2YBVtg4+6Lq9xwAlwnFCv36
         N4IA2tyT8dLitmRqr/KeW502f4LS7pFq0a5GfYDIJrOYd+O68HfSr2JrtH+SHcumv49j
         ANa/Aw1lfcy/2QcLWB/Xpm7aBEMJJmgZWazFQoy1gKiewTFoBjV/FTvY+aASVQA90tJH
         S+H8xAJc+DCgLEND7NHO8Vf46pOrmiNo1H5cvbsRrwzjJYddARiLG2X+Bm5NfFeLx3gw
         q48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bFVfjauKy/wB+7WBTfZ//6sv9lDGSc0czvIHFu1R8CM=;
        b=L+77PUkddauYkkUxprqweFjiwDJ7XJPmgrHO31sdtUQec026GY4AZhhSi6Mbk75Jvt
         wm4YnkVlbkSlgT7iSwKCkGe2RXEv3g7ts7Ox9sXRfi4tOUPm3PK3/E3TByYfVe8qHJXM
         xMo7wywbQKCnSxhz9kimUuVU1q75hFlT//5k2U2qM7rC4IHDS0b4sHwBRBnJxpFVbxbM
         uzfz8h7Ql0JgvIBPEBPxxqLoLDCj3JUhx4yh07KeoL0pJ8Jpcn6iPXpx3q1G68Rnzu4i
         hlSA+W6KBwVi1mpzyJ6qOoTxrB0NOphMzagnO1t8wDDPL9rKPZurbm/C9EZPFqROipPn
         5/zQ==
X-Gm-Message-State: ABuFfojYtJNpA/AzaXbt6TPEZeIRMUnWXsRm/SqVsSFlII4I59THS4nV
        9zC7Rou85w8I5mKjknDM39k=
X-Google-Smtp-Source: ACcGV63SiYHh39c7t783WOim2+38hVIUahMc/EBdwfgJU0ezO2m0WJihKIK1Kojebvf+UIrNvnVipw==
X-Received: by 2002:a1c:bc82:: with SMTP id m124-v6mr468710wmf.47.1539238691015;
        Wed, 10 Oct 2018 23:18:11 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o126-v6sm18197268wmo.3.2018.10.10.23.18.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 23:18:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     git@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH 3/3] send-email: also pick up cc addresses from -by trailers
References: <20181010111351.5045-1-rv@rasmusvillemoes.dk>
        <20181010111351.5045-4-rv@rasmusvillemoes.dk>
Date:   Thu, 11 Oct 2018 15:18:09 +0900
In-Reply-To: <20181010111351.5045-4-rv@rasmusvillemoes.dk> (Rasmus Villemoes's
        message of "Wed, 10 Oct 2018 13:13:51 +0200")
Message-ID: <xmqqd0shgg66.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rasmus Villemoes <rv@rasmusvillemoes.dk> writes:

> @@ -1681,7 +1681,7 @@ sub process_file {
>  	# Now parse the message body
>  	while(<$fh>) {
>  		$message .=  $_;
> -		if (/^(Signed-off-by|Cc): (.*)/i) {
> +		if (/^([a-z-]*-by|Cc): (.*)/i) {

So this picks up anything-by not just s-o-by, which sort of makes sense.

> @@ -1691,7 +1691,9 @@ sub process_file {
>  			if ($sc eq $sender) {
>  				next if ($suppress_cc{'self'});
>  			} else {
> -				next if $suppress_cc{'sob'} and $what =~ /Signed-off-by/i;

We used to only grab CC or Signed-off-by (and specifically not
something like "Not-Signed-off-by") upfront above, so matching
/Signed-off-by/ was sufficient (it would have been sufficient to
just look for 's').  But to suppress s-o-b and keep allowing via
misc-by a trailer "Not-signed-off-by:", we now ...

> +				next if $suppress_cc{'sob'} and $what =~ /^Signed-off-by$/i;

... must make sure what we have is _exactly_ "signed-off-by" when
'sob' is suppressed.  Makes sense.

> +				next if $suppress_cc{'misc-by'}
> +					and $what =~ /-by$/i and $what !~ /^Signed-off-by$/i;

And this is the opposite side of the same coin, which also makes sense.

I wonder if it would make it easier to grok if we made the logic
inside out, i.e.

	if ($sc eq $sender) {
		...
	} else {
		if ($what =~ /^Signed-off-by$/i) {
			next if $suppress_cc{'sob'};
		} elsif ($what =~ /-by$/i) {
			next if $suppress_cc{'misc'};
		} elsif ($what =~ /^Cc$/i) {
			next if $suppress_cc{'bodycc'};
		}
		push @cc, $c;
		...
	}

>  				next if $suppress_cc{'bodycc'} and $what =~ /Cc/i;
>  			}
>  			if ($c !~ /.+@.+|<.+>/) {
