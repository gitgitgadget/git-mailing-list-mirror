From: =?UTF-8?Q?Marcin_Wi=C5=9Bnicki?= <mwisnicki@gmail.com>
Subject: Re: Missing blobs after pruning dangling commits
Date: Tue, 23 Aug 2011 12:16:49 +0200
Message-ID: <CAC9GOO_QGsadeE4EK8gg6JMZdzFPY_SjnnwOqjp5f--A2SO9Og@mail.gmail.com>
References: <CAC9GOO-cAKTvUyKvrijA8H8z4uRFkTjzJ_dqS_-aO1MYB-yaTw@mail.gmail.com>
	<4E5372E5.1070509@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Aug 23 12:16:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvo2R-0004mT-2r
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 12:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752695Ab1HWKQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 06:16:51 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:50158 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636Ab1HWKQu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 06:16:50 -0400
Received: by qyk34 with SMTP id 34so2726835qyk.19
        for <git@vger.kernel.org>; Tue, 23 Aug 2011 03:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FQce5W4ugQ19yeenZM4CnmSrXQYkKfEbYaZ5xnJWbPs=;
        b=PpgrhvQvaGnjjxbMxVz0qtiO2nlM2HZ4bndwfpsNSAk8gB2IOFM6r2E6UlQgkXKutI
         dEIxlBcb177bz1eY8cv6jaIhe0GJL1/0MOWnHi3LI9kXXTgWjq/2SKGQxoOG8YrlE/HR
         XUr303LlPJckGorreXIDYAGVjhHAE7Svxm5x8=
Received: by 10.229.19.21 with SMTP id y21mr2104575qca.144.1314094609705; Tue,
 23 Aug 2011 03:16:49 -0700 (PDT)
Received: by 10.229.42.70 with HTTP; Tue, 23 Aug 2011 03:16:49 -0700 (PDT)
In-Reply-To: <4E5372E5.1070509@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179934>

2011/8/23 Michael J Gruber <git@drmicha.warpmail.net>:
> Suggestions:

Neither of them helped, however I've added old packs from backup and did

git fsck
git repack -ad
git reflog expire --expire=0 --all
git repack -ad
git prune
git fsck

And now everything is fine.

Only thing that concerns me is that there are still two packs:
$ ls -la .git/objects/pack/
total 145632
drwxr-xr-x    2 marcin.w Administ     4096 Aug 23 11:42 .
drwxr-xr-x    4 marcin.w Administ    20480 Aug 23 11:47 ..
-rw-r--r--    1 marcin.w Administ   529152 Aug  9 15:01
.tmp-3616-pack-83952e51abdea7469eef06dde2e692e04ba8f9f3.idx
-rw-r--r--    1 marcin.w Administ 149572531 Aug  9 15:01
.tmp-3616-pack-83952e51abdea7469eef06dde2e692e04ba8f9f3.pack
-r--r--r--    1 marcin.w Administ   555724 Aug 23 11:42
pack-3cd1ec9be7cdb31d8eac4404c249edf9c1654937.idx
-r--r--r--    1 marcin.w Administ 147570858 Aug 23 11:42
pack-3cd1ec9be7cdb31d8eac4404c249edf9c1654937.pack

Both files have identical ACLs but pack-3cd1.. has dos attribute
"readonly". Toggling this attribute on any file does not seem to have
an effect on git repack. Both packs are present in
.git/objects/info/packs.
Deleting it by hand followed by repack -ad and fsck seems to work
though, which means it was redundant yet not removed by repack.

> Could you share that repo or is it private?

Unfortunately I can't.
