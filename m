From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Why doesn't git-fetch obey -c "remote.origin.url" on the command-line?
Date: Fri, 13 Jun 2014 09:37:07 +0200
Message-ID: <CACBZZX4MyaOKkCvTSKhZtyRMFvpBMiMGz2ix3OxMz_s=P-=p=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alex Riesen <raa.lkml@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 13 09:37:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvM3I-0007YJ-Ux
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 09:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbaFMHh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 03:37:29 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:60640 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218AbaFMHh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 03:37:28 -0400
Received: by mail-ob0-f180.google.com with SMTP id vb8so2492579obc.25
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 00:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=419Y83ZCMNwsP0iJcDYmOv4KI89nMtfoyjzyMVcVRqg=;
        b=EyLnKCu/KMIxijzTFLnHQPOv66XzNe8gtvJUbowp9aTW5GhHew7V+b8kxj2dmtJRWw
         kdSQeJ2DrbNowYE0+sG1oqdz/lBxdITsN7hW1BdA22jrLBheYPGmocHcbJIfgwfRW3Wm
         WUo1J0AZfZRcIMJNHLerkYyvzov/THOj/i8hq0v9+3y0rK4uHhkTVELHs0aFGVKuJ9xw
         wS9ckCQCr49bi8QHkJ/pwi92bobhzZLsUgluvLVFfTXXYWEauJZL6cHvRqbYSxeoorgq
         4Uk+TwWpdR5hLEVg/NySiJYgY5aPOmvIxNA5MHH1EZkP1xswZTxPT3uTo73UdrgeZFCd
         g1sA==
X-Received: by 10.60.45.233 with SMTP id q9mr896456oem.37.1402645048182; Fri,
 13 Jun 2014 00:37:28 -0700 (PDT)
Received: by 10.76.34.166 with HTTP; Fri, 13 Jun 2014 00:37:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251527>

On a git built from the master branch just now:

 $ ./git config remote.origin.url
https://code.google.com/p/git-core/
$ ./git -c remote.origin.url=git://git.sourceforge.jp/gitroot/git-core/git.git
config remote.origin.url
git://git.sourceforge.jp/gitroot/git-core/git.git
$ GIT_TRACE=1 ./git -c
remote.origin.url=git://git.sourceforge.jp/gitroot/git-core/git.git
fetch 2>&1 | head -n 2
trace: built-in: git 'fetch'
trace: run_command: 'git-remote-https' 'origin'
'https://code.google.com/p/git-core/'

I'd expect this to try to fetch from the remote.origin.url I specified
on the command-line, but for some reason fetch doesn't pick that up.
Isn't this a bug?

The use case for this is to have a script in cron that does a pull of
repositories via http while the developers expecting to occasionally
use those repositories as work directories should transparently be
able to pull/push from them.

I know about remote.origin.pushurl, but I'd prefer pulls to also be
over ssh in those cases, because then you don't have to worry about
proxy settings (different for the devs & that automated script).

I could fix this, but I thought I'd first send a question about
whether this shouldn't be considered a bug, and I haven't dug into
this yet but I think that configuration passed via the -c option
should *always* override any other config Git may get from elsewhere.
