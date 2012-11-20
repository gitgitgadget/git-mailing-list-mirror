From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: Auto-repo-repair
Date: Tue, 20 Nov 2012 06:56:17 -0500
Message-ID: <CAM9Z-n=tAcpQHTU7WHhzZkoVL_ar9vcH8G1tKd-026+djAiJ4A@mail.gmail.com>
References: <CAM9Z-nmu2MiE9vF9T6Aw8vFTR8mTkuR3akHgZX6+=n3uA4fmpA@mail.gmail.com>
	<fd162e10-46a8-433c-80b2-c1c4185c2032@zcs>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Enrico Weigelt <enrico.weigelt@vnc.biz>
X-From: git-owner@vger.kernel.org Tue Nov 20 12:56:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TamRN-00008E-OF
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 12:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753129Ab2KTL4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 06:56:19 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:42414 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753111Ab2KTL4T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 06:56:19 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so2360000bkw.19
        for <git@vger.kernel.org>; Tue, 20 Nov 2012 03:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2OqLElKxQgTKRS1MBl9JTvrtAynEzm6+W3Yk2qxSg9Y=;
        b=AHXzwvaVJSTnn0HZhruw0rS6gSdBJUJXjHCFildqUWdQriZwaER2pEKqZxkCAIStB/
         J+saIV2aoVMSPc1D20f/xApShJBejOMIR8+PSGhZY0wj41gcuANzDNwLpsToZ0jc3ByE
         Vr1lBeFyYUv2ENqVcL5nseMBLKNpUGkUsVaOqsTgt9oK1Dp/OMjNE7GEa0gxAfK8QrTc
         /jG1QakS53z2jChBHSEQECVpUkx4V3s+l+nIwpWGPX2dLowvzZPJp49WJZeM88/wGf4J
         sEGEBwTaJx+tqvPlSd/LKlTERGwglbxgJsCobL0J+Vp8scgKheOMDpUCCHftZz+Y1fcI
         9fqQ==
Received: by 10.204.9.147 with SMTP id l19mr6178329bkl.15.1353412577920; Tue,
 20 Nov 2012 03:56:17 -0800 (PST)
Received: by 10.205.122.144 with HTTP; Tue, 20 Nov 2012 03:56:17 -0800 (PST)
In-Reply-To: <fd162e10-46a8-433c-80b2-c1c4185c2032@zcs>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210093>

On Mon, Nov 19, 2012 at 5:35 PM, Enrico Weigelt <enrico.weigelt@vnc.biz> wrote:
>
>> >> How would the broken repository be sure of what it is missing to
>> >> request it from the other side?
>> >
>> > fsck will find missing objects.
>>
>> And what about the objects referred to by objects that are missing?
>
> Will be fetched after multiple iterations.
> We could even introduce some 'fsck --autorepair' mode, which triggers
> it to fetch any missing object from its remotes.
>
> Maybe even introduce a concept of peer object stores, which (a bit like
> alternates) are asked for objects that arent locally availabe - that
> could be even a plain venti store.

I still think that it would make the most sense to do the following
(if you insist on some sort of automated repair):
(1) Fetch a "good" clone (or clones) into a temporary directory;
(2) Cannibalize the objects from it (them);
(3) Re-run git fsck and check for still-missing / unreachable items;
(4) IF THE RESULT OF (3) IS ACCEPTABLE, run git gc to clean up the
mess, discard / "merge" duplicate objects, and fix up the packfiles.

It is step (4) that requires the most user interaction. I could see
building up a shell script that does all but (4) nearly automatically.
None of this requires modifying Git itself.

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
