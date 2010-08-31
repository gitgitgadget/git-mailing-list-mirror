From: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: Re: Q. about usage of notes
Date: Tue, 31 Aug 2010 12:13:12 +0200
Organization: ATLAS Elektronik GmbH
Message-ID: <4C7CD5B8.20602@atlas-elektronik.com>
References: <4C7CB8AF.5080008@atlas-elektronik.com> <201008311107.32278.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Aug 31 12:13:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqNqL-0001vP-2I
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 12:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855Ab0HaKNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 06:13:24 -0400
Received: from lxsrv96.atlas.de ([194.156.172.86]:33929 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751755Ab0HaKNX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 06:13:23 -0400
Received: from VSSRV01.atlas.de (vssrv01.atlas.de [10.200.101.18])
	by mail96.atlas.de (Postfix) with ESMTP id 8DA6D138A7
	for <git@vger.kernel.org>; Tue, 31 Aug 2010 12:13:21 +0200 (CEST)
X-AuditID: 0ac86512-00001798000005d0-7f-4c7cd5c079d1
Received: from mgsrv01.atlas.de ([10.200.101.16]) by VSSRV01.atlas.de with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 31 Aug 2010 12:13:20 +0200
Received: from mgsrv01.atlas.de (localhost [127.0.0.1])
	by mail01-int.atlas.de (Postfix) with ESMTP id E28BA2717A;
	Tue, 31 Aug 2010 12:13:20 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on mgsrv01.atlas.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=5.0 tests=ALL_TRUSTED,BAYES_50
	autolearn=disabled version=3.2.5
Received: from [141.200.42.243] (as106913.atlas.de [141.200.42.243])
	by mail01.atlas.de (Postfix) with ESMTP id D03AF2716A;
	Tue, 31 Aug 2010 12:13:20 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.14) Gecko/20080421 Lightning/0.8 Thunderbird/2.0.0.14 Mnenhy/0.7.5.0
In-Reply-To: <201008311107.32278.johan@herland.net>
X-Enigmail-Version: 1.1.1
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154890>

On 8/31/2010 11:07 AM, Johan Herland wrote:
> On Tuesday 31 August 2010, Stefan Naewe wrote:
>> Hi,
>>
>> I was playing around with 'git notes' these days (after reading S.Chacons
>> post to this list and hist blog post at progit.org).
>>
>> Some things came to my mind when doing some 'git notes add' and
>> 'git notes remove':
>>
>> How do I really get rid of git notes ? 'git notes remove' doesn't really
>> remove the notes but creates a new commit (like 'git rm file ; git
>> commit..' does).
> 
> Well, how do you "really" get rid of a file on a "regular" Git branch? The 
> answer is that Git doesn't let you do this without rewriting history (e.g. 
> using 'git filter-branch' to create a new history where that file never 
> existed). The same argument goes for notes: If you want to remove all traces 
> of notes for a given object, you must rewrite the notes history so that 
> those notes never existed.

OK. Understood.
 
> At least that's how the 'git notes' porcelain behaves. At the plumbing 
> level, it's possible to create notes commits that don't point to the 
> preceding notes history (every notes commit is a root commit), and thus end 
> up with "history-less" notes. An example of this is the notes-cache code.
> 
>> And why does 'git remove' do that repetetively (is that even a word...?),
>> i.e. 'git add -m"Note" ; git remove; git remove; git remove; git remove'
>> creates 5 commit objects under 'refs/notes/commits' Is that the intended
>> behaviour ?
> 
> (I assume your meant to put "notes" in all those commands: git notes add, 
> git notes remove, etc.)

Yes, sorry.

> Yes, this is the intended behaviour. Otherwise you would need a separate 
> notes index where you could stage notes changes (with git notes add/remove), 
> and then later commit those notes changes with (the imaginary) git notes 
> commit. This was deemed too cumbersome/complicated, and we settled for the 
> current approach instead.

But if I do:

$ touch file ; git add file ; git commit -m"add file"

and then 

$ for n in 1 2 3; do git rm file; git commit -m"rm file"; done
 
I get:

rm 'file'
[master 5b24511] rm file
 0 files changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 file
fatal: pathspec 'file' did not match any files
# On branch master
nothing to commit (working directory clean)
fatal: pathspec 'file' did not match any files
# On branch master
nothing to commit (working directory clean)

I don't get 4 commits. That's the part I don't understand :-(

> If you want to make several adds/removes per notes commit, you could:
> 
> 1. Use git-fast-import and its 'N' command (search the manual page for 
> "notemodify").

OK. Thanks. Didn't know that. 

> 2. Check out the notes ref into your working tree ("git checkout 
> refs/notes/commits"). You can now edit notes directly, like you would edit 
> your "regular" files. (Ideally, you should have some knowledge about the 
> format of notes trees before you add/rename files). When you're done, you 
> stage and commit as you would do in your regular checkout.

OK. I already tried that.
 
And to delete the 'notes branch' I can only use 'git update-ref' ?!


Thanks for your answer

Stefan
-- 
----------------------------------------------------------------
/dev/random says: Nostalgia isn't what it used to be.
