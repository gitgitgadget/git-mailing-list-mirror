From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 4/4] bundle v3: the beginning
Date: Thu, 3 Mar 2016 08:36:40 +0700
Message-ID: <CACsJy8AzZsC3_7mWQutko8W=X1Lch3bMZRjoHtjVnWwtbMBt7A@mail.gmail.com>
References: <xmqqfuw84uhb.fsf@gitster.mtv.corp.google.com> <1456950761-19759-1-git-send-email-gitster@pobox.com>
 <1456950761-19759-5-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 02:37:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abICc-00019G-Io
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 02:37:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753797AbcCCBhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 20:37:13 -0500
Received: from mail-lb0-f172.google.com ([209.85.217.172]:35882 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbcCCBhL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 20:37:11 -0500
Received: by mail-lb0-f172.google.com with SMTP id x1so6028054lbj.3
        for <git@vger.kernel.org>; Wed, 02 Mar 2016 17:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cNfDYUuA+N78OZicn11xWcHoCSUvoxGfDhDjkCD53m0=;
        b=cnHyPrBmfXVjsVa6gPBc0wf2v82yOyTmY1t5YJl13dzysfwaO9JVajb14PGLUjeXBf
         QkFJUDn6Ktya6bxWym4Psj5VcaoNH0SAyIBGsY6gARVjLlSQJ7yTKqJNiN5zZJcgg2n5
         ZObYPVUnYkKr/FmT9vHvuC05xjURv4SUS4lBq81z83p6JauSjB48UocbcUvkzfaJ5M0X
         5+JI49QKfP9bMw/BTj38lE2fH9fsFuwhWGEJcB9R+VlukCstdLl2k9csvH9vHVlCzEdz
         M7WOebMkWwM+MeuB8zbHNpy1yzHtzGQRK7WBQpCZA7gMxDB+ZFRb4kwM+FcSmHODWkxF
         MPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cNfDYUuA+N78OZicn11xWcHoCSUvoxGfDhDjkCD53m0=;
        b=HMin1Qu/ixDFJZ7QzdlHRZOVNyzvCOst0Q8xpt2e4lE4VLnhrPCJX/zPCDLtiJOVwy
         Y17vd6Xp6CLMhjX/ym+5McDvRyj5fc6m6DSb1K9jNo2lF8XSbGZp57DuqptrQ6ecsdJK
         5WdoZvckczCZl2lls5jGiMhZx8nzKgRLassBiFnVgD7B5V5PfiWm/3CQmDcydrkRNevk
         62Oz80bR89W0QXdFv/aZCQvdCw4uKDWjhztvftDXW4IXagRysHNUepZrRRcGGeGEIIrw
         452r5q5+0dtuzjIkx/ycz68BP+DK7DBRyeoJWjVRsrBrqt+wHtQfDR5Na4ADBS9hDnYt
         X1Lg==
X-Gm-Message-State: AD7BkJJD6248O0ZaDoPZTkLnoYOjolqvpxzjFDTnX+9UOQftRUzVZM2etCUXTMV0oyzT3pqmQTIbUn/oxaU9NQ==
X-Received: by 10.112.150.133 with SMTP id ui5mr11116763lbb.12.1456969030114;
 Wed, 02 Mar 2016 17:37:10 -0800 (PST)
Received: by 10.112.34.162 with HTTP; Wed, 2 Mar 2016 17:36:40 -0800 (PST)
In-Reply-To: <1456950761-19759-5-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288161>

On Thu, Mar 3, 2016 at 3:32 AM, Junio C Hamano <gitster@pobox.com> wrote:
>  - After arranging that packfile to be downloadable over popular
>    transfer methods used for serving static files (such as HTTP or
>    HTTPS) that are easily resumable as $URL/pack-$name.pack, a v3
>    bundle file (call it $name.bndl) can be prepared with an extended
>    header "data: $URL/pack-$name.pack" to point at the download
>    location for the packfile, and be served at "$URL/$name.bndl".

Extra setup to offload things to CDN is great and all. But would it be
ok if we introduced a minimal resumable download service via
git-daemon to enable this feature with very little setup? Like
git-shell, you can only download certain packfiles for this use case
and nothing else with this service.
-- 
Duy
