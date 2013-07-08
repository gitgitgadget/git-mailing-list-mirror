From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: A local shared clone is now much slower
Date: Mon, 8 Jul 2013 10:20:22 +0700
Message-ID: <CACsJy8BG0i-ncGTJ+9YkN=R1v6WOqF3MJkv_+572=eDjm-ug1A@mail.gmail.com>
References: <20130708130355.647fffb6e5b6a453bfa0fa6e@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Linus <torvalds@linux-foundation.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
X-From: git-owner@vger.kernel.org Mon Jul 08 05:21:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uw20b-0002f9-AA
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 05:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981Ab3GHDUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 23:20:54 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34871 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821Ab3GHDUx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 23:20:53 -0400
Received: by mail-ob0-f179.google.com with SMTP id xk17so4890499obc.24
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 20:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4FfMu4aPDdWhwjAF0lRaN7iTSeefpHtbHGYc21mn150=;
        b=o85JxKdPDYBwaOlJNCHA+dpkl0vCtzzvD8EGMIrHyiTYHxchmm/f1ebEUBh9pDyJSf
         hIVJuOqqOF3A6FzraXWx5Hwn/P9HDZpWOIeBKtAjwID0+aL4F2zvaKwm+lyCjKx+ygdS
         q1h+IPpIUFxa6lIGIw4dnvY3j0XuEqmdMp2i7sgYlnJcN+Gkkz0OP+c3CTwpRI8Onmcc
         batjE6vgODdeLPGjLkpWkLGcS+q7pKJDF/BMFoE3zguKmmnL3lPvvd2Yg6yVIO8MojMv
         jd7LmPnRCIhnXqU9/h7tRuq/yjjQqGknrHM1SyaFd6nsWQxsLWB9WuaG8EF9ZtYeJL2t
         7LEw==
X-Received: by 10.60.102.202 with SMTP id fq10mr18950905oeb.42.1373253653020;
 Sun, 07 Jul 2013 20:20:53 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Sun, 7 Jul 2013 20:20:22 -0700 (PDT)
In-Reply-To: <20130708130355.647fffb6e5b6a453bfa0fa6e@canb.auug.org.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229823>

On Mon, Jul 8, 2013 at 10:03 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi guys,
>
> So commit 0433ad128c59 ("clone: run check_everything_connected") (which
> turned up with v1.8.3) added a large traversal to clone which (as the
> comment said) makes a clone much slower.  It is especially noticeable on
> "git clone -s -l -n" which I use every day and used to be almost
> instant.  Is there any thought to making it fast again, please?

It's done that way as a security measure against repo corruption.
Although I wonder if we could do connectivity check in background
instead (reports are stored in .git and picked up by git-status). The
same mechanism could be used for "git gc --auto". If the repo turns
out corrupted, the user may lose the last ~10 minutes of work, not
really bad for the speed trade off. This mode is not the default, of
course. The user has to be aware of the risk when choosing this route.
--
Duy
