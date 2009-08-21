From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Continue git clone after interruption
Date: Fri, 21 Aug 2009 12:07:37 +0200
Message-ID: <200908211207.38555.jnareb@gmail.com>
References: <1250509342.2885.13.camel@cf-48> <200908200937.05412.jnareb@gmail.com> <alpine.LFD.2.00.0908201358010.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Tomasz Kontusz <roverorna@gmail.com>, git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Aug 21 12:09:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeR3v-0000WW-0H
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 12:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380AbZHUKHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 06:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbZHUKHn
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 06:07:43 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:58591 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707AbZHUKHm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 06:07:42 -0400
Received: by fxm17 with SMTP id 17so377886fxm.37
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 03:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:content-type:content-transfer-encoding
         :message-id;
        bh=hBYXtKtqX5/q1ohQKHrDzryr1FjtsI8WRt1WAnxOu3M=;
        b=Bm3HWp96Cl+kRXH+YwnRQLbXhkfy5w9KZ06VdaBknGxIn0zvhWTUYzqvly7xRqeZ8U
         X3wYCta4W8mwJ6IdpkPgQfvA2Oe7nNHmGsjSGzr+goxaR3tttrFbrImwPQ9CfwaLyOn7
         KpRNTp8ru32/AQGr4bFerMWGCP9G0ZWWi5D4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        b=gQ+ngdd0Y7R583wN9UOm7lLCzZvF2gILxO57NXNOm+5Ap28kbjWWMU3e7w/RQqSvo+
         AqU0XLmyOPeprGWVf9Qb+NMzBdgC9AYjrSr4oEpAruY4TqD6S5kLMST6U2eifFDbQAdx
         K789FBwArZfcxpvMqhQWv/INLD28+k0D8Yh5w=
Received: by 10.86.211.38 with SMTP id j38mr728096fgg.26.1250849262365;
        Fri, 21 Aug 2009 03:07:42 -0700 (PDT)
Received: from ?192.168.1.13? (abwr82.neoplus.adsl.tpnet.pl [83.8.241.82])
        by mx.google.com with ESMTPS id 12sm2925158fgg.25.2009.08.21.03.07.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 Aug 2009 03:07:40 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.2.00.0908201358010.6044@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126703>

On Thu, 20 Aug 2009, Nicolas Pitre wrote:
> On Thu, 20 Aug 2009, Jakub Narebski wrote:
>> On Wed, 19 Aug 2009, Nicolas Pitre wrote:

>>> You'll get the very latest revision for HEAD, and only that.  The size 
>>> of the transfer will be roughly the size of a daily snapshot, except it 
>>> is fully up to date.  It is however non resumable in the event of a 
>>> network outage.  My proposal is to replace this with a "git archive" 
>>> call.  It won't get all branches, but for the purpose of initialising 
>>> one's repository that should be good enough.  And the "git archive" can 
>>> be fully resumable as I explained.
>> 
>> It is however only 2.5 MB out of 37 MB that are resumable, which is 7%
>> (well, that of course depends on repository).  Not that much that is
>> resumable.
> 
> Take the Linux kernel then.  It is more like 75 MB.

Ah... good example.

On the other hand Linux is fairly large project in terms of LoC, but
it had its history cut when moving to Git, so the ratio of git-archive
of HEAD to the size of packfile is overemphasized here.

>>> Now to deepen that history.  Let's say you want 10 more revisions going 
>>> back then you simply perform the fetch again with a --depth=10.  Right 
>>> now it doesn't seem to work optimally, but the pack that is then being 
>>> sent could be made of deltas against objects found in the commits we 
>>> already have.  Currently it seems that a pack that also includes those 
>>> objects we already have in addition to those we want is created, which 
>>> is IMHO a flaw in the shallow support that shouldn't be too hard to fix.  
>>> Each level of deepening should then be as small as standard fetches 
>>> going forward when updating the repository with new revisions.
>> 
>> You would have the same (or at least quite similar) problems with 
>> deepening part (the 'incrementals' transfer part) as you found with my
>> first proposal of server bisection / division of rev-list, and serving
>> 1/Nth of revisions (where N is selected so packfile is reasonable) to
>> client as incrementals.  Yours is top-down, mine was bottom-up approach
>> to sending series of smaller packs.  The problem is how to select size
>> of incrementals, and that incrementals are all-or-nothing (but see also
>> comment below).
> 
> Yes and no.  Combined with a slight reordering of commit objects, it 
> could be possible to receive a partial pack and still be able to extract 
> a bunch of full revisions.  The biggest issue is to be able to transfer 
> revision x (75 MB for Linux), but revision x-1 usually requires only a 
> few kilobytes, revision x-2 a few other kilobytes, etc.  Remember that 
> you are likely to have only a few deltas from one revision to another, 
> which is not the case for the very first revision you get.

