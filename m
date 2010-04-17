From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff too slow for a file
Date: Sat, 17 Apr 2010 10:10:32 -0700
Message-ID: <7vpr1y2eev.fsf@alter.siamese.dyndns.org>
References: <4BB00573.6040005@gmail.com> <4BC9D928.50909@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SungHyun Nam <goweol@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Apr 17 19:10:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3BXe-0004ZF-TC
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 19:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848Ab0DQRKq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Apr 2010 13:10:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34934 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185Ab0DQRKp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Apr 2010 13:10:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E9F1CAB13D;
	Sat, 17 Apr 2010 13:10:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=x6bClvAoWtCb
	NLJT5wUFOC+Wa7I=; b=WLaMoILtIeLWC3PcbvQfzBbB5nJNSw4hxq6NQGauU+G1
	VTGqHpoWZ83InPEqr3Q/wQbIedOsYtKV+CdfxhVR7NjfxRFUYOBTdm5AINVZdoBF
	STrBt6J8OgcDq0+gj241/P9ayLM9vXchh21q26AngDjUjogOnpf0KZ/qt62spu4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=daAvVe
	SUzqEURZPdYe1sGO6dx+0X1WBywdS87F3q3zg2qhABnvpPAG17ZqZIYmjSMQJ1xE
	5k45M3A0r5nI0sEHiikZMJW316+XGZG4b74lE2zlMWfYW3naey87UVFT6TAcAg66
	2SoTZ99JNmF6/e8dUp1rHAypqhgzlPeyPsbLE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B7DCFAB13C;
	Sat, 17 Apr 2010 13:10:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F2E0AB138; Sat, 17 Apr
 2010 13:10:34 -0400 (EDT)
In-Reply-To: <4BC9D928.50909@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Sat\, 17 Apr 2010 17\:52\:08 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 253A62B0-4A44-11DF-85B3-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145160>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Am 29.03.2010 03:42, schrieb SungHyun Nam:
>>  ...
>> Well, though the files are ascii file, they includes a random
>> hexa-decimal datas, so that I don't interest the diff result at
>> all.
> ...
> The following patch is not meant for inclusion, but rather to start a
> dicussion.  Is XDF_NEED_MINIMAL a good default to have?

This is a very valid question to ask.  The choice of the default was do=
ne
without any benchmarking nor analysis on performance impact at all.

What we should do next would be to:

 - see how much performance impact we have been getting from more norma=
l
   set of files (say, "git log -p" in the kernel archive) by our use of
   MINIMAL;  I suspect that git.git itself is too small to observe any
   meaningful difference.  We already _know_ that MINIMAL is more
   expensive, so this is not very important, but it would be good to
   know.

 - inspect the difference of the quality of output for not using MINIMA=
L,
   again for more normal set of files.  We know that the quality does n=
ot
   matter for pathological cases like the one in this thread --- the us=
er
   is not even "interested in the diff result at all".

Thanks for starting this.
