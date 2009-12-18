From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] am: fix patch format detection for Thunderbird "Save
 As" emails
Date: Fri, 18 Dec 2009 15:49:21 -0800
Message-ID: <7vmy1fsv0e.fsf@alter.siamese.dyndns.org>
References: <7vtyvpcf36.fsf@alter.siamese.dyndns.org>
 <1261172078-9174-1-git-send-email-bebarino@gmail.com>
 <loom.20091218T223918-175@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Blake <ebb9@byu.net>, Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 00:49:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLmZu-000546-TZ
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 00:49:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755589AbZLRXte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 18:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755646AbZLRXtd
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 18:49:33 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34920 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755593AbZLRXtb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 18:49:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F29D889587;
	Fri, 18 Dec 2009 18:49:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ny9BO5k6cS9dMXXpQ+bi6BQ0Das=; b=LLFwRy
	LmlulpFvlJDcH6Ej4ewc+XDfVtLBWSh4V0xeasbmxGgM94AqIb+HSfT/iwzAGa/J
	HFxFIPGva01lOSMTFG5BfOhC1yhJ6lW5skuEcGRG8Hm1YHc70JW3/NGhw2ISe4/Y
	9T0w5Vh3Fugdu7tYvge7wy/ZLHzBmTjP/BVxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UEKAGrEf9WvJ/schv+PdX14VxTE70y1W
	xHcsJzgLUDBioJYW4N8qkUHSk0kG1itzhq6YP/t7ILNHl5pvDPPA43gC1GzQkcDi
	jW0zjqfTDMmetVrZ9/x2Gipeyg0JsmOStKS+LWewyODcMzZBww+QgfG2zPtemr5R
	4HBb91IKNRU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B92E389581;
	Fri, 18 Dec 2009 18:49:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 00C428957D; Fri, 18 Dec
 2009 18:49:22 -0500 (EST)
In-Reply-To: <loom.20091218T223918-175@post.gmane.org> (Eric Blake's message
 of "Fri\, 18 Dec 2009 21\:42\:49 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F9DB9836-EC2F-11DE-AF9F-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135449>

Eric Blake <ebb9@byu.net> writes:

> Stephen Boyd <bebarino <at> gmail.com> writes:
>
>> +	{
>> +		echo "X-Fake-Field: Line One\015" &&
>
> echo and \ do not portably mix.  For that matter, shell double quotes and 
> backslash escapes that are not required by POSIX do not portably mix.  To 
> reliably create carriage returns in shell, you need to use printf, or else 
> something like:
>
> echo "...@" | tr '@' '\015'

Thanks.

Also we probably want to change the "only munge the first three lines" to
something like:

	format-patch --stdout |
        sed -e 's/$/Q/' |
        tr 'Q' '\015'

picking some 'Q' that we know does not appear in the text.
