From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Restructure some of the checkout opts.
Date: Sun, 05 Sep 2010 23:25:23 -0700
Message-ID: <7v39tnwfqk.fsf@alter.siamese.dyndns.org>
References: <9f6f4947af20df9dc0ebd8915dcdb9b5f756d35d.1283688482.git.jaredhance@gmail.com> <4C838BE9.5000006@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jared Hance <jaredhance@gmail.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Sep 06 08:25:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsV9C-0000gt-4J
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 08:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224Ab0IFGZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 02:25:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58693 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107Ab0IFGZf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 02:25:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 44733D3A9D;
	Mon,  6 Sep 2010 02:25:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iyAVtTYoVj4+XaL0pwWpZsYznr0=; b=doV8fT
	ZHGox0FkL2g9S3Hgsj53axz/y8tmo7r4Lsy5BAyl5Yn/wFX94ggdbl6xFcjLuRk2
	z/XYo/7Q9HyDb4HQwOM65xGwMrhz82VJK1JcWr+m0od5p+dzyVDOyfnLIjqvPQwy
	HIKApG5WbgrE2JMSKhR1IiagP+8IAkzQGSsmY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fnJ6wcnpfwJScknU539OmYvB0AktBl/m
	ynBW0Du8xTtGvS1Y+/09HyNPQdJAjEXXzzvrqkhyAoVwepY2wqTkWFPI1GeOD2eP
	Ul1om8yCQOIGanZH7jBPBh0YSM9sFJG1ymWU01W4MR13E6iO1Lb4bVUkOxRiPerg
	UMcSm8o2yeA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D49CD3A9C;
	Mon,  6 Sep 2010 02:25:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E06FD3A9B; Mon,  6 Sep
 2010 02:25:25 -0400 (EDT)
In-Reply-To: <4C838BE9.5000006@web.de> (Jens Lehmann's message of "Sun\, 05
 Sep 2010 14\:24\:09 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8C4CF116-B97F-11DF-BE60-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155534>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 05.09.2010 14:09, schrieb Jared Hance:
>> Previously, most opts in `builtin.checkout.c' had been an instance of
>> `struct checkout_opts'. It appears that some of the opts that were
>> perhaps added later were not in the struct. Move them into the struct
>> in order to maintain consistency.
>
> Hm, they aren't used outside of cmd_checkout() (as the other members
> are), so maybe it is ok that they aren't in the struct?

Correct.  I do not think they are outside the structure because they are
overlooked.

They simply do not make sense outside the context of "builtin/checkout.c"
where "struct checkout" is used (e.g. what would patch-mode possibly mean
in the context of "builtin/apply" where the struct is used to check out a
path that is not checked out to the working tree).  Moving them into the
structure would thus make no sense and _will_ confuse people.
