From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] trailer: reuse ignore_non_trailer() to ignore conflict lines
Date: Sun, 09 Nov 2014 08:45:59 -0800
Message-ID: <xmqqfvdse308.fsf@gitster.dls.corp.google.com>
References: <20141107184148.16854.63825.chriscool@tuxfamily.org>
	<20141107185053.16854.5660.chriscool@tuxfamily.org>
	<xmqqzjc2eoyw.fsf@gitster.dls.corp.google.com>
	<20141109.113509.1363113947439404678.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, johan@herland.net, josh@joshtriplett.org,
	tr@thomasrast.ch, mhagger@alum.mit.edu, dan.carpenter@oracle.com,
	greg@kroah.com, peff@peff.net, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk, jrnieder@gmail.com,
	marcnarc@xiplink.com
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Nov 09 17:46:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnVcz-0000kp-Op
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 17:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbaKIQqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 11:46:09 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55613 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751468AbaKIQqI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 11:46:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E5DEF1A344;
	Sun,  9 Nov 2014 11:46:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hs8t8HQBhCDMYvsRdHDbwLuCDTY=; b=oXWZFg
	lCUC3sHysrtk1bKas6yeALWq2YDmImNV9HmFg5ZdSVh7iFJ79xS2qdfumvW6/Xcq
	6t4vTLBZGZYujQa9KUj1E4aACzby42mov+ozYpnBR4cEG9B8g73o3eYzI7DhjIS7
	lO0Ys82Sw/v9tL2ztIpRJCrTWVYhMElQi3pdk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bpvfn4KeeFwsR4E+qS2HQV+Sbn5fIsF1
	Nw5ymtM7F1tgHdJl/9YIFU4LgYAVRd/aJIdhM2t3vEW8svzAhfGU/t5To0LnlmIC
	mfrFPlSs7jMD5cyGYGeXCPydU4rxUQs7dLYIBQd6Mg3+c6EauEqCN6R7ERoFMnln
	ybHjmUk1Nck=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D9C7B1A343;
	Sun,  9 Nov 2014 11:46:01 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5895B1A342;
	Sun,  9 Nov 2014 11:46:01 -0500 (EST)
In-Reply-To: <20141109.113509.1363113947439404678.chriscool@tuxfamily.org>
	(Christian Couder's message of "Sun, 09 Nov 2014 11:35:09 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E351E738-682F-11E4-9B48-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <chriscool@tuxfamily.org> writes:

> Yeah, it won't be as efficient as using only one strbuf and only byte
> oriented functions, and it looks much less manly too :-) But over time in
> Git we have developed a number of less efficient but quite clean
> abstractions like strbuf, argv_array, sha1_array and so on, that we
> are quite happy with.

Actually, all these examples you gave are fairly efficient and clean
abstractions.  I find it insulting to pretend that the "one line per
strbuf" is in the same league.  It isn't.

And it is not about manliness.
