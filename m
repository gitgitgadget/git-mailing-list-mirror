From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: More builtin git-am issues..
Date: Fri, 4 Sep 2015 18:20:37 -0700
Message-ID: <CA+55aFwcv+iXnUtMhZrtx9hFrJ_xjfxvoinLmKTyEfLwrDoJvQ@mail.gmail.com>
References: <CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPxgK0KQGw@mail.gmail.com>
	<xmqqd1xxekt8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 03:20:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZY2A6-0006u5-7u
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 03:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932956AbbIEBUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 21:20:39 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:36440 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932489AbbIEBUi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 21:20:38 -0400
Received: by ioii196 with SMTP id i196so41563798ioi.3
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 18:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=5PLG3QEWIsinAR2vRTiyl88eNk7MuZgIaApqiRxYHOY=;
        b=lb7yMANl1vHNuv9awIaGuUAZ46LYDgX0pV27trRwR2rVb81aOHbULb3MuN8HjjwmzI
         tMf16PjTjLIpn6fKcSB1RbdUcmxX6FXKzEBX8N2jqNWUyC0UXYn5C8+tcnZDpGbjT7vx
         wpF0NhDC2xh/JZKBlOuxhoE/A4XC5h5JXryXOm7KF9/dKiD2y4SxzvS1jiROBEZnCrCR
         qWXz7FsHxiOyMNtm2OTOy/vaPKoIe8AtQlYLiUd0f9ql0g+txWzm3BiGXwPXpZm4u1VJ
         YlzWz0yeJXLkXQz8Fn0OEB4Qdjjf5ggQ1VfOBjuiaDlyYqrjIEsvpitVVSqFvtyVIZ/E
         sy2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=5PLG3QEWIsinAR2vRTiyl88eNk7MuZgIaApqiRxYHOY=;
        b=f+9bx5MftjC9ejsvDQja5WzR6hSmypp0HcjDUpeqf4KBZRn7qgyFnqcyAlI0XffV/F
         zskg9DdBjCknytjotbymD2tkKUQw0Jse/TCJIaEEyeLodAZo7YXd9IyBQliVhMtcxOCc
         yJ9U9gC5AgY1yjWopD+MODAfRIzj8rb12dGEo=
X-Received: by 10.107.11.223 with SMTP id 92mr12034013iol.186.1441416037861;
 Fri, 04 Sep 2015 18:20:37 -0700 (PDT)
Received: by 10.36.124.195 with HTTP; Fri, 4 Sep 2015 18:20:37 -0700 (PDT)
In-Reply-To: <xmqqd1xxekt8.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: -_52k09GcB-6xyg7-dT_Vp3zYT8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277356>

On Fri, Sep 4, 2015 at 6:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> that rule would still not think this is a signature block, but at
> that point, do we really want to consider such a block of text a
> signature block?

So exactly why are you arguing for these rules that are known to break
in real life, that I gave actual examples for existing, and that I
also gave an actual example for not just giving a false negative, but
also a false positive?

I'm also pretty sure that what you are arguing for is a regression.

Now, as mentioned, it may well be true that we've had this odd
behavior before, and it's not a real regression - I may just have
picked up on this problem because I've been more careful. Maybe I
didn't notice these problems before.

But looking at the old git-am.sh script, it does simply seem to look
for that '^Signed-off-by:' pattern. It did

              ADD_SIGNOFF=$(
                  test "$LAST_SIGNED_OFF_BY" = "$SIGNOFF" || {
                  test '' = "$LAST_SIGNED_OFF_BY" && echo
                  echo "$SIGNOFF"
              })

which seems to literally just check the last sign-off line it found.
If it matches the new sign-off, it doesn't do anything (and doesn't
add the new one either), and if it doesn't exist at all (so it's
empty) it adds teh empty line.

Quite frankly, that not only worked for a long time, it's simply less
ambiguous than your made up rule.

It's very simple. "if you find a sign-off in the commit message, don't
add an new empty line before the new signoff".

Much better than "every line in the last set of lines must match some
weak format that isn't even true, and is too non-specific anyway".

                Linus
