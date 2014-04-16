From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitignore vs. exclude vs assume-unchanged?
Date: Wed, 16 Apr 2014 10:51:53 -0700
Message-ID: <xmqqy4z5go1y.fsf@gitster.dls.corp.google.com>
References: <b3f480af1c362c615ad9ce85296e2be2@bellandwhistle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: alex@bellandwhistle.net
X-From: git-owner@vger.kernel.org Wed Apr 16 19:52:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaU0B-0005zF-Cg
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 19:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350AbaDPRv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 13:51:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44392 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752120AbaDPRv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 13:51:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA8AD7B03F;
	Wed, 16 Apr 2014 13:51:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DRAaRBewQWThfpkpa4tt9G4rQxs=; b=KvINxm
	YKkLB4SDC/Yss28LmdzgWQ0+GCn4YYIEGSQGYBVgdT7XuLc8BVw3BZhkqifv0RKb
	CZYej/iMb3Q6h6/bkXXhfBcKlJeQJLdHZR0PTCdsAomJIhCzFhBt4xC/B8sljxGN
	Jc3A0esqjz4syRAZBYdDNISJCEATMskEpVDfc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QEP47ww5WkXaYDAD9IEfJLZJ5jfZQB1p
	NBi8MtAY0gjjMlTRuAfIY6NP5kLMg1x5hFm/D4FUZSkY+Ew3KK5qsKeMww+MUSlN
	fUt41L3t7gsVvyniVQmzbtbbfdkTN5mXB92E3tsoZmFSFX5+j7aa99R8LPS1+YBh
	NrDL7KiUyAA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A9D57B03E;
	Wed, 16 Apr 2014 13:51:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 213B67B03C;
	Wed, 16 Apr 2014 13:51:55 -0400 (EDT)
In-Reply-To: <b3f480af1c362c615ad9ce85296e2be2@bellandwhistle.net>
	(alex@bellandwhistle.net's message of "Wed, 16 Apr 2014 09:33:33
	-0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CC68DC7C-C58F-11E3-A1DD-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246368>

alex@bellandwhistle.net writes:

> Any clarification on the differences much appreciated:
>
> http://stackoverflow.com/questions/23097368/git-ignore-vs-exclude-vs-assume-unchanged/23097509

Please don't force people to refer to external site.

The .gitignore and .git/info/exclude are the two UIs to invoke the
same mechanism.  In-tree .gitignore are to be shared among project
members (i.e. everybody working on the project should consider the
paths that match the ignore pattern in there as cruft).  On the
other hand, .git/info/exclude is meant for personal ignore patterns
(i.e. you, while working on the project, consider them as cruft).

Assume-unchanged should not be abused for an ignore mechanism.  It
is "I know my filesystem operations are slow.  I'll promise Git that
I won't change these paths by making them with that bit---that way,
Git does not have to check if I changed things in there every time I
ask for 'git status' output".  It does not mean anything other than
that.  Especially, it is *not* a promise by Git that Git will always
consider these paths are unmodified---if Git can determine a path
that is marked as assume-unchanged has changed without incurring
extra lstat(2) cost, it reserves the right to report that the path
*has been* modified (as a result, "git commit -a" is free to commit
that change).
