From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/4] count-objects: report garbage files in pack
 directory too
Date: Wed, 13 Feb 2013 08:54:41 -0800
Message-ID: <7vpq049msu.fsf@alter.siamese.dyndns.org>
References: <7va9r9igze.fsf@alter.siamese.dyndns.org>
 <1360746799-3668-1-git-send-email-pclouds@gmail.com>
 <1360746799-3668-4-git-send-email-pclouds@gmail.com>
 <7vehgkb43v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 17:55:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5fbw-0002EZ-8P
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 17:55:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760037Ab3BMQyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 11:54:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48059 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760009Ab3BMQyo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 11:54:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E32D0CA74;
	Wed, 13 Feb 2013 11:54:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FDzUVMBgryRCuaPz4r83/kYl5v0=; b=PeL1bB
	WA1xCr5nG2mPixq6tU2AoxFZBcN4ccyB5Adp6HdgcVStY+lZdwHRcJzK36sAaV5i
	KkXCdDdscGJIh1xSMlELdJC5o/bzeEX8s6ADUw/Wxc8F8k8LyPrne2fKWc6VVU9P
	J83UAKzeX5Yd/ziuKaXguizCM1pnC4xOc8Ao0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G5lI557OruSXzm9k078wP/yUECiobIs/
	Ci7WsVcZ/RfP/CmkDuesfaqimUvjXfSocmR4gVQJorK3uWzUF3x0OTgpFdlZ8JtQ
	2Vc4PD18yLHzK3dggLsXUV7QupIk4xO7EnIsX2hglKqkg6rm8zNbVWp51VDgjtJs
	AIYe8MorVT8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D21AFCA73;
	Wed, 13 Feb 2013 11:54:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5208ECA6D; Wed, 13 Feb 2013
 11:54:43 -0500 (EST)
In-Reply-To: <7vehgkb43v.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 13 Feb 2013 07:55:32 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 107F1ECC-75FE-11E2-AC79-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216270>

Junio C Hamano <gitster@pobox.com> writes:

>> +		if (has_extension(de->d_name, ".idx") ||
>> +		    has_extension(de->d_name, ".pack") ||
>> +		    has_extension(de->d_name, ".keep"))
>> +			string_list_append(&garbage, path);
>
> It might be OK to put .pack and .keep in the same "if (A || B)" as
> it may happen to be that they do not need any special treatment
> right now, but I do not think this is a good idea in general.

Actually I take this part back.  I can see that the condition part
grow over time but I do not think the body should.  That is the
whole point of collecting paths that cannot be judged as garbage by
themselves into a list; we shouldn't be doing anything else by
definition in the body.

Everything else I said in the review still stands, though..

Thanks.
