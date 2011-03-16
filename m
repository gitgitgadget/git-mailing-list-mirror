From: Eric Montellese <emontellese@gmail.com>
Subject: Re: Fwd: Git and Large Binaries: A Proposed Solution
Date: Tue, 15 Mar 2011 20:35:14 -0400
Message-ID: <AANLkTikhARYW=UcvfGmHb4a8Jja6jmHw+_qut6LAMXpk@mail.gmail.com>
References: <AANLkTin=UySutWLS0Y7OmuvkE=T=+YB8G8aUCxLH=GKa@mail.gmail.com>
 <AANLkTimPua_kz2w33BRPeTtOEWOKDCsJzf0sqxm=db68@mail.gmail.com>
 <20110121222440.GA1837@sigill.intra.peff.net> <20110123141417.GA6133@mew.padd.com>
 <4D793C7D.1000502@miseler.de> <20110310222443.GC15828@sigill.intra.peff.net>
 <AANLkTimpbhaGEfxW1wwRc14tpV6qnPDiZYnXp_tvA3Ft@mail.gmail.com>
 <20110313025258.GA10452@sigill.intra.peff.net> <4D7D1BFE.2030008@miseler.de> <20110314193254.GA21581@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexander Miseler <alexander@miseler.de>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org,
	schacon@gmail.com, joey@kitenet.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 16 01:35:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzeiF-0006bR-CY
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 01:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757269Ab1CPAfg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Mar 2011 20:35:36 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47143 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755556Ab1CPAff convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Mar 2011 20:35:35 -0400
Received: by bwz15 with SMTP id 15so1098101bwz.19
        for <git@vger.kernel.org>; Tue, 15 Mar 2011 17:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=1w46+EFlDFfPbO/aVIxpoN72ex+SH2g74qsTieaeIOU=;
        b=AYOKfB+L6jUiSdteuP1nMy71sf4YEQDKs+kdejIslVlr5HaOzMuEYLKxxLCXdqjMGs
         lzY9zeb7l7NIkRDy8hCgv99bXkwu0OafUCUdRH2zTimxuw2fVtlMvEvz+7hWgqiKH4YI
         ovQdNOoWiMxUsoEKl7ZuBSZD5ft9nj0aPmzMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=l+02KWkyZyDZIfABmXt9inCtZSU3IAv5chMb5WbV37tezUaM1hNzqqZI3sZ2WMQis5
         Bd518ipM5wuPN3PjGHVSGDpu9S/oTqTdaWKAgCpojrXXweRyCQ6zIWxUeOwnh5K7eUs5
         awyp4i/Fia9CazWtu9ILiXCi1wZzvQnozYZ+0=
Received: by 10.204.20.74 with SMTP id e10mr137167bkb.148.1300235734082; Tue,
 15 Mar 2011 17:35:34 -0700 (PDT)
Received: by 10.204.14.210 with HTTP; Tue, 15 Mar 2011 17:35:14 -0700 (PDT)
In-Reply-To: <20110314193254.GA21581@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169094>

Makes a lot of sense --

As you said, the "sparse clone" idea and this one (not downloading all
binaries) probably have a similar or related solution...  In fact, I'd
imagine that most of the reasons for needing a sparse clone are
because of large binaries.    (since text files compress so nicely in
git).

And actually, if the sparse-clone idea is limited to only binaries
being "sparse" (i.e. not copied) that probably simplifies the
spares-clone logic quite a bit since you don't need to split up the
bits of patches to generate the resulting changesets you need?  (this
is based on my very loose understanding of how git works)


So, if we simplify our requirements a bit (at least as a first cut),
perhaps we've now simplified down to these tasks  (similar but
modified from before):

1. clean up git's handling of binaries to improve efficiency.  In
doing so, see if it makes sense to separate somewhat the way that
binaries are stored (particularly because this would help (2))

2.  Allow full clones to be "sparsely cloned" (that is, cloned with
the exception of the large binary files).
   2.1 As a corollary, no clones of any kind can be made from a sparse
