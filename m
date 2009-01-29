From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Something weird is happening...
Date: Thu, 29 Jan 2009 23:20:01 +0100
Message-ID: <49822B91.6070303@lsrfire.ath.cx>
References: <49814BA4.6030705@zytor.com> <7vr62mha7a.fsf@gitster.siamese.dyndns.org> <20090129113846.GA10645@elte.hu> <20090129120539.GA26975@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Thu Jan 29 23:22:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSfGe-00089w-1B
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 23:21:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755625AbZA2WUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 17:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755205AbZA2WUL
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 17:20:11 -0500
Received: from india601.server4you.de ([85.25.151.105]:34001 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754812AbZA2WUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 17:20:09 -0500
Received: from [10.0.1.101] (p57B7CD5D.dip.t-dialin.net [87.183.205.93])
	by india601.server4you.de (Postfix) with ESMTPSA id 9C5432F8045;
	Thu, 29 Jan 2009 23:20:05 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <20090129120539.GA26975@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107736>

Ingo Molnar schrieb:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
>> a simple 'git fsck' still reports a ton of dangling and missing objects. 
>> (see it below)
>>
>> amongst them is the object above:
>>
>>   missing blob af0e01d4c663a101f48614e40d006ed6272d5c36
>>
>> but this does not seem to cause problems with git version 1.6.0.6 that 
>> i'm using now.
> 
> hm - maybe it's unrelated, but yesterday, a few hours before the incident 
> i did a higher-order Octopus merge with 1.6.1, that segfaulted.
> 
> I didnt think much of it - git often crashes with our crazy -tip tree when 
> i get above the magic 20 branches limit. The crash left a .git/index.lock 
> file around which i removed - and then forgot about the incident. I wanted 
> to report those crashes before but procrastinated it.
> 
> I used git/maint snapshots because new versions of Git are much better at 
> doing Octopus merges.
> 
> I've written a reproducer for git-1.6.1.1-1.fc11.i386. See the crash log 
> below.
> 
> To reproduce, pick up the -tip tree as a remote:
> 
>    http://people.redhat.com/mingo/tip.git/README
> 
> (you can run the README file as a script)
> 
> Then do this:
> 
>    git checkout -b tmp.crash v2.6.29-rc3
> 
>    git merge  tip/x86/asm        tip/x86/cleanups     tip/x86/cpudetect    \
>               tip/x86/debug      tip/x86/doc          tip/x86/header-fixes \
>               tip/x86/mm         tip/x86/paravirt     tip/x86/pat          \
>               tip/x86/setup-v2   tip/x86/subarch      tip/x86/uaccess      \
>               tip/x86/urgent     tip/core/percpu
> 
> and you should see the segfault.
> 
> interestingly i did not reproduce with the sha1's hardcoded:
> 
>   git checkout -b tmp.crash 18e352e4a73465349711a9324767e1b2453383e2
> 
>  git merge 2d4d57db692ea790e185656516e6ebe8791f1788 a448720ca3248e8a7a426336885549d6e923fd8e b38b0665905538e76e26f2a4c686179abb1f69f6 d5e397cb49b53381e4c99a064ca733c665646de8 e56d0cfe7790fd3218ae4f6aae1335547fea8763 dbca1df48e89d8aa59254fdc10ef16c16e73d94e fb746d0e1365b7472ccc4c3d5b0672b34a092d0b 6522869c34664dd5f05a0a327e93915b1281c90d d639bab8da86d330493487e8c0fea8ca31f53427 042cbaf88ab48e11afb725541e3c2cbf5b483680 5662a2f8e7313f78d6b17ab383f3e4f04971c335 3b4b75700a245d0d48fc52a4d2f67d3155812aba bf3647c44bc76c43c4b2ebb4c37a559e899ac70e 4369f1fb7cd4cf777312f43e1cb9aa5504fc4125
> 
> 	Ingo
> 
> -------------------->
> earth4:~/tip> git merge x86/asm x86/cleanups x86/cpudetect x86/debug 
> x86/doc x86/header-fixes x86/mm x86/paravirt x86/pat x86/setup-v2 
> x86/subarch x86/uaccess x86/urgent core/percpu
> Trying simple merge with 2d4d57db692ea790e185656516e6ebe8791f1788
> Trying simple merge with a448720ca3248e8a7a426336885549d6e923fd8e
> Simple merge did not work, trying automatic merge.
> Auto-merging arch/x86/include/asm/io.h
> Auto-merging arch/x86/include/asm/spinlock.h
> Auto-merging arch/x86/kernel/mpparse.c
> Auto-merging arch/x86/kernel/setup_percpu.c
> Auto-merging arch/x86/mm/init_32.c
> Trying simple merge with b38b0665905538e76e26f2a4c686179abb1f69f6
> Simple merge did not work, trying automatic merge.
> Auto-merging arch/x86/kernel/cpu/common.c
> Auto-merging arch/x86/kernel/cpu/intel.c
> Auto-merging arch/x86/mm/pat.c
> Trying simple merge with d5e397cb49b53381e4c99a064ca733c665646de8
> Trying simple merge with e56d0cfe7790fd3218ae4f6aae1335547fea8763
> Trying simple merge with dbca1df48e89d8aa59254fdc10ef16c16e73d94e
> Trying simple merge with fb746d0e1365b7472ccc4c3d5b0672b34a092d0b
> Trying simple merge with 6522869c34664dd5f05a0a327e93915b1281c90d
> Simple merge did not work, trying automatic merge.
> Auto-merging arch/x86/include/asm/paravirt.h
> Trying simple merge with d639bab8da86d330493487e8c0fea8ca31f53427
> Simple merge did not work, trying automatic merge.
> Auto-merging arch/x86/include/asm/io.h
> Auto-merging arch/x86/mm/ioremap.c
> Trying simple merge with 042cbaf88ab48e11afb725541e3c2cbf5b483680
> Trying simple merge with 5662a2f8e7313f78d6b17ab383f3e4f04971c335
> Trying simple merge with 3b4b75700a245d0d48fc52a4d2f67d3155812aba
> Simple merge did not work, trying automatic merge.
> Auto-merging arch/x86/kernel/signal.c
> Trying simple merge with bf3647c44bc76c43c4b2ebb4c37a559e899ac70e
> Simple merge did not work, trying automatic merge.
> Auto-merging arch/x86/kernel/cpu/intel.c
> Trying simple merge with 4369f1fb7cd4cf777312f43e1cb9aa5504fc4125
> /usr/libexec/git-core/git-merge-octopus: line 52: 26758 Segmentation fault      
> git read-tree -u -m --aggressive $common $MRT $SHA1
> Merge with strategy octopus failed.
> earth4:~/tip> 

Current master (a34a9dbbc) with the following patch should not
segfault anymore (it doesn't here), but I don't know where the
magic number six is coming from. :-/

diff --git a/unpack-trees.c b/unpack-trees.c
index 16bc2ca..4b02fbf 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -8,6 +8,8 @@
 #include "progress.h"
 #include "refs.h"
 
+#define STAGES (5 + 1)
+
 /*
  * Error messages expected by scripts out of plumbing commands such as
  * read-tree.  Non-scripted Porcelain is not required to use these messages
@@ -143,7 +145,7 @@ static inline int call_unpack_fn(struct cache_entry **src, struct unpack_trees_o
 
 static int unpack_index_entry(struct cache_entry *ce, struct unpack_trees_options *o)
 {
-	struct cache_entry *src[5] = { ce, };
+	struct cache_entry *src[STAGES] = { ce, };
 
 	o->pos++;
 	if (ce_stage(ce)) {
@@ -240,7 +242,7 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info, con
 	return ce;
 }
 
-static int unpack_nondirectories(int n, unsigned long mask, unsigned long dirmask, struct cache_entry *src[5],
+static int unpack_nondirectories(int n, unsigned long mask, unsigned long dirmask, struct cache_entry *src[STAGES],
 	const struct name_entry *names, const struct traverse_info *info)
 {
 	int i;
@@ -291,7 +293,7 @@ static int unpack_nondirectories(int n, unsigned long mask, unsigned long dirmas
 
 static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, struct name_entry *names, struct traverse_info *info)
 {
-	struct cache_entry *src[5] = { NULL, };
+	struct cache_entry *src[STAGES] = { NULL, };
 	struct unpack_trees_options *o = info->data;
 	const struct name_entry *p = names;
 
@@ -728,7 +730,7 @@ int threeway_merge(struct cache_entry **stages, struct unpack_trees_options *o)
 {
 	struct cache_entry *index;
 	struct cache_entry *head;
-	struct cache_entry *remote = stages[o->head_idx + 1];
+	struct cache_entry *remote;
 	int count;
 	int head_match = 0;
 	int remote_match = 0;
@@ -755,6 +757,9 @@ int threeway_merge(struct cache_entry **stages, struct unpack_trees_options *o)
 		head = NULL;
 	}
 
+	if (o->head_idx + 1 >= STAGES)
+		die("Too many stages (internal error)");
+	remote = stages[o->head_idx + 1];
 	if (remote == o->df_conflict_entry) {
 		df_conflict_remote = 1;
 		remote = NULL;
