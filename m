From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-submodule.sh respects submodule.$name.update in .git/config but not .gitmodules
Date: Wed, 11 Dec 2013 17:16:08 -0800
Message-ID: <7vtxeeuaw7.fsf@alter.siamese.dyndns.org>
References: <CABYr9QtSeX=Euf73MZPq6suo+GpVA=f+tH73Ct0tP-3LYogh9w@mail.gmail.com>
	<20131209223506.GF9606@sandbox-ub>
	<xmqqlhztvbi8.fsf@gitster.dls.corp.google.com> <52A8E689.80701@web.de>
	<20131211224424.GB25409@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Charlie Dyson <charlie@charliedyson.net>, git@vger.kernel.org
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Dec 12 02:16:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vqut2-0007WE-5O
	for gcvg-git-2@plane.gmane.org; Thu, 12 Dec 2013 02:16:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300Ab3LLBQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 20:16:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62566 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013Ab3LLBQP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 20:16:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9893B5AA0C;
	Wed, 11 Dec 2013 20:16:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fHL//ydD588k8pLJHENUqNsJumA=; b=AExJqw
	Q3wrHrrmHYe1v2q04/lmO5GL/6fe4tkKVlcZnU3J9AfirUktcHqf8njeeif1qpaN
	baGaffnEVYub4mOeON5H4DXVo2B5t6C35HGq4ZEJQ7tlW+jELDB7Em7YDfKxL8Ru
	hvlKd6grLnDYdCeZJlud76R/s5UPA2O1DTwtM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uSDM77LDAdtK2EN9V3LxV8LX/qCYbmZx
	4Lc0QBB0nHJpsaufloraFXXPBmUC+km/oFfzpdJbypHQhaTVsMHb6Xou8GecC/C9
	K+3CR8MqIlLmFpVcIW7ARFaz+lA2hkauUANGcn1zUhnS94nBgSY6Aa4Ukf2zafhI
	qrkQyPVGrfE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7960D5AA0B;
	Wed, 11 Dec 2013 20:16:14 -0500 (EST)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8628E5AA08;
	Wed, 11 Dec 2013 20:16:12 -0500 (EST)
In-Reply-To: <20131211224424.GB25409@odin.tremily.us> (W. Trevor King's
	message of "Wed, 11 Dec 2013 14:44:24 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FD67BFAA-62CA-11E3-A46B-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239221>

"W. Trevor King" <wking@tremily.us> writes:

> For
> safety, maybe the default `init` should copy *everything* into
> .git/config, after which users can remove stuff they'd like to
> delegate to .gitmodules.

Copying everything into config is "be unsafe and inconvenient by
default for everybody", isn't it?  Folks who want safety are forced
to inspect the resulting entries in their config file (which is more
inconvenent if you compare with the design where nothing is copied
and nothing dynamically defaults to what then-current .gitmodules
happens to contain).  Folks who trust those who update .gitmodules
for them are forced to update their config every time upstream
decides to use different settings in .gitmodules, because they have
stale values in their config that mask what are in .gitmodules.

I think the solution we want is to copy only minimum to the config
(and that "minimum" may turn out to be "nothing"), and to default
keys that are only absolutely safe to .gitmodules file.
