From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] commit: don't rewrite shared index unnecessarily
Date: Mon, 31 Aug 2015 17:02:31 +0700
Message-ID: <CACsJy8D=KyWBYf1LW=n928rmG=9xavSaR+1G1g+F7mMTKFCpfg@mail.gmail.com>
References: <1440695274-12400-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 12:03:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWLvf-0002IK-7X
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 12:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058AbbHaKDC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 06:03:02 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:35751 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026AbbHaKDB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 06:03:01 -0400
Received: by iog7 with SMTP id 7so28748098iog.2
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 03:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VgJpRwOoJ//ab+C+ycIXYyFV+WmNARZbyQqOsRIpHgQ=;
        b=pGm0Wv5OIXRJKHOYoRiEyI03XWB8a2CTpr45zBa8s1aLjyZUbAxQdMuGLg2oUZE6Qh
         ozswrm75YYVlmSdGbYeEoFQqbtSlm+vWIcLEOFQr/qlv6vESGlmbCjC0BnzY4tOnXEK4
         QISifhcW39dsi81ZLRIUXDNM0Q9QffOXWZQenYXZ5vr1m0VHg+gDMZxFVOu4clYY/bCu
         7Mkchqc2f1rKBWFfNo2dEWXboPN50hAl9nDLBhwugErIZ8RjLk2uCzSNBtxFUTd58OHJ
         ImeW2ZX0pJChTkJ6ZDy/nNyPAqvqXOw448CVoC4nd9gSUW4+wgkECDn2vqF2BZQbk+Jm
         sD1A==
X-Received: by 10.107.4.17 with SMTP id 17mr22812749ioe.10.1441015380669; Mon,
 31 Aug 2015 03:03:00 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Mon, 31 Aug 2015 03:02:31 -0700 (PDT)
In-Reply-To: <1440695274-12400-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276863>

On Fri, Aug 28, 2015 at 12:07 AM, David Turner <dturner@twopensource.com> wrote:
> Remove a cache invalidation which would cause the shared index to be
> rewritten on as-is commits.
>
> When the cache-tree has changed, we need to update it.  But we don't
> necessarily need to update the shared index.  So setting
> active_cache_changed to SOMETHING_CHANGED is unnecessary.  Instead, we
> let update_main_cache_tree just update the CACHE_TREE_CHANGED bit.
>
> In order to test this, make test-dump-split-index not segfault on
> missing replace_bitmap/delete_bitmap.  This new codepath is not called
> now that the test passes, but is necessary to avoid a segfault when the
> new test is run with the old builtin/commit.c code.
>
> Signed-off-by: David Turner <dturner@twopensource.com>

Ack.

I made SOMETHING_CHANGED "1" for catching these cases (there were a
few on-flight topics when this series was being cooked and I was
afraid I could not cache all active_cache_changed sites).

> ---
>
> I introduced this bug last year while improving the cache-tree code.
> I guess I probably didn't notice that active_cache_changed wasn't a
> boolean.

So.. you did you split-index? Cool. Never heard anyone using it for
real. It needs the other part to improve reading/refresh side to get
to full potential though..
-- 
Duy
