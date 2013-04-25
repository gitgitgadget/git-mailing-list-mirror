From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Itches with the current rev spec
Date: Thu, 25 Apr 2013 10:37:16 +0530
Message-ID: <CALkWK0n97VLtiR96VEy86645NVoDL2rS-g7LBuLb=JpncdH6VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 25 07:08:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVEPZ-0004gA-GB
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 07:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242Ab3DYFH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 01:07:57 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:62830 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920Ab3DYFH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 01:07:56 -0400
Received: by mail-ie0-f178.google.com with SMTP id aq17so3079052iec.37
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 22:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to:cc
         :content-type;
        bh=8h4h3TOZaH492lkL3Sc51qUaOx0Qot5J2/x5nvVSJjk=;
        b=hGPp5jeYhZ6tzdJ4EljLzJ4gltVl6AbmHHrkRAna8SDkvRnsPh1gMTlpxTr/G+uCQe
         k84Mme/7FeUnJFZTo7m52t9Yx2hQ5P2rD3xk/XOxGSlAVYOS4YhKVCdkdQAkLx07py5w
         pw+3yUqF72Eddx+MVf6vZxVT+KTZjJ9+44IhPQDSYbbX+vsPI20dyNJpqxH9iKHOuXCh
         tbK1TveOU0f3y43jMd20dFe1U0FDD1TbLyX27JsRAUCJRqYzs+nDUcAqotTzMPVrA0Im
         VuRjhobZfTbqwjsh691ioNGkG/4+W1WWJGTmW5cb5PyJjeUBNk39psnlY66z4fLeLONs
         wx8w==
X-Received: by 10.50.55.73 with SMTP id q9mr24633909igp.44.1366866476187; Wed,
 24 Apr 2013 22:07:56 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 24 Apr 2013 22:07:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222343>

Hi,

So, I have three serious itches that would be nice to address:

1. git reset --hard HEAD~1/ git show HEAD~1 is a very common idiom
that's unnecessarily cumbersome to type out.  We can make the <rev>
part of <rev>~<n> optional without being ambiguous: you might argue
that ~<n> normally refers to a /home/<n>, but who uses numbers in
place of usernames?  Even if they do, how can that path possibly be
inside our repository?

2. git rebase -i master fails unless I've rebased my branch on top of
master.  I always wished I could do the equivalent of 'git rebase -i
master..', but I can't.  Can we give the A..B syntax a new meaning in
the context of rebase, namely $(git merge-base A B)?  No, this is not
similar to the current diff A..B at all: first, we don't operate on
two endpoints (so 'git rebase -i A B' is nonsensical, and only the
'git rebase -i A ^B'/ 'git rebase -i ^A B' should be handled as
special cases); second, we're trying to be consistent with the
end-result meaning of A..B in ranged-commands like log (as opposed to
diff, which is being inconsistent).

3. Even though I lashed out strongly against 'git diff A..B' because
of inconsistency, I can't say that it's not useful (omit specifying
HEAD on one side).  If we were to start over today, I would argue that
'git diff A ^B' and 'git diff B ^A' be handled as special cases to
mean 'git diff B $(git merge-base A B)' and 'git diff $(git merge-base
A B) B' respectively.  The normal 'git diff A B' should have nothing
to do with this.  Plus, 'git diff A...B' is really an eyesore.  So I
ask again: what can be done to improve the situation?

Thanks.
