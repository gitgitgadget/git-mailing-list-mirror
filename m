From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH] config: add core.trustmtime
Date: Fri, 27 Nov 2015 02:35:46 +0100
Message-ID: <CACBZZX4jJ_b-5sbor6YibXGASeOa0gx8nEBiv8=54yoHfWL8Fw@mail.gmail.com>
References: <1448433323-21037-1-git-send-email-chriscool@tuxfamily.org>
 <CACBZZX4YSvfA=BRayk8CC8ipk_nDdvJfznxjyb-upwP9PKRBSA@mail.gmail.com>
 <CACsJy8DhAfu7J=WpPAp8HYGLuFQC5+DZyZj6Hs6vruEJEeVKig@mail.gmail.com>
 <CAP8UFD2V3nbY2-abW6cGDtB2PR9Q+sN+d0RgTVJORCPg6TPMcQ@mail.gmail.com> <CACsJy8CNRbvsDY+ucFZGcO4+tE9Ud_QNr1k4D=+utawSCrc+Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	David Turner <dturner@twopensource.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 02:36:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a27xK-0000JF-Gm
	for gcvg-git-2@plane.gmane.org; Fri, 27 Nov 2015 02:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692AbbK0BgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2015 20:36:09 -0500
Received: from mail-qg0-f48.google.com ([209.85.192.48]:35086 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593AbbK0BgH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2015 20:36:07 -0500
Received: by qgec40 with SMTP id c40so64221846qge.2
        for <git@vger.kernel.org>; Thu, 26 Nov 2015 17:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YN9bouErr99wI0r9OYBb909+xoteQnJuWcYwrxoUgxU=;
        b=p5cEoW32RESn6fch/0JjzS8zIQ5tI2ujrVXHHqqo/xo95i+ldCdn7zqYMlSnrh6cFK
         5kDcWFaiLY9syC4aPItvJJFqqS6o+DCUWY08ViPLgkfrT+MzZfNTTb5KrZXW/BVx0RBX
         HxwOIgBXGN6wA28ZsiRjWSrbQqHA0C8JNZRd+NNkzPoougGTdRofRjW/XIHXhi6lKEca
         XtiXMwO/5u1AT0q+Vxr/fmj1GTPYYvhQMpJ1n6fpeC/3++C4AlElx9WxYkWVq0ud1X8j
         COjl85kWZB85XaccaQQm2vyuFPZXzYc7CW/u/6DMyD8dq45/ii7aJRqfZ535TBOAIB9Q
         nyMw==
X-Received: by 10.140.102.244 with SMTP id w107mr51248922qge.90.1448588166370;
 Thu, 26 Nov 2015 17:36:06 -0800 (PST)
Received: by 10.55.33.11 with HTTP; Thu, 26 Nov 2015 17:35:46 -0800 (PST)
In-Reply-To: <CACsJy8CNRbvsDY+ucFZGcO4+tE9Ud_QNr1k4D=+utawSCrc+Sg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281765>

On Thu, Nov 26, 2015 at 6:53 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Nov 26, 2015 at 6:21 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> I am wondering why you didn't make it by default run the mtime checks
>> when a kernel change is detected. Maybe that would be better than
>> disabling itself.
>
> It takes about 10 seconds to go through the mtime check. Imagine you
> have to wait 10s for some random "git status".. Plus I didn't want to
> do anything fancy.

I browsed through the commits that added the --untracked-cache and
tried to find the original mailing list discussion, but I couldn't
find the reason for why the default interface for enabling it is doing
these exhaustive tests.

Maybe I'm missing some really common breakage with st_mtime on some
system, but having a feature the user explicitly enables turn itself
off and doing FS-testing that takes 10 seconds when it's enabled seems
like the wrong default to me.

We don't do it with core.fileMode, core.ignorecase or core.trustctime
or core.symlinks. Do we really need to be treating this differently?

If that's a "no" then the default interface to this could be much
simpler. Rather than being a change you apply to .git/index (going
away if you nuke it etc.) it could just be a config option like the
rest.
