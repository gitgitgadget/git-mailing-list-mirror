From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 05/12] sequencer.c: recognize "(cherry picked from
 ..." as part of s-o-b footer
Date: Tue, 12 Feb 2013 11:36:21 -0800
Message-ID: <7vtxphfhoq.fsf@alter.siamese.dyndns.org>
References: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
 <1360664260-11803-6-git-send-email-drafnel@gmail.com>
 <7v621xgxax.fsf@alter.siamese.dyndns.org> <511A98C0.70201@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <drafnel@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	"pclouds\@gmail.com" <pclouds@gmail.com>,
	"jrnieder\@gmail.com" <jrnieder@gmail.com>
To: Brandon Casey <bcasey@nvidia.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 20:36:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Leu-0003z8-BV
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 20:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933302Ab3BLTgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 14:36:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58594 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933161Ab3BLTgX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 14:36:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B82EB93E;
	Tue, 12 Feb 2013 14:36:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O426JWC3AuCw7Bxi9uEuhxQqiBQ=; b=E3ZPzP
	tQPmDQyEMK6Cm6Rerx3TtTifFzoEtPZedbSdUVNguFgglwmVsfuLXWUqO7E35lO/
	o8wpomU2tUk/dcpLuBBmxthNOZiyQd6OR1b8ir8szi0HpnDsfxbGUz8h4JINCQNm
	p/97VEvoUMEsMnHrwLhUekOwKDSr+3yyCisR0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BBi5DoEZTQC4LjYrLLct/E0IyURwE1FC
	aXXQKLsjIivQN4/4Yd7i5HTInZ75oVFJkof3CdIIFMQEA+MMJFHivG/v5X5KI7Pp
	sVdKL7qnQm2zwfKu+PyQNHRs+xtoKqYjdy2HijL8JOwNp9bNoW7cOcpUkP4d5+rO
	Lgmx41mvtZs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1070DB93C;
	Tue, 12 Feb 2013 14:36:23 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88634B93B; Tue, 12 Feb 2013
 14:36:22 -0500 (EST)
In-Reply-To: <511A98C0.70201@nvidia.com> (Brandon Casey's message of "Tue, 12
 Feb 2013 11:32:16 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7B455CC0-754B-11E2-BCC6-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216178>

Brandon Casey <bcasey@nvidia.com> writes:

>>> +	return len > strlen(cherry_picked_prefix) + 1 &&
>>> +		!prefixcmp(buf, cherry_picked_prefix) && buf[len - 1] == ')';
>>> +}
>> 
>> Does the first "is it longer than the prefix?" check matter?  If it
>> is not, prefixcmp() would not match anyway, no?
>
> Probably not in practice, but technically we should only be accessing
> len characters in buf even though buf may be longer than len.  So the
> check is just making sure the function doesn't access chars it's not
> supposed to.

Sorry, I do not follow.  Isn't caller's buf terminated with LF at buf[len],
which would never match cherry_picked_prefix even if len is shorter
than the prefix?
