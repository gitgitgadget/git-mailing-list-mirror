From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Initialize notes trees if %N is used and no --show-notes
 given
Date: Tue, 06 Apr 2010 23:18:34 -0700
Message-ID: <7v39z7g4zp.fsf@alter.siamese.dyndns.org>
References: <20100405115548.GA19971@macbook.lan.lan>
 <201004061127.01471.trast@student.ethz.ch>
 <20100406111904.GA46425@macbook.lan.lan>
 <201004061352.21945.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Gilger <heipei@hackvalue.de>,
	Git ML <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Apr 07 08:18:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzObF-0003GB-QL
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 08:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154Ab0DGGSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 02:18:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43461 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753018Ab0DGGSs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 02:18:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B753DA807D;
	Wed,  7 Apr 2010 02:18:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=7Mu0aLQg5Pw95O/cj/B/JgSNAhk=; b=IRG3SBApHZDF459kbGgsxwU
	4hpmHx0aLFycNNrH+XtptEY6LDaKopNqyFe6bcbOOGzsHkiUR/RzYi+bteu1x7BF
	9Se3dAs0S4N7YKHd7IARstTUdhvLeONZj4wqOlv511cDWUriOxTUNtOuATqK0SyS
	jrv3BuxGgawogs47glWg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Cz+4cdDLv/pnYWva1Hz2Cgx+3f2Y2RirOHXrMK8yX76eAWLZb
	JoxrkXSVSfM3ohVp+P7txmPcijoGLA5GI/wkv/Rg08eDS0rSBgvKDm2m/Cejmdd3
	Ei/BuwalchNyH2gKILeC/jA0FHedg56hgkw7J1YZTrI5JgleO76WOsCGP4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 34D8FA807A;
	Wed,  7 Apr 2010 02:18:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F477A8075; Wed,  7 Apr
 2010 02:18:36 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6929A7E0-420D-11DF-954C-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144201>

Thomas Rast <trast@student.ethz.ch> writes:

>> I'd really like %N to do the initialization. There is no other
>> placeholder which requires an extra option to work, if I see it
>> correctly.
>
> %g[dDs] expand to nothing unless the log command walks reflogs, so
> there is some precedent.

As Peff pointed out, %d does things lazily, but I suspect it might be hard
to do a similar initialization for %N.

I wonder if we can inspect-but-not-use format string before we even start
walking, to see if we need notes (when we see %N).

None of the abouve applies to %g because making it cause reflog walking
will change not only the output, but the fundamental behaviour of the
command.
