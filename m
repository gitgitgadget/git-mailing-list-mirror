From: Junio C Hamano <gitster@pobox.com>
Subject: Re: regression: "96b9e0e3 config: treat user and xdg config
 permission problems as errors" busted git-daemon
Date: Fri, 12 Apr 2013 13:45:51 -0700
Message-ID: <7vli8ncwao.fsf@alter.siamese.dyndns.org>
References: <7vr4igfj9w.fsf@alter.siamese.dyndns.org>
 <20130412050550.GA15724@sigill.intra.peff.net>
 <20130412112636.GC20178@odin.tremily.us>
 <20130412144855.GA17968@sigill.intra.peff.net>
 <7vk3o7g29s.fsf@alter.siamese.dyndns.org>
 <20130412161600.GA20492@sigill.intra.peff.net>
 <20130412170505.GA2383@sigill.intra.peff.net>
 <7vbo9jehfx.fsf@alter.siamese.dyndns.org>
 <20130412190152.GB4108@sigill.intra.peff.net>
 <7vr4ifcytk.fsf@alter.siamese.dyndns.org>
 <20130412195854.GA7795@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "W. Trevor King" <wking@tremily.us>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Mike Galbraith <bitbucket@online.de>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 12 22:46:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQkr9-0007UV-B9
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 22:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998Ab3DLUpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 16:45:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59150 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753538Ab3DLUpy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 16:45:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB40816679;
	Fri, 12 Apr 2013 20:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bWNBY97IP85ntCgKHRt0GteM7po=; b=HvsKOz
	PNYuh2DoZqqXGi6JeoBJS3lTdKB8htUeZFYL+YM+wdDDrJZeGEj+UxCzFHDWRxDl
	h8G5ZvvR3t/hMg4So0EKbFaYylde+04/8YNh0KKkoV5921nOCldfnYuwT1XCEBrB
	w/QPZG0BcrArZ6OJkFemRvwiMSN8khLy0yMUw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eJDQwAllXumOZ/ATzLT6Xgsco4lOt65k
	TangO/lOMZEXBUs0CokVl0FsUzqhOtTrPqQLJaPk7eM2fHAwFo2S9j4PW+XccQEb
	utjkW8KMHj6XE7UFir8EEq/8RNKSvU/065yJbyhCurdJFml+EEcHgIXvmSmnUW6n
	JeBpOTbCKdE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C177816678;
	Fri, 12 Apr 2013 20:45:53 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 49A0816676; Fri, 12 Apr
 2013 20:45:53 +0000 (UTC)
In-Reply-To: <20130412195854.GA7795@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 12 Apr 2013 15:58:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F799CD4E-A3B1-11E2-B045-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221025>

Jeff King <peff@peff.net> writes:

> OK. I'll hold off for now while we stew on it. Jonathan's patch looks OK
> to me, but it has the same issue. But I think every path has to be one
> of:
>
>   1. We annoy sysadmins who need to take an extra step to handle the
>      HOME situation with --user (the current behavior, or any other
>      proposal that they have to opt into).
>
>   2. We annoy sysadmins who want to set HOME with --user, either by
>      making what they want to do impossible, or making them set an extra
>      variable or option to accomplish what used to work (my patch to set
>      HOME with --user).
>
>   3. We loosen the check, so some cases which might be noteworthy are
>      not caught (my patch, Jonathan's patch, etc).
>
> I think any solution will have to fall into one of those slots. So we
> need to pick the least evil one, and then hammer out its least evil
> form.

That summarizes our options nicely, I think.  Thanks.
