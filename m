From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Sat, 28 Jul 2007 10:44:56 +0200
Organization: Organization?!?
Message-ID: <854pjo533r.fsf@lola.goethe.zz>
References: <85lkdezi08.fsf@lola.goethe.zz> <Pine.LNX.4.64.0707180135200.14781@racer.site> <858x9ez1li.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org> <vpq4pk1vf7q.fsf@bauges.imag.fr>  =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?alpine.LFD.0.999?= =?ISO-8859-1?Q?.0707181004330.=04?=
	=?ISO-8859-1?Q?27353@woody.linu?= =?ISO-8859-1?Q?x-foundation.org?=
	=?ISO-8859-1?Q?>?= <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org> <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <851wf2bcqy.fsf@lola.goethe.zz>  =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?alpine.LFD.0.999?= =?ISO-8859-1?Q?.070720=042135450.?=
	=?ISO-8859-1?Q?27249@woody.linu?= =?ISO-8859-1?Q?x-foundation.org?=
	=?ISO-8859-1?Q?>?= <alpine.LFD.0.999.0707202154220.27249@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 28 10:45:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEhvY-0001ot-44
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 10:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934221AbXG1Ip3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 04:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbXG1Ip3
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 04:45:29 -0400
Received: from main.gmane.org ([80.91.229.2]:54467 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752619AbXG1Ip1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 04:45:27 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IEhvM-0006sW-D8
	for git@vger.kernel.org; Sat, 28 Jul 2007 10:45:20 +0200
Received: from dslb-084-061-039-045.pools.arcor-ip.net ([84.61.39.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Jul 2007 10:45:20 +0200
Received: from dak by dslb-084-061-039-045.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Jul 2007 10:45:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-039-045.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:SmiyVa+WI1fk5B9K6aDdJGvYJfE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54008>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Why? Because my preliminary patches sort the index entries wrong. A 
> directory should always sort *as*if* it had the '/' at the end.
>
> See base_name_compare() for details.
>
> And we've never done that for the index, because the index has never had 
> this issue (since it never contained directories). So sit down and compare 
> base_name_compare (for tree entries) with cache_name_compare() (for index 
> entries), and see how the latter doesn't care about the type of names.
>
> This was actually something that I hit already with subproject support, 
> and one of my very first patches even had some (aborted) code to start 
> sorting subprojects in the index the way we sort directories.
>
> And I *should* have done it that way, but I never did. It now makes the 
> S_ISDIR handling harder, because directories really do have to be sorted 
> as if they had the '/' at the end, or "git-fsck" will complain about bad 
> sorting.
>
> Sad, sad, sad. It effectively means that S_IFGITLINK is *not* quite the 
> same as S_IFDIR, because they sort differently. Duh.
>
> Of course, it seldom matters, but basically, you should test a directory 
> structure that has the files
>
> 	dir.c
> 	dir/test
>
> in it, and the "dir" directory should always sort _after_ "dir.c".
>
> And yes, having the index entry with a '/' at the end would handle that 
> automatically.

Personally, I am not much in favor of using different names in index
and repository.

> As it is, with the "mode" difference, it instead needs to fix up 
> "cache_name_compare()". Admittedly, that would actually be a cleanup 
> (since it would now match base_name_compare() in logic, and could actually 
> use that to do the name comparison!), but it's a damn painful cleanup 
> because we don't even pass in the mode to "cache_name_compare()", since we 
> never needed it.
>
> Gaah.
>
> cache_name_compare itself isn't used in that many places,

dir.c and readcache.c

> but it's used by "index_name_pos()/cache_name_pos()", which *is*
> used in many places.

cache_name_pos:
builtin-apply.c
builtin-blame.c
builtin-checkout-index.c
builtin-ls-files.c
builtin-mv.c
builtin-read-tree.c
builtin-rm.c
builtin-update-index.c
diff.c
diff-lib.c
dir.c
merge-index.c
sha1_name.c
unpack-trees.c
wt-status.c

index_name_pos:
read-cache.c

> And again, that one doesn't even have the mode, so it cannot pass it
> down.

> So it probably *is* easier to add the '/' at the end of the name
> instead, to make directories sort the right way in the index. I'd
> still suggest you *also* make the mode be S_IFDIR, though (and
> preferably make git-fsck actually verify that the mode and the last
> character of the name matches!).

Actually, pretty much all of the above files are likely to get touched
by directory support one way or another anyway.  One really should aim
for the cleanest solution in the long run, and this for me more or
less means that it makes no sense to have different names in index and
repository.  Putting that slash in always would probably simplify some
logic in the repository as well, but I don't really like something as
marker-like as "/" in the data structures.  Putting a slash there
would involve a three-phase plan:

a) make fsck and the other code deal gracefully with either slash or
   no slash.
Wait until everybody uses this code.

b) make the code actually _put_ slashes there.
Wait until everybody has used this code.

c) deal with it for all eternity, oops: since rewriting the
   cryptographic history of existing repositories is pretty much out
   as far as I understand (which might be insufficient), one has to
   navigate around slash/noslash all the time when accessing
   repositories, including the sorting.  The index, however, can at
   one point of time phase out the slash-specific sorting.  There is
   no such thing as prehistoric indexes we would need to mind.

I guess that looks like not being worth the pain.  Double the code or
no money back.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
