From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [WIP] Shift rev-list enumeration from upload-pack to pack-objects
Date: Fri, 05 Jun 2009 10:10:23 +0200
Message-ID: <4A28D2EF.8040704@viscovery.net>
References: <20090605054500.06A9D21C3F4@mail.utsl.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nick Edelen <sirnot@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	Jeff King <peff@peff.net>
To: sam@vilain.net
X-From: git-owner@vger.kernel.org Fri Jun 05 10:11:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCUWM-0007R2-II
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 10:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756446AbZFEIKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 04:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756459AbZFEIK3
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 04:10:29 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:28282 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756441AbZFEIK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 04:10:26 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MCUVM-0001SE-2p; Fri, 05 Jun 2009 10:10:24 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id CC6D94E4; Fri,  5 Jun 2009 10:10:23 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090605054500.06A9D21C3F4@mail.utsl.gen.nz>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120759>

sam@vilain.net schrieb:
> instead of using the internal revision walker and piping object refs
> to pack-objects this patch passes only the revs to pack-objects, which
> in turn handles both enumeration and packing.

I appreciate this move. We have one test failing in MinGW git (t5530.6)
because of the rev-list that is run using start_async(). Even though this
patch doesn't change that (the test case still uses the start_async()
path), it is one step closer to the solution.

> +	/* sending rev params to pack-objects directly is great, but unfortunately pack-objects 
> +	 * has no way of turning off thin pack generation.  this would be a relatively simple 
> +	 * addition, but as we also have to deal with shallow grafts and all it's simplest to 
> +	 * just resort to piping object refs.
> +	 */

You certainly will reformat comments like this to shorter lines, proper
capitalization, without trailing spaces, and adjust the style (initial /*
is on its own line)?

> @@ -181,6 +195,28 @@ static void create_pack_file(void)
>  	if (start_command(&pack_objects))
>  		die("git upload-pack: unable to fork git-pack-objects");
>  
> +	/* pass on revisions we (don't) want 
> +	 * (do we need to check the validity of pack_objects.in?)

No, you don't need to check. It's valid, or you would have died above.

FYI, with this patch MinGW git hangs in t5530.8; the test-case exercises
the new code path.

-- Hannes
