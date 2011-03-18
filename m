From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] system_path: use a static buffer
Date: Fri, 18 Mar 2011 00:25:32 -0700
Message-ID: <7vpqpoyjo3.fsf@alter.siamese.dyndns.org>
References: <1300359664-6230-1-git-send-email-cmn@elego.de>
 <1300371853-8965-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Mar 18 08:25:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0U4C-0007bQ-Um
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 08:25:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756377Ab1CRHZo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2011 03:25:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64738 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756307Ab1CRHZm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2011 03:25:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0DCDD2483;
	Fri, 18 Mar 2011 03:27:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=xt0Pzmr6LBjFQalPEYLxq35n5
	B8=; b=eD3Gd7/jWV+LLJjgE6ats7Omdj7UCtFWOnfW2bmuaqrx/oqR8CHmjBm5Q
	yqC9UsKsQ5CgIkYhtZDO06LvLzdJouixggRvd7JX4u58vbQ7kJ7Cbe2vlk0hwLXn
	o8zO1KdioHFFZTDdZiaYQAY13igoKRwR7D3ywSFoYmpQIauXOw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=coqdkp5uEeQIKb1ouJ2
	5d0NpFAsEG0DiogC725gXWz9Cd+e8FZXCu/BDIk3nZAgcQLmIlx2aCwJm3DyR0yZ
	DyUUN4K2mpNm+nrqVn5Kbf8fZvUhglY+B1q7+JjR6ovKaIZz7Hj9CY8pFqBZpIZw
	z8getxkO7bjNxRYwTFv/GW/w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CEE122482;
	Fri, 18 Mar 2011 03:27:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BC6DD2481; Fri, 18 Mar 2011
 03:27:07 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 23D287C8-5131-11E0-A25F-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169297>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> +	ret =3D snprintf(buf, sizeof(buf), "%s/%s", prefix, path);
> +	if (ret >=3D sizeof(buf))
> +		die("system path too long for %s", path);
> +	else if (ret < 0)
> +		die_errno("encoding error");

POSIX says snprintf() should set errno in this case, and your use of
die_errno() would show that information, but what is "encoding error"?

Just being curious, as I suspect that "snprintf() returned an error" ma=
y
be more appropriate, if the answer is "I don't know what kind of error =
it
is, but snprintf() found something faulty while encoding so I chose to
call it encoding error".

By the way, thanks for checking all the callers.
