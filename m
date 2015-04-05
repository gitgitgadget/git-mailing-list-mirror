From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/6] strbuf_getwholeline: use getc_unlocked
Date: Sun, 5 Apr 2015 21:36:04 +0700
Message-ID: <CACsJy8Biv6D2foDxpn-CZhEsjn3WsPV=_A3UOnT4+1LVrpRnTw@mail.gmail.com>
References: <20150405010611.GA15901@peff.net> <20150405011110.GC30127@peff.net>
 <20150405045614.GA12053@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 05 16:36:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YelfE-0006G5-Fe
	for gcvg-git-2@plane.gmane.org; Sun, 05 Apr 2015 16:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295AbbDEOgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2015 10:36:35 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:34025 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863AbbDEOgf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2015 10:36:35 -0400
Received: by iedfl3 with SMTP id fl3so8179440ied.1
        for <git@vger.kernel.org>; Sun, 05 Apr 2015 07:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xXYlDua+7ib8NXKYdWM7cgY/KFkscQwds1eKhYP068Y=;
        b=Vhwo55OI87u1rZ4GtiX2QaTiF/0/UHmRzgWFzSReIIXZXP2EFwYWznWMn8Qaw4CL9K
         9/7MX3w3g0sjcaiFx48ZxdM6qdmzj7w/DyolCCbM8tk9ZF8MwUhhDiLz1xPIZIxiSL19
         KrzQ0MIM3+EzSl5aS2UDtAwOR41ouvpgjUv7w9YF+Nbkm084m4yIKb7WtD8oWlDjPk0o
         OkLUVuErB46PTTfw0Kto2OOYbrYWElrnwkQ/Ykw4UXg3Asw6xiblT/2J9pzFGR5AQO42
         3IyDNyNkOK9ZU4SkHtPCXuS9xaFf0m271OL5CFE9qxXkprDfzAJ7fQ8k6BIoOTWjuCkb
         SMgA==
X-Received: by 10.50.61.239 with SMTP id t15mr5776968igr.7.1428244594384; Sun,
 05 Apr 2015 07:36:34 -0700 (PDT)
Received: by 10.107.47.170 with HTTP; Sun, 5 Apr 2015 07:36:04 -0700 (PDT)
In-Reply-To: <20150405045614.GA12053@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266807>

On Sun, Apr 5, 2015 at 11:56 AM, Jeff King <peff@peff.net> wrote:
> So we'd have to either:
>
>   1. Decide that doesn't matter.
>
>   2. Have callers specify a "damn the NULs, I want it fast" flag.

2+. Avoid FILE* interface and go with syscalls for reading
packed-refs? If mmaping the entire file could be a problem for some
platform because it's too large, we have code for reading (with
bufferring) from fd somewhere, e.g. index-pack.

>   3. Find some alternative that is more robust than fgets, and faster
>      than getc. I don't think there is anything in stdio, but I am not
>      above dropping in a faster non-portable call if it is available,
>      and then falling back to the current code otherwise.
-- 
Duy
