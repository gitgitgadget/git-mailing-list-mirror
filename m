From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv3 2/2] git submodule: Fix adding of submodules at paths
 with ./, .. and //
Date: Tue, 03 Mar 2009 15:09:45 +0100
Message-ID: <49AD3A29.10404@drmicha.warpmail.net>
References: <7vtz6ht9ho.fsf@gitster.siamese.dyndns.org> <1236083989-20526-1-git-send-email-git@drmicha.warpmail.net> <1236083989-20526-2-git-send-email-git@drmicha.warpmail.net> <1236083989-20526-3-git-send-email-git@drmicha.warpmail.net> <49AD2BE6.1000105@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Andrei Thorp <garoth@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 15:11:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeVLC-0002KQ-Bp
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 15:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbZCCOJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 09:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbZCCOJ5
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 09:09:57 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:36267 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750706AbZCCOJ4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 09:09:56 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id F12E22D3507;
	Tue,  3 Mar 2009 09:09:54 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 03 Mar 2009 09:09:55 -0500
X-Sasl-enc: xswpomt96IOHNhHfZ6jTxk1zvs0FUW+/s11Q/XKrh2Ex 1236089394
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 07E162EBF2;
	Tue,  3 Mar 2009 09:09:53 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090303 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <49AD2BE6.1000105@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112075>

Johannes Sixt venit, vidit, dixit 03.03.2009 14:08:
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

Shoot, I thought I had a complete test case...
Thanks for spotting.

> Once this is fixed, I have to ask what should happen with path names like
> "../a/b", "../../a/b"? Should there be a warning or error?

That triggers the error message when trying to git add a submodule which
is not within the current wc. Same before and after the patch, and I
think that's how it should be.

> Other than that, this expression works on AIX 4.3.3! Note in particular
> that '\n' in the printf format string is essential!

I learned that from you ;)

Michael

> 
>> +			tstart
>> +			s|/*$||
>> +		')
> 
> -- Hannes
> 
