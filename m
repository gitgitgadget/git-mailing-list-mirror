From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Mon, 6 Apr 2009 11:28:39 -0400
Message-ID: <9e4733910904060828m414dfe7v66b19f7b4c5b670e@mail.gmail.com>
References: <20090404220743.GA869@curie-int>
	 <alpine.DEB.1.10.0904051419490.6245@asgard.lang.hm>
	 <20090405225954.GA18730@vidovic>
	 <alpine.DEB.1.10.0904051613420.6245@asgard.lang.hm>
	 <alpine.LFD.2.00.0904052326090.6741@xanadu.home>
	 <7vab6ue520.fsf@gitster.siamese.dyndns.org>
	 <9e4733910904060652t6c0f37d9t246b7394e3aad350@mail.gmail.com>
	 <alpine.LFD.2.00.0904060959250.6741@xanadu.home>
	 <9e4733910904060737k3d1c082fk785cd98cdeb6d73d@mail.gmail.com>
	 <alpine.LFD.2.00.0904061042300.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, david@lang.hm,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Apr 06 17:30:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqqm8-0008Kf-Af
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 17:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbZDFP2o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2009 11:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbZDFP2o
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 11:28:44 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:48376 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbZDFP2n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Apr 2009 11:28:43 -0400
Received: by qyk16 with SMTP id 16so3738938qyk.33
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 08:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4v+wLey04fj+KXNPxW1OYfVwtY1lVAxlyEkX2LjMTrc=;
        b=TOmWpsgIoKJUGxQYaLGKoCkx5x2HdYK8pbVoldolNDVp9LnvyJEBi8+S/E7SU5J5ee
         yNJxTSVvk1mcALzPTeQ0hL2Mlbjm5L6Mw7vf+GkrEikSod6BzYg4gd5AocHHkCis1DV8
         g5jTnRHp+dagu/ayz+8ps7VMsopW0+jbs5ucY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=yEWVLUH1lCP1OunvPvQ7dGjCMr4dY7l6DpW/Zf5sfXCJCzmtNor4StqrU2VoXycdsF
         FaFsTS+hDI6hcULSLqF2zIbFGiLADZHp79jD9UbxMRebGtl0foJQ3MBq15VLsCmi7Mpa
         h+KSAJ/riLVqoDb/Nzvzut5MEfa7IiPrk14Yc=
Received: by 10.220.97.75 with SMTP id k11mr3911748vcn.39.1239031720744; Mon, 
	06 Apr 2009 08:28:40 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0904061042300.6741@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115846>

On Mon, Apr 6, 2009 at 11:14 AM, Nicolas Pitre <nico@cam.org> wrote:
> On Mon, 6 Apr 2009, Jon Smirl wrote:
>
>> On Mon, Apr 6, 2009 at 10:19 AM, Nicolas Pitre <nico@cam.org> wrote:
>> > On Mon, 6 Apr 2009, Jon Smirl wrote:
>> >
>> >> First thing an initial clone does is copy all of the pack files f=
rom
>> >> the server to the client without even looking at them.
>> >
>> > This is a no go for reasons already stated many times. =A0There ar=
e
>> > security implications (those packs might contain stuff that you di=
dn't
>> > intend to be publically accessible) and there might be efficiency
>> > reasons as well (you might have a shared object store with lots of=
 stuff
>> > unrelated to the particular clone).
>>
>> How do you deal with dense history packs? These packs take many hour=
s
>> to make (on a server class machine) and can be half the size of a
>> regular pack. Shouldn't there be a way to copy these packs intact on
>> an initial clone? It's ok if these packs are specially marked as bei=
ng
>> ok to copy.
>
> [sigh]
>
> Let me explain it all again.
>
> There is basically two ways to create a new pack: the intelligent way=
,
> and the bruteforce way.
>
> When creating a new pack the intelligent way, what we do is to enumer=
ate
> all the needed object and look them up in the object store. =A0When a
> particular object is found, we create a record for that object and no=
te
> in which pack it is located, at what offset in that pack, how much sp=
ace
> it occupies in its compressed form within that pack, , and if whether=
 it
> is a delta or not. =A0When that object is indeed a delta (the majorit=
y of
> objects usually are) then we also keep a pointer on the record for th=
e
> base object for that delta.
>
> Next, for all objects in delta form which base object is also part of
> the object enumeration and obviously part of the same pack, we simply
> flag those objects as directly reusable without any further processin=
g.
> This means that, when those objects are about to be stored in the new
> pack, their raw data is simply copied straight from the original pack
> using the offset and size noted above. =A0In other words, those objec=
ts
> are simply never redeltified nor redeflated at all, and all the work
> that was previously done to find the best delta match is preserved wi=
th
> no extra cost.

Does this process cause random reads all over a 2GB pack file? Busy
servers can't keep a 2GB pack in memory.
sendfile() the 2GB pack to client is way more efficient. (assuming the
pack is marked as being ok to send).

>
> Of course, when your repository is tightly packed into a single pack,
> then all enumerated objects fall into the reusable category and
> therefore a copy of the original pack is indeed sent over the wire.
> One exception is with older git clients which don't support the delta
> base offset encoding, in which case the delta reference encoding is
> substituted on the fly with almost no cost (this is btw another reaso=
n
> why a dumb copy of existing pack may not work universally either). =A0=
But
> in the common case, you might see the above as just the same as if gi=
t
> did copy the pack file because it really only reads some data from a
> pack and immediately writes that data out.
>
> The bruteforce repacking is different because it simply doesn't conce=
rn
> itself with existing deltas at all. =A0It instead start everything fr=
om
> scratch and perform the whole delta search all over for all objects.
> This is what takes lots of resources and CPU cycles, and as you may
> guess, is never used for fetch/clone requests.
>
>
> Nicolas
>



--=20
Jon Smirl
jonsmirl@gmail.com
