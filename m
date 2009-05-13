From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] Documentation: clarify / requirement in 'git check-ref-format'
Date: Wed, 13 May 2009 17:43:06 +0200
Message-ID: <1242229386-27486-1-git-send-email-git@drmicha.warpmail.net>
References: <alpine.LNX.2.00.0905131051240.2147@iabervon.org>
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	geoffrey.russell@gmail.com,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 17:43:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4GcB-0007Tu-2O
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 17:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757467AbZEMPnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 11:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756704AbZEMPnQ
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 11:43:16 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50851 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754906AbZEMPnP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2009 11:43:15 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 3DAD6345946;
	Wed, 13 May 2009 11:43:16 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 13 May 2009 11:43:16 -0400
X-Sasl-enc: 0cszdqtXxAe9W2QFyehWyMzxBG0pV1wvyxCrjF9cPk9W 1242229395
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6C92A3A624;
	Wed, 13 May 2009 11:43:15 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.195.gad816
In-Reply-To: <alpine.LNX.2.00.0905131051240.2147@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119059>

'git check-ref-format' checks for the presence of at least one '/', the
idea being that there should be no refs directly below 'refs/', so there
should be a category like 'heads/' or 'tags/' in a refname.

Try and make this clearer in the man page.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Daniel Barkalow venit, vidit, dixit 13.05.2009 17:03:
> On Wed, 13 May 2009, Michael J Gruber wrote:
> 
>> Geoff Russell venit, vidit, dixit 13.05.2009 02:09:
>>> 1 $ git --version
>>> git version 1.6.2.3
>>> 2 $ git check-ref-format xxxx && echo OK
>>> 3 $ git-check-ref-format --branch xxxx && echo OK
>>> xxxx
>>> OK
>>> 4 $ git check-ref-format --branch xxxx && echo OK
>>> usage: git check-ref-format refname
>>>
>>>
>>> 2 seems wrong,
>>> I tried 3 after looking at  builtin-check-ref-format.c
>>> I couldn't find any test cases in the git/t directory
>>>
>>> From the documenation, I expect "git check-ref-format xxx" to return 0 if xxx is
>>> a valid branch or ref name.  git version 1.6.3 gives the same results.
>>
>> There are several things going on:
>>
>> A) In 3 you use a different git than in 1,2,4. You told us the latter is
>> 1.6.2.3, and I'm telling you the former contains v1.6.2.1-310-ga31dca0
>> (which has the new --branch option).
>> This simply checks whether refs/heads/xxxx is sane. (It also resolves
>> @{-1} and such, which is what makes it useful at all.)
>>
>> B) "master" certainly looks like a valid refname, the doc seems to imply
>> that it should pass the check.
>>
>> C) Looking at the code, check-ref-format checks explicitly for the
>> presence of at least 2 levels: foo/bar is good, foo is bad. So, master
>> always had been bad, as well (or bad) as full sha1s!
>>
>> The code has always behaved like C since its inception but I don't know
>> the rationale behind the 2 level requirement. Daniel, Junio?
> 
> In general, it's because you use it right before trying to use git 
> update-ref $name, and you probably don't really want to change 
> refs/master. Unless you know exactly what you're going (in which case, 
> you're unlikely to check whether it's okay), you want to have a first 
> level that specifies the type of ref and one or more additional levels 
> that specify which ref of that type it is.
> 
> I believe that, if you've got "master", and you want to do the sensible 
> thing with it (i.e., the file you care about is .git/refs/heads/master), 
> you want to use rev-parse with some option or other, not check-ref-format, 
> but I don't know the plumbing-level shell API very well.
> 
> 	-Daniel
> *This .sig left intentionally blank*

Thanks Daniel and Sverre for the clarification, this makes a lot of sense.

Michael

 Documentation/git-check-ref-format.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index bf43454..0b7982e 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -25,6 +25,10 @@ imposes the following rules on how references are named:
   grouping, but no slash-separated component can begin with a
   dot `.`.
 
+. They must contain at least one `/`. This enforces the presence of a
+  category like `heads/`, `tags/` etc. but the actual names are not
+  restricted.
+
 . They cannot have two consecutive dots `..` anywhere.
 
 . They cannot have ASCII control characters (i.e. bytes whose
-- 
1.6.3.195.gad816
