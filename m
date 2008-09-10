From: "Eric Raible" <raible@gmail.com>
Subject: RFC: perhaps a "new file" should not be deleted by "git reset --hard"
Date: Wed, 10 Sep 2008 12:12:21 -0700
Message-ID: <279b37b20809101212g57e9ad99qbf6fa15888679894@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 10 21:13:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdV87-00015O-7z
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 21:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbYIJTMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 15:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbYIJTMY
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 15:12:24 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:44961 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbYIJTMX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 15:12:23 -0400
Received: by gxk9 with SMTP id 9so14572770gxk.13
        for <git@vger.kernel.org>; Wed, 10 Sep 2008 12:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=C7OsIsBnRW6euhyis9BUOYgOad0nP/Bq6GB8OvhRBWw=;
        b=ARmpFj25ANW1r5s/UdCoj/0xqtguQqVIKlI3/Qi6oFI/Em41/mMaMhjeIxD/B+oX7A
         cEKSl84TSDXlwnnKlzHQOqrDQo12pkjeYyU6PpDhOOlk/D8Orqe9+cc3k+chKSoj3rT7
         WTX0sUAIEtrcrWNz47YPe8loB5m/WiiJXZeYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=dfwchRQbremlhos5W4Cd8Sp6za8wpKwrEEUYisIY3mc5DsDtXF4vQZes50ALx29NsH
         E4HUYkjbpoheDscW4Ioqu6U0Z4ZMhbhGAfAXSD3ix9JJ3qIHvXa1iFNoB0p3ApYRxmPO
         DMVjEGVNKO8EQm4BiZbixAImbg3QYZQEmfcVQ=
Received: by 10.150.95.15 with SMTP id s15mr2520883ybb.210.1221073941362;
        Wed, 10 Sep 2008 12:12:21 -0700 (PDT)
Received: by 10.151.113.10 with HTTP; Wed, 10 Sep 2008 12:12:21 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95546>

In http://marc.theaimsgroup.com/?l=git&m=114917892328066
(references by http://git.or.cz/gitwiki/GitFaq), Linus says:

'And "git reset" won't be deleting files it doesn't track (it had _better_
not touch them), even more so when it has been told to ignore them, so it
makes total sense to _not_ delete them when doing that reset.'

Now consider this example:

# Create a single commit in a new repo (so that we have a HEAD)
mkdir xx
cd xx
git init
git commit --allow-empty -m"initial"
# Add an important file
echo "Important stuff" > file42
git add file42
git status # -> new file:   file42
ls # -> file42, or course
git reset --hard
ls # -> nothing

I would argue that as a "new file" (as reported by git status)
that file42 was never actually tracked by git.  Sure, it _would_
have been tracked in the future, but git never actually tracked it
(it's not part of any commits).

So in this scenario wouldn't it make more sense for
"git reset --hard" to handle file42 as "git reset" does
instead of deleting it w/out a trace [1]?

The same question goes for "git checkout -f", too, I suppose.

I actually accidentally deleted hundred of newly added files yesterday
doing just this.  https://mozy.com/?code=V3D4MM) saved my butt,
but it wasn't pleasant.

- Eric

[1] - There's not even a reflog entry.  Sure, "git fsck" can be
used, but that's hardly a friendly fallback.
