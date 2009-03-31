From: "Michael Johnson" <redbeard@mdjohnson.us>
Subject: Re: Segfault on merge with 1.6.2.1
Date: Tue, 31 Mar 2009 02:14:21 -0500
Message-ID: <op.urnad7jbso3nzr@sulidor.mdjohnson.us>
References: <op.urifmtkkso3nzr@sulidor.mdjohnson.us>
 <20090329121700.GN22446@genesis.frugalware.org>
 <op.urk20nanso3nzr@sulidor.mdjohnson.us>
 <20090330110335.GF22446@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Mar 31 09:16:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoYD9-0002wv-KL
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 09:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359AbZCaHOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 03:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753317AbZCaHOd
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 03:14:33 -0400
Received: from caibbdcaaaaf.dreamhost.com ([208.113.200.5]:42623 "EHLO
	looneymail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752599AbZCaHOc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 03:14:32 -0400
Received: from sulidor.mdjohnson.us (216.49.248-IP-55.ckt.net [216.49.248.55])
	by looneymail-a5.g.dreamhost.com (Postfix) with ESMTP id 633A7122544;
	Tue, 31 Mar 2009 00:14:29 -0700 (PDT)
In-Reply-To: <20090330110335.GF22446@genesis.frugalware.org>
User-Agent: Opera Mail/9.64 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115230>

On Mon, 30 Mar 2009 06:03:35 -0500, Miklos Vajna <vmiklos@frugalware.org>  
wrote:

> On Sun, Mar 29, 2009 at 09:39:49PM -0500, Michael Johnson  
> <redbeard@mdjohnson.us> wrote:
>> Well, I've got a backtrace, but I don't have debugging symbols,
>> apparently. There is not a Debian package I can find that has them. I
>> checked debug.debian.net, as well as the standard sid repository. So I
>> will have to rebuild the package with debugging turned on. I will not be
>> able to do that tonight, unfortunately. I will probably have a chance
>> tomorrow evening.
>
> Okay, no rush. In case Dscho's patch does not fix your problem, please
> rebuild git with debug symbols enabled and send a normal trace.
>

It would appear that the patch has already been applied to 1.6.2.1.

That said, here's my backtrace. I've tried tracing through to figure out  
where the problem is occurring, but my gdb-foo is non-existent, I'm wating  
for some GUIs to install, and I'm ready for some sleep :| So if I haven't  
heard back by tomorrow evening, I'll be running one of the frontends for  
gdb until I have something traced down :)

If you need any more information, please let me know.

Thanks,
Michael

(gdb) run merge origin/dojo-1.3
Starting program: /usr/bin/git merge origin/dojo-1.3
[Thread debugging using libthread_db enabled]
[New Thread 0xb7b1bb30 (LWP 2651)]

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0xb7b1bb30 (LWP 2651)]
0x080fa828 in parse_tree (item=0x0) at tree.c:250
250		if (item->object.parsed)
(gdb) backtrace
#0  0x080fa828 in parse_tree (item=0x0) at tree.c:250
#1  0x080cc40b in init_tree_desc_from_tree (desc=0xbfdf53ac, tree=0x0) at  
merge-recursive.c:161
#2  0x080cc4d4 in git_merge_trees (index_only=1, common=0x8fa5df8,  
head=0x0, merge=0x8fa5718) at merge-recursive.c:186
#3  0x080cf28e in merge_trees (o=0xbfdf54d0, head=0x0, merge=0x8fa5718,  
common=0x8fa5df8, result=0xbfdf5448)
     at merge-recursive.c:1170
#4  0x080cf75f in merge_recursive (o=0xbfdf54d0, h1=0x8ffc200,  
h2=0x8f992f0, ca=0x0, result=0xbfdf548c)
     at merge-recursive.c:1294
#5  0x080cf6c7 in merge_recursive (o=0xbfdf54d0, h1=0x8f99050,  
h2=0x8f98ff0, ca=0x8f97b98, result=0xbfdf551c)
     at merge-recursive.c:1280
#6  0x08080d75 in try_merge_strategy (strategy=0x811b9b0 "recursive",  
common=0x8fd40f0, head_arg=0x811be14 "HEAD")
     at builtin-merge.c:566
#7  0x08082446 in cmd_merge (argc=1, argv=0xbfdf5808, prefix=0x0) at  
builtin-merge.c:1111
#8  0x0804bb5f in run_builtin (p=0x8130400, argc=2, argv=0xbfdf5808) at  
git.c:244
#9  0x0804bcf3 in handle_internal_command (argc=2, argv=0xbfdf5808) at  
git.c:388
#10 0x0804bdf0 in run_argv (argcp=0xbfdf5780, argv=0xbfdf5784) at git.c:434
#11 0x0804bf82 in main (argc=2, argv=0xbfdf5808) at git.c:505

-- 
Michael D Johnson   <redbeard@mdjohnson.us>    
redbeardcreator.deviantart.com

"Marketing research...[has] shown that energy weapons that make sounds sell
  better..." - Kevin Siembieda (Rifts Game Master Guide, pg 111)
