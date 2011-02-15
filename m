From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] mergetool: don't skip modify/remove conflicts
Date: Tue, 15 Feb 2011 12:12:18 -0800
Message-ID: <7vbp2dnjkt.fsf@alter.siamese.dyndns.org>
References: <1297134518-4387-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297570198-21103-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297570198-21103-2-git-send-email-martin.von.zweigbergk@gmail.com>
 <7v1v3aqfqm.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.1102142204240.7843@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 21:12:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpRGE-0007mN-Lc
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 21:12:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755633Ab1BOUM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 15:12:29 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46722 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783Ab1BOUM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 15:12:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5EB6A39BC;
	Tue, 15 Feb 2011 15:13:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6bPEojiYweofcxlAvtOMihX/WAg=; b=NMBhwz
	35C8BFMbY32/bIEL1ZJQhFHx35aUEPuHiBEESla7Y3WBLq11UIpTVZwlme2l6Mpk
	LF0FN0JKsdyGMnLB1/vxsgpFSH94rY6TLZ57UwTzdl/fwpNf2IzKQCYchlC9AtpQ
	0Mb45oTEyof2ByTV0NxU4ol6L0Loef+9LLOTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SiTA6F0NvAP6enDd+s9tKX8G+6pbADKP
	T0BSmUljwUfldzCPywfxckxMG+oTEUah+vz8jgfqC70IKqdAbdpf6Ivfzwi5Q0qY
	xqfG+8zILFg9hwdWv4gM9j8YuUf7UJEQmItS4CAq+mMwUX65IzoSXySeuQsoA8lk
	OaXNF9WKwkc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 265CD39BB;
	Tue, 15 Feb 2011 15:13:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0362B39BA; Tue, 15 Feb 2011
 15:13:25 -0500 (EST)
In-Reply-To: <alpine.DEB.2.00.1102142204240.7843@debian> (Martin von
 Zweigbergk's message of "Mon\, 14 Feb 2011 22\:30\:55 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0E43ADD2-3940-11E0-9FF6-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166873>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> On Mon, 14 Feb 2011, Junio C Hamano wrote:
>
>> But shouldn't you also revert the parts of my patch to do_plain_rerere()
>> and rerere_forget() that have similar special cases?
>
> Yep, done in patch 2/2.
>
> Your changes in find_conflicts() are still there after patch 1/2 and
> since do_plain_rerere() and rerere_forget() call find_conflicts(), I
> think they need to check for the punted paths. Only the callers of
> setup_rerere() no longer need to care.
>
> In patch 2/2, I refactored a bit more, so that find_conflicts()
> behaves the way it did before your first patch, and then the checks
> for punted paths are removed from the callers.
>
> If you think the second one is good, it could easily be squashed with
> the first one.  I left it separate because I wasn't quite sure.

Probably the changes to rerere proper from all three patches should be
squashed into one, and then the patch to the script to use the new feature
can be applied on top of it.
