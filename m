From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rerere affects handling of git-stash-pop merge conflicts
Date: Sun, 17 Jul 2011 14:59:08 -0700
Message-ID: <7voc0szhzn.fsf@alter.siamese.dyndns.org>
References: <4E1F22DF.7060209@cisco.com>
 <alpine.DEB.2.00.1107152208530.12060@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <hordp@cisco.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 17 23:59:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiZMv-0004TS-Ek
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jul 2011 23:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753833Ab1GQV7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jul 2011 17:59:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45270 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752970Ab1GQV7M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2011 17:59:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82CA147CE;
	Sun, 17 Jul 2011 17:59:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=peKr87wFx3ozsg0kWuiMtKaM2ZE=; b=f14vZM
	E5HZhzj0Hsc2cfTUtlrMhHoA/Dca5KzKEZHrbHITeaUbSf6vQY9blBwhNGGEvdqi
	u4DAgtExZzkfu0N+Y5sQtpBZKgOBb+SmvJOaZlqgj1GHvy9nyDVbZWFDMOIR3JaO
	Ll/xclg5a598jdq1oIWN6VSJDoIdtERVbnjFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iStwK/Lbe4ZUVtU/z0YRFw6Z7ADdKxwg
	stZ4oqthojnZDFVqpuD1rbDbSFGwKBMBT782sAzNTU1ghP3uEX1zVoKuhR7TWNgr
	XssWv9mP+AsryK2346Gq/cV/CMNfymXiwUpCtslIZZY3wtMa/EDmlpKPPTQjcnep
	NZjTMmlcmc4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79FCC47CD;
	Sun, 17 Jul 2011 17:59:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D83847CC; Sun, 17 Jul 2011
 17:59:10 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.00.1107152208530.12060@debian> (Martin von
 Zweigbergk's message of "Fri, 15 Jul 2011 22:19:27 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 008E99D4-B0C0-11E0-A2C7-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177319>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> On Thu, 14 Jul 2011, Phil Hord wrote:
>
>> Summary:
>> After a 'git stash pop' with conflicts, 'git mergetool' fails to notice
>> the conflicted files if 'rerere.enabled=true'.  git mergetool
>> erroneously reports 'no files need merging'.
>
> It seems to be because git-stash uses git merge-recursive directly
> instead of calling git merge. I don't know why git merge-recursive is
> used directly. It has been like that ever since git-stash was
> introduced in f2c66ed (Add git-stash script, 2007-06-30).

But "stash pop/apply" should never call "merge" directly, as it is not
interested in creating (nor preparing to create, with "merge --no-commit")
a new merge commit, nor doing the history level three-way merge.

Calling merge-recursive backend is used as a way to run a three-way tree
merge with explicitly specified three trees.
