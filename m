From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Removing unreachable objects in the presence of broken links?
Date: Sun, 28 Oct 2012 22:21:32 +0100
Message-ID: <CAMuHMdUqUtDspOP2kE9wtGEr9aJHGGBG=HRomdY6NRa8gxar4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 22:21:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSaIk-0008GS-PX
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 22:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756000Ab2J1VVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 17:21:35 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:52881 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755946Ab2J1VVe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 17:21:34 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so2647695lbo.19
        for <git@vger.kernel.org>; Sun, 28 Oct 2012 14:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=Hf5EKCeZL8yk2LcDLrJ73u50reB1z+nQP4WRFPOfApc=;
        b=OmujAIqhwnn9EeeJo3RyTe0HH7ICa0+xi9+jd1IsoAAZNbYkVLuOeSHdL5ogGOPaH4
         g+QztSiuf6wzMthlRVueV5qvaXsJa1pt70MR8HRCbuJ2kXk4s/eZu+yGqKkc8Dggryzu
         o8M2jpJ4DCmScFxykDNc+UX/I549C3QCk6Zup0NspWalu1E7PZ+2tl2K4/RF4tGGe9g5
         Nsq/WkXC9c6QBjaNAJeYwPn1OaPo7Bsa5RPt+vnUJ8ba6NkhDHad9J785Q7Li4JXw6VW
         ueT+QyURmFKUDvD/kcUBdVL8KZOCTQ0VnuOF760/AoqRK2GRrgMQTXoQkuuu7f6nKaem
         hU3Q==
Received: by 10.112.38.228 with SMTP id j4mr11070672lbk.87.1351459292772; Sun,
 28 Oct 2012 14:21:32 -0700 (PDT)
Received: by 10.152.112.168 with HTTP; Sun, 28 Oct 2012 14:21:32 -0700 (PDT)
X-Google-Sender-Auth: OQcQ6_Qjl-mUB_1tvalFHDE--X0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208569>

Hi,

I managed to have a few missing objects in my development Linux kernel
repository, which uses another Linux kernel clone as an alternate.
Fortunately nothing is lost, as all missing objects are unreachable.
Probably they were in a branch that has been rebased, and the objects existed
for a small timespan in the alternate when I tried whether a patch created
in the development tree applied cleanly.

Is there a way to force removing unreachable objects in the presence of broken
links?

"git prune" doesn't do it, as it aborts when encountering the first
missing object.
Same with "git repack -[aA]d".

"git fsck" reported
broken link from    tree 1330855dc33c1042b80d4c8ecbb6d56a19557ee8
              to    tree b6c8c53b804662d6a6435c62b6dec1612bfbeb46
broken link from    tree f182e2fa155b9684b79ff6e17159d03d4de9a773
              to    blob d41f9ed0e2aba47ef62b4b4dd211b91cfe474ff8
missing blob d41f9ed0e2aba47ef62b4b4dd211b91cfe474ff8
missing tree b6c8c53b804662d6a6435c62b6dec1612bfbeb46

"git fsck --unreachable HEAD $(git for-each-ref
--format="%(objectname)" refs/heads)"
told me about lots of unreachable objects, including the tree objects that
contain the two broken links.

BTW, every time I now do a rebase that triggers a gc (after the actual rebase
operation has completed), I end up with "(no branch)", so I have to do:
    git banch -D <branch>
    git branch <branch>
    git checkout <branch>
to get back on the branch.
This is with git version 1.7.0.4 (1:1.7.0.4-1ubuntu0.2).

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
