From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Fri, 19 Feb 2010 09:52:10 -0800
Message-ID: <7vzl35jeph.fsf@alter.siamese.dyndns.org>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
 <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
 <201002181114.19984.trast@student.ethz.ch>
 <7vtytee7ff.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002181456230.1946@xanadu.home>
 <7v635ub8oa.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002181604310.1946@xanadu.home>
 <20100219010456.GA1789@progeny.tock>
 <20100219152609.GC11733@gibbs.hungrycats.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Thomas Rast <trast@student.ethz.ch>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: Zygo Blaxell <zblaxell@gibbs.hungrycats.org>
X-From: git-owner@vger.kernel.org Fri Feb 19 18:52:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiX1m-0000vB-DI
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 18:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505Ab0BSRw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 12:52:29 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53859 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754367Ab0BSRw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 12:52:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 02EEA9B44B;
	Fri, 19 Feb 2010 12:52:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=1cq/flc6db1OSdtpT+Ltw5tRddM=; b=KDBXoj/SzTYER90zZTRc4EQ
	MAFRLqoJcOfqkoXHjnfOWRk5Zuytb1CpPAxsflewWrsspbh8v84kbCUEFbm431ca
	bXLJjyUXPadC2E3RXrIIVDQyehg/Mcdjf1NaY4Fw3Izvte4haFhmuX/A9Lh5td+8
	44+13DEBlqrdc6HDYBB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=QUfGayegI1LdYu/RPZVe9CBTYdjTfOQb8No5jSLdApchkiLCp
	Q2WlQIlaQoOb9GduT51Fk2ylofnK83WqoaG1InhV5TszvO68PCJpzYKcpWAAlM0O
	P/zqSFNXu/ZxFVtPZw9EBVhWfrMxysupOEIMf8iLHfr2y1jxu1LYVenRWw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 71B639B43D;
	Fri, 19 Feb 2010 12:52:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E61AA9B42B; Fri, 19 Feb
 2010 12:52:11 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 86D155FC-1D7F-11DF-AA33-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140473>

Zygo Blaxell <zblaxell@gibbs.hungrycats.org> writes:

> As far as I can tell, the index doesn't handle this case at all.
> ...
> racy-git.txt doesn't discuss concurrent modification of files with the
> index.  It only discusses low-resolution file timestamps and modifications
> at times that are close to, but not concurrent with, index modifications.

Correct.  As I said a few times in this thread, a use case with concurrent
modifications is outside of the original design scope of git.

As you may have realized, racy-git solution actually _relies_ on lack of
concurrent modifications.  The document does not even _talk_ about this
assumption, exactly because at least back then it was a common knowledge
shared by everybody that users are not supposed to muck with files in the
work tree until they get control back from git and they can keep both
halves if they get a new broken loose object if they did so ;-).
