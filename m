From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Mon, 06 Sep 2010 12:51:47 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009061025210.19366@xanadu.home>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
 <alpine.LFD.2.00.1009021624170.19366@xanadu.home>
 <B757A854-C7BF-4CBF-9132-91D205344606@mit.edu>
 <7voccezr7m.fsf@alter.siamese.dyndns.org> <20100903183120.GA4887@thunk.org>
 <alpine.LFD.2.00.1009031522590.19366@xanadu.home>
 <AANLkTi=sC3NMNzPRQM5RKwnZQyRq-gq6+7wdiT5LGDrc@mail.gmail.com>
 <AANLkTinoyehduhdHSEm5yGTLvU6C-ViE885yLd63iQU0@mail.gmail.com>
 <4C81A67B.2060400@gmail.com> <alpine.LFD.2.00.1009032304560.19366@xanadu.home>
 <4C81DC34.2090800@gmail.com> <alpine.LFD.2.00.1009040153280.19366@xanadu.home>
 <AANLkTi=7jUSCNiPf+HfEQuxaf16Jt06--bFE7=Of9wp=@mail.gmail.com>
 <AANLkTik9awEd40s3r-O8t9DwZBh34Z0ozsxMm1QNjNoT@mail.gmail.com>
 <alpine.LFD.2.00.1009042132500.19366@xanadu.home>
 <AANLkTi=YLx6MqbWd_N0geXbuXLdqAUOneGoym75dfthL@mail.gmail.com>
 <alpine.LFD.2.00.1009051820100.19366@xanadu.home>
 <AANLkTi=CEOj40Sj+zegvX+ry8-y6p7UwsyqdtoHB1d-T@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_W5UunvyN625iD7Nw38Q2Cw)"
Cc: Artur Skawina <art.08.09@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 18:52:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsevP-0004Xq-9b
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 18:52:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158Ab0IFQvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 12:51:50 -0400
Received: from relais.videotron.ca ([24.201.245.36]:31627 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014Ab0IFQvs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 12:51:48 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L8C00654467LET0@VL-MR-MRZ20.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 06 Sep 2010 12:51:44 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <AANLkTi=CEOj40Sj+zegvX+ry8-y6p7UwsyqdtoHB1d-T@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Content-id: <alpine.LFD.2.00.1009061151220.19366@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155583>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_W5UunvyN625iD7Nw38Q2Cw)
Content-id: <alpine.LFD.2.00.1009061151221.19366@xanadu.home>
Content-type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-transfer-encoding: 8BIT

On Mon, 6 Sep 2010, Luke Kenneth Casson Leighton wrote:

> On Mon, Sep 6, 2010 at 12:52 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> 
> > And object enumeration has absolutely nothing to do with packs, nor .idx
> > files for that matter.
> 
>  mmm packs not being to do with object enumeration i get.  i
> understand that .idx files contain "lists of objects" which isn't the
> same thing (and also happen to contain pointers/offsets to the objects
> of its associated .pack)
> 
>  at some point i'd really like to know what the object list is (not
> the objects themselves) that comes out of "git pack-objects --thin"

You need to feed 'git pack-objects' a list of objects in the first 
place for it to pack anything.  So you must have that list even before 
pack-objects can produce any output.  And that list is usually generated 
by 'git rev-list'.  So, typically, you'd do:

	git rev-list --objects <commit_range> | git pack-objects foo

But these days the ability to enumerate objects was integrated into 
pack-objects directly, so you can do:

	echo "<commit_range>" | git pack-objects --revs foo

But you should get the idea.

> > So... I hope you understand now that there is no relation between
> > commits and .idx files.  The only exception is when you do create a
> > custom pack with 'git pack-objects'.
> 
>  yes.  ahh... that's what i've been doing: using "git pack-objects
> --thin".  and the reason for that is because i've seen it used in the
> http implementation of "git fetch".

Well, the HTTP implementation is a rather tricky example as there are 
actually two implementations: one that is dumb and only slurps packs and 
loose objects out of a remote .git/ directory, and another that is smart 
enough to carry the smarter Git protocol across HTTP requests.  

When using the "smart" Git protocol, the client tells the server what it 
already has, and then the server uses pack-objects to produce a pack 
with only those objects that the client doesn't have, and stream that 
pack directly without even storing it on disk.  The server doesn't even 
produce a .idx file in that case.  It is up to the client to store the 
pack on disk, and feed it through 'git index-pack' to construct a .idx 
file for it locally.

>  so, my questions up until now regarding .pack and .idx have all been
> targetted at that, and based on that context, _not_ the packs+idx
> files that are in .git/

Tell me if the above clears them up.

> > If you want all commits then you just need --all instead of HEAD.
> 
>  no, i want commits separated and individual and "compoundable".  the plan is:
> 
> * to get the ref associated with refs/heads/master

You can do:

	git rev-parse refs/heads/master

> * to get the list of all commits associated with that master ref

Just use (without the --objects argument):

	git rev-list refs/heads/master

> * to work out how far local deviates from remote along that list of commits

That's an operation that only the peer with the most recent commits can 
do, unless you transfer that huge list of commits from above across the 
network.  So, on a server (i.e. the peer sending objects) you'd do:

	git rev-list <refs_that_I_publish> --not <refs_that_the_remote_has>

