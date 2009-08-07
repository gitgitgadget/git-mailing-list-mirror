From: Nick Edelen <sirnot@gmail.com>
Subject: Re: [PATCH 0/5] Suggested for PU: revision caching system to 
	significantly speed up packing/walking
Date: Fri, 7 Aug 2009 02:15:17 +0200
Message-ID: <c77435a80908061715u7ff7456cl6c5ded16b51b122f@mail.gmail.com>
References: <op.ux8i6hrbtdk399@sirnot.private>
	 <4A7AEFA8.5010001@drmicha.warpmail.net>
	 <c77435a80908061039p30b83511qb7c378cfd68a6cf6@mail.gmail.com>
	 <alpine.DEB.1.00.0908062030340.8306@pacific.mpi-cbg.de>
	 <c77435a80908061301n5e855aeci16af392ed3128651@mail.gmail.com>
	 <c77435a80908061330h2461012at8b877970cab4906b@mail.gmail.com>
	 <20090806203223.GK1033@spearce.org> <4A7B68C4.8070406@gmail.com>
	 <20090806233739.GL1033@spearce.org> <4A7B6A94.9020200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Sam Vilain <sam@vilain.net>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Fri Aug 07 02:15:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZD7H-0006Hz-RU
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 02:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756600AbZHGAPT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Aug 2009 20:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755416AbZHGAPT
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 20:15:19 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:49046 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754670AbZHGAPS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2009 20:15:18 -0400
Received: by ewy10 with SMTP id 10so1211974ewy.37
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 17:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UiuJ1KXsexiccSPIOV/+F+XU3xGU6PH7oA8QDpEHI8A=;
        b=LUxLYAAOT69KD6AEG42gGfPUJx9VIkegnuRAW7MRbMTPQeu8/qU1Y3UtKoGnxw1wOr
         rWYOMTil+FwLqM127FzSqkxwUZ2ts5LCq7UnxObRGQDwfvTUQuqjuGYuo9qO9ieW9Lg3
         kvWfg9gedbREYWD6TPAGUBdlJoZQiuPyzSdu4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kze8PhyW0+fiooDgBFsYNv/w2ANKhil86u/PhlYTsXJ2yyjvb65Ouio832QnwqU5pm
         WF4AoKiFb+Fp1G3t34Q/EMDFLsiZMIcApqxl2n8NUAUwAjRRzVgN26Q6BgIP36z+eBIT
         oaJYJ2sKlatddNkn8DoVR+HYt8It458U7Mlhs=
Received: by 10.216.71.83 with SMTP id q61mr107631wed.14.1249604117686; Thu, 
	06 Aug 2009 17:15:17 -0700 (PDT)
In-Reply-To: <4A7B6A94.9020200@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125146>

That would work, but I sorta like the idea of caching the actual
names.  I'm thinking of having a block of slice-unique, null-seperated
names at the end of each slice (ie. not in the mapping) which is
loaded into memory (it wouldn't be very big).  Then each blob/tree
object would have an variable length index referencing a particular
name.

Using the actual names would give us greater flexbility, and allow
rev-cache to output proper rev-list type output (with the names after
the hashes).

On Fri, Aug 7, 2009 at 1:43 AM, A Large Angry SCM<gitzilla@gmail.com> w=
rote:
> Shawn O. Pearce wrote:
>>
>> A Large Angry SCM <gitzilla@gmail.com> wrote:
>>>
>>> Shawn O. Pearce wrote:
>>>>
>>>> Nick Edelen <sirnot@gmail.com> wrote:
>>>>>
>>>>> Hrmm, I just realized that it dosn't actually cache paths/names..=
=2E
>>>>
>>>> You may not need the path name, but instead the hash value that
>>>> pack-objects computes from the path name.
>>>
>>> Please do NOT expose the hash values. The hash used by pack-objects=
 is
>>> =A0an implementation detail of the heuristics used by the _current_=
 object
>>> =A0packing code. It would be a real shame to have to maintain backw=
ard
>>> =A0compatibility with it at some future date after the packing mach=
inery =A0has
>>> changed.
>>
>> This is a local cache. =A0If there was a version number in the heade=
r,
>> and the hash function changes, we could just bump the version number
>> and invalidate all of the caches.
>>
>> No sense in storing (and doing IO of) huge duplicate string values
>> for something where we really only need 32 bits, and where a
>> recompute from scratch only costs a minute.
>>
>
> That will work for me if the cache gets a version number and iff the
> pack-objects hash code gets big warning comments about the cache code
> dependency.
>