clone (sparse clones are "leaf" nodes on a tree of descendants) --
that simplifies the complexity quite a bit, since the "remote" you
cloned from will always have the files if you need 'em.


doing so limits some of the possible applications of "binary sparse"
clones, but might yield a cleaner final solution -- thoughts?


Eric




On Mon, Mar 14, 2011 at 3:32 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Mar 13, 2011 at 08:33:18PM +0100, Alexander Miseler wrote:
>
>> We want to store them as flat as possible. Ideally if we have a temp
>> file with the content (e.g. the output of some filter) it should be
>> possible to store it by simply doing a move/rename and updating some
>> meta data external to the actual file.
>
> Yeah, that would be a nice optimization. =A0But I'd rather do the eas=
y
> stuff first and see if more advanced stuff is still worth doing.
>
> For example, I spent some time a while back designing a faster textco=
nv
> interface (the current interface spools the blob to a tempfile, where=
as
> in some cases a filter needs to only access the first couple kilobyte=
s
> of the file to get metadata). But what I found was that an even bette=
r
> scheme was to cache textconv output in git-notes. Then it speeds up t=
he
> slow case _and_ the already-fast case.
>
> Now after this, would my new textconv interface still speed up the
> initial non-cached textconv? Absolutely. But I didn't really care
> anymore, because the small speed up on the first run was not worth th=
e
> trouble of maintaining two interfaces (at least for my datasets).
>
> And this may fall into the same category. Accessing big blobs is
> expensive. One solution is to make it a bit faster. Another solution =
is
> to just do it less. So we may find that once we are doing it less, it=
 is
> not worth the complexity to make it faster.
>
> And note that I am not saying "it definitely won't be worth it"; only
> that it is worth making the easy, big optimizations first and then
> seeing what's left to do.
>
>> 1.) The loose file format is inherently unsuited for this. It has a
>> header before the actual content and the whole file (header + conten=
t)
>> is always compressed. Even if one changes this to
>> compressing/decompressing header and content independently it is sti=
ll
>> unsuited by a) having the header within the same file and b) because
>> the header has no flags or other means to indicate a different
>> behavior (e.g. no compression) for the content. We could extend the
>> header format or introduce a new object type (e.g. flatblob) but bot=
h
>> would probably cause more trouble than other solutions. Another idea
>> would be to keep the metadata in an external file (e.g. 84d7.header
>> for the object 84d7). This would probably have a bad performance
>> though since every object lookup would first need to check for the
>> existence of a header file. A smarter variant would be to optionally
>> keep the meta data directly in the filename (e.g. saving the object =
as
>> 84d7.object_type.size.flag instead of just 84d7).
>> This would only require special handling for cases where the normal =
lookup for 84d7 fails.
>
> A new object type is definitely a bad idea. It changes the sha1 of th=
e
> resulting object, which means that our identical trees which differ o=
nly
> in the use of "flatblob" versus regular blob will have different sha1=
s.
>
> So I think the right place to insert this would be at the object db
> layer. The header just has the type and size. But I don't think anybo=
dy
> is having a problem with large objects that are _not_ blobs. So the
> simplest implementation would be a special blob-only object db
> containing pristine files. We implicitly know that objects in this db
> are blobs, and we can get the size from the filesystem via stat().
> Checking their sha1 would involve prepending "blob <size>\0" to the f=
ile
> data. It does introduce an extra stat() into object lookup, so probab=
ly
> we would have the lookup order of pack, regular loose object, flat bl=
ob
> object. Then you pay the extra stat() only in the less-common case of
> accessing either a large blob or a non-existent object.
>
> That being said, I'm not sure how much this optimization will buy us.
> There are times when being able to mmap() the file directly, or point=
 an
> external program directly at the original blob will be helpful. But w=
e
> will still have to copy, for example on checkout. It would be nice if
> there was a way to make a copy-on-write link from the working tree to
> the original file. But I don't think there is a portable way to do so=
,
> and we can't allow the user to accidentally munge the contents of the
> object db, which are supposed to be immutable.
>
> -Peff
>
