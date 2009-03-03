From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 2/2] git submodule: Fix adding of submodules at paths
 with ./, .. and //
Date: Tue, 03 Mar 2009 07:36:33 -0800
Message-ID: <7v3aduehz2.fsf@gitster.siamese.dyndns.org>
References: <7vtz6ht9ho.fsf@gitster.siamese.dyndns.org>
 <1236083989-20526-1-git-send-email-git@drmicha.warpmail.net>
 <1236083989-20526-2-git-send-email-git@drmicha.warpmail.net>
 <1236083989-20526-3-git-send-email-git@drmicha.warpmail.net>
 <49AD2BE6.1000105@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Andrei Thorp <garoth@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 16:38:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeWhc-0001Sj-Rm
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 16:38:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754828AbZCCPgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 10:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754705AbZCCPgn
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 10:36:43 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55689 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753239AbZCCPgm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 10:36:42 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1DE022FFD;
	Tue,  3 Mar 2009 10:36:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3833A2FF5; Tue, 
 3 Mar 2009 10:36:35 -0500 (EST)
In-Reply-To: <49AD2BE6.1000105@viscovery.net> (Johannes Sixt's message of
 "Tue, 03 Mar 2009 14:08:54 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1791F00C-0809-11DE-9F2B-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112088>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Michael J Gruber schrieb:
>> +	# normalize path:
>> +	# multiple //; leading ./; /./; /../; trailing /
>> +	path=$(printf '%s/\n' "$path" |
>> +		sed -e '
>> +			s|//*|/|g
>> +			s|^\(\./\)*||
>> +			s|/\./|/|g
>> +			:start
>> +			s|\([^/]*\)/\.\./||g
>
> Sorry to say: not yet. This turns "a/b/c/d/../../../d" into "a/b/c/d"
> instead of "a/d". Drop the 'g'.
>
> Once this is fixed, I have to ask what should happen with path names like
> "../a/b", "../../a/b"? Should there be a warning or error?
>
> Other than that, this expression works on AIX 4.3.3! Note in particular
> that '\n' in the printf format string is essential!
>
>> +			tstart
>> +			s|/*$||
>> +		')

At some point you should wonder if all of this complication is worth it,
or it makes sense to reject when you see // or /\.\./ in the input.
