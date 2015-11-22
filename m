From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH v1] blame: add support for --[no-]progress option
Date: Sun, 22 Nov 2015 03:07:06 -0600
Message-ID: <CAOc6etbnOCDPv+25dEgYGajCSbpixMu_ahhsWM7EOCcqYpamUg@mail.gmail.com>
References: <1448169116-32335-1-git-send-email-eantoranz@gmail.com>
	<CAOc6etbfzrqT4-5dorCAq_=5Oh9wXV4LgRwK9hrEqjmSYHiBEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, "Max A.K." <max@max630.net>,
	Edmundo Carmona Antoranz <eantoranz@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 22 10:08:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0Qcr-0005Qy-JO
	for gcvg-git-2@plane.gmane.org; Sun, 22 Nov 2015 10:08:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbbKVJHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2015 04:07:12 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33439 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbbKVJHH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2015 04:07:07 -0500
Received: by pabfh17 with SMTP id fh17so165718848pab.0
        for <git@vger.kernel.org>; Sun, 22 Nov 2015 01:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kjSBrBcDdrK1B+cTSoTuAqL4lF0mao9CZeenl3aGiNg=;
        b=QW4cfDv/cxpOpAA+5fZG6P9TlG7x1X9TbI0cRg+IIrldXdPb6QZnQXoo1jdc55Wkt6
         NRnp1x1wDVXjvEEe/W3p2qn6GWFDMwTkZDX2fK/JlvhfzIHfXh1yIPjSGiwSJTN9rtvj
         VCbCO0VrOP7f8UUJl7kCblnBp13K18VJCbLxb4oug/KhD242oej9zZU8sQs+WvCQqzb6
         JA9QtA7TZ0HfSYG/jcFqeERR1GFD74/0VCKHh4l809wJMVyXFx6U4tdP6Y+zY9iK5vKG
         wTw4+i7IyJuPgYubfjtdo8JrtEepD46A82JAxpwsEyHigj4WF1mnP2PCHJYc9LHnvVWp
         hgtg==
X-Received: by 10.68.182.130 with SMTP id ee2mr29630370pbc.156.1448183226368;
 Sun, 22 Nov 2015 01:07:06 -0800 (PST)
Received: by 10.66.89.42 with HTTP; Sun, 22 Nov 2015 01:07:06 -0800 (PST)
In-Reply-To: <CAOc6etbfzrqT4-5dorCAq_=5Oh9wXV4LgRwK9hrEqjmSYHiBEg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281563>

I think I found where to calculate the number of blamed lines without
having to do it from scratch every cycle. It's where the list of
sb->ent is getting its nodes pointed.... around here:

for (;;) {
    struct blame_entry *next = ent->next;
    found_guilty_entry(ent);
    if (next) {
        ent = next;
        continue;
    }
    ent->next = sb->ent;
    sb->ent = suspect->suspects;
    suspect->suspects = NULL;
    break;
}

So the function I added to blame.c, it's gone.
