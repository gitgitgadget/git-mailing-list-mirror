From: Jay Soffian <jaysoffian@gmail.com>
Subject: Confused about diff-tree --cc output
Date: Wed, 4 Feb 2009 16:13:39 -0500
Message-ID: <76718490902041313y44eeb99bya33513bc9818aeb0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 04 22:15:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUp5V-000768-IT
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 22:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756745AbZBDVNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 16:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756437AbZBDVNl
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 16:13:41 -0500
Received: from rv-out-0506.google.com ([209.85.198.235]:46402 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755884AbZBDVNk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 16:13:40 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2738017rvb.1
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 13:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=rW5D3LNlJuqY2cnWmFRWRNN/2A9ri8AlGLxrAhoM6YA=;
        b=rbsm3KyN7I5m0fvR5HQVi7v9IMoGJ6UZwhIpTbMKIrHgJNbKPgry39trOXdZ3zE1re
         XhgF0I1Hdi/OKVntXobUyEFBPT5FCxSFY0pEdUuXAav0hq173Q0m+OKPFCGXX8yP7Pr5
         rFAepfuGIGHyI7CmWzmR0Y/x0XOdKRPtyBGcs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=X1z5JUU5gCu/Hnq4ZGYl4byCEIXZrssUDLWLJiQz4jcSIM9i0F8YAj7A8cCmEdWD/m
         X1+ic4YubCJADJd2dkcjfdGOhDDrgN41+Drb6D4vesccCNGqthvFvLWhM6KXyAjlm7N0
         /EuxUAv2EW85ITKk2QoDQb7qiImM/9w7irZ/I=
Received: by 10.140.201.8 with SMTP id y8mr3891372rvf.12.1233782019577; Wed, 
	04 Feb 2009 13:13:39 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108438>

I'm a bit confused about the output of "git show 8554af" (i.e. git
diff-tree --cc 8554af) on the git tree.

This is a merge of a topic branch of two patches I submitted. If I
understand what Junio did, he branched js/maint-remote-remove-mirror
from maint, applied the two patches I sent via email, then merged that
to next. (Given the topic name he chose, after cooking for a while, I
guess it will eventually merge to maint.)

My understanding of "git show <merge commit>" is that it should only
show changes if the merge resulted in a conflict that needed to be
touched up (ignoring the possibility of an evil merge). Yet git show
on this commit shows this diff:

diff --cc builtin-remote.c
index abc8dd8,07cfdac..db18bcf
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@@ -539,11 -362,14 +549,14 @@@ static int rm(int argc, const char **ar
  		OPT_END()
  	};
  	struct remote *remote;
 -	struct strbuf buf;
 +	struct strbuf buf = STRBUF_INIT;
  	struct known_remotes known_remotes = { NULL, NULL };
  	struct string_list branches = { NULL, 0, 0, 1 };
- 	struct branches_for_remote cb_data = { NULL, &branches, &known_remotes };
- 	int i;
+ 	struct string_list skipped = { NULL, 0, 0, 1 };
+ 	struct branches_for_remote cb_data = {
+ 		NULL, &branches, &skipped, &known_remotes
+ 	};
+ 	int i, result;

  	if (argc != 2)
  		usage_with_options(builtin_remote_usage, options);

This is the same output shown here:

  http://repo.or.cz/w/git.git?a=commitdiff;h=8554af

However, kernel.org's git shows something different (and more what I
would expect, if any output is to be shown):

  http://git.kernel.org/?p=git/git.git;a=commitdiff;h=8554af

(I guess kernel.org is using something like diff-tree -p 3613d1 8554af
--, but I'm not sure why.)

I don't see any other changes to builtin-remote.c that would have
caused a merge conflict, so, color me confused.

j.
