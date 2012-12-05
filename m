From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/2] reset: learn to reset to tree
Date: Tue, 04 Dec 2012 21:46:20 -0800
Message-ID: <7vtxs1kq4z.fsf@alter.siamese.dyndns.org>
References: <CANiSa6isDKAgxHWqh5XiQ-adT3-ASFtvAshp028DTcotjQxzmQ@mail.gmail.com>
 <1354213975-17866-1-git-send-email-martinvonz@gmail.com>
 <1354213975-17866-2-git-send-email-martinvonz@gmail.com>
 <7v4nk8qmaj.fsf@alter.siamese.dyndns.org>
 <7vzk20p6ik.fsf@alter.siamese.dyndns.org>
 <CANiSa6hWYsfm0t+s_q7=CcD78yNfpuduxkRc35xW8qDOy97W3g@mail.gmail.com>
 <CANiSa6i2f-4jXFUpYV6+fYnpG-tSRRA3cRg_v-v=UrgfwfFz_g@mail.gmail.com>
 <7vd2yunn0e.fsf@alter.siamese.dyndns.org>
 <CANiSa6iMxzQGM8mZYdfR-drPGgydwVpM5JsQ-8oO09MX5XDH+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 06:46:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tg7oe-0004s4-8Q
	for gcvg-git-2@plane.gmane.org; Wed, 05 Dec 2012 06:46:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168Ab2LEFqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 00:46:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53271 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751666Ab2LEFqX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 00:46:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC583AE5A;
	Wed,  5 Dec 2012 00:46:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aA0uaGEVkVkGX463s2Vm+OT7jvQ=; b=ZSvTy7
	ahJ7w/HmL0qdncfgVVyuE5VYzvuREFhHXP/VG2LrHjCQgpuUvctLOKHTBPbSvj9u
	tFZf6AoNJ3kUuik/zwXP1BGlPXLBlxqz3YqL1bTEBOXILPRqqVlpf/iZlVBRfUJz
	ZE+qG8i6iyx8ja0u1K7IMgJCuMPWvhbTRsZOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ks300jiLt41jHT6BO1C4L+QFqUfUmRJq
	fN/lWycM9eN/GOnguXjztveTYhdf9QiN/9nRV30sDwmYwVhUc9Wrvl+Py9/nMhvN
	C7wH21mM/4p/d2r5WX6zCNYxmns47a7WWSoQecnb1To0tLnaEYgiswvYQRvj4Sp2
	RfGB9jwwMeo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A8F6AE59;
	Wed,  5 Dec 2012 00:46:22 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 04EE6AE55; Wed,  5 Dec 2012
 00:46:21 -0500 (EST)
In-Reply-To: <CANiSa6iMxzQGM8mZYdfR-drPGgydwVpM5JsQ-8oO09MX5XDH+g@mail.gmail.com> (Martin
 von Zweigbergk's message of "Tue, 4 Dec 2012 19:45:47 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1955514C-3E9F-11E2-A3BC-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211105>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> More importantly, when is it desirable not to delete deleted entries?

When I am trying to check out contents of Documentation/ directory
as of an older edition because we made mistakes updating the files
in recent versions, with "git checkout v1.9.0 Documentation/", for
example.  Perhaps somebody had this bright idea of reformatting our
docs with "= Newer Style =" section headers, replacing the underline
style, and we found our toolchain depend on the underline style, or
something.  The new files in the same directory added since v1.9.0
may share the same mistake as the files whose recent such changes I
am nuking with this operation, but that does not mean I want to
retype the contents of them from scratch; I'd rather keep them
around so that I can fix them up by hand.

I would have to say that it is more common; I do not recall a time I
wanted to replace everything in a directory (and only there without
touching other parts of the tree) with an old version, removing new
ones.  "git checkout [$commit] $paths" is still an operation to help
me build new history forward starting from HEAD, and is not about
start building on top of the old $commit.  Losing the work I've done
to the files that did not exist in $commit:$paths is almost always
*not* what I would expect to happen with the command.
