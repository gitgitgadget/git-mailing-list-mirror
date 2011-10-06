From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revert.c: defer writing CHERRY_PICK_HEAD till it is safe
 to do so
Date: Thu, 06 Oct 2011 14:49:45 -0700
Message-ID: <7v4nzlzt6u.fsf@alter.siamese.dyndns.org>
References: <1317911641-47660-1-git-send-email-jaysoffian@gmail.com>
 <7vty7m12b2.fsf@alter.siamese.dyndns.org>
 <CAG+J_DxqpDAm-qPR-Udkr_b1gc=Y+LoKbsQdmiCi6ztNKz0_Mg@mail.gmail.com>
 <CAG+J_Dx0W0oRL-MkoZSGuOfmUNCqmMRUigmgND_0o7kbKppu1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, nicolas.dichtel@6wind.com,
	Jeff King <peff@peff.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 23:49:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBvpA-00034c-Uq
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 23:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759332Ab1JFVts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 17:49:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46582 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759260Ab1JFVtr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 17:49:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D0776DD5;
	Thu,  6 Oct 2011 17:49:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5VSGI2F+E/UAEDNRvQdwty7cnlA=; b=Paitgn
	WLBmlDHMwn5d5oavS4kApTLkQKqG+tsyHxs0IRkw58g3bR+sKfcw7wEuT0qzW2Ku
	w0/cr5H+4onnbGnVvMpnvJB54yoSGLuOJSYJzm2Gh38kgQu6DqZwPq5S5A9csxgS
	C4H81M0KhqD6LE+4Ix/XAihIZVtcklmWXrI3k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uTcprhECv1r7kLw0+aCzNm5yPWeO3TLQ
	eJraOhi4GIZwYzv1PylKzmHvWVtIEZJM1eXgH87FJoqC7TLbiJGVbgM1hlw+19KL
	U9MdI8WMDm7WRn2uAxmvuw8bhpbQ44s7b1ECoqA8czZYPF1f7DY/z4Gk2qrBko9o
	oOw+IhzLN0g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0436E6DD4;
	Thu,  6 Oct 2011 17:49:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 793A66DD3; Thu,  6 Oct 2011
 17:49:46 -0400 (EDT)
In-Reply-To: <CAG+J_Dx0W0oRL-MkoZSGuOfmUNCqmMRUigmgND_0o7kbKppu1Q@mail.gmail.com> (Jay
 Soffian's message of "Thu, 6 Oct 2011 13:33:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1B8375C2-F065-11E0-A4A9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183040>

Jay Soffian <jaysoffian@gmail.com> writes:

> For that matter, I don't see how to distinguish "the merge did not
> even start" from "the merge had conflicts" when using
> try_merge_command().

I suspect you figured it out by now (sorry I have been tending other
topics and general project maintenance issues), but in case you haven't,
the exit values from the strategy backends are returned straight back to
the caller. The strategy backends are supposed to exit with 1 when they
left the conflicts, and 2 when they punted and did not touch the index nor
the working tree.
