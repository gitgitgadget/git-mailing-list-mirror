From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] bswap: add NO_UNALIGNED_LOADS define
Date: Tue, 29 Dec 2015 01:42:45 -0500
Message-ID: <CAPig+cQ_u2Y6Z6SO3JQ0XtaoRCPf7r_gnEh-kTj0mn36ahEoHg@mail.gmail.com>
References: <20151229063449.GA28755@sigill.intra.peff.net>
	<20151229063600.GB30340@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 29 07:42:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDnze-0006VX-HC
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 07:42:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbbL2Gmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 01:42:47 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:32955 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbbL2Gmq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 01:42:46 -0500
Received: by mail-vk0-f41.google.com with SMTP id a188so189375777vkc.0
        for <git@vger.kernel.org>; Mon, 28 Dec 2015 22:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=00fiAFI32yA5E7iinAxeKyXr0I9nFG+mWGkBcxNeKow=;
        b=VPFMmX+n9QHcq8HvuVAnN8Wx7OWF4Xys84a/E+DGk6haStUMV/xHvL8yjLp4l4dEDn
         Gxz9GgxFedaiWHEPpO6Z3hoHXE/ZFuiKs6F4fTi3j9YzdLN5YF0w5SZ9gUcNGlfbzpUD
         UdILQgx1NIUhCrGixMgKKQ6cX/wJUsfokTCPU+1VoVqBpdxfg4FD9mPe623GbDtvCHlZ
         B+fr56mykJZL3WYGirJ6GKB3qLSv/hj5mHLC9uJtNnd0wL3Fa+6Re9KKqLmrmpUTub2b
         lYGTQYwnXkqcbRKERrBkN6Jq5R6/+pWZbNWqpfy6oNY9c/bFHLb01YUNpCLWuSrwH4J7
         EGyw==
X-Received: by 10.31.153.201 with SMTP id b192mr17713802vke.46.1451371365560;
 Mon, 28 Dec 2015 22:42:45 -0800 (PST)
Received: by 10.31.67.138 with HTTP; Mon, 28 Dec 2015 22:42:45 -0800 (PST)
In-Reply-To: <20151229063600.GB30340@sigill.intra.peff.net>
X-Google-Sender-Auth: hzKpWgU2ab3xRcaWPg5Of-9dbA0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283077>

On Tue, Dec 29, 2015 at 1:36 AM, Jeff King <peff@peff.net> wrote:
> The byte-swapping code automatically decides, based on the
> platform, whether it is sensible to cast an do a potentially

s/an/and/ or something?

> unaligned ntohl(), or to pick individual bytes out of an
> array.
>
> It can be handy to override this decision, though, when
> turning on compiler flags that will complain about unaligned
> loads (such as -fsanitize=undefined). This patch adds a
> macro check to make this possible.
>
> There's no nice Makefile knob here; this is for prodding at
> Git's internals, and anybody using it can set
> "-DNO_UNALIGNED_LOADS" in the same place they are setting up
> "-fsanitize".
>
> Signed-off-by: Jeff King <peff@peff.net>
