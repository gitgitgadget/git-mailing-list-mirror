From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC 11 submodule] Status update
Date: Wed, 29 Jun 2011 14:58:48 -0700
Message-ID: <7vpqlws3jb.fsf@alter.siamese.dyndns.org>
References: <20110627193444.GA26778@paksenarrion.iveqy.com>
 <4E09205E.2080904@cisco.com> <20110628184358.GA3700@book.hvoigt.net>
 <4E0B98CA.2050207@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	jens.lehmann@web.de
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Wed Jun 29 23:59:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qc2mg-0006TW-EP
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 23:58:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757831Ab1F2V6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jun 2011 17:58:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55456 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752987Ab1F2V6v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2011 17:58:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6713E51CC;
	Wed, 29 Jun 2011 18:01:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S+6utY0uDd1U6srP3tbRBfVF3Do=; b=GLbLnt
	yqPff5otYwH1VbsLZ/o9tbCjiSR3tsw4obAyF0TYF/z8Hhue6xyZRsLotTGEQP4T
	GilpltPwaAHRUyokQY6iqzRB6mRhBrwW+VdJfVfX20AoQuDFfp0UCTlWYTkvqMwM
	n2V0Wt2luBmtN45lJLOoNcdT3pzoBAVnBUFGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wd1m7v9xryeLC89gQhP8iy1VMKUf0NfR
	yP0OIs+VvQymbFgLLxycuNaWY16a7AYYZP2+A2WzM/xdvM9ub3C9EeLelM4hr4NB
	GzVwvQdgiBppFryHHoN/upw4xqjF+a0RE8Yf9DxD0ZoOQkglTiCmlg2j4GPonjkq
	6b0cudBOfYM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 603BB51CB;
	Wed, 29 Jun 2011 18:01:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AFFC551CA; Wed, 29 Jun 2011
 18:01:04 -0400 (EDT)
In-Reply-To: <4E0B98CA.2050207@cisco.com> (Phil Hord's message of "Wed, 29
 Jun 2011 17:27:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48DEAEAA-A29B-11E0-9E17-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176462>

Phil Hord <hordp@cisco.com> writes:

> It frightens me because it seems like a fundamental break from the
> current submodule functionality.  Today a submodule exists as a git
> repository with no knowledge that it is a submodule or who its
> super-repository is.

The use of .git that is a text file that records where the real directory
is not limited to submodules.  Placing that "real directory" somewhere in
the .git directory of the superproject is merely a convention.

In other words, it does not change anything fundamental.

> Once it finds it, it will
> (safely, today) assume that is the .git directory relating to its
> files.  After this change, the tool will be broken.

Then it is already broken if it does not pay attention to .git that is not
a directory but is a text file that records where the real directory is.

> I think I can answer my other concerns now.  Do these answers sound right?
>
> - What happens if the submodule working directory is dirty?  
> - But what if the submodule working directory is 'clean' after considering
>   .gitignore?  Do untracked/ignored files also get deleted?
> - What if a 'git checkout' results in the submodule being removed?
> - What if a 'git checkout' or 'git merge' results in submodule 'foo' being
>   added where there is already a file named 'foo'?

These "different" questions are answered exactly the same way, which is:

>   Treat it the same as git does for its own working directory.

When switching to another branch, a directory that does not exist in the
switched-to branch needs to be removed, but we would refrain from "rm -fr"
that directory if it has any leftover cruft in it (untracked and unignored
files). A submodule directory should behave in the same way.
