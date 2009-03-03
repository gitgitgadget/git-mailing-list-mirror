From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCHv3 2/2] git submodule: Fix adding of submodules at paths
 with ./, .. and //
Date: Tue, 03 Mar 2009 14:08:54 +0100
Message-ID: <49AD2BE6.1000105@viscovery.net>
References: <7vtz6ht9ho.fsf@gitster.siamese.dyndns.org> <1236083989-20526-1-git-send-email-git@drmicha.warpmail.net> <1236083989-20526-2-git-send-email-git@drmicha.warpmail.net> <1236083989-20526-3-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Andrei Thorp <garoth@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 14:10:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeUOF-0006xD-JT
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 14:10:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbZCCNJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 08:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbZCCNJD
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 08:09:03 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:46021 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618AbZCCNJB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 08:09:01 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LeUMg-0000se-II; Tue, 03 Mar 2009 14:08:54 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 248E26B7; Tue,  3 Mar 2009 14:08:54 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <1236083989-20526-3-git-send-email-git@drmicha.warpmail.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112071>

Michael J Gruber schrieb:
> +	# normalize path:
> +	# multiple //; leading ./; /./; /../; trailing /
> +	path=$(printf '%s/\n' "$path" |
> +		sed -e '
> +			s|//*|/|g
> +			s|^\(\./\)*||
> +			s|/\./|/|g
> +			:start
> +			s|\([^/]*\)/\.\./||g

Sorry to say: not yet. This turns "a/b/c/d/../../../d" into "a/b/c/d"
instead of "a/d". Drop the 'g'.

Once this is fixed, I have to ask what should happen with path names like
"../a/b", "../../a/b"? Should there be a warning or error?

Other than that, this expression works on AIX 4.3.3! Note in particular
that '\n' in the printf format string is essential!

> +			tstart
> +			s|/*$||
> +		')

-- Hannes
