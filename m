From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Add a test for git-commit being confused by relative GIT_DIR
Date: Sun, 12 Aug 2007 08:47:07 +0200
Message-ID: <854pj5s104.fsf@lola.goethe.zz>
References: <7vbqddn8zj.fsf@assigned-by-dhcp.cox.net>
	<85tzr5spaj.fsf@lola.goethe.zz>
	<7vvebljz31.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 08:47:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IK7EL-0004ZZ-1m
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 08:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377AbXHLGrM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 02:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753306AbXHLGrM
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 02:47:12 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:40226 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752602AbXHLGrL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2007 02:47:11 -0400
Received: from mail-in-07-z2.arcor-online.net (mail-in-07-z2.arcor-online.net [151.189.8.19])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 2D1861F5A96;
	Sun, 12 Aug 2007 08:47:10 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-07-z2.arcor-online.net (Postfix) with ESMTP id 187002C6A01;
	Sun, 12 Aug 2007 08:47:10 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-036-190.pools.arcor-ip.net [84.61.36.190])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id CA7353425E2;
	Sun, 12 Aug 2007 08:47:09 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 059D21C3C79D; Sun, 12 Aug 2007 08:47:07 +0200 (CEST)
In-Reply-To: <7vvebljz31.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sat\, 11 Aug 2007 18\:55\:46 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3934/Sun Aug 12 03:59:08 2007 on mail-in-09.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55666>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> +test_expect_success 'Setting up post-commit hook' '
>> +mkdir -p .git/hooks &&
>> +cat <<EOF >.git/hooks/post-commit &&
>> +#!/bin/sh
>> +touch $(pwd)/output
>> +echo "Post commit hook was called."
>> +EOF
>> +chmod +x .git/hooks/post-commit'
>
> We have avoided to use here text inside test_expect_success, as
> there have been reports that some otherwise reasonably usable
> shells do not grok it.

Ok.

> Although I prefer to do everything, including the set-up part,
> inside test_expect_success, please move this code outside.

I can easily enough make it an echo.

> Also I do not think you would want to say touch $(pwd)/output
> there inside the here text that begins with <<EOF not <<\EOF.

But I most certainly do!  The same file should be touched regardless
of what the cwd at the time of calling the hook is.  Otherwise, I
would not need the $(pwd) in the first place.  The whole point is that
it is expanded at the time of the hook creation.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
