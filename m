From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Requirements for integrating a new git subcommand
Date: Sun, 25 Nov 2012 18:57:08 -0800
Message-ID: <7vmwy5xe9n.fsf@alter.siamese.dyndns.org>
References: <20121122053012.GA17265@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Mon Nov 26 03:57:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tcot2-0007Qp-25
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 03:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753861Ab2KZC5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 21:57:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59281 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753776Ab2KZC5L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 21:57:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3BAF8710;
	Sun, 25 Nov 2012 21:57:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=mo2mpQxqeYw3UelqBo6lg0xxNR4=; b=YhMzY8rzLYzbo+nv2ZPI
	K7YE9TB8xgolPSatUFqAWgtwcMaYK3CJEMGUC6fusYaJ1zOfK+blR7ct77/8SfnT
	D6/xiZ8VjnBqQwEtS302uDUGZccUOBSG2q+OQAkr77uumbEFjQRsVQPjMYFUTaiS
	X+rHfrHFTHBCYJM3AaB3eP0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=robtIzEOh2X3FwmgDwmZIwpKwfWiHXqj6jOo8Uw+3T+QUA
	rNNLJ0SHfQCAvLOapqgJUdn6xdcyog7NpexgU3kOD86j+ittlM2br8fsBzZm+cK4
	T6taGx05wwgetJ+w+JWgR2SDKHi8HstI7hWH0tizLDod306Uqxoswg/XCgYfA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C287F870F;
	Sun, 25 Nov 2012 21:57:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 29678870D; Sun, 25 Nov 2012
 21:57:10 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F8A40D52-3774-11E2-9236-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210403>

"Eric S. Raymond" <esr@thyrsus.com> writes:

> While the weave operation can build a commit graph with any structure
> desired, an important restriction of the inverse (unraveling)
> operation is that it operates on *master branches only*. The unravel
> operation discards non-master-branch content, emitting a warning 
> to standard error when it has to do so.

Imagine that I have a simple four-commit diamond:

    I---A
     \   \
      B---M

where Amy and Bob forked the initial commit made by Ian and created
one commit each, and their branches were merged into one 'master'
branch by a merge commit made by Mac.  How many state snapshots will
I see when I ask you to unravel this?  Three, or four?

If you are going to give me all four states, then I do not
understand why this needs to be limited to the master branch only.
Even if you start from a single commit at the tip of 'master', once
you hit a merge, you will need to follow all of two (or more) paths
to dig down to the root(s), so supporting to start digging from more
than one commit is not all that different.

If you are going to give me only three states, following the first
parent ancestry chain, then the description needs to state it more
clearly.  I am not saying first-parent-only history is useless, but
the user needs to know that merges are flattened in the unraveled
result and the resulting history becomes linear, following the first
parent ancestry chain of the original history (if that is what the
tool does) before deciding if this tool matches what she needs.

As to the procedural stuff, I think others have sufficiently
answered already.  If I may add something, a new stuff typically
start its life in contrib/ before it proves to be useful.
