From: Junio C Hamano <gitster@pobox.com>
Subject: Re: More builtin git-am issues..
Date: Fri, 04 Sep 2015 18:06:43 -0700
Message-ID: <xmqqd1xxekt8.fsf@gitster.mtv.corp.google.com>
References: <CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPxgK0KQGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Sep 05 03:10:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZY1zo-0005ME-Me
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 03:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935009AbbIEBHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 21:07:32 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35448 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934974AbbIEBGp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 21:06:45 -0400
Received: by pacfv12 with SMTP id fv12so39624712pac.2
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 18:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=nldSBwZml5Mh9ydT1KX4JX9NB+kvX1POvO1z8q8Qh6c=;
        b=0Gw06VzBd1PhCPofZhY9SpzIu0T210gT0zSWLvOGbqMNGQTR9uA2TdufVFZNd+FLiv
         n5r4dwekZqnDJvPvzFU8gN+Wn+wLaCg9r5ZdpJ880MN3QNM6TI9Ghssk0mY+Iq6SOGED
         drCaBxvCOsg6s8Ecp/IjcTkuq9wCDufEZARIOkqH41kGt+Y9HpC97xF8+rxk4UgYYNN1
         s1ND+ad/YYpKTbDi2e5i9XZ5mzLVChodyGVmbXC0YIPf2FAoyMlyEEdGGcftIjznAEtr
         ZvyfzbPUQUi7NXtn4CCekOu6xIATyUDH6MFGsFExaiy3c8jYuu5eH39jqbZ9LSs7r7M2
         YzYw==
X-Received: by 10.66.122.4 with SMTP id lo4mr14520020pab.1.1441415204851;
        Fri, 04 Sep 2015 18:06:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:20fa:dab1:6d64:e4c9])
        by smtp.gmail.com with ESMTPSA id fi5sm3894640pdb.5.2015.09.04.18.06.43
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 04 Sep 2015 18:06:44 -0700 (PDT)
In-Reply-To: <CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPxgK0KQGw@mail.gmail.com>
	(Linus Torvalds's message of "Fri, 4 Sep 2015 16:47:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277355>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> but the failing cases have a comment by Andrew:
>
>     [akpm@linux-foundation.org: coding-style fixes]
>     Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
>     Cc: Xishi Qiu <qiuxishi@huawei.com>
>     Cc: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
>     Cc: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
>     Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>
>     Cc: Gu Zheng <guz.fnst@cn.fujitsu.com>
>     Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>     Cc: Vlastimil Babka <vbabka@suse.cz>
>     Cc: Mel Gorman <mgorman@techsingularity.net>
>     Cc: David Rientjes <rientjes@google.com>
>     Cc: <stable@vger.kernel.org>        [4.2.x]
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>
> ie that "[akpm@linux-foundation.org: coding-style fixes]" makes git am
> now decide that the previous block of text was not a sign-off block,
> so it adds an empty line before adding my sign-off. But very obviously
> it *was* a sign-off block.

Ahh, OK, scratch what I said earlier.  The user intended this to be
sign-off block, but the convention append_signoff() was taught from
very earlier days is that the sign-off block must consist of block
of text all of which look like rfc2822 "keyword: value" header lines,
and the comment thing makes it a non-conforming header.

Perhaps

    A block of text at the end of the existing text could be a
    signature block.  If all its lines that are rfc2822-like are at
    its end, then it is a sign-off block.  Otherwise it is not.

would allow the leading non-signature lines in the above example.

If the comment line (which I would say should have been separated by
a blank line from the signature block if only to make it easier to
read the whole thing) were in the middle, e.g.

>     Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
>     Cc: Xishi Qiu <qiuxishi@huawei.com>
>     Cc: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
>     Cc: Vlastimil Babka <vbabka@suse.cz>
>     Cc: Mel Gorman <mgorman@techsingularity.net>
>     [akpm@linux-foundation.org: coding-style fixes]
>     Cc: David Rientjes <rientjes@google.com>
>     Cc: <stable@vger.kernel.org>        [4.2.x]
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

that rule would still not think this is a signature block, but at
that point, do we really want to consider such a block of text a
signature block?