> * to get the objects which will make up the missing commits (if they
> aren't already in the local store)

Again, that's a task for the peer with objects to offer.  It just has to 
use the above rev-list invocation and add the --objects argument to it 
(or feed the equivalent ref specifications to pack-objects directly as 
shown previously).

> * to apply those commits in the correct order

Why would you care about this?  There is nothing to "apply" as all you 
have to do is simply transfer objects.

> in other words, the plan is to follow what git http fetch and/org git
> git:// fetch does as much as possible (ok, perhaps not).

Well... I don't think it would be easy to do the same in a P2P context.  
Those fetch operations are totally stream oriented between 2 peers, and 
not many to many.

> the reason for getting the objects individually (blobs etc.) should be
> clear: prior commits _could_ have resulted in that exact object having
> been obtained already.

Sure.  But objects known to exist on the remote side won't be listed by 
rev-list.

> so far i have implemented:
> 
> * get the master ref using git for-each-ref
> * get the list of all commits using git rev-list

So far so good.

> * enumerate the list of objects associated with an individual commit by:
>     i) creating a CUSTOM pack+idx using git pack-objects {ref}
>     ii) *parsing* the idx file using gitdb's FileIndex to get the list
> of objects

That's where you're going so much out of your way to give you trouble.  
A simple rev-list would give you that list:

	git rev-list --objects <this_commit> --not <this_commit''s_parents>

That's it.

>     iii) transferring that list to the local machine
> * requesting *individual* objects from the enumerated list out of the idx file
>    by using a CUSTOM "git pack-objects --thin {ref} < {ref}" command

That's where you'll have to get your hands real dirty and write actual 
code to serve individual objects but not through cat-file.  In a P2P 
setup you'd want to transfer as little amount of data as possible, 
meaning that you'd want to serve deltas as much as possible.  It's then 
a matter of finding if the requested object exists already in delta 
form, if so then whether or not its base object is something that the 
other end has in which case you send that as is, otherwise figuring out 
if that would be worth creating a delta against another object known to 
exist at the other end.

On the receiving end, you'd simply have to store those objects in 
the .git/objects/ directories as loose objects after expanding the 
deltas, or even stuff everything 
into a pack and run 'git index-pack' on it when the transfer is 
complete (and run 'git repack' to optimize the pack eventually).

Once the transfer is complete, you do a  reachability and validity check 
on the refs you are supposed to have received the objects for, and if 
everything is OK then you update the refs and you're done.

> that's as far as i've got, before you mentioned that it would be
> better to use "git rev-list --objects commit1..commit2" and to use
> "git cat-file" to obtain the actual object [what's not clear in this
> plan is how to store that cat'ed file at the local end, hence the
> continued use of git pack-objects --thin {ref} < {ref}]
> 
> the prior implementation was to treat the custom pack-object as if it
> was "the atomic leaf-node operation" instead of individual objects
> (blobs, trees).

Well, OK.  But suppose that you have only 2 new commits with a big 
amount of objects for each.  Typically the very first commit of a 
project corresponds to the import of that project into Git, and it is 
equivalent to the whole work tree.  Don't you want to spread the request 
for those objects across as many peers as possible?

>  what i _have_ been doing however is custom-generating pack-objects
> and associated pack-indexes (just like git http fetch) _including_
> using the --thin option because that's what git http fetch does.

Well, let's get back to that HTTP fetch which has a double personality.  
The "smart" HTTP fetch doesn't involve any pack index at all.  It ends 
up streaming pack-objects stdout's output over the net and the pack 
index is recreated on the other end.

However, what the _dumb_ HTTP fetch does (and that is the same idea for 
the FTP fetch, or the rsync fetch) is to dig into the remote's .git 
directory and grab those .idx files, look into them to see if the 
corresponding .pack file actually contain the wanted objects, so to only 
downloads the needed packs afterwards.  And those dumb protocols are 
what they are: dumb.  They usually end up transferring way more data 
than actually necessary.

> > If an object that does get transmitted is
> > actually a delta against an object that is only part of a branch that is
> > not published, then the delta will be expanded and redone against
> > another suitable object before transmission.
> 
>  and that's handled by git pack-objects --thin (am i right?)

Right.  But the --thin flag here is unrelated to this.

What --thin does is to tell pack-objects that it can produce deltas 
against objects that will _not_ be included in the produced pack.  That 
is OK only if the consumer of that pack is 1) aware of that fact and
2) is going to "fix" the pack by appending those objects to the pack 
from a local copy.  For a pack to be "valid" in your .git directory, it 
has to be self contained with regards to deltas.  It is not allowed to 
have deltas across different packs as this makes the issue of delta 
loops extremely difficult to deal with in the context of incremental 
repacks.

>  so.  we have a hierarchical plan: get the commit list, get a
> per-commit object-list, get the objects (if needed), store the
> objects.
> 
>  problem: despite looking through virtually every single builtin/*.c
> file which uses write_sha1_file (which i believe i have correctly
> identified, from examining git unpack-objects, as being the function
> which stores actual objects, including their type), i do not see a git
> command (yet) which performs the reverse operation of "git cat-file".

It is 'git hash-object'.


Nicolas

--Boundary_(ID_W5UunvyN625iD7Nw38Q2Cw)--
