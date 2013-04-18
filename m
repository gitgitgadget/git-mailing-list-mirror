From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stash: tighten IS_STASH_LIKE logic
Date: Thu, 18 Apr 2013 15:20:23 -0700
Message-ID: <7vk3nz4h20.fsf@alter.siamese.dyndns.org>
References: <1366270717-19929-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Brandon Casey <drafnel@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 00:20:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USxBv-0006gR-9X
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 00:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936578Ab3DRWU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 18:20:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41625 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936456Ab3DRWUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 18:20:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03763172EE;
	Thu, 18 Apr 2013 22:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aLynM4gKgkp2s1N8fiytqQHb25s=; b=Jx5PdB
	v9vdOHZd93jpp8s/jSkHDjXeAx3ewPZbGnqTXidSo5h6lx4Cc1MqINlCJsBMnOgG
	Az0ty9ouBb5JLBrerGBSyL6xvjDzXLyz9pmJHeTMFowybn1k9Ic4OpbdJeiSWsLB
	7jNtqb0r0QwQtc1eLxiyaBu9fYCC/viu8982Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RICxuxwBbYsH2Az0ZpSGb7wl4NT+9s93
	lMRaDx8J56YlZCGyLtmgeMYrgSXF/v/q38/WNpQQ3SWf8Paxxe1fdO5Qj+KFIxyj
	6luVklVjdCN4UAIILF4BhD0RsvjZq+AB0R2iD2L6Bwf9OjtwfaOOc1ePsGeiB0Hp
	MZ9cCPNItHk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBEA9172ED;
	Thu, 18 Apr 2013 22:20:24 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6724E172E9;
	Thu, 18 Apr 2013 22:20:24 +0000 (UTC)
In-Reply-To: <1366270717-19929-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Thu, 18 Apr 2013 13:08:37 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2A544C14-A876-11E2-BEAB-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221698>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Currently, 'git stash show' and 'git stash apply' can show/apply any
> merge commit, as the test for setting IS_STASH_LIKE simply asserts if
> the commit is a merge.  Improve the situation by asserting if the
> index_commit and the worktree_commit are based off the same commit, by
> checking that $REV^1 is equal to $REV^2^1.

When was the last time you tried to run "git stash apply next"?

The current code parses the ancestors and trees because the real
work needs them, and the 'does this look like a stash?' is a side
effect, but reading it^2^1 and comparing with it^1 is a pure
overhead for the sake of checking.  It looks like a futile mental
masturbation to solve theoretical non-issue to me.

Is it worth it?
