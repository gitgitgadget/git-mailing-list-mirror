From: Nick Edelen <sirnot@gmail.com>
Subject: Re: [PATCH 0/5] Suggested for PU: revision caching system to 
	significantly speed up packing/walking
Date: Thu, 6 Aug 2009 22:30:41 +0200
Message-ID: <c77435a80908061330h2461012at8b877970cab4906b@mail.gmail.com>
References: <op.ux8i6hrbtdk399@sirnot.private>
	 <alpine.DEB.1.00.0908061645470.8306@pacific.mpi-cbg.de>
	 <4A7AEFA8.5010001@drmicha.warpmail.net>
	 <c77435a80908061039p30b83511qb7c378cfd68a6cf6@mail.gmail.com>
	 <alpine.DEB.1.00.0908062030340.8306@pacific.mpi-cbg.de>
	 <c77435a80908061301n5e855aeci16af392ed3128651@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Sam Vilain <sam@vilain.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 06 22:31:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ9c2-000206-Sy
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 22:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbZHFUam convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Aug 2009 16:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbZHFUam
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 16:30:42 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:12998 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932155AbZHFUal convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2009 16:30:41 -0400
Received: by ey-out-2122.google.com with SMTP id 9so414174eyd.37
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 13:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zIyJcVsXKT2eLbWqEFijcpwG4zUEjLfS5WCmDvip1vM=;
        b=JSDTQO+sDXiIoZUYR80rjqsdNv1QCHI1JrmsJEpPCxgn3nRMT7tyEswJbZblPwlGfb
         um0BUHb1Oc48zQiPsH9gFRVBLx5f1HX+A5ISge3nCwoayCowQBfzewEf8r/teqPqKT/H
         GY5It69MSM9Q/DwZSwCY+zG6LDU7baHztjGOY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NtjcRqya+p5CqYapFdl/CclbIiPyJbPOUMSEJjfOBHCgxweqM8tCH6dILmAtj0TFfr
         tyfIvQe/cBvEabvDqw8/2pfAC9KaWSDSUbB3MlFlaTY6Vl4nfuYezvnMvDm7zJbP4YwE
         SQWsIlygrbdfv4AUncbgvSkCUcl+eeGBSj3k8=
Received: by 10.216.8.65 with SMTP id 43mr58389weq.168.1249590641171; Thu, 06 
	Aug 2009 13:30:41 -0700 (PDT)
In-Reply-To: <c77435a80908061301n5e855aeci16af392ed3128651@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125122>

Hrmm, I just realized that it dosn't actually cache paths/names...
This obviously has no bearing on its use in packing, but I should
either add that in or restrict usage in non-packing-related walks.
Weird how things like that escape you.

I think I may go ahead and add support for this tomorrow.  It should
have no effect on performance and very little impact on cache slice
size.

On Thu, Aug 6, 2009 at 10:01 PM, Nick Edelen<sirnot@gmail.com> wrote:
> Hi,
>
>>My idea with that was that you already have a SHA-1 map in the pack i=
ndex,
>>and if all you want to be able to accelerate the revision walker, you=
'd
>>probably need something that adds yet another mapping, from commit to
>>parents and tree, and from tree to sub-tree and blob (so you can avoi=
d
>>unpacking commit and tree objects).
>
> As I mention in one of the patch descriptions, along with each commit
> a list of objects introduced per commit is cached, so no extra I/O is
> necessary for tree recursion, etc. during traversal.
>
>>I just thought that it could be more efficient to do it at the time t=
he
>>pack index is written _anyway_, as nothing will change in the pack af=
ter
>>that anyway.
>
> Nothing might change in the pack, but the slices were made to allow
> for continual addition and refinement of the cache. =A0In a typical
> usage slices will be added and fused on a regular basis, which would
> require tinkering in pack indexes if they were combined.
>
>>But I guess I can answer my question easily myself: the boundary comm=
its
>>will not be handled that way.
>>
>>Still, there is some redundancy between the pack index and your cache=
, as
>>you have to write out the whole list of SHA-1s all over again. =A0I g=
uess it
>>is time to look at the code instead of asking stupid questions.
>
> The whole revision cache is redundant, technically speaking: nothing
> in it can't be found by rummaging through packs or objects. =A0The po=
int
> of it was to distill out important information for fast, easy access
> of the commit tree.
>
> On another note, I've eliminated the python dependancy. =A0Shall I
> resend the patchset now or should I wait until it has been further
> reviewed? (don't want to flood the list with resubmits)
>
> =A0- Nick
>
> On Thu, Aug 6, 2009 at 9:06 PM, Johannes
> Schindelin<Johannes.Schindelin@gmx.de> wrote:
>> Hi,
>>
>> On Thu, 6 Aug 2009, Nick Edelen wrote:
>>
>>> > Sorry, I forgot the details, could you quickly remind me why thes=
e
>>> > caches are not in the pack index files?
>>>
>>> Er, I'm not sure what you mean. =A0Are you asking why these revisio=
n
>>> caches are required if we have a pack index, or why they aren't in =
the
>>> pack index, or something different? =A0I'm thinking probably the se=
cond:
>>
>> Yep.
>>
>>> the short answer is that cache slices are totally independant of pa=
ck
>>> files.
>>
>> My idea with that was that you already have a SHA-1 map in the pack =
index,
>> and if all you want to be able to accelerate the revision walker, yo=
u'd
>> probably need something that adds yet another mapping, from commit t=
o
>> parents and tree, and from tree to sub-tree and blob (so you can avo=
id
>> unpacking commit and tree objects).
>>
>> I just thought that it could be more efficient to do it at the time =
the
>> pack index is written _anyway_, as nothing will change in the pack a=
fter
>> that anyway.
>>
>> But I guess I can answer my question easily myself: the boundary com=
mits
>> will not be handled that way.
>>
>> Still, there is some redundancy between the pack index and your cach=
e, as
>> you have to write out the whole list of SHA-1s all over again. =A0I =
guess it
>> is time to look at the code instead of asking stupid questions.
>>
>>> It might be possible to somehow merge revision cache slices with pa=
ck
>>> indexes, but I don't think it'd be a very suitable modification. =A0=
The
>>> rev-cache slices are meant to act almost like topo-relation pack fi=
les:
>>> new slices are simply new files, seperate slice files can be fused
>>> ("repacked") into a larger one, the index is a (recreatable) single=
 file
>>> associating file (positions) with objects. =A0The format was geared=
 to
>>> reducing potential cache/data loss and preventing overly large cach=
e
>>> slices.
>>>
>>> >> Hmpf.
>>> >>
>>> >> We got rid of the last Python script in Git a long time ago, but=
 now
>>> >> two different patch series try to sneak that dependency (at leas=
t for
>>> >> testing) back in.
>>> >>
>>> >> That's all the worse because we cannot use Python in msysGit, an=
d
>>> >> Windows should be a platform benefitting dramatically from your =
work.
>>> >
>>> > In fact, the test the script performs could be easily rephrased w=
ith
>>> > "sort", "uniq" and "comm". OTOH: If the walker is supposed to ret=
urn
>>> > the exact same orderd list of commits you can just use test_cmp.
>>>
>>> The language that script is written in isn't important. =A0I origin=
ally
>>> wrote it in python because I wanted something quick and wasn't much=
 of
>>> a sh guru (sorry :-/ ). =A0As Micheal said I've no doubt it can eas=
ily
>>> be converted to shell script
>>
>> That is not what I wanted to hear.
>>
>>> -- in fact, I'll try to get a shell version working today.
>>
>> That is.
>>
>> Thanks,
>> Dscho
>>
>
