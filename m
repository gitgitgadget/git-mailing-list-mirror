From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 3/3] status: don't suggest "git rm" or "git add" if not
 appropriate
Date: Fri, 01 Jun 2012 09:38:42 -0700
Message-ID: <7vbol33s31.fsf@alter.siamese.dyndns.org>
References: <1338384216-18782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338477344-15940-3-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <CABURp0qS-bDYTTgz75mQOOZsXzM1TkF_CNjaRNcXa4MYXAg0kA@mail.gmail.com>
 <20120601160808.Horde.ij8nYXwdC4BPyMzILrtjxYA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthieu.Moy@grenoble-inp.fr,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Fri Jun 01 18:38:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaUsE-00044J-IU
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 18:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965471Ab2FAQip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 12:38:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46060 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965419Ab2FAQip (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 12:38:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 796C68318;
	Fri,  1 Jun 2012 12:38:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vvatLZyfj561OgRLR4HJIIyDN7I=; b=Ke2IFz
	iWoUuayzEBUyEb+1geQtucdylOIF20OJ9N++BTlkY8ScmeKwWlqIM12RVvdEbLB2
	7evGmPu16HwMSju/rGFix+E4TPNjUumoi02ww3yVFO/OohhUFiGglizDM63cOHJg
	DJhVnbAoJLqoZobHDb3K3Wzc/H2KA/5aXznsA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h7iPliGOzVOd5dO5hLQ7U1MOxfSX796E
	e6FAnAcpeiipOoNGL0tY1sv0WOVVwkSk4Ph/KXSFNSUuu8vvmyv9MqxQQlW3Y8Gt
	Wkx9WrfStwkKtizZiHcdJQ3a3XIgfepkmkFCVxGk3YeTx+W050B+CxwcBLWzjyIB
	FS0HE5whLUY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DE3F8317;
	Fri,  1 Jun 2012 12:38:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B8AAA8316; Fri,  1 Jun 2012
 12:38:43 -0400 (EDT)
In-Reply-To: <20120601160808.Horde.ij8nYXwdC4BPyMzILrtjxYA@webmail.minatec.grenoble-inp.fr> (konglu@minatec.inpg.fr's message of "Fri, 01 Jun 2012 16:08:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4066194E-AC08-11E1-891E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199000>

konglu@minatec.inpg.fr writes:

> If both sides delete the same file with "git rm", this case does not occur
> because there is no conflict when merging. However, it can occur when
> both sides rename the file and then merge.
>
>> As this patch highlights, the only expected resolution is to 'git rm'
>> the file; why can't git figure this out for me and continue on?
>
> I agree. The only option for the user is to run "git rm".

If both sides remove the path A and one side creates a similar
looking B but the other side does so for C, it is clear that neither
side wants A in the result, so the only option FOR THE PATH A is to
run "git rm".

But when looking at B and C to decide, it would help knowing that
the corresponding source of these renames is potentially A.  If we
auto-resolved A, we would lose that information, no?

You need to look at a larger picture.
