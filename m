From: Dmitry Gutov <dgutov@yandex.ru>
Subject: Re: How do I resolve conflict after popping stash without
 adding the file to index?
Date: Wed, 22 Apr 2015 01:35:05 +0300
Message-ID: <5536D099.1000103@yandex.ru>
References: <5535697E.2030204@yandex.ru> <xmqqsibujyit.fsf@gitster.dls.corp.google.com> <553583C0.6090404@yandex.ru> <20150421212922.GC13230@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 22 00:35:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ykgl9-0003sx-W6
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 00:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755941AbbDUWfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 18:35:10 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:33172 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753843AbbDUWfI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 18:35:08 -0400
Received: by wiax7 with SMTP id x7so117330411wia.0
        for <git@vger.kernel.org>; Tue, 21 Apr 2015 15:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=SCaoy+zst0pGS2p6BY0tCdrgHgqEvXb1ygtffwHXPHw=;
        b=YgG1RUoq62TKuBBfHfEx9upqL4KMg3G5MSERN9L7aqg4RgVCgnbY8SQaQMQsfaMMOz
         Reo8wk/ycIgKJj8WHuHaMcWuwIesP98EbcqnGeNTveX25AJPyQmQdqrcEQW4c8CqcVW7
         e8lDDJken6CBYTgdRt8jq+XW41osVY5CNGQkYBlkizEX+sQuZEqwlJXf64D+tSPQ2KZA
         D4dw1WzZ49aCsoz7T7qpEP9LnBLrtpf4ojIhPAlQzm+hUlWg7H0Lj3mTBbUzpxoHZ3aj
         J8fp/WKpukf8j5idwgGAZtQ36V0UPmt2elWFpltXQd6wnJ154rP8WyOTwsI9bQBL+aFk
         /h/g==
X-Received: by 10.180.84.130 with SMTP id z2mr465141wiy.42.1429655707547;
        Tue, 21 Apr 2015 15:35:07 -0700 (PDT)
Received: from [192.168.1.2] ([82.102.93.54])
        by mx.google.com with ESMTPSA id o6sm21578586wiz.24.2015.04.21.15.35.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Apr 2015 15:35:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:36.0) Gecko/20100101 Thunderbird/36.0
In-Reply-To: <20150421212922.GC13230@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267562>

On 04/22/2015 12:29 AM, Jeff King wrote:

> Hmm, interestingly, if you do _not_ stage the changes (i.e., drop the
> final "git add" there), you get:
>
>    $ git stash pop
>    error: Your local changes to the following files would be overwritten by merge:
> 	test
>    Please, commit your changes or stash them before you can merge.
>    Aborting
>
> which makes sense. Writing conflict markers into the file would leave
> you in a situation where it is hard to recover the "bbbbb" content.

Indeed.

> But we seem to skip that safety valve when the content has been staged,
> which seems questionable to me (technically we are slightly better off
> than the protected case because "bbbbb" was written to a git blob
> object, so you can recover it.  But it may be difficult to find the
> correct blob in the object database).

Any suggestions how to restore that content in the index 
programmatically? If it's non-trivial to do, maybe that is indeed a bug, 
and 'git stash pop' should abort before creating the conflict.
