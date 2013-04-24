From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 2/7] show: obey --textconv for blobs
Date: Wed, 24 Apr 2013 10:30:34 -0700
Message-ID: <7vip3beszp.fsf@alter.siamese.dyndns.org>
References: <517298D4.3030802@drmicha.warpmail.net>
	<c631e41a9f9b02f1ad5e40dd4bcaf18670b27c59.1366718624.git.git@drmicha.warpmail.net>
	<7va9opl1om.fsf@alter.siamese.dyndns.org>
	<5177AF6B.5040102@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	jeremy.rosen@openwide.fr, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Apr 24 19:30:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV3Wn-0000me-M9
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 19:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756213Ab3DXRal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 13:30:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59814 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756000Ab3DXRak (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 13:30:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28D27194C8;
	Wed, 24 Apr 2013 17:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eCxAZEi8s/WG1/D9ZW/9mCtPRxQ=; b=h/pGcz
	9zLmAQkK9CIwxhLSyJ6mztJ0yw4KNoxgEiZnsQjsLb4jgOZHD+p/P5BEWpgD+DXp
	EkSifCe6BqXjAH/4vLKxwZydVxUHtgPk/bZqO2oYlTsp0i5pY+X6B7a+N04n1r39
	cxn3Pmcflo5y7qwUa8pkgvlcS+0yzeqiIr32w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IEDo7w28TP/mShiwT8uSDcA70blRTKLz
	14+F0jZ2/x+c0SL9gtjDQBEJrYs77uW9fGXhbVH2F51rFiZokIwkIdOXOUR2McRS
	U28RzeDQCbQTW9uHoMT8jHLaJmD0gsLKwTV0bIJ8D+3WfA4zi7T8z0b6ZKF8O+Ad
	i6GcAe6O8Jg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2041B194C7;
	Wed, 24 Apr 2013 17:30:40 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 53B9B194C0;
	Wed, 24 Apr 2013 17:30:39 +0000 (UTC)
In-Reply-To: <5177AF6B.5040102@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Wed, 24 Apr 2013 12:09:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AE8A5982-AD04-11E2-A458-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222276>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 23.04.2013 17:14:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>> 
>>>> Subject: Re: [PATCHv2 2/7] show: obey --textconv for blobs
>> 
>> s/obey/honor/;
>
> I missed that one, thanks.
>
>>> Currently, "diff" and "cat-file" for blobs honor "--textconv" options
>>> (with the former defaulting to "--textconv" and the latter to
>>> "--no-textconv") whereas "show" does not honor this option, even though
>>> it takes diff options.
>>>
>>> Make "show" on blobs behave like "diff", i.e. honor "--textconv" by
>>> default and "--no-textconv" when given.
>> 
>> It is the right thing to do to teach it to react to --[no-]textconv;
>> I am not sure if the default is right, though.
>
> That is the question ;)

Then let me make it easier.  It is not just "I am not sure if", but "I
do not think that".
