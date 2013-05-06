From: Andreas Jacobsen <andreas@andreasjacobsen.com>
Subject: Re: Segfault in git merge-tree (1.8.2.2)
Date: Mon, 6 May 2013 16:13:28 +0200
Message-ID: <CADEJa-5-UpkUaNQ=QResY54cH4TvXqiUSeG-jewH+n+HsZqmHA@mail.gmail.com>
References: <CADEJa-5prhhY-fUHgkk91M8HKWRG3enODS_h7Mq0dgo7V9sYsQ@mail.gmail.com>
	<20130506133937.GB25912@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon May 06 16:13:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZMAg-0000KH-WE
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 16:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251Ab3EFONg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 10:13:36 -0400
Received: from mail-ve0-f169.google.com ([209.85.128.169]:37463 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119Ab3EFON3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 10:13:29 -0400
Received: by mail-ve0-f169.google.com with SMTP id jz10so3207183veb.14
        for <git@vger.kernel.org>; Mon, 06 May 2013 07:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:x-gm-message-state;
        bh=DgqKKw7S7u+3vKCIz46QvNpCkcQ7WF7lgVnrG4uJVy4=;
        b=cpBtf/nqEJS8r/Wb0tHvIc6rcCQtvbgLSBMSBDU4ASRdEYNtCt0a5TjHHuhM+/HwTg
         aH3qEZF2S2thKkfRKE239luk5Ww937N8BWIrUiSDEYnXPfNzlYc5klftAR8nkN7nybQv
         EltVPqY5W4qlu60NwJosAjHpumNMpC50aPdaAr7fDnLkn3tQy+3U9pndcnLvEwUhYvtN
         O/bbKdBr2hNwDYGZq6Ax87NLj2FediHuk6hmEzxc5k5a+zcsa0ikNNUBy3GhwFlPlRiT
         Rryvjcjz4LCN7+5643Nf0a5QKUL8wNK71xarI3VanUaq2tHpw+ZqPY7pTJAaz02Tgqzn
         ENmg==
X-Received: by 10.52.96.138 with SMTP id ds10mr5811277vdb.3.1367849608689;
 Mon, 06 May 2013 07:13:28 -0700 (PDT)
Received: by 10.58.252.135 with HTTP; Mon, 6 May 2013 07:13:28 -0700 (PDT)
In-Reply-To: <20130506133937.GB25912@serenity.lan>
X-Gm-Message-State: ALoCoQkILUo727lyOWhWpthryBqdAfdGndGUFLF2BKoAYBCQZzUOnEzN8Aa8NYdNDlubMuGh/7w/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223452>

Sure, here you go, this time built from the HEAD I found on github
(7d3ccdffb5d28970dd7a4d177cfcca690ccd0c22) with:

NO_GETTEXT=1 make prefix=/usr/local/Cellar/git/HEAD CC=cc CFLAGS='-O0
-g' install (this is homebrew's setup, but I built it manually rather
than using the recipe.)

And the gdb output:

(gdb) set args merge-tree 027058e6ac8d03e029c4e1455bf90f63cd20e65b
FETCH_HEAD master
(gdb) run
Starting program: /usr/local/bin/git merge-tree
027058e6ac8d03e029c4e1455bf90f63cd20e65b FETCH_HEAD master
Reading symbols for shared libraries +++++.............................. done

