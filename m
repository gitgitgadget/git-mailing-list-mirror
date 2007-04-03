From: "Dana How" <danahow@gmail.com>
Subject: Re: git-index-pack really does suck..
Date: Tue, 3 Apr 2007 15:40:00 -0700
Message-ID: <56b7f5510704031540i4df918e6g5a82389b6759c50b@mail.gmail.com>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
	 <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
	 <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
	 <alpine.LFD.0.98.0704031625050.28181@xanadu.home>
	 <Pine.LNX.4.64.0704031346250.6730@woody.linux-foundation.org>
	 <20070403210319.GH27706@spearce.org>
	 <Pine.LNX.4.64.0704031411320.6730@woody.linux-foundation.org>
	 <20070403211709.GJ27706@spearce.org>
	 <alpine.LFD.0.98.0704031730300.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Chris Lee" <clee@kde.org>, "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Apr 04 00:40:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYrfc-0002Eb-W0
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 00:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992452AbXDCWkG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 18:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992454AbXDCWkF
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 18:40:05 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:18478 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992452AbXDCWkB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 18:40:01 -0400
Received: by wr-out-0506.google.com with SMTP id 76so2459wra
        for <git@vger.kernel.org>; Tue, 03 Apr 2007 15:40:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h29tkgZz64Yq0Ixkz0wJGP/gNTF3rTbJxEIy1PkQJOjd5sRmoiYiHzIgP0fCkab2ZWmRYZAqXrQhjpnWq8k+Bwja4JsWG5FHzjZ+x8UaM1DvaKs0ysWC5B1V1zCaJ4KvWybm/OBiej9A9LzKD4vGytAvqHbHNEsHAfw+vqhMu18=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gAG9m69vL3ARSq8UcqBCKxGCYoPGDqLcaMML3QV8Qpg9N+nVGCQcbcEBdL8q8UVHD8XLFsZDyhRqAoXImbsUddPcQfsxWjqSChcuNdc0Xx3SgiWraDrBGP/071sdBDG1zlnptSpntp2tuaqeIcoc52VSZWn7gkFepHA6HiVW/qk=
Received: by 10.115.92.2 with SMTP id u2mr2440898wal.1175640000361;
        Tue, 03 Apr 2007 15:40:00 -0700 (PDT)
Received: by 10.114.46.4 with HTTP; Tue, 3 Apr 2007 15:40:00 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.98.0704031730300.28181@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43685>

On 4/3/07, Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 3 Apr 2007, Shawn O. Pearce wrote:
> > Right.  But maybe we shouldn't be scanning for packfiles every
> > time we don't find a loose object.  Especially if the caller is in
> > a context where we actually *expect* to not find said object like
> > half of the time... say in git-add/update-index.  ;-)
>
> First, I truly believe we should have a 64-bit pack index and fewer
> larger packs than many small packs.
>
> Which leaves us with the actual pack index lookup.  At that point the
> cost of finding an existing object and finding that a given object
> doesn't exist is about the same thing, isn't it?
>
> Optimizing that lookup is going to benefit both cases.

Do you get what you want if you move to fewer larger INDEX files
but not pack files -- in the extreme, one large index file?
A "super index" could be built from multiple .idx files.
This would be a new file (format) unencumbered by the past,
so it could be tried out more quickly.
Just like objects are pruned when packed,
.idx files could be pruned when the super index is built.

Perhaps a number of (<2GB) packfiles and a large index
file could work out.

Larger and larger pack files make me nervous.
They are expensive to manipulate,
and >2GB requires a file format change.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
