From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git gc & deleted branches
Date: Thu, 08 May 2008 20:21:57 -0700
Message-ID: <7vabj0b1re.fsf@gitster.siamese.dyndns.org>
References: <48235D99.2040407@nrlssc.navy.mil>
 <alpine.LSU.1.10.0805082232070.4260@bianca.dialin.t-online.de>
 <20080508210125.GC32762@sigill.intra.peff.net>
 <alpine.LFD.1.10.0805081712270.23581@xanadu.home>
 <20080508211734.GA819@sigill.intra.peff.net>
 <48236F69.2060900@nrlssc.navy.mil>
 <20080508213107.GA1016@sigill.intra.peff.net>
 <48237344.6070405@nrlssc.navy.mil>
 <20080508214454.GA1939@sigill.intra.peff.net>
 <48237650.5060008@nrlssc.navy.mil>
 <20080508224827.GA2938@sigill.intra.peff.net>
 <loom.20080509T011318-478@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 05:23:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuJCO-0007r1-1X
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 05:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752870AbYEIDWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 23:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751987AbYEIDWK
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 23:22:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64791 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518AbYEIDWI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 23:22:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8C2A44C37;
	Thu,  8 May 2008 23:22:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C54024C36; Thu,  8 May 2008 23:22:01 -0400 (EDT)
In-Reply-To: <loom.20080509T011318-478@post.gmane.org> (Brandon Casey's
 message of "Fri, 9 May 2008 01:41:30 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 18D07E7A-1D77-11DD-AD76-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81596>

Brandon Casey <drafnel@gmail.com> writes:

> @@ -116,7 +113,15 @@ for name in $names ; do
>                 echo >&2 "old-pack-$name.{pack,idx} in $PACKDIR."
>                 exit 1
>         }
> -       rm -f "$PACKDIR/old-pack-$name.pack" "$PACKDIR/old-pack-$name.idx"
> +       rm -f "$PACKDIR/old-pack-$name.idx"
> +       test -z "$keep_unreachable" ||
> +         ! test -f "$PACKDIR/old-pack-$name.pack" ||
> +         git unpack-objects < "$PACKDIR/old-pack-$name.pack" || {
> +               echo >&2 "Failed unpacking unreachable objects from old pack"
> +               echo >&2 "saved as old-pack-$name.pack in $PACKDIR."
> +               exit 1
> +       }

Neat trick.  Unreachable objects that are only in this pack will get
current timestamp and gets a new lease of life for two weeks and then will
disappear.
