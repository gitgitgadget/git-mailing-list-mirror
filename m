From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 01/11] builtin/pack-objects.c: change
 check_pbase_path() to use ALLOC_GROW()
Date: Fri, 28 Feb 2014 21:36:49 +0700
Message-ID: <CACsJy8C1Jv-7Fz=qTZ94vZCVD6s39iju2BRZdhnkSR25VoJ=Ow@mail.gmail.com>
References: <530FA3E7.8020200@yandex.ru> <531056E7.3010305@yandex.ru>
 <53105995.3010001@yandex.ru> <CACsJy8C2h13JFqh=CKvR=3TByHkxWCNR-XhK-WxA+DOE3GmvAQ@mail.gmail.com>
 <CACsJy8AmQeVb-i6Sn0BH-_ikEXPHTdtKnQRyzChX1WfD9Lj4Jw@mail.gmail.com> <53109B19.8070103@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 28 15:37:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJOZ5-0004vh-Re
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 15:37:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251AbaB1OhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 09:37:21 -0500
Received: from mail-qg0-f46.google.com ([209.85.192.46]:34328 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbaB1OhU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 09:37:20 -0500
Received: by mail-qg0-f46.google.com with SMTP id e89so2300486qgf.5
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 06:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vrvc7Y6WUNgKdXwWzx075XxEUj1IfKuwWzGOFMoSBqY=;
        b=bzzmYDVC4wnUHsPwTxhHf0bncyl49aZ/uJMhrG6FoVK+o6ZG8axAkRAGcNzms/zGxG
         wL/DUP19tdex0FI+5m2KKF6tfr3FojgbVirOhrthpz3Nj8gdCvmgI28EmVDv008NStPu
         T347qjQz4yTvdA43Cr77l4rThGgQKmS3rZyI09iWZvBzl0sUMTN6BTvJURrsOPFOzp0Z
         RrlSs1X2awA7uJYVIOEyQirNf0npbKMEe+PUXogEJO0rJi38RtXXfU1V3wEfWhC8q/cl
         SbHIQbnpHMvguHVpl8oQGKg7fb+LUdxAyVJXHcK6qybcfQ2eqIlKLAImez0Id5UpkBhK
         jXmQ==
X-Received: by 10.140.93.130 with SMTP id d2mr3761396qge.41.1393598239477;
 Fri, 28 Feb 2014 06:37:19 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Fri, 28 Feb 2014 06:36:49 -0800 (PST)
In-Reply-To: <53109B19.8070103@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242968>

On Fri, Feb 28, 2014 at 9:20 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Duy,
>
> The example in Documentation/technical/api-allocation-growing.txt does
> it the same way as Dmitry:
>
>     ALLOC_GROW(item, nr + 1, alloc);
>     item[nr++] = value you like;
>
> The alternative,
>
>     nr++;
>     ALLOC_GROW(item, nr, alloc);
>     item[nr] = value you like;
>
> is an extra line, which is at least a small argument for the variant
> shown in the docs.  (Since ALLOC_GROW is a macro, it is not OK to use
> "++nr" as its second argument.)  Personally, I also prefer the shorter
> version.  The line
>
>     item[nr++] = value
>
> is an easy-to-recognize idiom, and
>
>     ALLOC_GROW(item, nr + 1, alloc);
>
> somehow makes it more transparent by how much more space will be needed.
>
> So my vote is that the patches are OK the way Dmitry wrote them (mind, I
> have only read through 05/11 so far).

I'm not saying all patches should do

nr++;
ALLOC_GROW(item, nr, alloc);

only those that do

if (..) realloc...;
nr++;
....

should be reordered. Those changes that do item[nr++] = yyy should be
kept. Anyway it's just an observation, not something that should block
these patches.
-- 
Duy
