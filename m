From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Triangular Workflow: user friendly full implementation
Date: Thu, 26 May 2016 11:30:16 -0700
Message-ID: <xmqqwpmgvfif.fsf@gitster.mtv.corp.google.com>
References: <E83A9439-54C8-4925-8EE3-6AEEDD9416F3@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>,
	Tom Russello <tom.russello@grenoble-inp.org>,
	Samuel Groot <samuel.groot@grenoble-inp.org>
To: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Thu May 26 20:30:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b603C-00033S-1u
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 20:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400AbcEZSaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 14:30:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60451 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750939AbcEZSaU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 14:30:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EC76A1EF75;
	Thu, 26 May 2016 14:30:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MmH0vnp37Ne0h2UFnMXU79hIxCc=; b=ILJ7J/
	CqEun1ilBgW9n36chGokwhPWTpeqP+ozqYYcIA1MvphMBjd44iR0p6aDj4BWDnOO
	EzYbAHbjpQT+trBRCK8hnBWbZqrlZFCPUgwmLQK80fMed3EYJeNa+sR8UJUqmfQ8
	jB6XoBNGCTiuUsxumLgrJyjC3k3e8WEszHxdg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TjrmjcFXlap794jncrhQKYRyQ/2ZabYk
	1dpNgKP4E10dV5qMo8p+MiGErunq6lM4ubYhUxUISn0HSraZHNG5mICkJlHfFCYO
	4tJXzGjFoHhE3sT2IMr5+o4uE6P+fMTN/mSg4p8HekL4Rur9dl05qtG6nY4xX0Fu
	RDE2p8WXUzA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E15281EF74;
	Thu, 26 May 2016 14:30:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4C5ED1EF71;
	Thu, 26 May 2016 14:30:18 -0400 (EDT)
In-Reply-To: <E83A9439-54C8-4925-8EE3-6AEEDD9416F3@grenoble-inp.org> (Jordan
	DE's message of "Thu, 26 May 2016 12:06:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E5BA1958-236F-11E6-B0E9-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295683>

Jordan DE GEA <jordan.de-gea@grenoble-inp.org> writes:

> We are working on full implementation of triangular workflow feature.
> For now, the main options available are: 
> 	 - branch.<name>.pushRemote
> 	 - remote.pushDefault
> And only setable by hands. 

And once it is set, you do not have to worry about it.  I am not
sure per-branch thing is all that useful, unless you are always
working on a single branch like 'master', but the latter would be
just set once and forget about it.

> Context:
> 	- One main remote repository, e.g. git/git.
> 	- A remote fork (e.g. a GitHub fork) of git/git, e.g. me/git.
> 	- A local clone of me/git on the machine
> Purposes:
> 	- the local branch master has to fetch to git/git by default
> 	- the local branch master has to push to me/git by default

Wouldn't remote.pushDefault be the single thing you need to set just
once and forget about it?  Why would your users even want to do
these things ...

> 	c. add `git fetch --set-default` in order to set remote.fetchDefault
> 	d. add `git fetch --set-remote` in order to set branch.<name>.fetchRemote
> 	e. add `git pull --set-default` in order to set remote.fetchDefault
> 	f. add `git pull --set-remote` in order to set branch.<name>.fetchRemote
> 	a. add `git push --set-default` in order to set remote.pushDefault
> 	b. add `git push --set-remote` in order to set branch.<name>.pushRemote

... just to configure many variables every time they work on a new
branch?
