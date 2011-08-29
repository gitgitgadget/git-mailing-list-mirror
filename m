From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's the difference between `git show branch:file | diff -u -
 file` vs `git diff branch file`?
Date: Mon, 29 Aug 2011 10:18:28 -0700
Message-ID: <7v1uw46srf.fsf@alter.siamese.dyndns.org>
References: <loom.20110823T091132-107@post.gmane.org>
 <CACsJy8DMqjMfb5wVMnsrZhP8yv2rF1wyQ6LM6b-PVcYY1SXkcQ@mail.gmail.com>
 <loom.20110829T155805-331@post.gmane.org>
 <CACsJy8Dar5i3Fn+rhOq78vdsqRL4D+RNUc5G64BM-6DvKC=L5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 29 19:18:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy5To-0005aa-Fl
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 19:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754499Ab1H2RSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 13:18:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40469 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754464Ab1H2RSa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 13:18:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D9C6358F;
	Mon, 29 Aug 2011 13:18:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kMGEAPMf2LYK4atktRHyReAFaQc=; b=l/+uo2
	tKd3rpCedLk0taNk584hkukiPLm6ArvvtoFpnwQaRBCTTZgNKdD6Ua2dIdCw44fj
	npm5v0HiRBBYviDr2WPKkFbnLFE4M1JmrASwGMmOWXHp3NiTgCuZwyfkeyR3VZLz
	zEB6Rv/kIyo5oq/qK3IH6AlSJj6WF+3E3m+jI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b8lxVIwnzeYrbzaWmI7+Xl+7eluEo2O3
	fnI7+UpSVym7Yib3yUc4B0Injqlfw+BlGUomzDXlsdcOFVtrcpN8xD6KaI0gCD2K
	fm7cKYtrTGepik/bd5rxQxSwoHxgSqwuicP0ra+Cg7wqQa2HajhwFKn4P618ObRR
	Rpgo58T4XuE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25B91358E;
	Mon, 29 Aug 2011 13:18:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B0225358B; Mon, 29 Aug 2011
 13:18:29 -0400 (EDT)
In-Reply-To: <CACsJy8Dar5i3Fn+rhOq78vdsqRL4D+RNUc5G64BM-6DvKC=L5w@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Mon, 29 Aug 2011 23:09:05 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EA1A1916-D262-11E0-B0E4-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180323>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> That may explain it. "git diff <ref>" walks through the index, unpacks
> tree objects along the way, matches up entries with the same path from
> the branch, the index then feeds matching entries to diff function.

Yeah, that would explain it. The implementation of diff-index has changed
a few times and the latest incarnation is based on unpack-trees, _merging_
the tree and the index, introduced by d1f2d7e (Make run_diff_index() use
unpack_trees(), not read_tree(), 2008-01-19).

Of course the merge machinery does not know anything about pruning with
pathspec, so it is understandable (not justifiable) it would walk the full
tree.

Will try to find time this week to cook up something.
