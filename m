From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revert "pack-objects: fix pack generation when using
 pack_size_limit"
Date: Mon, 08 Feb 2010 09:43:57 -0800
Message-ID: <7v3a1bpqqq.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.1002081032530.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Feb 08 18:44:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeXem-0007E3-Oi
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 18:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166Ab0BHRoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 12:44:05 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37300 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087Ab0BHRoD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 12:44:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E50D9899D;
	Mon,  8 Feb 2010 12:44:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=6SejHkWj5waQHizz7mozWi12Hhg=; b=hXw1Qd5hG5a6ObqAMG7ZZgp
	d5I8XjE6rttOc9t8svTYhSQ2K/gE7s7LFntjOpBi74wUuald6Pw8/vUoaZmbV/ca
	EsXPrXvoBqO7A2TgMuBEpGgOOUybLQPwU9q3+yoeJxlGa8ZUC4VBq758CiUNh76Z
	VAXSxc05BvLsF7/oVcZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=fe0dGPro2v4QGl68T+hmJ2rOWiaDeCtuC1CUtcvZdrJ4Hbnns
	4dE6/ZmLdVZ5+CuY257ovlQ6blx+iD1RbgnfeLbMVldbIWqaZCUcH41T0j2Fkrfv
	TLhyVcyP3HV/fYJvAZLwyJIgAZfVlkiJMqHyHzKI0ATV4QnoWkHzrhDJkc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B7D598999;
	Mon,  8 Feb 2010 12:44:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 68BF898995; Mon,  8 Feb
 2010 12:43:58 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8A98A950-14D9-11DF-8EB4-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139301>

Nicolas Pitre <nico@fluxnic.net> writes:

> This reverts most of commit a2430dde8ceaaaabf05937438249397b883ca77a.
>
> That commit made the situation better for repositories with relatively
> small number of objects.  However with many objects and a small pack size
> limit, the time required to complete the repack tends towards O(n^2),
> or even much worse with long delta chains.
>
> Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> ---
>
> Fixing this doesn't appear to be as trivial as I initially thought.
> Although I do have some ideas, they're not appropriate so late in 
> the -rc period.

Ok, so the idea is what a2430dd tried is an issue worth addressing but the
particular execution wasn't good?  We revert it for now, but we will try
again after the release, perhaps doing it differently?

I agree with it if that is your intention, but "Most of" bugs me a bit.
