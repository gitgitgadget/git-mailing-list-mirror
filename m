From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame: make sure that the last line ends in an LF
Date: Tue, 20 Oct 2009 09:55:11 -0700
Message-ID: <7vbpk2ovio.fsf@alter.siamese.dyndns.org>
References: <1256007988-13321-1-git-send-email-srabbelier@gmail.com>
 <7vbpk2sg6m.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0910200615x5d487cdk6f50e11c96f2cb6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 18:56:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0I0U-00045n-6f
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 18:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760AbZJTQzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 12:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752732AbZJTQzU
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 12:55:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51647 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbZJTQzT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 12:55:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 09179608AC;
	Tue, 20 Oct 2009 12:55:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=CEHEdWxfLU7X6vQgOFZubyiqCNE=; b=t+P0euTvYaUVYh3M5pmhkBy
	ngPpG+Mvx4HEdoLNQf1NZN8FievCyffgogTToSx0KnF+wJ8OXcJ0iQOE0WD62iCq
	tZoCYT+Q+kLGST1xdTZfx8FRX3yt4M9CBMuNG7UlRkC2g4xoTjOv5+6oPd+cBrHP
	y0wYj6LbO02/KExH9hPg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Pwds3Kl4hxHQSdn7lOJpEglXelcrtGVwHo8TbIxvL2ZYNEgNi
	jg2BobahIaEa+9fXkWxVUgE92IM7j5gAPDq5ZGyaZytQGnVDtaWuL7NAqhmsiDXG
	gyfmu731TWzbMYLCjGhePKAL2ERQrr+FGBwm1S2f9PPKMROSjGUaEi//ik=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C63B8608AA;
	Tue, 20 Oct 2009 12:55:17 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 805D3608A9; Tue, 20 Oct
 2009 12:55:12 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 585C1306-BD99-11DE-93A4-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130813>

Sverre Rabbelier <srabbelier@gmail.com> writes:

>> Does the code assign blame
>> correctly around the last line of the original blob?
> 
> Yes, it does,...

That is kind of surprising ;-) as I do remember that I never thought about
this issue of dealing with the incomplete lines while writing the blame
algorithm.  I actually didn't even think about "well this will not work
because I am ignoring the incomplete lines".

>> Or am I worrying too much?
>
> No, I think your concerns are valid, we should go with (2) and DTRT.
> Does the updated patch address your concerns? If so I can send a new
> version.

Assuming the internal blame algorithm correctly works with such an input,
I'd be happier with an approach to allow users to tell the difference.
The --porcelain output was designed to be extensible, and it might make
sense to show the "this line is incomplete" as a separate bit, though.
