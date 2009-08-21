From: Sam Vilain <sam@vilain.net>
Subject: Re: Continue git clone after interruption
Date: Sat, 22 Aug 2009 11:07:05 +1200
Message-ID: <1250896025.19039.7.camel@maia.lan>
References: <1250509342.2885.13.camel@cf-48>
	 <200908200937.05412.jnareb@gmail.com>
	 <alpine.LFD.2.00.0908201358010.6044@xanadu.home>
	 <200908211207.38555.jnareb@gmail.com>
	 <alpine.LFD.2.00.0908211614220.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Tomasz Kontusz <roverorna@gmail.com>,
	git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Aug 22 01:04:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MedA5-0002uf-PD
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 01:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932860AbZHUXEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 19:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932858AbZHUXEe
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 19:04:34 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:41445 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932769AbZHUXEe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 19:04:34 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 8081E21D1F9; Sat, 22 Aug 2009 11:04:35 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 09CF621D22B;
	Sat, 22 Aug 2009 11:04:30 +1200 (NZST)
In-Reply-To: <alpine.LFD.2.00.0908211614220.6044@xanadu.home>
X-Mailer: Evolution 2.24.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126772>

On Fri, 2009-08-21 at 17:07 -0400, Nicolas Pitre wrote:
> > 2. There is support in git pack format to do 'deepening' of shallow
> >    clone, which means that git can generate incrementals in top-down
> >    order, _similar to how objects are ordered in packfile_.
> 
> Well... the pack format was not meant for that "support".  The fact
> that 
> the typical object order used by pack-objects when serving fetch
> request 
> is amenable to incremental top-down updates is rather coincidental
> and 
> not really planned.

Mmm.  And the problem with 'thin' packs is that they normally allow
deltas the other way.

I think the first step here would be to allow thin pack generation to
accept a bounded range of commits, any of the objects within which may
be used as delta base candidates.  That way, these "top down" thin packs
can be generated.  Currently of course it just uses the --not and makes
"bottom up" thin packs.

> > Another solution would be to try to come up with some sort of stable
> > sorting of objects so that packfile generated for the same
> > parameters (endpoints) would be always byte-for-byte the same.  But
> > that might be difficult, or even impossible.
>
> And I don't want to commit to that either.  Having some flexibility
> in object ordering makes it possible to improve on the packing
> heuristics.

You don't have to lose that for storage.  It's only for generating the
thin packs that it matters; also, the restriction is relaxed when it
comes to objects which are all being sent in the same pack, which can
freely delta amongst themselves in any direction.

What did you think about the bundle slicing stuff?

Sam
