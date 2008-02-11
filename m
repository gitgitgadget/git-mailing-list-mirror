From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Mon, 11 Feb 2008 02:20:07 +0100
Message-ID: <200802110220.08078.jnareb@gmail.com>
References: <200802081828.43849.kendy@suse.cz> <m3ejbngtnn.fsf@localhost.localdomain> <200802091627.25913.kendy@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jan Holesovsky <kendy@suse.cz>
X-From: git-owner@vger.kernel.org Mon Feb 11 02:20:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JONLu-000884-Th
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 02:20:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbYBKBUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 20:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbYBKBUX
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 20:20:23 -0500
Received: from hs-out-0708.google.com ([64.233.178.242]:26468 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750745AbYBKBUW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 20:20:22 -0500
Received: by hs-out-2122.google.com with SMTP id 54so3752657hsz.5
        for <git@vger.kernel.org>; Sun, 10 Feb 2008 17:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        bh=AWomoiWwZb9rVO3lSCgS+itg7a7JaaRxr4EklkIVAww=;
        b=rfAsBBIR2dsOWsSkKLwe9T6+12bRu2UjAjTT2TmV4apgyvOoN3YhYA6s693vU0hIsI41MibIWkkRfhfEj88DSqE2WJCj887Z0wDWnO9wSfdyxqu4MJ3wNnoMsGiC3B9YgEfma0mC+/S4LIHqec2iyV0g19CdZR7AP93YrTMcNyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=j0+92ch/3gkBZXLV0bWXc1nBXVTD6CqOtIge7hKiNnW5Mjba6P3dckPEtWc8joMSeCV0NLDN5BMWt7VatqFjrLIBP/Yh+sFbFuA5DInPCK/JM04aAiyUCOm4P/cw6MapEUcGetL0hXdInKn8CiLMYlRru0HAdQ8yadAoJ4SFHus=
Received: by 10.78.182.17 with SMTP id e17mr27803588huf.67.1202692819518;
        Sun, 10 Feb 2008 17:20:19 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.220.19])
        by mx.google.com with ESMTPS id f6sm536895nfh.21.2008.02.10.17.20.16
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Feb 2008 17:20:17 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200802091627.25913.kendy@suse.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73447>

Hi, Jan!

On Sat, 9 Feb 2008, Jan Holesovsky wrote:
> On Friday 08 February 2008 20:00, Jakub Narebski wrote:
> 
>> It was not implemented because it was thought to be hard; git assumes
>> in many places that if it has an object, it has all objects referenced
>> by it.
>>
>> But it is very nice of you to [try to] implement 'lazy clone'/'remote
>> alternates'.
>>
>> Could you provide some benchmarks (time, network throughtput, latency)
>> for your implementation?
> 
> Unfortunately not yet :-(  The only data I have that clone done on 
> git://localhost/ooo.git took 10 minutes without the lazy clone, and 7.5 
> minutes with it - and then I sent the patch for review here ;-)  The deadline 
> for our SVN vs. git comparison for OOo is the next Friday, so I'll definitely 
> have some better data by then.

Here perhaps another optimization which wasn't done because git is
fast enough on moderately-sized repositories, namely that IIRC git-clone
(and git-fetch for sure) over native (smart) protocol recreates pack,
even if sometimes better and simplier would be to just copy (transfer)
existing pack.

But this would need multi-pack "extension". (it should work just now
without transport protocol extension, receiver must only be aware
of the need to split resulting pack, and index them all).

>> Both Mozilla import, and GCC import were packed below 0.5 GB. Warning:
>> you would need machine with large amount of memory to repack it
>> tightly in sensible time!
> 
> As I answered elsewhere, unfortunately it goes out of memory even on 8G 
> machine (x86-64), so...  But still trying.

I hope that would work better...

>>> Shallow clone is not a possibility - we don't get patches through
>>> mailing lists, so we need the pull/push, and also thanks to the OOo
>>> development cycle, we have too many living heads which causes the
>>> shallow clone to download about 1.5G even with --depth 1.
>>
>> Wouldn't be easier to try to fix shallow clone implementation to allow
>> for pushing from shallow to full clone (fetching from full to shallow
>> is implemented), and perhaps also push/pull between two shallow
>> clones?
> 
> I tried to look into it a bit, but unfortunately did not see a clear way how 
> to do it transparently for the user - say you pull a branch that is based off 
> a commit you do not have.  But of course, I could have missed something ;-)

