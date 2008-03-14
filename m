From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-objects: proper pack time stamping with
 --max-pack-size
Date: Thu, 13 Mar 2008 21:33:20 -0700
Message-ID: <7vmyp1vsa7.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0803131440590.2947@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Mar 14 05:34:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja1cQ-00068q-7Y
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 05:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbYCNEdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 00:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbYCNEdb
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 00:33:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42051 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbYCNEda (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 00:33:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EF3212298;
	Fri, 14 Mar 2008 00:33:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4C44A2297; Fri, 14 Mar 2008 00:33:25 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.00.0803131440590.2947@xanadu.home> (Nicolas
 Pitre's message of "Thu, 13 Mar 2008 14:59:29 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77168>

Nicolas Pitre <nico@cam.org> writes:

> Runtime pack access is done in the pack file mtime order since recent 
> packs are more likely to contain frequently used objects than old packs.
> However the --max-pack-size option can produce multiple packs with mtime 
> in the reversed order as newer objects are always written first.
>
> Let's modify mtime of later pack files (when any) so they appear older 
> than preceding ones when a repack creates multiple packs.
>
> Signed-off-by: Nicolas Pitre <nico@cam.org>
> ---
> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index f504cff..4c2ed70 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -17,6 +17,8 @@
>  #include "progress.h"
>  #include "refs.h"
>  
> +#include <utime.h>
> +

Hmmm.  Shouldn't this go to git-compat-util.h?
