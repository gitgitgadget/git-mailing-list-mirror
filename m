From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv8 4/4] status: better advices when splitting a commit
 (during rebase -i)
Date: Fri, 08 Jun 2012 08:05:01 -0700
Message-ID: <7vzk8ddeua.fsf@alter.siamese.dyndns.org>
References: <1338830399-31504-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338927687-29822-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338927687-29822-4-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <7vfwa9o3xo.fsf@alter.siamese.dyndns.org>
 <20120608112945.Horde.I4abIHwdC4BP0cYJzywVAeA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Fri Jun 08 17:05:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd0kS-0000nE-3U
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 17:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756977Ab2FHPFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 11:05:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47364 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755528Ab2FHPFF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 11:05:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1758B8715;
	Fri,  8 Jun 2012 11:05:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rR/tZ0PfsI0cBMezeuqMu0ufPrg=; b=s4hoje
	Ofq3OOAh39H94aY8pKlz6LFeoflhSEOfFWiHn9Qa6bpvBw9aN8w1rYMJTPIWyx2W
	BcGyJsyF2d5ozpn5xWNd67Fy/8OxYO1phmVyCh4ROP7uf5+lWGmNiiTVKF1IHFTM
	OlhKe7X6memLUvOGXbQEkjtyYZceKOYRfx65I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ntpk/DxHMQ4GWQFeaUopaNedj//1KwJW
	i3tKLaBeOX27+isblzztW/5JjfXyzWiCWZerrstTJ3DHXHeGAL4iFFvm7+onxwEy
	l1aZoMBdpqu5etrJZ4AMVEkKh7SfnXpPTJew6H0wTFCP2Cki2Lflvk8j++sBpXWd
	uDv3a57goNM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D6588714;
	Fri,  8 Jun 2012 11:05:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 792CE8710; Fri,  8 Jun 2012
 11:05:02 -0400 (EDT)
In-Reply-To: <20120608112945.Horde.I4abIHwdC4BP0cYJzywVAeA@webmail.minatec.grenoble-inp.fr> (konglu@minatec.inpg.fr's message of "Fri, 08 Jun 2012 11:29:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 52CAF334-B17B-11E1-A345-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199502>

konglu@minatec.inpg.fr writes:

>> Reading from git_path("HEAD") looked funny, as you may end up
>> reading the "ref: refs/heads/master".  Of course that would not
>> compare equal to what you would read from "rebase-merge/amend", and
>> that may be fine for the purpose of your test, but it still looks
>> somewhat funny.  As modern rebase is done on a detached HEAD,
>> perhaps it is a good idea to check if the HEAD is detached and
>> return false from this function if that is not the case.  I dunno.
>
> On second thoughts, I do not think that checking if HEAD is detached
> or not is needed, as the part of the code that includes reading can
> only be called during a rebase interactive, in which case the HEAD
> can only be detached.

"can only be detached" is making a huge assumption.

I'd rather see a code that verifies that the assumption still holds
after changes are made to other parts of the system and gracefully
degrade its behaviour when the assumption it makes no longer holds.

Besides, making sure that the HEAD is detached when you _think_ you
are in the middle of a rebase is a necessary part of catching and
reporting a potential mistake like this, no?

	$ git checkout -b throwaway
        $ git rebase --onto HEAD~5 HEAD~2
        ... conflicts ...
        $ git checkout throwaway
