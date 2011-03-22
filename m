From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Actually use retval
Date: Tue, 22 Mar 2011 11:10:08 -0700
Message-ID: <7v7hbrkovz.fsf@alter.siamese.dyndns.org>
References: <cover.1300798069.git.johannes.schindelin@gmx.de>
 <91afab0d46939238dd7c90ea2902b02cae083316.1300798069.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 22 19:10:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q262B-0002zj-Ox
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 19:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754715Ab1CVSKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 14:10:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61823 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382Ab1CVSKS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 14:10:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9A6024AFE;
	Tue, 22 Mar 2011 14:11:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PRsXwgtStkd3rEBwAzsW1jebACk=; b=R4nt7p
	kIv9AlIqd5lbRV6ORiwjg2PZmMnA5c7fXcTZ+Umvs38qrktT/r4YsDt0F512qqqA
	0Qm+d7bwMZ/cZxOau7MmYFPVvuLOjK+PDeOkar0qtct78fkIaqARNb8igA/r7tOo
	GCt1J9tPeR5pKbvjvkSosHHaCI6Q1nToQBou0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EtoakG07zRDTpMAA3y+ULmXT4XJ4bsaJ
	wyLHmnQ962vMlgIaQPXA7Bk7Y9910E3WcxdqtIwrGzlCr3YVGaWWxK74TcxgbD7J
	4zpcFPfrus14fRRtR8nOG37qJ++1rAvmq1Fj+LGsTO/APFcKivP8IgQ+rTPvDiOy
	J0xYRkfplzk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 77C8B4AFD;
	Tue, 22 Mar 2011 14:11:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 575424AFB; Tue, 22 Mar 2011
 14:11:49 -0400 (EDT)
In-Reply-To: <91afab0d46939238dd7c90ea2902b02cae083316.1300798069.git.johannes.schindelin@gmx.de> (Johannes Schindelin's message of "Tue, 22 Mar 2011 13:50:46 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DCF29FB4-54AF-11E0-8E23-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169756>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This is most likely a bug. Nocited by gcc 4.6.0.

While I don't doubt gcc 4.6.0 found the retval assigned is not used, I
think you misunderstood the value returned from this function.

The caller uses the return value to decide if an entry from t1 (and not
from t2) was consumed, if an entry each from both t1 and t2 were consumed,
or an entry from t2 (and not from t1) was consumed.  It doesn't change the
fact that the entry at the beginning of each tree we looked at in this
function at that point shared the same name and we consumed them, whatever
the call to diff_tree_sha1() to run a recursive comparison between the
trees found.

The likely fix would be to remove assignment to retval instead.
