From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] push: introduce implicit push
Date: Mon, 15 Apr 2013 00:20:32 -0700
Message-ID: <7vzjx01cqn.fsf@alter.siamese.dyndns.org>
References: <1365780835-2853-1-git-send-email-artagnon@gmail.com>
 <7v38uvcrjl.fsf@alter.siamese.dyndns.org>
 <CALkWK0=-GcOF17Q-y-Aqj0ThX5pPQFrriDqoJ2qsr=CS+wUNGA@mail.gmail.com>
 <7vehed7ilu.fsf@alter.siamese.dyndns.org>
 <CALkWK0k6bmjFxTSMAutgu2EjWRZ_cyTU9jZ3Er-aaV78T16RtQ@mail.gmail.com>
 <7vppxw335o.fsf@alter.siamese.dyndns.org> <516BA732.4080405@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Apr 15 09:20:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URdiW-0005cE-Ry
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 09:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497Ab3DOHUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 03:20:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64002 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753487Ab3DOHUe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 03:20:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28A5D11BDF;
	Mon, 15 Apr 2013 07:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mzJxbNTx3AdbqoGrqbMiw7i8HHg=; b=osEmy1
	xWo/01mg7YztD7AFSwXRf1ssddGkWW/xd3ShXqXwdXWJMDX5XpjUrU0xMLuc5ZZd
	vqnyVMML/u2JCQbqxesiB+QtxLyThIE5YgXcxIrgqO7OPwWQIR7SWQJ6Z3AnaL7U
	y0hon5UCTf/9yN9KwcHiZHmhq5ijat7QY7BLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V+DVT3UX6N1UrbcJFXZ2MLf6MXGbQ3EQ
	PxOvmYi+nGOp/zOmmHmr3BhJ88eapblig8rt9amnzsJCw9E2rnQKHKL3/packpqR
	J59aCdnP3gmCUWMk6I+2bHF2fz/ntUEFzBsBEBLmTIpd4e2tRjo5RavQtlCUaszd
	4OdlBsvlRYY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F5AC11BDE;
	Mon, 15 Apr 2013 07:20:34 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9478411BDC; Mon, 15 Apr
 2013 07:20:33 +0000 (UTC)
In-Reply-To: <516BA732.4080405@viscovery.net> (Johannes Sixt's message of
 "Mon, 15 Apr 2013 09:07:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F60F09C0-A59C-11E2-B7C0-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221196>

Johannes Sixt <j.sixt@viscovery.net> writes:

> User says:
>
>    git push -- master docs release
>
> Then git pushes the three branches to three different upstreams. You find
> that confusing. Do I understanding correctly so far?

It is far more subtle than that.  User says that while on 'next'
branch.

The user has been trained to think "branch.master.remote" takes
effect while he has "master" branch checked out.

That is where the possible confusion comes from. As I said number of
times, you may be able to declare that the confusion is unfounded
once you think it through.

> Just my 2 cents. (But I'm a traditional "matching" type, so take this with
> a grain of salt. Or I may be missing the point of this thread, as I
> haven't followed closely.)

For exmaple, see

cf. http://thread.gmane.org/gmane.comp.version-control.git/218429/focus=220707

where I say "branch.next.remote" should not come into play when I
say "git push --master docs release" while on the next branch and
Peff gives a counter-viewpoint.
