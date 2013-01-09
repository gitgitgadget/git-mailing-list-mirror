From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 19/19] reset [--mixed]: use diff-based reset whether or
 not pathspec was given
Date: Wed, 09 Jan 2013 12:27:31 -0800
Message-ID: <7vvcb63xvw.fsf@alter.siamese.dyndns.org>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1357719376-16406-20-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 21:27:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt2Fe-0006pF-Tb
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 21:27:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433Ab3AIU1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 15:27:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59792 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932106Ab3AIU1e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 15:27:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6289BD7C;
	Wed,  9 Jan 2013 15:27:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rhim/aOhWDt+EzU81asV0jrkgdo=; b=TW9AlJ
	5T++QuI9RpoXPcfaBlFO3R23SEv3yweDhnNuj4e3TJNQ6Q4Cjl4JbzPwCVXmW2me
	enE08m5N9VrTnlk7ZuNwyC1T5RVqclY6a49idfumhfD3+ScLDnTSLvEmFCQ9dENH
	VwIJ7Q3YsRbe2jM72rcEid3bvad8ks5684Fbk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mw8D+gTJqFHVfuxAtWvaMn9frw0fpbi+
	CnIS3kQEpoZcjvKnUj5BpzC9nQsIBBA33cwh1VsjuoUpV1tpIoYqhcPBitCDIFUW
	/jFBYVgXMm2vZtJ7iOAqOpvL9QM1UYffZ7LKrQD22eXVKQ1Dge0Mt9iualRf/Ibu
	pcrl8tj1AHA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAC06BD7B;
	Wed,  9 Jan 2013 15:27:33 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4CCE8BD79; Wed,  9 Jan 2013
 15:27:33 -0500 (EST)
In-Reply-To: <1357719376-16406-20-git-send-email-martinvonz@gmail.com>
 (Martin von Zweigbergk's message of "Wed, 9 Jan 2013 00:16:16 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF89C280-5A9A-11E2-94AB-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213100>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> Thanks to b65982b (Optimize "diff-index --cached" using cache-tree,
> 2009-05-20), resetting with paths is much faster than resetting
> without paths. Some timings for the linux-2.6 repo to illustrate this
> (best of five, warm cache):
>
>         reset       reset .
> real    0m0.219s    0m0.080s
> user    0m0.140s    0m0.040s
> sys     0m0.070s    0m0.030s

Nice.
