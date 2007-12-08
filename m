From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Something is broken in repack
Date: Fri, 7 Dec 2007 21:22:21 -0500
Message-ID: <9e4733910712071822w5a7d5bb5k5d099825b333acda@mail.gmail.com>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
	 <alpine.LFD.0.99999.0712072032410.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Dec 08 03:23:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0pLR-000311-RP
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 03:23:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753615AbXLHCWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 21:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752892AbXLHCWZ
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 21:22:25 -0500
Received: from ro-out-1112.google.com ([72.14.202.183]:37253 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368AbXLHCWY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 21:22:24 -0500
Received: by ro-out-1112.google.com with SMTP id p4so7395338roc
        for <git@vger.kernel.org>; Fri, 07 Dec 2007 18:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=gmh9e3kXul1j/bC3Zr7p6k1vKKnBvv+Jz3LMup6N/BM=;
        b=vBUAP2CYZaMVq8BIsoia2GFRHIKFU956maCbK4vqFNrzA6T0Alrnj8TJwuLxRrh2pu7a27Ly5iZ48t8EhLcX7pmjJuvcxkKKDeU75FwMiWr2b/6/4ajLoIdGeqjArJLQV4JhUcnHhYn+/kx7qLoZDNju3TdyDBiwitX3tqoEwf4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZvcsRstyeY4td6KMtDnrMReaCbqv6ggl13tWhvZZaeZ/S5ZWBS3CByORNHeGD71esTqJwOvI1B2dIW9wWkljdMykKTAX41L2He6beFofzTqK7CqFpsbhDQUASfywqCqHGxKn++Ln3fCHxy/E4HVscVqLcrMHpgHFKoeyqkwKnvk=
Received: by 10.114.171.1 with SMTP id t1mr3580836wae.1197080541538;
        Fri, 07 Dec 2007 18:22:21 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Fri, 7 Dec 2007 18:22:21 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0712072032410.555@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67498>

On 12/7/07, Nicolas Pitre <nico@cam.org> wrote:
> So the problem seems to be related to the pack access code and not the
> repack code.  And it must have something to do with the number of deltas
> being replayed.  And because the repack is attempting delta compression
> roughly from newest to oldest, and because old objects are typically in
> a deeper delta chain, then this might explain the logarithmic slowdown.

What could be wrongly allocating 4GB of memory? Figure that out and
you should have your answer. The slow down may be coming from having
to search through more and more objects in memory.

Memory consumption seem to be correlated to the depth of the delta
chain being accessed. It blows up tremendously right at the end. It
may even be a square of the length of the chain length. For the normal
default case the square didn't hurt, but 250*250 = 62,500 which would
eat a huge amount of memory.

-- 
Jon Smirl
jonsmirl@gmail.com
