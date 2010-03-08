From: Jay Soffian <jaysoffian@gmail.com>
Subject: merge -s ours question
Date: Mon, 8 Mar 2010 17:26:20 -0500
Message-ID: <76718491003081426j4329e322we91fc6fe13f2d03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 08 23:26:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NolPD-0004ad-6m
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 23:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755965Ab0CHW0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 17:26:25 -0500
Received: from mail-iw0-f176.google.com ([209.85.223.176]:42813 "EHLO
	mail-iw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755752Ab0CHW0V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 17:26:21 -0500
Received: by iwn6 with SMTP id 6so2947725iwn.4
        for <git@vger.kernel.org>; Mon, 08 Mar 2010 14:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=HVl30iwVQ4m36w4hXEElsjurFkB4ygfAnOe4N1Lek1M=;
        b=gsLTzgMg4DIHhA6SF4qp3BZEz/HDPrvM3nH6RFPb4yJF3SUuQbx2IJ1wdzNrQLqypp
         pXCcGuXJGeU5f+lJljomiap7fZUigNP4GHJdjArrdybcLV7sp/aTV34SJ1RFs7kAi2Bg
         lT1hI9X/JCjc1yN+z5AiVSYgFxvy/63AnpEqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=OTGm4jQmdFByzXK7IL/Z9fNjEEEbTA3HdxSa819RkMnJQLZLRWFlQmNpowt4I/IQ/p
         8tEMxrV1VXlrJJaIPT+iRwi1z5gG15Fvsemm+n3FUeoOqmnlxIm+Q+8m8tn38I8RTBqq
         sGA9WTkYFL8IhfVrSlRMAqJhRpQeAusoIC32M=
Received: by 10.231.161.138 with SMTP id r10mr126919ibx.34.1268087180328; Mon, 
	08 Mar 2010 14:26:20 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141793>

Here's the scenario,

I have a muddled development branch that has a mix of local development and
upstream merges:

 upstream 1--2--3--4--5
           \     \     \
      dev   o--A--x--B--x ... Y

It took a lot of work, but I backported everything newer than A using rebase
and cherry-pick, and omitting the merges, giving me a dev' clean of merges
from upstream:

     dev'   o--A'--B' ... Y'
           /
 upstream 1--2--3--4--5
           \     \     \
      dev   o--A--x--B--x ... Y

Now it turns out that going forward, I need two development branches, one
that's based on a newer version of upstream for which the merge work was
already done in the original dev. In an ideal world I'd have this history:

upstream 1--2--3--4--5
          \           \
    dev2   \           o--o--o--o
            \
    dev1     o--o--o--o--o

And I would periodically merge dev1 into dev2 (dev2 requires the work being
done on dev1). The problem is that my backported dev' has a mix of dev1 and
dev2 and it's impossible for me to tease them apart at this point. So my plan
was to do this:


     dev'   o--A'--B' ... Y'
           /               \
 upstream 1--2--3--4--5     \
           \     \     \     \
      dev   o--A--x--B--x ... Z

Where Z is created using using "git merge -s ours dev'". Is it correct that
this should do nothing more than give me a new merge base for dev and dev'?
Then going forward I can merge from dev' to dev per usual.

Thanks,

j.
