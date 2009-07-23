From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: infinite loop in git-send-email with alias files
Date: Thu, 23 Jul 2009 14:30:55 +0200
Message-ID: <4A6857FF.5070401@viscovery.net>
References: <8bd0f97a0907161810w22726ffdye5c8d64719b77b53@mail.gmail.com> <20090723110928.GC4247@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Mike Frysinger <vapier.adi@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 23 14:31:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTxS3-0000bV-4x
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 14:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608AbZGWMbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 08:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbZGWMbB
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 08:31:01 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:7258 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbZGWMbA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 08:31:00 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MTxRo-0008S8-Ay; Thu, 23 Jul 2009 14:30:56 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id ED0936D9; Thu, 23 Jul 2009 14:30:55 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090723110928.GC4247@coredump.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123868>

Jeff King schrieb:
> +my %EXPANDED_ALIASES;
> +sub expand_one_alias {
> +	my $alias = shift;
> +	if ($EXPANDED_ALIASES{$alias}) {
> +		die "fatal: alias '$alias' expands to itself\n";
> +	}
> +	local $EXPANDED_ALIASES{$alias} = 1;
> +	return $aliases{$alias} ? expand_aliases(@{$aliases{$alias}}) : $alias;

What does 'local' make local here? Only the assignment of the slot
$EXPANDED_ALIASES{$alias}? Or the whole %EXPANDED_ALIASES? If the latter,
does this copy the existing %EXPANDED_ALIASES before the assignment is
made; otherwise, how can this work if only ever a single slot of
%EXPANDED_ALIASES is filled in?

(Disclaimer: I'm not a perl expert, obviously, and I didn't test your patch.)

-- Hannes
