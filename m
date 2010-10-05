From: Junio C Hamano <gitster@pobox.com>
Subject: Re: large files and low memory
Date: Tue, 05 Oct 2010 09:42:44 -0700
Message-ID: <7vfwwk7fqz.fsf@alter.siamese.dyndns.org>
References: <20101004092046.GA4382@nibiru.local>
 <AANLkTimbdrAqoWMxiteT5zNYmwHp8M698BEv1FLuiAxx@mail.gmail.com>
 <4CAA1BEB.3050908@workspacewhiz.com>
 <AANLkTi=nzyRgiBL07f2oeyjdUc8XnaKbJEJ+k8_g9rQ1@mail.gmail.com>
 <20101005005902.GC2768@nibiru.local> <20101005074144.GA22564@nibiru.local>
 <vpqpqvpf4qm.fsf@bauges.imag.fr> <20101005081700.GB22564@nibiru.local>
 <AANLkTin+i7VZApDRmairgpMth4MzPoDF=oHt-UHCt98E@mail.gmail.com>
 <vpqbp78x418.fsf@bauges.imag.fr>
 <AANLkTi=ni_21uP7oPrmB3obMscg0o9Z=uawkM2PoxWxT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Alex Riesen <raa.lkml@gmail.com>, weigelt@metux.de,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 18:43:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3Abe-0007kC-BX
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 18:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754682Ab0JEQnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 12:43:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34601 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754420Ab0JEQm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 12:42:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D5567DC31F;
	Tue,  5 Oct 2010 12:42:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R1eBJ77hrA795z1GzCb5pPwRjEo=; b=Kat42G
	SHSKxZ1uuTuh+5VNjip0DbPmHnEZzcHFMoljlBgCyyIKlzNe9e0ZkjyGEMnKJq/n
	J6VYONbU7Q68FeoSXBH/Sv1RTnUBiorw0Y1DYYVeiDR9E8oDGudDJ7rkFcnBO8iT
	EPjPN9sRvAnz1GoWG8vLtYWd+T5fOuh4Ik4dc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nenm+1YVvUkaP5sE9l0iA3djVbY7bmbM
	s+QGI/eFZ+VtfUzs7N3AFTUuIEpeioAE0IQw1ccE7cmu6LjjpW+tRcwQdQIq7phZ
	VXH4FNVo23mE93OeQrg52DPGofkPEN7hUpwmiVRVBXNCs4FSAWl8vwcWHUDwUNP2
	J14MofzWQw8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7835CDC31E;
	Tue,  5 Oct 2010 12:42:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 511F0DC31D; Tue,  5 Oct
 2010 12:42:46 -0400 (EDT)
In-Reply-To: <AANLkTi=ni_21uP7oPrmB3obMscg0o9Z=uawkM2PoxWxT@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Tue\, 5 Oct 2010 18\:55\:53 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 994B1F14-D09F-11DF-9EBA-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158214>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> I assume you do git-commit with no index modification at all. The
> index refresh part dated back in 2888605 (builtin-commit: fix
> partial-commit support - 2007-11-18). Commit message does not tell why
> index refresh is needed (for summary stat maybe?). If so, then we can
> skip refreshing if -q is given.

Most likely to give a clean index to post-commit hook.
