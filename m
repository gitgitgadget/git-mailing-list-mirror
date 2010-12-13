From: Yuriy Romanenko <groman@gmail.com>
Subject: Revert-style merge/Working tree-only checkout?
Date: Mon, 13 Dec 2010 15:30:00 -0800
Message-ID: <AANLkTi=ioX25aqXg-yWDA0oXBTATkFe+J25g-dB7-psS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 14 00:30:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSHqP-0005kG-De
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 00:30:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755858Ab0LMXaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 18:30:04 -0500
Received: from mail-fx0-f66.google.com ([209.85.161.66]:64559 "EHLO
	mail-fx0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab0LMXaC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 18:30:02 -0500
Received: by fxm14 with SMTP id 14so8655fxm.1
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 15:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=Ha7bayJqPQqo7W0GBW1WiAyOo4Q+O0QKslafrQmPh4E=;
        b=qKaQpk15GxlwivkSUO2YBXpfOzmpNr2JufDYek+SAQVg3QS8j3Aa8x9J/4AaNQAqyJ
         e4IMnu/ePfN2e9bd1PAS/mvcw6ugg8PuP+rfRB6kP+sRwBifVl4eU7GZxzMSTSWdvsk+
         jgbLZaHrSy3H8h3PXyya1MUtTbDwS/nMBotDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=J+3sOI8/CKHq5qjN2I4kIz3tT5MnmXfa6rPlLKdvLcya5BCH1I5zfrkOQDyv6P3VHa
         b1pWBanLfiXnA9Y2ooT8qJ96RLLjkg6Rfb8xgdRyr4Hn90fagZh6LhMVWb9lFzZbxMe0
         LUQ24yiw3yY1S9W7jNEGmTG9ADAcNe5I2JRHc=
Received: by 10.223.69.129 with SMTP id z1mr4930788fai.144.1292283000934; Mon,
 13 Dec 2010 15:30:00 -0800 (PST)
Received: by 10.223.72.196 with HTTP; Mon, 13 Dec 2010 15:30:00 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163605>

Hello,

I am somewhat new to Git and I keep running into having to accomplish
a certain task and reading through the documentation I can't seem to
find any way of doing this easily.

The problem is when branches diverge and I want to sync a branch to
another branch with full overwrite, but maintain history and maintain
separate branches.

For example, say there is a branch "master" and I create a branch "b1"
from master at some point. After this, there are 5 commits
(C1,C2,C3,C4,C5) to master and
17 commits to b1 (let's call them cb1, cb2, cb3, ..., cb17). Say I
want to create an 18-th commit to "b1" that makes it identical to the
C5 (current) state of master. Essentially a single commit wipe of
changes cb1 -> cb17 as well as application of C1->C5. So far I have
found one way of accomplishing this, but it is difficult, error prone,
slow and I just plain don't like it. I feel like there should be an
easier way.

What I currently do:

$ rm -rf *
$ git checkout -f master
$ tar -cvzf /tmp/master.tar.gz *
$ git checkout b1
$ rm -rf *
$ tar -xvzf /tmp/master.tar.gz
$ git add
$ git commit -a
$ git merge master


I've considered doing something like the following

$ git checkout b1
$ git revert b1~17..b1
$ git merge master

but it also seems wrong, and requires me to count the submits by hand,
which seems silly --> I'm not actually reverting anything. I don't
know if this would even work.


Any suggestions on how to accomplish this easier? Some sort of a
force-checkout that affects working tree only but not the index?

Thank you,

Yuriy
