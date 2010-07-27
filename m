From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: object/pack size x5 larger than a fresh clone?
Date: Tue, 27 Jul 2010 10:03:17 -0700
Message-ID: <20100727170317.GC25268@spearce.org>
References: <AANLkTimL+wfu+yMPutq2VHD6vO2AtaF_7FpWt8aZPm1c@mail.gmail.com> <4C4D42BA.6070900@op5.se> <AANLkTimLAROADKgWvEXa9QyyDGbWQGP+9BdbcN4fMHJ0@mail.gmail.com> <7v7hkg982j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hin-Tak Leung <hintak.leung@gmail.com>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 19:03:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdnYt-0005Ec-BM
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 19:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564Ab0G0RDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 13:03:22 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:50135 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457Ab0G0RDV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 13:03:21 -0400
Received: by pzk26 with SMTP id 26so1462197pzk.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 10:03:21 -0700 (PDT)
Received: by 10.142.148.2 with SMTP id v2mr10694910wfd.114.1280250200967;
        Tue, 27 Jul 2010 10:03:20 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id t11sm5884105wfc.16.2010.07.27.10.03.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 10:03:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v7hkg982j.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151958>

Junio C Hamano <gitster@pobox.com> wrote:
> Hin-Tak Leung <hintak.leung@gmail.com> writes:
> 
> > So I guess these *.idx without a corresponding *.pack are safe to
> > delete? But git gc or one of the other house keeping commands should
> > get rid of them though, I think.
> 
> I agree.  I think the dumb transports like http:// grab *.idx files
> without downloading corresponding *.pack files when they encounter an
> object that is not found loose in the originating repository to see which
> packfile to fetch, but after they are done (or when they are interrupted,
> for that matter), these *.idx files may not be getting garbage-collected.
> 
> And they should be, perhaps with or without some grace period (I don't
> know which offhand---I didn't think this through).

We should GC these, but only after a grace period.

Long ago when I used dumb http it really helped to have the *.idx
files cached.  If the upstream only did an incremental repack holding
onto the *.idx files locally meant I didn't need to redownload
them in order to rule-out those packs as onces interesting for the
current fetch.

Maybe we just prune those during git fetch if they don't have a
local *.pack and they don't match a pack listed by the remote's
objects/info/packs file?

-- 
Shawn.
