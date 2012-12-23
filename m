From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] learn to pick/revert into unborn branch
Date: Sun, 23 Dec 2012 11:35:16 -0800
Message-ID: <7vvcbso93f.fsf@alter.siamese.dyndns.org>
References: <1356117013-20613-1-git-send-email-martinvonz@gmail.com>
 <1356117013-20613-2-git-send-email-martinvonz@gmail.com>
 <7vr4mhpi0l.fsf@alter.siamese.dyndns.org>
 <CANiSa6i0-Z=FkPnSJxgT+3ABHTzgOTNNNUb=wHQpm2DKAN_UOw@mail.gmail.com>
 <7v4njcpof8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 23 20:35:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmrKr-0007MO-Dd
	for gcvg-git-2@plane.gmane.org; Sun, 23 Dec 2012 20:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310Ab2LWTfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2012 14:35:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33270 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752215Ab2LWTfT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2012 14:35:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EFB54987A;
	Sun, 23 Dec 2012 14:35:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XPnlmboYfK+ui1Ic6uvFEdUFumw=; b=afiUbf
	FfVXFHg4THBh1ytA1/jOldKQvR2rMz6pXBh060oJWZvSdptsxb0UeBPzCVm2rUU2
	Op4wzqXsco2vpXmfLSicDabRZdzj72kKckkCgU+xYNSXHqM4UAHtqWP7eQUbdtwv
	ET4YA3thV/SfRYuBHPpj4toqnzPhhNgXzKudg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZCtU4pKmoqKPmedquQVXXPc225gNyr7j
	qEBRNV5mULNNpwk2Ho+cjFYkVKcbq5CPuGvoADlSBLPVnvAyavSJ0NgNp/t3PAjG
	BinoGhD/MEjDecztxaLevG7b2Z0KHTZ9MdBzFfV6orzC+8NIXcu5E3WRTR4AFAN3
	l+CXFRbAzig=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDAC29879;
	Sun, 23 Dec 2012 14:35:18 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 448B39878; Sun, 23 Dec 2012
 14:35:18 -0500 (EST)
In-Reply-To: <7v4njcpof8.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 23 Dec 2012 11:18:51 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E1E3CCFA-4D37-11E2-ACF5-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212088>

Junio C Hamano <gitster@pobox.com> writes:

> Yes, and I do not think it is an implementation detail.
>
> I am not opposed to an "internal use" of the cherry-pick machinery to
> implement a corner case of "rebase -i":
> ...
> In step 4., you would be internally using the cherry-pick machinery
> to implement the step of "rebase -i" sequence.  That is what I would
> call an implementation detail.  And that is cherry-picking to the
> root.  It transplants something that used to depend on the entire
> history behind it ...

Just to add another example, I do not think I would be opposed to
the case where you "edit" the root commit in the above example,
i.e. keeping the "Hello world" as the root commit, but modifying its
tree and/or log message. The internal impemenation detail has to
first chery-pick that existing commit on top of a void state before
it gives the user a chance to tweak the tree and commit the result
with a modified log message.  Just like "commit --amend" can be used
to amend the root commit, it logically makes sense the recreated
commit records nothing as its parent if done when HEAD is not valid
yet.
