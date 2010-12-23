From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Expected behaviour of 'git log -S' when searching in a
 merged/deleted file?
Date: Thu, 23 Dec 2010 08:03:50 -0800
Message-ID: <7vwrn0328p.fsf@alter.siamese.dyndns.org>
References: <AANLkTimXk6ei6EAQfvTTfnMzdBqYHkNoaxkEab+atnHd@mail.gmail.com>
 <7vzkrx4qp6.fsf@alter.siamese.dyndns.org>
 <AANLkTim4z3XvpjnEERuXgTE6CtA7D-dnBxSUgO3mE-FM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan del Strother <jdelstrother@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 23 17:04:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVneC-0006DX-U3
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 17:04:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361Ab0LWQED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Dec 2010 11:04:03 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52951 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053Ab0LWQEB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Dec 2010 11:04:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 02D79296F;
	Thu, 23 Dec 2010 11:04:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=djRpreQJGD0Dp0QUh09MR2oDT00=; b=F/i1I9
	hFsyckk+wWy94T+F9td381A4InXDefQyPsFmiGPpufWsuZXzjuIHA7llXCnNfp4q
	JKSW5Kj43E/bSF/6J6QyOeGqvwrY17bIzJPopg3O4CaZwGpJFI3PUwqFT/k9F8IG
	e8GaUmauO7mo4InvH9+n/Yy3nQfglykaeaHGk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eVeWglNS5ipj24VGtYuLIReZ6r2+Kslw
	vEindubVzppHcP0SVzWv6sD/XLA1WtNDP9g1benABLpP/nvu+Ve4gsxdo0KNHL23
	8kHqUo6DIUP67oxhPUh/appDglT9lUiH91cuHzfZWFy8GtP/gjxL3u4Xz4VsY27l
	9oYw4a1csBs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C64FA296E;
	Thu, 23 Dec 2010 11:04:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B8C56296D; Thu, 23 Dec 2010
 11:04:22 -0500 (EST)
In-Reply-To: <AANLkTim4z3XvpjnEERuXgTE6CtA7D-dnBxSUgO3mE-FM@mail.gmail.com>
 (Jonathan del Strother's message of "Thu\, 23 Dec 2010 09\:47\:57 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5061C4FE-0EAE-11E0-8DBB-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164126>

Jonathan del Strother <jdelstrother@gmail.com> writes:

> ....  If 'needle' was added
> and removed within the duration of a single branch, I could understand
> "git log -S" never finding 'needle' due to history simplication, but I
> don't understand how simplification applies here.

Ahh, sorry, I misunderstood the scenario.  Just like you do not see a
patch output from "log -p", the diff machinery (including -S and its newer
cousin -G) does not kick in by default for merge commits (this is a bit of
white lie as "log -p" defaults to "combine diff", i.e. be silent on any
uninteresting merge that takes its results literally from either parent).

Please try it with "-m" (not "--full-history").  We _might_ want to change
this behaviour for -S/-G but it needs a bit more thought.