Let's reiterate again, to be sure that I understand this correctly:


You make use here of a few facts:

1. Objects in packfile are _usually_ sorted in recency order, with most
   recent commits, and most recent versions of trees and tags being in
   the front of pack file, and being base objects for a large set of 
   objects.  Note the "usually" part; it is not set in stone as for RCS
   (and CVS) reverse delta based repository format.

2. There is support in git pack format to do 'deepening' of shallow
   clone, which means that git can generate incrementals in top-down
   order, _similar to how objects are ordered in packfile_.

3. git-archive output is stable.  _git-archive can be made resumable_
   (with range/partial requests), and can be made so it can create
   single-head depth 0 shallow clone.

Also, with top-down deepening order even if you don't use 
'git clone --continue' but 'git clone --skip' (or something), you
would have got usable shallow clone.  In the most extreme case when
you are able to get only the fully resumable part, i.e. git-archive
part (with top commit), you would have single-branch depth 0
shallow clone (not very usable, but still better than nothing).

> A special 
> mode to pack-object could place commit objects only after all the 
> objects needed to create that revision.  So once you get a commit object 
> on the receiving end, you could assume that all objects reachable from 
> that commit are already received, or you had them locally already.

Yes, with such mode (which I think wouldn't reduce / interfere with
ability for upload-pack to pack more tightly by reordering objects
and choosing different deltas) it would be easy to do a salvage of
a partially completed / transferred packfile.  Even if there is no
extension to tell git server which objects we have ("have" is only
about commits), if there is at least one commit object in received
part of packfile, we can try to continue from later (from more);
there is less left to download.

> 
>> In proposal using git-archive and shallow clone deepening as incrementals
>> you have this small seed (how small it depends on repository: 50% - 5%)
>> which is resumable.  And presumably with deepening you can somehow make
>> some use from incomplete packfile, only part of which was transferred 
>> before network error / disconnect.  And even tell server about objects
>> which you managed to extract from *.pack.part.
> 
> yes.  And at that point resuming the transfer is just another case of 
> shallow repository deepening.

Also for deepening top-down incrementals like in your proposal you can
have 'salvage' operation which tries to use something out of partially
transferred packfile (partially downloaded incremental).  It is not, 
I think, the case with my earlier 'server bisect' bottom-up incrementals
idea.

> 
>> *NEW IDEA*
>> 
>> Another solution would be to try to come up with some sort of stable
>> sorting of objects so that packfile generated for the same parameters
>> (endpoints) would be always byte-for-byte the same.  But that might be
>> difficult, or even impossible.
> 
> And I don't want to commit to that either.  Having some flexibility in 
> object ordering makes it possible to improve on the packing heuristics.  
> We certainly should avoid imposing strong restrictions like that for 
> little gain.  Even the deltas are likely to be different from one 
> request to another when using threads as one thread might be getting 
> more CPU time than another slightly modifying the outcome.

Right.

>> Well, we could send the list of objects in pack in order used later by
>> pack creation to client (non-resumable but small part), and if packfile
>> transport was interrupted in the middle client would compare list of 
>> complete objects in part of packfile against this manifest, and sent
>> request to server with *sorted* list of object it doesn't have yet.
> 
> Well... actually that's one of the item for pack V4.  Lots of SHA1s are 
> duplicated in tree and commit objects, in addition to the pack index 
> file.  With pack v4 all those SHA1s would be stored only once in a table 
> and objects would index that table instead.
> 
> Still, that is not _that_ small though.  Just look at the size of the 
> pack index file for the Linux repository to give you an idea.

Well, as such plan (map) of a packfile wouldn't be much smaller than
pack index, if pack index file is large enough (or connection crappy
enough) that it couldn't be transferred without interruption.

Nevertheless 34 MB index for largest 310 MB packfile in Linux kernel
http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/pack/
isn't something very large.  And objects-list / plan of packfile would
be of comparable size.
 

I was envisioning packfile plan (packfile map) as something like that

  sha1 TERMINATOR

for objects that are not deltified in the packfile, and

  sha1 SEPARATOR base-sha1 TERMINATOR

for objects that are deltified (or something like that; we could use
pkt-line format instead).

>> Server would probably have to check validity of objects list first (the
>> object list might be needed to be more than just object list; it might
>> need to specify topology of deltas, i.e. which objects are base for which
>> ones).  Then it would generate rest of packfile.
> 
> I'm afraid that has the looks of something adding lots of complexity to 
> a piece of git that is already quite complex already, namely 
> pack-objects.  And there is already only a few individuals with their 
> brain around it.

Well, with complexity or server CPU/IO because one should not trust 
client (unfortunately), with 'packfile plan' transfer being non-resumable,
and also with requiring packv4 or a temporary file or memory to send 
packfile plan (packfile map)... I think we can scrape that half-baked
idea.

