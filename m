From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: "--work-tree blah" does not imply "--git-dir blah/.git" or
 fix misleading error message
Date: Wed, 30 Nov 2011 12:45:41 -0800
Message-ID: <7v1uspqqyy.fsf@alter.siamese.dyndns.org>
References: <CAEUMa-cA8qPjJuPBREE1RqhgwmcZG7x1MjBYkxa3i+ZSAnMPOA@mail.gmail.com>
 <7vaa7dquva.fsf@alter.siamese.dyndns.org>
 <20111130194233.GD12096@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Twilley <mathuin@gmail.com>, git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <carlos@cmartin.tk>
X-From: git-owner@vger.kernel.org Wed Nov 30 21:45:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVr2L-0006yn-Kk
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 21:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227Ab1K3Upo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Nov 2011 15:45:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54267 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752165Ab1K3Upo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Nov 2011 15:45:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AAF95FD6;
	Wed, 30 Nov 2011 15:45:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/cJKjoJcQLIh
	qKXYCrQ5pEAO1HU=; b=e53jlM2KM27Osh0LrnnHRNFaagfjRq5PWVPCiETOPDsw
	0Mxn2JGEUmc4qWTb5g/XTREpVeQ05PcF8jfH9jJxgu6nwWsdV+Q0gFkMwD/2OyVz
	tNzxPIhT1i7Fg4YemOs4n2GRWlSBlIfuQzaQSCcMlLhPR0/49u7E7teuJFAvnuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=TJjYny
	wydQNJylqmSi2o0PBrPb3k+KCIo6bi6rJnYu9GZQsiP4pjk+j9nUnReKekxgN5Sj
	poTRjp2RhXEXBZJaHbanRJCp6XB8uFQ+ogXjZW6XwaJAf+HTh6J5qE4cGvwiFGj4
	XbC4fo+EiP93CN/T6285C3NgLibwaT1+1VGFQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F5635FD5;
	Wed, 30 Nov 2011 15:45:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A5D6C5FD3; Wed, 30 Nov 2011
 15:45:42 -0500 (EST)
In-Reply-To: <20111130194233.GD12096@centaur.lab.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Wed, 30 Nov 2011 20:42:33
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4523AEE2-1B94-11E1-97F4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186141>

Carlos Mart=C3=ADn Nieto <carlos@cmartin.tk> writes:

> On Wed, Nov 30, 2011 at 11:21:29AM -0800, Junio C Hamano wrote:
>> subdirectory "blah/.git"), but I do not think this is likely to chan=
ge, as
>> I suspect that people and scripts are relying on the current behavio=
ur to
>> be able to do something like this:
>>=20
>>     cd /pub/scm/git/git.git ;# this is a bare repository
>>     mkdir /var/tmp/git
>>     git --work-tree=3D/var/tmp/git checkout
>
> This is in fact the way that many (or from what I can see the most
> popular) tutorials for abusing git as a deployment system tell you to
> run it (though more often than not setting GIT_WORKTREE in the
> environment).

Heh, *ab*using is a good description if they really mean to use it as a
deployment system. For one thing it won't do anything a proper deployme=
nt
should do if the target directory is not empty ;-)
