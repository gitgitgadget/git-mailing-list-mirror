From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] git-show.txt: mention that object path must be relative in EXAMPLES.
Date: Sun, 08 Feb 2009 09:52:11 +0200
Message-ID: <87skmpxt5g.fsf@jondo.cante.net>
References: <87zlgxzydw.fsf@jondo.cante.net>
	<m3mycxvn55.fsf@localhost.localdomain>
	<200902072259.29121.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Sun Feb 08 09:09:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW4jS-0002o3-4t
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 09:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467AbZBHIDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 03:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752461AbZBHIDl
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 03:03:41 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:49194 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300AbZBHIDk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 03:03:40 -0500
X-Greylist: delayed 682 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Feb 2009 03:03:40 EST
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 15EDDEBD44;
	Sun,  8 Feb 2009 09:52:16 +0200 (EET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A047A615ED5; Sun, 08 Feb 2009 09:52:16 +0200
Received: from jondo.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 2EAD91C638C;
	Sun,  8 Feb 2009 09:52:11 +0200 (EET)
In-Reply-To: <200902072259.29121.bss@iguanasuicide.net> (Boyd Stephen Smith,
	Jr.'s message of "Sat, 7 Feb 2009 22:59:28 -0600")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108928>

"Boyd Stephen Smith Jr." <bss@iguanasuicide.net> writes:

> On Saturday 07 February 2009 17:31:47 Jakub Narebski wrote:
>
>> Jari Aalto <jari.aalto@cante.net> writes:
>> > +	`next`. *Note:* the 'object' path must always be relative to git
>> > +	project root. This wouldn't have worked:
>> > +
>> > +	$ cd Documentation
>> > +	$ git show next~10:README
>>
>> Actually that is not exactly true.  In the <tree-ish>:<path> the
>> 'object' path must be always relative to <tree-ish), in this case
>> to "next~10", which means relative to project root at given commit
>> (important in case of subtree merge).
>
> Also important if one of your commits moves everything into a subdirectory in 
> preparation for adding new top-level directories.  Sure, everyone on this list 
> always knows exactly what their project tree should look like from the first 
> commit, but there may be users of git that aren't that sophisticated.  ;)
>
> So, I think better additional text would simply be:
> *Note:* the path is interpreted relative to the tree-ish.

Changed, See below.

> A example of what not to do is probably not useful in this case.

It is important to give examples. This is a common mistake:

    $ cd todir
    $ ls file.txt
    file.txt

    $ git show 8b2de93:file.txt

    fatal: ambiguous argument '8b2de93:file.txt':
    unknown revision or path not in the working tree.

The path is in working tree from user's point of view but Git expects
it from project root. Not intuitive if you're deep/in/the/directory/hierarchy

Jari

>From 9de53447e456aaf5ab64f616df76f05888cc0d76 Mon Sep 17 00:00:00 2001
From: Jari Aalto <jari.aalto@cante.net>
Date: Sun, 8 Feb 2009 09:43:57 +0200
Subject: [PATCH] git-show.txt: mention that object path must be relative in EXAMPLES.

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-show.txt |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index 48b612e..27f771b 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -57,7 +57,13 @@ git show v1.0.0^\{tree\}::
 git show next~10:Documentation/README::
 	Shows the contents of the file `Documentation/README` as
 	they were current in the 10th last commit of the branch
-	`next`.
+	`next`. *Note:* the path is interpreted relative to the tree-ish.
+	A typical mistake is that after changing to a subdirectory from
+	project root, the current' directory's filename is used:
+
+	$ cd Documentation
+	$ git show next~10:README		 # Error, needs path
+	$ git show next~10:Documentation/README  # Ok, relative to tree-ish
 
 git show master:Makefile master:t/Makefile::
 	Concatenates the contents of said Makefiles in the head
-- 
1.5.6.5
