From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Using git for file archival/backup purposes - deletion strategy
Date: Thu, 27 Dec 2007 11:43:48 +1300
Message-ID: <46a038f90712261443t6aa0cd76u46d8ae88fc7c1eba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 26 23:44:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J7ez1-0004ie-2C
	for gcvg-git-2@gmane.org; Wed, 26 Dec 2007 23:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbXLZWnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2007 17:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751709AbXLZWnu
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Dec 2007 17:43:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:64586 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbXLZWnu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2007 17:43:50 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1541855ugc.16
        for <git@vger.kernel.org>; Wed, 26 Dec 2007 14:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=4DNnu+qhco7v2Ow2+mcRJA6nVwPDibZ/OtbaUJZ1/Lw=;
        b=QMoVaSexhL/x2J5RXjTWNWwsemdxYHUHB0CWkWKEgCfHWnsUhr+zbk2f8F79lVuWYUMb7IgGewXBiJ8oeIQzvlhILTYSZeu1bNMIhxii+xfu2iSk5KnTz+fp284muZC0cPmhX8ydZV3mvpBAUkMCrItJsdco0lVlUcUISvL4gdM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LaRe/nbwx5nNP+Kbopm/MdypAh2RAWC0bj+6LflGnETaRKt0UZ01CyjwOghbP4RqBhTlbwD0B5AHFe8rEU/FnC60uvz7mnYQD5w9SLetcGyiT6nY244/kP7hkh/O3B+GPSNEeESd3UDVgPM0ESs+M6NzGsPvT5J+CvMq4yRQfZM=
Received: by 10.66.252.18 with SMTP id z18mr6463161ugh.37.1198709028456;
        Wed, 26 Dec 2007 14:43:48 -0800 (PST)
Received: by 10.66.250.13 with HTTP; Wed, 26 Dec 2007 14:43:48 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69247>

Hi list!

I am drafting a tool to use GIT as a behind-the-scenes archival/backup
tool for web applications. There's been countless threads covering
generic file archival, discussing /etc and homedirs, so I am pretty
comfortable with the mechanics and the whole idea. This is a fairly
narrow use, where the web apps are reasonable well behaved -- most
(all?) of the caveats in ~ and /etc archival seem to be under control.

What I am not 100% clear on is the "old history" deletion strategy.
The history will be *strictly* linear, so my intention is to keep the
last N commits, by overriding the parent of the Nth commit that git
log lists with a "shallow" entry in $GIT_DIR/shallow as documented in
Documentation/technical/shallow.txt , and call gc after that.

Is that the correct way to "forget" old history? Searching high and
low in the list, I fail to find a definitive answer. Shallow and
grafts entries are discussed as ways of doing this, but I can't find a
"correct" way of doing this.

BTW I've just done a git clone --depth 10 ~/src/git and while I do get
a clearly "shallow" checkout, with a tiny .git/objects directory, I
can't find any file called shallow, or grafts. .git/config doesn't say
anything either, and alternates is empty. I frankly cannot tell how
git recognizes it as a shallow repo.

Ah! Local clones won't honour --depth!. A clone from git.kernel.org
does get its .git/shallow file.

So the question is: is it safe (and enough) to add the SHA1 to the
.git/shallow file and call git gc? Is there a better way?

cheers,


m
