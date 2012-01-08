From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] run-command: kill children on exit by default
Date: Sat, 07 Jan 2012 22:26:49 -0800
Message-ID: <7v4nw6hfpy.fsf@alter.siamese.dyndns.org>
References: <7vipkoih0e.fsf@alter.siamese.dyndns.org>
 <1325936567-3136-1-git-send-email-drizzd@aon.at>
 <1325936567-3136-3-git-send-email-drizzd@aon.at>
 <20120107145004.GB2461@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 08 07:27:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjmDu-0002sU-U9
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 07:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670Ab2AHG0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 01:26:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46942 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751568Ab2AHG0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 01:26:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F1667CC9;
	Sun,  8 Jan 2012 01:26:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b3emmnyTxIyVr2oKONk819+M1Xs=; b=OJr+et
	U3ZAYN8aDAXUJuTs4mkVuI4EuuM2r+WZ3Pl/pdlPAWrIsie1cbNp6HcLGqON2Ksc
	ixw567XV33/eR96MBbrIxTbrFMlhG3c4VhQxqPz4xebKqWCLBu9RJEQSZuJfEW5K
	voefHntZnmklgvOFGwzeacd8r261dJzKGQ5sc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J5YO+GPCSB/2rK/12nhWyduCPYYRdNkK
	ur/PGq5cRUJaEhOc9MsbhKIURPMUJ6j9m4Y++kbJXNb9wPtuYYyfv4ZD9l5ByQ6c
	Onl0Pu8o+7n9jGO75ECloxPsW7SVbD6WyituqRx27f1g3I3eIF7nvr5LEcFRP2c7
	j0tylB0Lh3E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35B137CC8;
	Sun,  8 Jan 2012 01:26:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A98D87CC7; Sun,  8 Jan 2012
 01:26:50 -0500 (EST)
In-Reply-To: <20120107145004.GB2461@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 7 Jan 2012 09:50:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BFCFF7A4-39C1-11E1-9B81-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188096>

Jeff King <peff@peff.net> writes:

> On Sat, Jan 07, 2012 at 12:42:44PM +0100, Clemens Buchacher wrote:
>
>> It feels natural for a user to view git commands as monolithic
>> commands with a single thread of execution. If the parent git
>> command dies, it should therefore clean up its child processes as
>> well. So enable the cleanup mechanism by default.
>
> I'm not sure this is a good idea. run_command is used in ~70 places in
> git, and I'm sure at least one of them is going to be unhappy (I see you
> found one in credential-cache, but how many others are there). I'd
> rather be conservative and leave the default the same, and then switch
> over callsites that make sense.

Yeah, I agree 100% with that reasoning. I seem to recall that was how this
commit was done in what I privately reviewed after Clemens announced his
github branch?
