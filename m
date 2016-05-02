From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 04/14] connect: rewrite feature parsing to work on
 string_list
Date: Mon, 02 May 2016 14:18:41 -0400
Organization: Twitter
Message-ID: <1462213121.4123.58.camel@twopensource.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
	 <1461972887-22100-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon May 02 20:18:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axIQi-0000wB-D9
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 20:18:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754784AbcEBSSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 14:18:45 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:35549 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754511AbcEBSSo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 14:18:44 -0400
Received: by mail-qg0-f51.google.com with SMTP id f74so72993100qge.2
        for <git@vger.kernel.org>; Mon, 02 May 2016 11:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=24hX6db1LvqrvF68z2rXe1XFOLMecf6uE9Xodik/1mg=;
        b=1otLi4d5Zg/SrOnUtjRIlmGbFcHOQfNM6re2YW0Fi9KfLEnExnZIPsuBkxyMp6Ml4Z
         deAKDd/yhD0mgQhLujjy1sC8N+gIio8YB4zXxIjdl8jdQ9dKAZJVTu5w97KHkqI2Jc7I
         h6sC8rra5QuozrcBryMfeFW0mng9xJGPc4XsA9WnKYDUT07UZQAveEUb2f7WdyftP2Xv
         5kvBJUofKqWXHsbyaKRvufUIi4Kg1ErAuwO8CfEKv0kPsVUtHn/0CRxJZSwpGWCQIRWV
         Jb5ie27rASTuAUmSPAVrBHaF195z2DvqB2BbqXau2moLosi6sI/KKSYmJiuGg9ogXpgT
         sQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=24hX6db1LvqrvF68z2rXe1XFOLMecf6uE9Xodik/1mg=;
        b=ADVl5zOU8iCPkYNC6z2ZvQq+FrGRLFIIC8NgDklrO16P0Inw0mBTtRR7FFCpi/yEjv
         P9omaXXAuNHODQujeJDG41RvpnHW6W3S+Wt1U071I81uTCPAw/17kreF19Gk+ruEI6rV
         9nhjMmMquuBMxrEEgIKEVeesrAJaJdcY+iZhXmPhiJan806pElVaxveVC4uJ+3aNC+Pl
         jHHc6+qWYes+c4YeHK6wq1YwQfgipFHywgDM3uZPDDYmkJR+bHCAPtE/7RRTfmrMuiR8
         b5SkAGzS+FjTuTu9PKFbxV7887m2xgluwKjcZIk83OF0CS07s0nfXl2uHT5Pf+G71BkE
         EuWw==
X-Gm-Message-State: AOPr4FV/JKPThzs6DYIASlVSz73F/PMYNY4SajTYFvUjRXfT734LvyUpxJe5pMdqrqagRw==
X-Received: by 10.140.102.193 with SMTP id w59mr33155562qge.58.1462213123165;
        Mon, 02 May 2016 11:18:43 -0700 (PDT)
Received: from ubuntu ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id j15sm9568920qge.0.2016.05.02.11.18.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 02 May 2016 11:18:42 -0700 (PDT)
In-Reply-To: <1461972887-22100-5-git-send-email-sbeller@google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293261>

On Fri, 2016-04-29 at 16:34 -0700, Stefan Beller wrote:
> +		if (skip_prefix(item->string, "symref", &val)) {
> +			if (!val)
> +				continue;

This if should never happen (skip_prefix returns 0 in that case).  You
probably meant !*val -- but:

> +			val++; /* skip the = */

I think you should instead skip_prefix "symref=" because:
(a) it saves some code.
(b) it allows for capabilities like symref_foo to later be added.

> +	struct string_list list = STRING_LIST_INIT_NODUP;

Maybe move the scope of list into the while loop below?

>  	char *line = packet_read_line(0, NULL);
>  	while (line) {
> -		parse_features(line);
> +		string_list_append(&list, line);
> +		parse_features(&list);
> +		string_list_clear(&list, 1);
>  		line = packet_read_line(0, NULL);

This is a bit convoluted in the one-feature-per-line case, but I guess
I understand that for the sake of generality it's useful.
