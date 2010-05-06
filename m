From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH v2] git-stash.txt: Add example "Using stash selectively"
Date: Thu, 06 May 2010 11:40:52 +0300
Organization: Private
Message-ID: <87pr194e3v.fsf_-_@jondo.cante.net>
References: <1273045035-7292-1-git-send-email-jari.aalto@cante.net>
	<7v39y6jfmv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 06 10:41:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9wdp-00016a-E0
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 10:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754932Ab0EFIlB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 04:41:01 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:50942 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419Ab0EFIlA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 04:41:00 -0400
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 5350118CFC3;
	Thu,  6 May 2010 11:40:57 +0300 (EEST)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A036B6504E9; Thu, 06 May 2010 11:40:57 +0300
Received: from jondo.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 391B7E51AA;
	Thu,  6 May 2010 11:40:52 +0300 (EEST)
References: <7v39y6jfmv.fsf@alter.siamese.dyndns.org>
In-Reply-to: <7v39y6jfmv.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146460>

Add a new example to demonstrate the use of --keep-index.
Idea by Johan Sageryd <j416@1616.se>.

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-stash.txt |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)


> While the above is not _wrong_ per-se, it was somewhat hard to understand
> for me without a description on _why_ you might want to do this.  It
> didn't help that "put only selected files" really meant "get rid of
> selected _changes_ from the working tree and the index temporarily".

This demonstrates the difference between the end-user and developer. The
end-used think in term of tangible objects: "I have files, I need to
stash some of them".

> I'd perhaps suggest rephrasing it like this:
>
>         Sifting the Wheat from the Chaff::

As a non-native, to my regret, I'm unable to compherend this Heading, my
suggestion in patch v2:

    "Using stash selectively"

>         When you have changes to the working tree that mix what are
>         necessary for the immediate task at hand, and what are needed
>         later but not right now, you can first `git add` only the former
>         and use `git stash save --keep-index` to get rid of the latter.
>         The latter is temporarily stored in the stash.  
>
>         Suppose you have changes to file A, B, and C, but only the half of
>         changes to file A and C are necessary for what you are doing:
>
>         $ git reset                     # make the index clean
>         $ git add -p A C                # add necessary bits to the index
>         $ git stash save --keep-index   # the remainder goes to the stash
>         ... test, debug, perfect ...
>         $ git commit
>         $ git stash pop                 # get the remainder back
>         ... and continue to work ...

I've rewritten the patch based on the comments. Please review.

Jari


diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 473889a..b3fa1e7 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -243,6 +243,22 @@ grep commit | cut -d\  -f3 |
 xargs git log --merges --no-walk --grep=WIP
 ----------------------------------------------------------------
 
+Using stash selectively::
+
+The `--keep-index` option can be useful in a situation where you want
+store some, but not all, files temporarily in the stash. Suppose you
+have changes to file A, B, and C, but only the half of changes to file
+A and C are necessary for what you are doing:
++
+----------------------------------------------------------------
+$ git reset                     # make the index clean
+$ git add -p A C                # add necessary bits to the index
+$ git stash save --keep-index   # the remainder goes to the stash
+... test, debug, perfect ...
+$ git commit
+$ git stash pop                 # get the remainder back
+... and continue to work ...
+----------------------------------------------------------------
 
 SEE ALSO
 --------
-- 
1.7.0
