From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 00/12] port tag.c to use ref-filter APIs
Date: Mon, 24 Aug 2015 10:27:19 -0700
Message-ID: <xmqqy4h04mx4.fsf@gitster.dls.corp.google.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 19:27:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTvWo-0001jG-4P
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 19:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754988AbbHXR1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 13:27:21 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35150 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754613AbbHXR1V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 13:27:21 -0400
Received: by pacdd16 with SMTP id dd16so101616143pac.2
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 10:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=NaswRQ6e/wJTi5S1pb8aOPdEARPZDN9BO8xRYNmNCs4=;
        b=rI0Nqmh1AgEYactre+wDHHDGjzDjgkFaeQHsIyVETg1B3w33J1+5NV7RmSyDjxcZiH
         XtD1B/42TX6c9JIPJJBucgBgBQOA2rYEyrMOi6sukzq2zQEZss/0sEjFFQBcWt+wiQ/L
         FWxnA9CJf6HwZutEEXyXUsIUlMc1MYG7hkHVBx56nlRuyyMEU7AeIlsoo2EDSnwDDLhw
         UEVmzJOLEdX/SUIokw5Rux5/WDNxK1WRDGw13t8HuStiFLg3MEUnDQKQWkGfmocgMVV8
         i4yKzgZUCC0yPd4uLxhvVQW1snujccti15KjlleT3rjRA74N2acV4pb574WzjX2Q/e0L
         AzFg==
X-Received: by 10.67.8.106 with SMTP id dj10mr37331372pad.123.1440437240735;
        Mon, 24 Aug 2015 10:27:20 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:813d:881a:159:a8e7])
        by smtp.gmail.com with ESMTPSA id i7sm18085712pdo.84.2015.08.24.10.27.19
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 24 Aug 2015 10:27:19 -0700 (PDT)
In-Reply-To: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Sat, 22 Aug 2015 09:09:36 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276467>

Karthik Nayak <karthik.188@gmail.com> writes:

> Interdiff:
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 1997657..06d468e 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -133,7 +133,8 @@ align::
>  	`<position>` is either left, right or middle and `<width>` is
>  	the total length of the content with alignment. If the
>  	contents length is more than the width then no alignment is
> -	performed.
> +	performed. If used with '--quote' everything in between %(align:..)
> +	and %(end) is quoted.

That sounds like a buggy behaviour that we may want to fix later,
though.  Perhaps document it as a known bug, e.g. "Currently it does
not work well when used with language-specific quoting like --shell,
etc." (while punting on fixing the implementation for now)?
