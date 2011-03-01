From: Junio C Hamano <gitster@pobox.com>
Subject: Re: problem with updating a shallow clone via a branch fetch
Date: Mon, 28 Feb 2011 16:25:17 -0800
Message-ID: <7vtyfng00i.fsf@alter.siamese.dyndns.org>
References: <AANLkTinx01bzzLKk=DfyEvfSz8Hun-YqzJfEDpX7gNSS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rick Bradley <rick@rickbradley.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 01:25:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuDPA-0005Lp-Eb
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 01:25:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753639Ab1CAAZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 19:25:26 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57206 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753350Ab1CAAZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 19:25:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 73C5F4D63;
	Mon, 28 Feb 2011 19:26:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PdEg65f5znQtSgmDHiFRruToAgE=; b=OVwJrD
	Jnre3oP4FUsWZEWx4yDLLXjBhGuWzQZs3soJv/2iVhcHIrECSSP6hGAgr/09z3UC
	+rHhwC/qZLEEfKDKb3Ce51ZHGELD/BPw3IWEeTgkZxI6CLQ0ZaGwMZ0d7e3cpRZ2
	hDEPYJ6Yn7092Rr3BgB2Pd6oC9clqR+gUh7JU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=etmUg7emlQxDPn6Xlvy2nS7AgkIBICy2
	tZl8wDv+Jd0kJ10iKSiy2DgSwKfAyAihdlmJUMJ/nHD/EoKgmxB6L3ccpVQMGyGg
	djbJDsfti0VySZBKC3bCUSBz+FnlRz1XA+J6PhpAFHm6ASF223mb5ig+jHZDVcT/
	d4jx23UYbjY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5174E4D62;
	Mon, 28 Feb 2011 19:26:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 71DBD4D61; Mon, 28 Feb 2011
 19:26:38 -0500 (EST)
In-Reply-To: <AANLkTinx01bzzLKk=DfyEvfSz8Hun-YqzJfEDpX7gNSS@mail.gmail.com>
 (Rick Bradley's message of "Mon\, 28 Feb 2011 18\:12\:21 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 94490DBE-439A-11E0-AEF5-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168169>

Rick Bradley <rick@rickbradley.com> writes:

> So I have a git repo that is shallow cloned:
>
>   % git clone --depth 1 <repo url>
>
> Sometimes (very rarely), when I do a branch fetch to update that
> repository I get an error:
>
>  % git fetch origin +refs/head/<branch>:refs/remotes/origin/<branch>
>
> fatal: did not find object for shallow <hash>

The message comes from the repository you are fetching from.  When you
fetch from a shallow clone, the fetch process on your end tells the other
side what commits your incomplete history ends at, and if the other end
does not have any of these commits, you get that message.  So the only
case (unless there is a bug---and I don't think this codepath is heavily
exercised so it is very possible there are bugs) you would see that
message is if the other side rewound the branch and then later garbage
collection lost the commit.
