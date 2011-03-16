From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] system_path: use a static buffer
Date: Wed, 16 Mar 2011 13:43:07 -0700
Message-ID: <7vipvi7q5g.fsf@alter.siamese.dyndns.org>
References: <AANLkTinEMzezKdfGUrwKv7sJ+tSK5duYM6XZMvBa-yj3@mail.gmail.com>
 <1300293183-26354-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Mar 16 21:43:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzxYx-00032p-0q
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 21:43:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752851Ab1CPUnT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 16:43:19 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49932 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab1CPUnR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Mar 2011 16:43:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9FC824BE6;
	Wed, 16 Mar 2011 16:44:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=C47Q/euooNk5
	EnpM4Q/QfW59jLI=; b=sQ2CB+PWy8FJz1Qlp45Q1/totMiLzfAWOBplPVPlwvks
	MqNcygIVclGcYmrEwid5RKasEZbeCxXsWCuBc0C8fywzth3VrOhXtLRERA1nDYuj
	VMLKPjliWR4Mz5HmUxxqn9wKqBhn7b02oOoREgl8FcfGNsnTFgB+X1xfurihG7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=GyxTB8
	OmWhHR07juIhRFBxiZtadMu0LFLghaVSVaAJ34IR7Hk2FV9tCV0awDiYgp0bwevH
	rP7sJhJnkv+ys7SRCboigqRvHkjag82jb9aqdkDHUGX+WTZuBOR0vhFbkEbhVU7x
	VrMo5UGx6nA3UQ9m0k2KZ4tMVtHV6iBUpFZv0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6FBC14BE1;
	Wed, 16 Mar 2011 16:44:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 594084BDF; Wed, 16 Mar 2011
 16:44:42 -0400 (EDT)
In-Reply-To: <1300293183-26354-1-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Wed, 16 Mar 2011 17:33:03
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3A95C3E0-500E-11E0-8CEF-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169190>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> Make system_path behave like the other path functions by using a
> static buffer, fixing a memory leak.
>
> Also make sure the prefix pointer is always initialized to either
> PREFIX or NULL.
>
> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
> ---

Have you made sure all the callers are Ok with this change?

If somebody called system_path(GIT_EXEC_PATH), saved the result in a
variable without copying, and then called system_path(ETC_GITATTRIBUTES=
),
his variable may now have a value unrelated to GIT_EXEC_PATH, and you
would fix all such callers to save the value away with strdup().