>>>> [...] I don't know enough
>>>> about 'shallow' capability (and what it enables) to know whether
>>>> it can be used for that.  Can you elaborate?
>>> 
>>> See above, or Documentation/technical/shallow.txt.
>>  
>> Documentation/technical/shallow.txt doesn't cover "shallow", "unshallow"
>> and "deepen" commands from 'shallow' capability extension to git pack
>> protocol (http://git-scm.com/gitserver.txt).
> 
> 404 Not Found
> 
> Maybe that should be committed to git in Documentation/technical/  as 
> well?

This was plain text RFC for the Git Packfile Protocol, generated from
rfc2629 XML sources at http://github.com/schacon/gitserver-rfc


Scott, what happened to http://git-scm.com/gitserver.txt? 

And could you create 'rfc' or 'text' branch in gitserver-rfc
repository, with processed plain/text output, similar to 'man' and
'html' branches in git.git repository? TIA.


_Some_ description of pack protocol can be found in git mailing list
archives
  http://thread.gmane.org/gmane.comp.version-control.git/118956
in "The Git Community Book"
  http://book.git-scm.com/7_transfer_protocols.html
  http://github.com/schacon/gitbook/blob/master/text/54_Transfer_Protocols/0_Transfer_Protocols.markdown
and in "Pro Git"
  http://progit.org/book/ch9-6.html
  http://github.com/progit/progit/blob/master/en/09-git-internals/01-chapter9.markdown

The description in Documentation/technical/pack-protocol.txt is very
brief, and Documentation/technical/shallow.txt doesn't cover 'shallow'
capability of git pack protocol.
 
>>>> Then you have to finish clone / fetch.  All solutions so far include
>>>> some kind of incremental improvements.  My first proposal of bisect
>>>> fetching 1/nth or predefined size pack is buttom-up solution, where
>>>> we build full clone from root commits up.  You propose, from what
>>>> I understand build full clone from top commit down, using deepening
>>>> from shallow clone.  In this step you either get full incremental
>>>> or not; downloading incremental (from what I understand) is not
>>>> resumable / they do not support partial fetch.
>>> 
>>> Right.  However, like I said, the incremental part should be much 
>>> smaller and therefore less susceptible to network troubles.
>> 
>> If you have 7% total pack size of git-archive resumable part, how small
>> do you plan to have those incremental deepening?  Besides in my 1/Nth
>> proposal those bottom-up packs werealso meant to be sufficiently small
>> to avoid network troubles.
> 
> Two issues here: 1) people with slow links might not be interested in a 
> deep history as it costs them time.  2) Extra revisions should typically 
> require only a few KB each, therefore we might manage to ask for the 
> full history after the initial revision is downloaded and salvage as 
> much as we can if a network outage is encountered.  There is no need for 
> arbitrary size, unless the user decides arbitrarily to get only 10 more 
> revisions, or 100 more, etc.

Those two features of your proposal: 
1.) It is possible salvage of partially transferred packfiles (so there
    is no requirement to guess accurately what size should they be),
2.) After completing initial git-archive transfer, you can convert 
    incomplete clone into functioning repository.  It would be shallow
    clone, and can be missing some branches and tags, but you can work
    with it if network connection fails completely.
make it very compelling.

>> P.S. As you can see implementing resumable clone isn't easy...
> 
> I've been saying that all along for quite a while now.   ;-)

Well, on the other hand side we have example of how long it took to
come to current implementation of git submodules.  But if finally
got done.


The git-archive + deepening approach you proposed can be split into
smaller individual improvements.  You don't need to implement it all
at once.

1. Improve deepening of shallow clone.  This means sending only required
   objects, and being able to use as a base objects that other side has
   and send thin pack.

2. Add support for resuming (range request) of git-archive.  It is up
   to client to translate size of partial transfer of compressed file
   into range request of original (uncompressed) archive.

3. Create new git-archive pseudoformat, used to transfer single commit
   (with commit object and original branch name in some extended header,
   similar to how commit ID is stored in extended pax header or ZIP
   comment).  It would imply not using export-* gitattributes.

4. Implement alternate ordering of objects in packfile, so commit object
   is put immediately after all its prerequisites.

5. Implement 'salvage' operation, which given partially transferred 
   packfile would deepen shallow clone, or advance tracking branches,
   ensuring that repository would pass fsck after this operation.

   Probably requires 4; might be not possible or much harder to salvage
   anything with current ordering of objects in packfile.

6. Implement resumable clone ("git clone --keep <URL> [<directory>]",
   "git clone --resume" / "git clone --continue", "git clone --abort",
   "git clone --make-shallow" / "git clone --salvage").

   Requires 1-5.

-- 
Jakub Narebski
Poland
