From: Nick Edelen <sirnot@gmail.com>
Subject: Re: [PATCH 0/5] Suggested for PU: revision caching system to 
	significantly speed up packing/walking
Date: Sat, 8 Aug 2009 00:02:57 +0200
Message-ID: <c77435a80908071502y48d14a38h79eec14a1be8c6fb@mail.gmail.com>
References: <op.ux8i6hrbtdk399@sirnot.private>
	 <alpine.DEB.1.00.0908061645470.8306@pacific.mpi-cbg.de>
	 <4A7AEFA8.5010001@drmicha.warpmail.net>
	 <c77435a80908061039p30b83511qb7c378cfd68a6cf6@mail.gmail.com>
	 <alpine.DEB.1.00.0908062030340.8306@pacific.mpi-cbg.de>
	 <4A7B95A8.2010000@vilain.net>
	 <alpine.DEB.1.00.0908070808340.8306@pacific.mpi-cbg.de>
	 <alpine.LFD.2.00.0908071029580.16073@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Aug 08 00:03:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZXWj-0004ua-Gu
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 00:03:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754352AbZHGWC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 18:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754297AbZHGWC6
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 18:02:58 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:44052 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233AbZHGWC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 18:02:57 -0400
Received: by ewy10 with SMTP id 10so1847101ewy.37
        for <git@vger.kernel.org>; Fri, 07 Aug 2009 15:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=C4RFFyy7bva7dDDQ6b3QO8VmMijrN6G+TTXP57O3TRo=;
        b=xy6TzL2ZrAvL0HnBdbYE2sSp0aSwH0cwUmeHpV3tfj1bM5Nm6xLCTi8RwtDBbqaJ1F
         SkGW7lgS3F33+spcVbbdoAl/JIg8ombPmcHViweYRDpg+uUHbmnchqqlydhPqNh4EFtR
         zThN4BtjZ1PGgyjUfkAWt4y5sY9xwmp5yyTtY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XVSXNKwGsbvKNRePM+AERJdwzdx/7Re1DpoBE0UNEuQzBd990HKsBGrgL2R8PhmX2p
         2YnbqFojBsjMSCFqW0IDnmtePt34k2d0Z95QPjIDZ1PFTATlh7uTq41xVj/Q4hn9LtjO
         mLu77uQY8iY5apryJcVPeUN2rdfL5MOASLveo=
Received: by 10.216.18.84 with SMTP id k62mr325568wek.126.1249682577786; Fri, 
	07 Aug 2009 15:02:57 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0908071029580.16073@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125232>

> I don't know about the size of the rev cache on disk yet (I asked Nick
> about that) nor do I really know how this cache is implemented.

The cache file for all of the linux repository (as of a few weeks ago)
is around 42MB, without names.  The names would probably add 2 or 3 MB
on top of that.  That's probably about as big as I'd want to get, as
the whole slice (minus the name list) is mapped to memory (then again
bigger might be ok; I'm not an expert on mem mapping).  The rev-cache
command fuse provides functionality to ignore certain cache sizes,
which was geared towards preventing overly large slices.
