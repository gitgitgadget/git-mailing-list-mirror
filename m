From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] git pull: Remove option handling done by fetch
Date: Sun, 06 Feb 2011 23:57:00 +0100
Message-ID: <4D4F273C.8030003@web.de>
References: <4D4C5EBC.2090100@web.de> <201102042326.08607.j6t@kdbg.org> <4D4D33E7.4000303@web.de> <7vipwwx56r.fsf@alter.siamese.dyndns.org> <4D4F19D0.2000408@web.de> <20110206220939.GC17210@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 06 23:57:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmDXa-0005eW-60
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 23:57:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031Ab1BFW5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 17:57:04 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:59041 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759Ab1BFW5C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 17:57:02 -0500
Received: from smtp07.web.de  ( [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 0F68118776715;
	Sun,  6 Feb 2011 23:57:01 +0100 (CET)
Received: from [93.240.100.155] (helo=[192.168.178.43])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PmDXQ-00074C-00; Sun, 06 Feb 2011 23:57:00 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20110206220939.GC17210@elie>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/RLycZtFlg1u0n3CoYH2IyBm7zuHJcSJkSjS6i
	T62kIU3xnSeo++5x+gRWeRyvpypQFNEKAiVQ8AXYyxsAt+ALf/
	AbEZfuvpBGdqZcHWR94g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166210>

Am 06.02.2011 23:09, schrieb Jonathan Nieder:
> Jens Lehmann wrote:
>> Am 06.02.2011 21:45, schrieb Junio C Hamano:
>>> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>>>> Yes, but isn't that exactly what the pull man-page says? Quote:
>>>> "Options meant for git pull itself and the underlying git merge
>>>> must be given before the options meant for git fetch."
>>>
>>> Yes, it says that, and I think that was a weasely way to say "the command
>>> line parser in git-pull is broken".
> [...]
>> (CCed Jonathan, as he is the author of the lines I quoted)
> 
> They're from Junio. :)  See v1.5.4.5~26 (git-pull documentation: warn
> about the option order, 2008-03-10).

And I thought I could trust "git blame -M -C" ... ;-)

> I also agree that (1) it would be very nice to find a way to fix this
> and (2) until then, it seems best as a general principle not to
> regress in those odd cases where we sort of fixed it.
> 
> In other words, if we were adding --recurse-submodules today, I'd
> agree that it should be treated like other fetch options, but we
> already added the option and some people/scripts might be used to
> the added flexibility, no?

Ok, even though that option was added only two months ago, somebody
could already use it. So that leaves option two:

1) Drop the patch I proposed

2) Document "--[no-]recurse-submodules" as " as "git pull" options

(And then I can later pass the same option to "git merge", which is
much better than the solutions I came up with ;-)

Maybe something like this?

-------------8<--------------
Subject: [PATCH] pull: Document the "--[no-]recurse-submodules" options

In commits be254a0ea9 and 7dce19d374 the handling of the new fetch options
"--[no-]recurse-submodules" had been added to git-pull.sh. But they were
not documented as the pull options they now are, so let's fix that.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/fetch-options.txt |    2 +-
 Documentation/git-pull.txt      |    4 ++++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 695696d..ab0dbfc 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -64,11 +64,11 @@ ifndef::git-pull[]
 	downloaded. The default behavior for a remote may be
 	specified with the remote.<name>.tagopt setting. See
 	linkgit:git-config[1].
-endif::git-pull[]

 --[no-]recurse-submodules::
 	This option controls if new commits of all populated submodules should
 	be fetched too (see linkgit:git-config[1] and linkgit:gitmodules[5]).
+endif::git-pull[]

 ifndef::git-pull[]
 --submodule-prefix=<path>::
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 3046691..7d0f601 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -84,6 +84,10 @@ must be given before the options meant for 'git fetch'.
 --verbose::
 	Pass --verbose to git-fetch and git-merge.

+--[no-]recurse-submodules::
+	This option controls if new commits of all populated submodules should
+	be fetched too (see linkgit:git-config[1] and linkgit:gitmodules[5]).
+
 Options related to merging
 ~~~~~~~~~~~~~~~~~~~~~~~~~~

-- 
1.7.4.31.g5ae186.dirty
