From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 0/5] Suggested for PU: revision caching system to  significantly
 speed up packing/walking
Date: Fri, 07 Aug 2009 14:47:04 +1200
Message-ID: <4A7B95A8.2010000@vilain.net>
References: <op.ux8i6hrbtdk399@sirnot.private>  <alpine.DEB.1.00.0908061645470.8306@pacific.mpi-cbg.de>  <4A7AEFA8.5010001@drmicha.warpmail.net> <c77435a80908061039p30b83511qb7c378cfd68a6cf6@mail.gmail.com> <alpine.DEB.1.00.0908062030340.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Nick Edelen <sirnot@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 07 04:47:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZFUr-0004o4-5Z
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 04:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756900AbZHGCra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 22:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756848AbZHGCra
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 22:47:30 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:40054 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752441AbZHGCr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 22:47:29 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 5029B21C4AC; Fri,  7 Aug 2009 14:47:09 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 1ECC521C44B;
	Fri,  7 Aug 2009 14:47:04 +1200 (NZST)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <alpine.DEB.1.00.0908062030340.8306@pacific.mpi-cbg.de>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125165>

Johannes Schindelin wrote:
>> the short answer is that cache slices are totally independant of pack 
>> files.
>>     
>
> My idea with that was that you already have a SHA-1 map in the pack index, 
> and if all you want to be able to accelerate the revision walker, you'd 
> probably need something that adds yet another mapping, from commit to 
> parents and tree, and from tree to sub-tree and blob (so you can avoid 
> unpacking commit and tree objects).
>   

Tying indexes together like that is not a good idea in the database
world. Especially as in this case as Nick mentions, the domain is subtly
different (ie pack vs dag). Unfortunately you just can't try to pretend
that they will always be the same; you can't force a full repack on
every ref change!

> Still, there is some redundancy between the pack index and your cache, as 
> you have to write out the whole list of SHA-1s all over again.  I guess it 
> is time to look at the code instead of asking stupid questions.
>   

"Disk is cheap" :-) It should be a welcome trade-off; perhaps it's worth
including numbers about how big the indexes are with the time
statistics. It sounds though like it should be a significant win as a
single index can be used to accelerate a wide range of rev-list
operations, and store indexes for many different questions that can be
asked.

Sam
