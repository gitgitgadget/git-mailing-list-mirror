From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] clone: fix repo name when cloning a server's root
Date: Mon, 27 Jul 2015 19:51:30 +0700
Message-ID: <CACsJy8C0xzTvxMo7=pLFJyu8Yaqm_nz1qVXMFFo9ubQE-dYYSw@mail.gmail.com>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Mon Jul 27 14:52:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJht0-0008E9-RI
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 14:52:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752891AbbG0MwC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 08:52:02 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36623 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737AbbG0MwA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 08:52:00 -0400
Received: by igbij6 with SMTP id ij6so69980257igb.1
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 05:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PWAW3JUqT+8QDgQWaWTUgOFMPUniN/B6wcxt5CfFM4I=;
        b=PvffYhVPS37ejkC6xUZbhCcvy+BpYcaB2F3JXy8Rbhahh6Hz/OmRUTfnPWfVD+Y8Jt
         KDeFPpa6Ul4jmktMNhs084eVT0dPnn2w9DZ8vWTSMck+LlxMhcJ/L5iS1mtdJ3+jg8lI
         kR88hum6rs8SNyHrbZv3bm2ndhdbyYkxlyw8AkPADHiYQYhtMOwHO/yH81m3JCCZKDfv
         fqnKCtJZgiYBZPZ5q0PlEK8YsEHcPU+9KuRzcIDDrBEzFS6ULPwJyQsx6jC4jCO4tSnc
         KkHMGNCwUXfirjK/r0fOrdxO8wAwoDmbUh3iNyQaz7RKdsHmUCExnjELWsyWMKiaE8rf
         oe1Q==
X-Received: by 10.50.142.9 with SMTP id rs9mr17912906igb.17.1438001519950;
 Mon, 27 Jul 2015 05:51:59 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Mon, 27 Jul 2015 05:51:30 -0700 (PDT)
In-Reply-To: <1437997708-10732-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274675>

On Mon, Jul 27, 2015 at 6:48 PM, Patrick Steinhardt <ps@pks.im> wrote:
> When cloning a repository from a server's root, that is the URL's
> path component is a '/' only, we fail to generate a sensible
> repository name when the URL contains authentication data. This
> is especially bad when cloning URLs like
> 'ssh://user:passwd@example.com/', which results in a repository
> 'passwd@example.com' being created.
>
> Improve the behavior by also regarding '@'-signs as a separator
> when scanning the URL. In the mentioned case this would instead
> result in a directory 'example.com' being created.

My initial reaction was, if you put password on the command line, you
deserve it. However, as we improve this heuristics, perhaps it's
better to export parse_connect_url() from connect.c and use it here?
We would have more robust parsing. You can create a repo named
example.com given the url ssh://user:pass@example.com:123/. Maybe it's
overkill?

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> I was not able to come by with a useful test as that would
> require being able to clone a root directory. I couldn't find
> anything in the current tests that looks like what I want to do.
> Does anybody have an idea on how to achieve this?

There's t/t1509/prepare-chroot.sh that will prepare a chroot for this
purpose. You'll need linux, busybox and chroot permission.
-- 
Duy
