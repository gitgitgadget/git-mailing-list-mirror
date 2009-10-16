From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Add proof-of-concept
 %[w(width,in1,in2)<<any-string>>%] implementation
Date: Fri, 16 Oct 2009 10:25:46 -0700
Message-ID: <7vk4yvuu79.fsf@alter.siamese.dyndns.org>
References: <1255681702-5215-1-git-send-email-gitster@pobox.com>
 <1255681702-5215-4-git-send-email-gitster@pobox.com>
 <alpine.DEB.1.00.0910161331350.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 16 19:33:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyqgG-0006qD-4t
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 19:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbZJPRZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 13:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755235AbZJPRZy
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 13:25:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57822 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754385AbZJPRZv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 13:25:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B37C25B454;
	Fri, 16 Oct 2009 13:25:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=7+2FcDq8H/LtbaBJIxEN8+ywC6I=; b=nwhMmkh9jy2fcmqeuWcNvse
	D9Orf3wGfB5o3rNi2GBxdk2Wc17DRTUg/7DQO7ziSKEfAg7cBErY3zdpP19H1oxO
	Dv102MN25cxccaVW8Fdx8zDBRaYeP5g0zQzBs4pUFLaBaQ7gNCWEWXQ15iTqpQ02
	ubfigFyQCPJbnm3UsYTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=ROKY6HGWyu9TxFgDdrZT6hVM9QxWb+yi4miLr1AFBESwKBoQV
	k0sR46xq/ZP6PuAwYkTduxu5Z8swE+2DHdkr1XOcPD0ng5NY60xGBojhKg68cJZO
	WS4KDJ85JLkcl3dpPiezc51u8Heoh1oXbfQZ3ZWN7PH1etjy0FQug7XJgg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 942A75B450;
	Fri, 16 Oct 2009 13:25:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0706F5B44D; Fri, 16 Oct
 2009 13:25:49 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F454FEC2-BA78-11DE-A94A-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130512>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> maybe "rewrap" would be a better name than "w"?

Perhaps, but I do not know if wrap() is even better.  The only reason I
said w() here is because I saw you used w() and this is meant to be a
superset replacement for it, as this can re-wrap anything, not just one
particular field from the commit object.

> On Fri, 16 Oct 2009, Junio C Hamano wrote:
>
>>   #1 "%[" introduces the nested string function.
>> 
>>   #2 After that, a name identifies what function to call.
>> 
>>   #3 The function parses its parameters ("(72,4,8)" in the above example),
>>      and makes a nested expansion on the remainder of the format string.
>
> Can't we parse it once, i.e. the first time?

I may be missing the issue you are raising here, but it parses the string
only once; it stuffs the expansion of the enclosed string into a separate
buffer (while noting where it ends), applies the function to the result
obtained in the separate buffer and appends the result of the function
application to the main buffer, and the main expansion resumes where the
nested one finished.
