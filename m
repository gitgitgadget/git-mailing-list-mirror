From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Can I use tmp_packs in the git root.
Date: Mon, 24 Sep 2012 11:18:30 -0700
Message-ID: <7vpq5bz3m1.fsf@alter.siamese.dyndns.org>
References: <CABx=OHw7P5ZpdDZ8XOKT4T03FUfPNAo9oX2mLR7OB95bWkXG_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Shakthi Prasad GS <shakthi.gs87@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 20:18:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGDEw-000118-It
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 20:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757496Ab2IXSSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 14:18:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34857 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756754Ab2IXSSc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 14:18:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 976C2953B;
	Mon, 24 Sep 2012 14:18:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KytR0vHbaBhVT49hwpXx/pcue/U=; b=E5j84H
	DB6RxMTprwG9wvfZTT37ZkQiHR2whdMfjBFXiH6amPuv1eN49KbUR8ATCBTJfZ7z
	PI8ZE1E2aX8LoGoB9W5ULC8DdwQpGugejP/PdeVpTgUptYrmVNdaunrUVC1pFK0d
	OatFSpjr36NDq9UL0IiZ12Q9H2HEwg9MdN2KI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BebypYDvn7Cfv5SXoNy0pWyoOIysXGQh
	DH6iOv6+zfKIj1uUMDL45VBziOzz8Rb2wQUo8riUCuN3lhyAY3xOv614KFJLjDhn
	lf4OQV0CVFZkVBsmxHjA4TAl4AbhE0EW2APqn3oP9/tBqNDwA7/eTCtMQT64S0sp
	DpB7XZ+jWbs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 850F1953A;
	Mon, 24 Sep 2012 14:18:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 074759538; Mon, 24 Sep 2012
 14:18:31 -0400 (EDT)
In-Reply-To: <CABx=OHw7P5ZpdDZ8XOKT4T03FUfPNAo9oX2mLR7OB95bWkXG_w@mail.gmail.com> (Shakthi
 Prasad's message of "Mon, 24 Sep 2012 22:57:09 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3F2C3772-0674-11E2-92AC-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206304>

Shakthi Prasad GS <shakthi.gs87@gmail.com> writes:

> Basically I use, "cat tmp_packs*|git-unpack-objects" . Log indicates
> that, objects are unpacked.
>
> Am I doing anything wrong,

If unpack is all you do, then it won't help very much, as Git only
trusts objects that are reachable from refs.  You would need to also
make the tips of histories contained in the temp_packs* known to Git
by pointing at them from somewhere in refs/ hierarchy.

See how scripted version of "git clone" used to do this by studying
how contrib/examples/git-clone.sh uses refs/reference-tmp/ does the
same for handling "--reference=" option.
