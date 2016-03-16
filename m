From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [RFC PATCH] hashmap API: introduce for_each_hashmap_entry() helper
 macro
Date: Thu, 17 Mar 2016 00:47:52 +0100
Message-ID: <56E9F0A8.5080308@gmail.com>
References: <1458146346-27959-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 00:48:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agLAa-00059y-Rq
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 00:48:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641AbcCPXr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 19:47:59 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38489 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710AbcCPXr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 19:47:58 -0400
Received: by mail-wm0-f52.google.com with SMTP id l68so94296386wml.1
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 16:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=PI6zGhE2gsx3+8mpUPNVt50Wa+pk9b4/pBBXLrkLymw=;
        b=ZT9Fc8r0gg5046YQGiJq66slBMlh4jVkC19OJTgEWjGN0+9gKYjuapDaQU+WrewQEz
         h8SiVrbeY1lOOpBhlRij+9IzIYxmuox3EQok4oR0G7aNK37BTgC8QIKOO4qh1xSWbWd+
         jttn6/JtdLnYEk8WqeGBrYP0Ze7+4fg/hSgxu3kv5mFVtGpW+quWflb164rfq6h6zVrg
         AFgbJWAVPwr8vmhAwsaSwg+K2m2/0QNt2soqgUyIMbVjNXtMLD5KPZqS7nOfJo8U/Lct
         LK9G7OyUTyi7Db9CiZjyv1Fl3QaiKXcdhSaiRItcrui45M4nNCPP7M4gO6Lr2WOh/mTK
         Z7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=PI6zGhE2gsx3+8mpUPNVt50Wa+pk9b4/pBBXLrkLymw=;
        b=T02HFAKJqp16PBXvZ50e62peAmYd4+rXxgZIJ+i8l/HQsu/J6LpqOESfliKgM1y0wd
         u8n/gxnm41XlN09T8qY70+BWnvCh3Inhk3Z5Y/i+NiJO+tT0bgJItZRpx+0hUFn4mrmv
         JO4fC3N5MkLNUJhicALPqBJV0szj9F/ikNUc8bUPIo3k/LBhBSB1bl9rcByoVDo1CB0O
         sAxEAoVpQistl01KXDz499UCP/3etznd2BeaNnwf5dIFIQF9lhn+geyLZHmEW8A0E6z8
         VNo67aCQ/yw/muoRstj3LL0iPUkY7DKCdn5U+sxdSGZCjyNYaUJYO8BP6gy/p9rFdG+s
         hbig==
X-Gm-Message-State: AD7BkJLH23/TbK+9X5sbyxo3IeRwzsAtBTy8RELs2UKfijkjbkbe+//Y7Ws29eOPZbDjlQ==
X-Received: by 10.28.45.209 with SMTP id t200mr32637517wmt.71.1458172076794;
        Wed, 16 Mar 2016 16:47:56 -0700 (PDT)
Received: from [10.1.116.51] (ns.dcon.de. [77.244.111.149])
        by smtp.googlemail.com with ESMTPSA id ux5sm5094242wjc.17.2016.03.16.16.47.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Mar 2016 16:47:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <1458146346-27959-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289062>

Am 16.03.2016 um 17:39 schrieb Alexander Kuleshov:

> There is common pattern to traverse a hashmap in git source code:
> 
>         hashmap_iter_init(map, &iter);
>         while ((entry = hashmap_iter_next(&iter)))
>              // do something with entry
> 

The hashmap_iter_first() function allows you to do this instead:

	for (entry = hashmap_iter_first(map, &iter); entry; entry = hashmap_iter_next(&iter))
		doSomething(entry);

With an appropriate macro definition, this could be simplified to:

	#define hashmap_for_each(map, iter, entry) for (entry = hashmap_iter_first(map, iter); entry; entry = hashmap_iter_next(iter))
	...
	hashmap_for_each(map, &iter, entry)
		doSomething(entry);

You would still need to declare the 'iter' and 'entry' variables, but
there is no danger of decl-after-statement or variable shadowing
mentioned by Junio. That is, you can do this:

	hashmap_for_each(map, &iter, entry)
		if (checkCondition(entry))
			break;
	// work with found entry

Or even this:

	hashmap_for_each(map, &iter1, entry1)
		hashmap_for_each(map, &iter2, entry2)
			doSomething(entry1, entry2);
