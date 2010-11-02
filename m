From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rebase not honoring core.worktree pointing elsewhere
Date: Mon, 01 Nov 2010 18:21:23 -0700
Message-ID: <7v1v7434h8.fsf@alter.siamese.dyndns.org>
References: <loom.20101101T182113-378@post.gmane.org>
 <AANLkTi=ejRcnz+83zc2Z-6etUGMsBSw1FFUY0JNFRFGB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Drews <paul.drews@intel.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 02 02:21:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PD5ZD-0004b9-Fs
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 02:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589Ab0KBBVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Nov 2010 21:21:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37156 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801Ab0KBBVd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Nov 2010 21:21:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 608532D0F;
	Mon,  1 Nov 2010 21:21:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hSacYVPEhWdAmIMKx1wGVL+Lrk8=; b=iOmA1Q
	9fdrkmSrYH/86uz2SYVSJNlpS2eoFh5L1pP09994v9NOSeF9sIezibQz+jN3JZtI
	4vVIMrDVpHF6uythQyJmgI5ThNmToZgnZexoURh2PLyclt4iAgDHqlH/lNHMaEx2
	VlmL7+JpYxcnPdSGwcRJYfF0F3H/aSIeR5MyU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gXAlYfWtdNsSiqZjYRoBv6Dec3klNOfn
	fYdCxmvVsmXS96mPYzry564PgDBy+6JjAE7gfsFlvkoN+P/8/E2haQJn3eiGvcBd
	iIbTYKsc+u8i4Idk99RZiXwpTu5wIjzAjDhV21bSyiuxUQqMEBbvsKlhKTaictaF
	hCKA3Ht5Nv0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B27E2D0C;
	Mon,  1 Nov 2010 21:21:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C3522D08; Mon,  1 Nov
 2010 21:21:25 -0400 (EDT)
In-Reply-To: <AANLkTi=ejRcnz+83zc2Z-6etUGMsBSw1FFUY0JNFRFGB@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Tue\, 2 Nov 2010 07\:11\:16 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 84D76CBE-E61F-11DF-B638-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160504>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Then, yes, rebase should be updated to use worktree even if it's
> outside cwd. I'm not sure how to do it properly in git-rebase.sh
> though.  The requirement "require_work_tree" can be loosen a bit.

require-work-tree traditionally meant "you must be inside the working
tree, you could be in a subdirectory of it", but as long as the command is
about the whole tree operation (which rebase is) and takes no pathname
relative to the $(cwd) as an argument (which rebase does not), there is no
strong reason why you should be _inside_ the working tree.  For such
commands, require-work-tree should mean "you must have a working tree, and
make it known where it is to git", nothing more.
