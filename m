From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] Add the 'fetch.recurseSubmodules' config setting
Date: Thu, 11 Nov 2010 10:31:22 -0800
Message-ID: <7v1v6rhfut.fsf@alter.siamese.dyndns.org>
References: <4CDB3063.5010801@web.de> <4CDB30D6.5040302@web.de>
 <20101111000216.GA14189@burratino> <4CDBA5FD.20802@web.de>
 <20101111082748.GA15525@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Kevin Ballard <kevin@sb.org>,
	Jon Seymour <jon.seymour@gmail.com>,
	Chris Packham <judge.packham@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 19:31:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGbw6-0008Un-Dy
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 19:31:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754747Ab0KKSbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 13:31:43 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63560 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754014Ab0KKSbm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 13:31:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 38AC03BBB;
	Thu, 11 Nov 2010 13:31:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bdkXT/wInU0mYFz+aeJQIJlOAgA=; b=k1zmkQ
	MhxMsyBVSzrsWrTmxTnSUWT0Iaq/6uMGAO21zDeDnu7HGfaUwOON00XKbWup2ObD
	kzsu66AisW9FNrxwGjl7ZL553mCP/7SHEgzSHIdpdVajrBQot1uWHJSe5OeCtnMi
	3cy2iTEgHG/KDwm7igvTAgwI16yU/7K2kG+Z0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BrtUeDE6SkEtEGbq7Z5B5+KD/W5jiEa5
	TqQE11ut5sUb/2fnU1Zpph/yfQd8Mgj6tOrmQX/RKwZ9p188lJaO0WcvtxSs4pBL
	TpL8nVh01xb9nk6xE9LAS6AelQwcDlAbFWKTUe8LguYFdwL96GosD1qDiWjv/WlD
	zNxeuGfcfio=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A675F3BB2;
	Thu, 11 Nov 2010 13:31:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A2D1F3BA9; Thu, 11 Nov 2010
 13:31:30 -0500 (EST)
In-Reply-To: <20101111082748.GA15525@burratino> (Jonathan Nieder's message of
 "Thu\, 11 Nov 2010 02\:27\:48 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EC7BF336-EDC1-11DF-80D9-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161288>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> "fetch.recurseSubmodules" is only read from .git/config. The one read
>> first from .gitmodules and then from .git/config is the per-submodule
>> setting "submodule.<name>.fetchRecurseSubmodules" added in 3/3.
>
> Sorry for the nonsense.  Would it be easy (or desirable) to make
> _that_ one not be read from .gitmodules?

I think the motivation behind having a way to read it from .gitmodules is
so that project can suggest the default for convenience (e.g. "almost
everybody who interacts with this project wants these submodules checked
out and kept updated").

Traditionally the suggestions kept in .gitmodules were propagated to the
config when the submodule was initialized, and at runtime we read only
from the config from then on without reading from .gitmodules, so that
once the user decides to follow what the project suggests (or customize
that away), the preference would stick to the repository.

That arrangement does not cater well to people who want to follow along
whatever the project's suggestion of the day, so we might want to change
things so that we if we find it in the config, we stop there and use what
we found, otherwise we use what is in the in-tree gitmodules; I suspect we
might require some changes to "submodule init" not to copy certain things
to the config for that to work, though...
