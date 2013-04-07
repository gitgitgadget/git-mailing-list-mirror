From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge-tree: fix "same file added in subdir"
Date: Sun, 07 Apr 2013 13:12:26 -0700
Message-ID: <7vk3oe2j85.fsf@alter.siamese.dyndns.org>
References: <0a6a0c978569906b8c8d9209a85338554e503236.1364419952.git.john@keeping.me.uk>
 <7vk3osjwgv.fsf@alter.siamese.dyndns.org>
 <20130327225739.GT2286@serenity.lan> <20130328093458.GV2286@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Apr 08 08:45:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5p8-0000sy-Fx
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934043Ab3DGUMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 16:12:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54583 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933955Ab3DGUM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 16:12:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AE7314434;
	Sun,  7 Apr 2013 20:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N4PYiA0nyWO19n7V/T6eGDkbZi0=; b=breYPz
	P/m9PR3mj9jpmhzoEkCSaVx0Mo91V/LUPo4gwuoYfXBLTlh8k3z3Ls5n5739A5DH
	7sVSloH03R6+Qm34FO1G/pW7hAs32JoxUo5AbsZvAMe+qsp7r1fflOQTP5J+by2k
	rzVbMEV4w7qaf3qaiOAZGHEHi4/3GonDWoJDg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CpjBYVWzLfJEG/HF0+lS5k/i5J4DZqkg
	ipSFArp0j3WS0P5Pua0wCK45rx2PHODpEIFYY9kXqIaseBPpQOTHi8J/+pdT1hjG
	zoXMMbh1z0OsJk5h07yvkeAWOH8f56i5ksSceSnzUWxdZlDpheqBw33iKRDptKgJ
	pA0epm+3lmI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1210714433;
	Sun,  7 Apr 2013 20:12:29 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 79D5014432; Sun,  7 Apr
 2013 20:12:28 +0000 (UTC)
In-Reply-To: <20130328093458.GV2286@serenity.lan> (John Keeping's message of
 "Thu, 28 Mar 2013 09:34:58 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 78945FD2-9FBF-11E2-A2F8-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220369>

John Keeping <john@keeping.me.uk> writes:

> Having re-read the manpage, I think you're right that we should just
> resolve the "both added identically" case cleanly, but I wonder whether
> some of the other cases should also be resolved cleanly.
>
> git-merge-tree(1) says:
>
>     the output from the command omits entries that match the <branch1>
>     tree.
>
> so you could argue that "added in branch1", "changed in branch1,
> unmodified in branch2" and "removed in branch1, unchanged in branch2"
> should also print no output.

Yes, that description explains what we wanted to achieve with
merge-tree that is still an unfinished experiment and fixing these
cases you identified above to match the stated goal is a good thing
to do.  I've been meaning to find enough time to do a new merge
strategy backend based on the logic of this program, and the few
patches I sent out on it recently were fallout from preparatory
steps for it.
