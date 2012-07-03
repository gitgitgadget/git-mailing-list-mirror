From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] Fix Q-encoded multi-octet-char split in email.
Date: Tue, 3 Jul 2012 11:52:20 +0200
Message-ID: <CABPQNSYbdjzrHyjsXu23ARFBEiZ_a6S+iEn0Pwy-1HaKTTAheQ@mail.gmail.com>
References: <1341279697-4596-1-git-send-email-gkatsu.ne@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, gitster@pobox.com,
	Takeharu Katsuyama <tkatsu.ne@gmail.com>
To: katsu <gkatsu.ne@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 11:53:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlznA-0002Mx-MD
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 11:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972Ab2GCJxD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 05:53:03 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:49640 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759Ab2GCJxC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 05:53:02 -0400
Received: by ghrr11 with SMTP id r11so5058424ghr.19
        for <git@vger.kernel.org>; Tue, 03 Jul 2012 02:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=vqZHkfwLvtUAxhszNtaPqgzVDzdNgqZdisHUvx5cOUw=;
        b=KaBwBjZdKvohQ4xwjf+aDDZDp/IFR8gxguzfWtnPC/wWWu4CWwQqIhXsQ4a0B7Pl9y
         KXQnRSjVmRFoi7MGvMtkVeD/piqyO4Gqd0LoUFVYJgsRYUhiKQYEqwggi8eRwZfSjPzB
         q16WqA1yS0oRcCbILoZm6KFJ1MTh9Oq/yM5zE8LrCyYERv4N+ZVlN7UNpb6LDO/W5AVE
         WwTeRGMOLzTYfjDuARCoi2jyzmd6NBl0L/I+b02O4wjXBkr5eBLDfQW4YsauZodaYVyp
         1GbGU1Aqv3QYWckQa1J6fisqFhdofq24/zT80nv38W0y5eiDgo4/3w2pMkuNiai1Gt5o
         vDBA==
Received: by 10.66.73.40 with SMTP id i8mr12864893pav.2.1341309180709; Tue, 03
 Jul 2012 02:53:00 -0700 (PDT)
Received: by 10.68.40.98 with HTTP; Tue, 3 Jul 2012 02:52:20 -0700 (PDT)
In-Reply-To: <1341279697-4596-1-git-send-email-gkatsu.ne@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200908>

On Tue, Jul 3, 2012 at 3:41 AM, katsu <gkatsu.ne@gmail.com> wrote:
> Issue: Email subject written in multi-octet language like japanese cannot
> be displayed in correct at destinations's email client, because the
> Q-encoded subject which is longer than 78 octets is split by a octet not by
> a character at line breaks.
> e.g.)
>    "=?utf-8?q? [PATCH] ... =E8=83=86=E8=81=A9?="
>                     |
>                     V
>    "=?utf-8?q? [PATCH] ... =E8=83=86=E8?="
>    "=?utf-8?q?=81=A9=?"
>
> Changes: Add a judge if a character is an part of utf-8 muti-octet, and
> split the characters by a character not by a octet at line breaks in
> function add_rfc2407() in pretty.c.

You mean add_rfc2047(), right?

Anyway, I'm not an expert here, but can't a "soft" newline (as
specified in rfc 2045) be used in message headers? If it could, then
we wouldn't need to grok the underlying encoding when wrapping, which
strikes me as slightly better...
