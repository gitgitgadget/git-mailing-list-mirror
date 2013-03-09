From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Replace strcmp_icase with strequal_icase
Date: Sat, 9 Mar 2013 17:54:45 +0700
Message-ID: <CACsJy8BbXjJeTgo0DzKKMY7B3NZB=r3r+Z-WsWJR=t00DkTVzQ@mail.gmail.com>
References: <1362818574-16873-1-git-send-email-iveqy@iveqy.com> <CACsJy8CphBDKsAAKjCoze98jv=4U+3pN3cW1OYD5XNhYgfcVCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sat Mar 09 11:55:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEHRL-0006LR-Bp
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 11:55:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071Ab3CIKzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 05:55:18 -0500
Received: from mail-la0-f43.google.com ([209.85.215.43]:34471 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757816Ab3CIKzR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 05:55:17 -0500
Received: by mail-la0-f43.google.com with SMTP id ek20so2506341lab.16
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 02:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=2ohzywc2uMJsJkJl+Jqsr2aK4PsKHXEgMCUbU9+KlAo=;
        b=RrDu/ceAXdXVC1s8Lpkj+OzMpWNtEETXEaq0Wc9te71akvyMSlquzg6GAPB/ylAyGm
         A67Mn2DhKML8OqWz5oxkyEhUySE9hasbVxE66ng2ctIpwSquCaoNev2WBDVBV2xExBYj
         /4wgdn8os8OE8QUHuVz5okIgdyrsHG+uq6DCtfsTlr8EnBuU01q9CVAFlJZ/ojnXxi/3
         SlDADyEdBKQY/N4HB5PQ5Wce/1lOQOtShIxO18TZFZKeF7mSRo+Ox6pH11oj+t30MAsU
         wF9eY6bGQO56UN+HlAI6uoRlKY15cOvLdP1p1CN+4ZUAYAmaQDso8uvk9NSVrfVCIYcj
         MynA==
X-Received: by 10.152.47.97 with SMTP id c1mr4792864lan.6.1362826515747; Sat,
 09 Mar 2013 02:55:15 -0800 (PST)
Received: by 10.114.25.226 with HTTP; Sat, 9 Mar 2013 02:54:45 -0800 (PST)
In-Reply-To: <CACsJy8CphBDKsAAKjCoze98jv=4U+3pN3cW1OYD5XNhYgfcVCA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217720>

On Sat, Mar 9, 2013 at 5:40 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Mar 9, 2013 at 3:42 PM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
>> To improve performance.
>
> BTW, by rolling our own string comparison, we may lose certain
> optimizations done by C library. In case of glibc, it may choose to
> run an sse4.2 version where 16 bytes are compared at a time. Maybe we
> encounter "string not equal" much often than "string equal" and such
> an optimization is unncessary, I don't know. Measured numbers say it's
> unncessary as my cpu supports sse4.2.

Another problem is locale. Git's toupper() does not care about locale,
which should be fine in most cases. strcasecmp is locale-aware, our
new str[n]equal_icase is not. It probably does not matter for
(ascii-based) pathnames, I guess. core.ignorecase users, any comments?
-- 
Duy