If I remember correctly fetching _into_ shallow clone works correctly,
as deepening depth of shallow clone. What is not implemented AFAIK, but
should be not too hard would be to allow to push from shallow clone
to full clone. This way the network of full clones (functioning as
centres to publish your work) and shallow + few branches repos (working
repositories).

I don't know if that would be enough.

For better support git would need to exchange graft-like information,
and use union of restrictions to get correct commits.


Perhaps it would be best to mail 'shallow clone' author...

>> As to many living heads: first, you don't need to fetch all
>> heads. Currently git-clone has no option to select subset of heads to
>> clone, but you can always use git-init + hand configuration +
>> git-remote and git-fetch for actual fetching.
> 
> Right, might be interesting as well.  But still the missing push/pull is 
> problematic for us [or at least I see it as a problem ;-)].

You can configure separate 'remote's for the same repository
with different heads. This would work both for pull and for push.


I think the solution proposed by Marco Costalba, namely of creating
"archive" repository, and "live" repository, joining them if needed
by grafts, similarly to how linux kernel has live repo, and historical
import repo, would be good alternative to shallow or lazy clone.

There would be "archive" repo (or repos), read only, with whole history,
very tightly packed with kept packs, with all branches and all tags,
and "live" repo, with only current history (a year, or since major
API change, or from today, or something like that), with only important
branches (or repos, each containg important for a team set of branches).
There would be prepared graft file to join two histories, if you have
to examine full history. Hopefully repo would be smaller.

>> By the way, did you try to split OpenOffice.org repository at the
>> components boundary into submodules (subprojects)? This would also
>> limit amount of needed download, as you don't neeed to download and
>> checkout all subprojects.
> 
> Yes, and got to much nicer repositories by that ;-) - by only moving some 
> binary stuff out of the CVS to a separate tree.  The problem is that the deal 
> is to compare the same stuff in SVN and git - so no choice for me in fact.

Sidenote: due to (from what I have read) heavy use of topic branches
in OOo development, Subversion would have to be used with svnmerge
extension, or together with SVK, to make work with it not complete
pain.

In CVS you could have ad-hoc modules, and ad-hoc partial checkouts
(so called 'modules'), but that plays merry hell with whole tree,
atomic, recoverable state commits. In Git you have to plan carefully
boundaries between submodules / subprojects. Additional advantage
is that you would have boundaries more clear, and better modularity
usually leads to better code.

Comparing directly Subversion and Git is a bit stupid: they promote
different workflows. From what I've read Git with its ability to very
easily create branches, with easy _merging_ of branches, and ability
to easily create _private_ branches (testing branches) have much
common witch chosen OOo SCM workflow. Playing to strentghs of
Subversion because that is why you used because of limits of previously
used tools is not smart.

But if you have to, then you have to. Git would hopefully get lazy
clone support from your effort. But perhaps it would be possible
(if additional work) to prepare two repositories: first the same
as Subversion (and same as now in CVS), second one "how it should
be done with Git".

>> The problem of course is _how_ to split repository into
>> submodules. Submodules should be enough self contained so the
>> whole-tree commit is alsays (or almost always) only about submodule.
> 
> I hope it will be doable _if_ the git wins & will be chosen for OOo.

I hope that ability to work with submodules (with ability to not
clone / checkout modules if not needed), i.e. "svn:externals
done right" to para[hrase SVN slogan, would be one of reasons to
chose Git over Subversion.

>>> Lazy clone sounded like the right idea to me.  With this
>>> proof-of-concept implementation, just about 550M from the 2.5G is
>>> downloaded, which is still about twice as much in comparison with
>>> downloading a tarball, but bearable.
>>
>> Do you have any numbers for OOo repository like number of revisions,
>> depth of DAG of commits (maximum number of revisions in one line of
>> commits), number of files, size of checkout, average size of file,
>> etc.?
> 
> I'll try to provide the data ASAP.

For example what is the size of full checkout (all version-control
managed files). Of for example it is 0.5 GB it would be hard to go
to less that 0.5GB or so with pack size, even with compression
of objects themselves in pack file.


Such large repositories, like Mozilla, GCC, or now OpenOffice.org
tests the limits of Git. Perhaps snapshot-based distributed SCMs
cannot deal sensibly with such large projects; I hope this is not
the case.

I wonder if packv4 improvements, which development stalled because
(if I understand correctly) because it didn't brough as much
improvements, and what is now was good enough for up-till-now
projects, would help with OpenOffice.org repository...


P.S. From what I have read OOo uses CVS + some branch DB; does
your importer make use of this branch info database?

-- 
Jakub Narebski
Poland