Program received signal EXC_BAD_ACCESS, Could not access memory.
Reason: KERN_INVALID_ADDRESS at address: 0x0000000000000000
0x000000010006f1a3 in add_merge_entry (entry=0x100432ba0) at
builtin/merge-tree.c:24
24 *merge_result_end = entry;
(gdb) bt
#0  0x000000010006f1a3 in add_merge_entry (entry=0x100432ba0) at
builtin/merge-tree.c:24
#1  0x000000010006ee24 in unresolved (info=0x7fff5fbfd508,
n=0x1004367c0) at builtin/merge-tree.c:270
#2  0x000000010006eaa2 in threeway_callback (n=3, mask=4, dirmask=0,
entry=0x1004367c0, info=0x7fff5fbfd508) at builtin/merge-tree.c:330
#3  0x000000010018eef2 in traverse_trees (n=3, t=0x7fff5fbfd5d0,
info=0x7fff5fbfd508) at tree-walk.c:407
#4  0x000000010006e8e8 in merge_trees_recursive (t=0x7fff5fbfd5d0,
base=0x100436780
"bibliotek/httpservice/src/main/java/no/ok/it/lib/http/service",
df_conflict=1) at builtin/merge-tree.c:341
#5  0x000000010006f082 in unresolved_directory (info=0x7fff5fbfd7d8,
n=0x100436660, df_conflict=1) at builtin/merge-tree.c:221
#6  0x000000010006ed2c in unresolved (info=0x7fff5fbfd7d8,
n=0x100436660) at builtin/merge-tree.c:258
#7  0x000000010006eaa2 in threeway_callback (n=3, mask=4, dirmask=4,
entry=0x100436660, info=0x7fff5fbfd7d8) at builtin/merge-tree.c:330
#8  0x000000010018eef2 in traverse_trees (n=3, t=0x7fff5fbfd8a0,
info=0x7fff5fbfd7d8) at tree-walk.c:407
#9  0x000000010006e8e8 in merge_trees_recursive (t=0x7fff5fbfd8a0,
base=0x100435e70
"bibliotek/httpservice/src/main/java/no/ok/it/lib/http",
df_conflict=1) at builtin/merge-tree.c:341
#10 0x000000010006f082 in unresolved_directory (info=0x7fff5fbfdaa8,
n=0x100435d50, df_conflict=1) at builtin/merge-tree.c:221
#11 0x000000010006ed2c in unresolved (info=0x7fff5fbfdaa8,
n=0x100435d50) at builtin/merge-tree.c:258
#12 0x000000010006eaa2 in threeway_callback (n=3, mask=4, dirmask=4,
entry=0x100435d50, info=0x7fff5fbfdaa8) at builtin/merge-tree.c:330
#13 0x000000010018eef2 in traverse_trees (n=3, t=0x7fff5fbfdb70,
info=0x7fff5fbfdaa8) at tree-walk.c:407
#14 0x000000010006e8e8 in merge_trees_recursive (t=0x7fff5fbfdb70,
base=0x100435d10 "bibliotek/httpservice/src/main/java/no/ok/it/lib",
df_conflict=1) at builtin/merge-tree.c:341
#15 0x000000010006f082 in unresolved_directory (info=0x7fff5fbfdd78,
n=0x100436450, df_conflict=1) at builtin/merge-tree.c:221
#16 0x000000010006ed2c in unresolved (info=0x7fff5fbfdd78,
n=0x100436450) at builtin/merge-tree.c:258
#17 0x000000010006eaa2 in threeway_callback (n=3, mask=4, dirmask=4,
entry=0x100436450, info=0x7fff5fbfdd78) at builtin/merge-tree.c:330
#18 0x000000010018eef2 in traverse_trees (n=3, t=0x7fff5fbfde40,
info=0x7fff5fbfdd78) at tree-walk.c:407
#19 0x000000010006e8e8 in merge_trees_recursive (t=0x7fff5fbfde40,
base=0x100436400 "bibliotek/httpservice/src/main/java/no/ok/it",
df_conflict=1) at builtin/merge-tree.c:341
#20 0x000000010006f082 in unresolved_directory (info=0x7fff5fbfe048,
n=0x100433c80, df_conflict=1) at builtin/merge-tree.c:221
#21 0x000000010006ed2c in unresolved (info=0x7fff5fbfe048,
n=0x100433c80) at builtin/merge-tree.c:258
#22 0x000000010006eaa2 in threeway_callback (n=3, mask=4, dirmask=4,
entry=0x100433c80, info=0x7fff5fbfe048) at builtin/merge-tree.c:330
#23 0x000000010018eef2 in traverse_trees (n=3, t=0x7fff5fbfe110,
info=0x7fff5fbfe048) at tree-walk.c:407
#24 0x000000010006e8e8 in merge_trees_recursive (t=0x7fff5fbfe110,
base=0x100433c50 "bibliotek/httpservice/src/main/java/no/ok",
df_conflict=1) at builtin/merge-tree.c:341
#25 0x000000010006f082 in unresolved_directory (info=0x7fff5fbfe318,
n=0x10042d2a0, df_conflict=1) at builtin/merge-tree.c:221
#26 0x000000010006ed2c in unresolved (info=0x7fff5fbfe318,
n=0x10042d2a0) at builtin/merge-tree.c:258
#27 0x000000010006eaa2 in threeway_callback (n=3, mask=4, dirmask=4,
entry=0x10042d2a0, info=0x7fff5fbfe318) at builtin/merge-tree.c:330
#28 0x000000010018eef2 in traverse_trees (n=3, t=0x7fff5fbfe3e0,
info=0x7fff5fbfe318) at tree-walk.c:407
#29 0x000000010006e8e8 in merge_trees_recursive (t=0x7fff5fbfe3e0,
base=0x10042d250 "bibliotek/httpservice/src/main/java/no",
df_conflict=1) at builtin/merge-tree.c:341
#30 0x000000010006f082 in unresolved_directory (info=0x7fff5fbfe5e8,
n=0x100435750, df_conflict=1) at builtin/merge-tree.c:221
#31 0x000000010006ed2c in unresolved (info=0x7fff5fbfe5e8,
n=0x100435750) at builtin/merge-tree.c:258
#32 0x000000010006eaa2 in threeway_callback (n=3, mask=4, dirmask=4,
entry=0x100435750, info=0x7fff5fbfe5e8) at builtin/merge-tree.c:330
#33 0x000000010018eef2 in traverse_trees (n=3, t=0x7fff5fbfe6b0,
info=0x7fff5fbfe5e8) at tree-walk.c:407
#34 0x000000010006e8e8 in merge_trees_recursive (t=0x7fff5fbfe6b0,
base=0x100431d70 "bibliotek/httpservice/src/main/java", df_conflict=1)
at builtin/merge-tree.c:341
#35 0x000000010006f082 in unresolved_directory (info=0x7fff5fbfe8b8,
n=0x100431460, df_conflict=1) at builtin/merge-tree.c:221
#36 0x000000010006ed2c in unresolved (info=0x7fff5fbfe8b8,
n=0x100431460) at builtin/merge-tree.c:258
#37 0x000000010006eaa2 in threeway_callback (n=3, mask=4, dirmask=4,
entry=0x100431460, info=0x7fff5fbfe8b8) at builtin/merge-tree.c:330
#38 0x000000010018eef2 in traverse_trees (n=3, t=0x7fff5fbfe980,
info=0x7fff5fbfe8b8) at tree-walk.c:407
#39 0x000000010006e8e8 in merge_trees_recursive (t=0x7fff5fbfe980,
base=0x100431420 "bibliotek/httpservice/src/main", df_conflict=1) at
builtin/merge-tree.c:341
#40 0x000000010006f082 in unresolved_directory (info=0x7fff5fbfeb88,
n=0x100433560, df_conflict=1) at builtin/merge-tree.c:221
#41 0x000000010006ed2c in unresolved (info=0x7fff5fbfeb88,
n=0x100433560) at builtin/merge-tree.c:258
#42 0x000000010006eaa2 in threeway_callback (n=3, mask=4, dirmask=4,
entry=0x100433560, info=0x7fff5fbfeb88) at builtin/merge-tree.c:330
#43 0x000000010018eef2 in traverse_trees (n=3, t=0x7fff5fbfec50,
info=0x7fff5fbfeb88) at tree-walk.c:407
#44 0x000000010006e8e8 in merge_trees_recursive (t=0x7fff5fbfec50,
base=0x1004325d0 "bibliotek/httpservice/src", df_conflict=1) at
builtin/merge-tree.c:341
#45 0x000000010006f082 in unresolved_directory (info=0x7fff5fbfee58,
n=0x100434ff0, df_conflict=1) at builtin/merge-tree.c:221
#46 0x000000010006ed2c in unresolved (info=0x7fff5fbfee58,
n=0x100434ff0) at builtin/merge-tree.c:258
#47 0x000000010006eaa2 in threeway_callback (n=3, mask=4, dirmask=4,
entry=0x100434ff0, info=0x7fff5fbfee58) at builtin/merge-tree.c:330
#48 0x000000010018eef2 in traverse_trees (n=3, t=0x7fff5fbfef20,
info=0x7fff5fbfee58) at tree-walk.c:407
#49 0x000000010006e8e8 in merge_trees_recursive (t=0x7fff5fbfef20,
base=0x100431770 "bibliotek/httpservice", df_conflict=1) at
builtin/merge-tree.c:341
#50 0x000000010006f082 in unresolved_directory (info=0x7fff5fbff128,
n=0x100433000, df_conflict=1) at builtin/merge-tree.c:221
#51 0x000000010006ed2c in unresolved (info=0x7fff5fbff128,
n=0x100433000) at builtin/merge-tree.c:258
#52 0x000000010006eaa2 in threeway_callback (n=3, mask=4, dirmask=4,
entry=0x100433000, info=0x7fff5fbff128) at builtin/merge-tree.c:330
#53 0x000000010018eef2 in traverse_trees (n=3, t=0x7fff5fbff1f0,
info=0x7fff5fbff128) at tree-walk.c:407
#54 0x000000010006e8e8 in merge_trees_recursive (t=0x7fff5fbff1f0,
base=0x10042fae0 "bibliotek", df_conflict=0) at
builtin/merge-tree.c:341
#55 0x000000010006f082 in unresolved_directory (info=0x7fff5fbff3f8,
n=0x100430530, df_conflict=0) at builtin/merge-tree.c:221
#56 0x000000010006ed2c in unresolved (info=0x7fff5fbff3f8,
n=0x100430530) at builtin/merge-tree.c:258
#57 0x000000010006eaa2 in threeway_callback (n=3, mask=7, dirmask=7,
entry=0x100430530, info=0x7fff5fbff3f8) at builtin/merge-tree.c:330
#58 0x000000010018eef2 in traverse_trees (n=3, t=0x7fff5fbff4b0,
info=0x7fff5fbff3f8) at tree-walk.c:407
#59 0x000000010006e8e8 in merge_trees_recursive (t=0x7fff5fbff4b0,
base=0x1001b548a "", df_conflict=0) at builtin/merge-tree.c:341
#60 0x000000010006e302 in merge_trees (t=0x7fff5fbff4b0,
base=0x1001b548a "") at builtin/merge-tree.c:346
#61 0x000000010006e1db in cmd_merge_tree (argc=4, argv=0x7fff5fbff720,
prefix=0x0) at builtin/merge-tree.c:373
#62 0x0000000100002940 in run_builtin (p=0x100210c40, argc=4,
argv=0x7fff5fbff720) at git.c:284
#63 0x0000000100001837 in handle_internal_command (argc=4,
argv=0x7fff5fbff720) at git.c:446
#64 0x0000000100002169 in run_argv (argcp=0x7fff5fbff6e8,
argv=0x7fff5fbff6e0) at git.c:492
#65 0x0000000100001675 in main (argc=4, argv=0x7fff5fbff720) at git.c:567
Current language:  auto; currently minimal

On 6 May 2013 15:39, John Keeping <john@keeping.me.uk> wrote:
> On Mon, May 06, 2013 at 03:02:10PM +0200, Andreas Jacobsen wrote:
>> I'm getting a segfault in git merge-tree using v1.8.2.2 on MacOS
>> 10.8.3. I can't share the repo, but I can build patches and check if
>> they fix the problem :)
>
> Can you rebuild with debugging information and try the backtrace again?
>
> Something like:
>
>     make CFLAGS='-O0 -g'
>
> Then use the "git" in bin-wrappers/.
