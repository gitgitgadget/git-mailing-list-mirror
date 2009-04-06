From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Mon, 6 Apr 2009 10:37:44 -0400
Message-ID: <9e4733910904060737k3d1c082fk785cd98cdeb6d73d@mail.gmail.com>
References: <20090404220743.GA869@curie-int> <20090405070412.GB869@curie-int>
	 <20090405190213.GA12929@vidovic>
	 <alpine.DEB.1.10.0904051419490.6245@asgard.lang.hm>
	 <20090405225954.GA18730@vidovic>
	 <alpine.DEB.1.10.0904051613420.6245@asgard.lang.hm>
	 <alpine.LFD.2.00.0904052326090.6741@xanadu.home>
	 <7vab6ue520.fsf@gitster.siamese.dyndns.org>
	 <9e4733910904060652t6c0f37d9t246b7394e3aad350@mail.gmail.com>
	 <alpine.LFD.2.00.0904060959250.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, david@lang.hm,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Apr 06 16:40:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqpzL-00074w-Rg
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 16:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756418AbZDFOhu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2009 10:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756118AbZDFOhu
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 10:37:50 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:44181 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756224AbZDFOht convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Apr 2009 10:37:49 -0400
Received: by rv-out-0506.google.com with SMTP id g37so1270817rvb.5
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 07:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DorY3Qg5IPDnNm/9Q7b2f8O4vhFHAUOR33FNoSRkhFw=;
        b=YMPMoBOW2kQqSzqiAyP0L/eQOhmyLn4bvo8HW3rlXQG5VVMD6VtbD6lkwHLgLznV9e
         lhhdFmdZEDffLZoKSEAAeTelo21FhHeTHnRyfrHysoREUKqL3j26D2RVobcQqe/9I69U
         xXDz27/2zcXPqWErYybxEyL0+WmqbzYoeSaQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xwN5TjKTv09D58qGULX1EmGj+Yv2CopDtRpRFp+F1nZXh9j5GcSsODeapUNkKfKjrr
         pHu49d/7ZFTTfBNtXtqjsL6PIzql7utYt6KlpcsCE9ApRq3vPTMz46zgPc1041g+kyvT
         yhSFKnpvfEfbUrpYN2n01jthNCf/hd1p8XSIw=
Received: by 10.220.45.131 with SMTP id e3mr3749517vcf.89.1239028666305; Mon, 
	06 Apr 2009 07:37:46 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0904060959250.6741@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115837>

On Mon, Apr 6, 2009 at 10:19 AM, Nicolas Pitre <nico@cam.org> wrote:
> On Mon, 6 Apr 2009, Jon Smirl wrote:
>
>> On Mon, Apr 6, 2009 at 1:15 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> > Nicolas Pitre <nico@cam.org> writes:
>> >
>> >> What git-pack-objects does in this case is not a full repack. =A0=
It
>> >> instead _reuse_ as much of the existing packs as possible, and on=
ly does
>> >> the heavy packing processing for loose objects and/or inter pack
>> >> boundaryes when gluing everything together for streaming over the=
 net.
>> >> If for example you have a single pack because your repo is alread=
y fully
>> >> packed, then the "packing operation" involved during a clone shou=
ld
>> >> merely copy the existing pack over with no further attempt at del=
ta
>> >> compression.
>> >
>> > One possibile scenario that you still need to spend memory and cyc=
le is if
>> > the cloned repository was packed to an excessive depth to cause ma=
ny of
>> > its objects to be in deltified form on insanely deep chains, while=
 cloning
>> > send-pack uses a depth that is more reasonable. =A0Then pack-objec=
ts invoked
>> > by send-pack is not allowed to reuse most of the objects and would=
 end up
>> > redoing the delta on them.
>>
>> That seems broken. You went through all of the trouble to make the
>> pack file smaller to reduce transmission time, and then clone undoes
>> the work.
>
> And as I already explained, this is indeed not what happens.
>
>> What about making a very simple special case for an initial clone?
>
> There should not be any need for initial clone hacks.
>
>> First thing an initial clone does is copy all of the pack files from
>> the server to the client without even looking at them.
>
> This is a no go for reasons already stated many times. =A0There are
> security implications (those packs might contain stuff that you didn'=
t
> intend to be publically accessible) and there might be efficiency
> reasons as well (you might have a shared object store with lots of st=
uff
> unrelated to the particular clone).

How do you deal with dense history packs? These packs take many hours
to make (on a server class machine) and can be half the size of a
regular pack. Shouldn't there be a way to copy these packs intact on
an initial clone? It's ok if these packs are specially marked as being
ok to copy.

>
> The biggest cost right now when cloning a big packed repo is object
> enumeration. =A0Any other issues related to memory costs in the GB ra=
nge
> simply has no reason for it, and is mostly due to misconfigurations o=
r
> bugs that have to be fixed. =A0Trying to work around the issue by all
> sorts of hacks is simply counter productive.
>
> In the case that started this very thread, I suspect that a small
> misfeature of some delta caching might be the culprit. =A0I asked Rob=
in H.
> Johnson to perform a really simple config addition to his repo and
> retest, for which we still haven't seen any results yet.
>
>
> Nicolas
>



--=20
Jon Smirl
jonsmirl@gmail.com
