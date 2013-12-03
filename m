From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Branching workflow
Date: Tue, 03 Dec 2013 11:12:45 -0800
Message-ID: <xmqq8uw1oij6.fsf@gitster.dls.corp.google.com>
References: <CALZVapnjN_69y0+PLFA2t8b72WDK+D4BhjDRnRPxU_9iX+_NuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Javier Domingo <javierdo1@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 20:12:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnvOx-0000eP-1u
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 20:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754545Ab3LCTMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 14:12:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50290 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754534Ab3LCTMt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 14:12:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C885155545;
	Tue,  3 Dec 2013 14:12:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ahj0hh0xoc6NKSjuFkx6yRQKPr0=; b=OJKkyx
	nGBIc9EK2V+qRpActO6wSvn4XaDy3BeNVJH8+k9jUBVj001s6An6W4qqc1mevylz
	55zmCkvQfw/ia0NxEAFPSmg3o/rDiVhMZgrhoObe6olMkGi6D2OM8AiGOpQufJ4X
	uGYT8z7q1u6t1DLspTcEIOPdlw3gQ2HZQe57c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uNqt0K3hFTcdPqF1OO+NXPOYNwv8P4AO
	RjBdHKAWiRSG8wibwJ280FfgepyqoHUITVJWF8wPzYZ2rpG2WsGEpsBUCi+zGd0B
	BEwPkxgiURAhr5zYNVTe54Qm7584jXtSTCL+5AxUeZeg3bJoCF51mRRZTjqDjLOt
	7C7P7UBkJlA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B652955544;
	Tue,  3 Dec 2013 14:12:48 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE64655541;
	Tue,  3 Dec 2013 14:12:47 -0500 (EST)
In-Reply-To: <CALZVapnjN_69y0+PLFA2t8b72WDK+D4BhjDRnRPxU_9iX+_NuA@mail.gmail.com>
	(Javier Domingo's message of "Tue, 3 Dec 2013 19:06:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E58597F4-5C4E-11E3-9B8A-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238719>

Javier Domingo <javierdo1@gmail.com> writes:

               
> Hi,
>
> I have been using a very basic workflow for branching, features each
> in a branch.
>
> My branches would be:
> - develop <= Main upstream branch
> - feature/* fix/*  <= Feature and fix branches
> - master <= Integration of the whole feature and fix branches
>
> So I have now came up with a very difficult task. I just discovered
> that one of those branches, lest call it feature/bad, is evil and is
> making the integration branch (master) fail horribly.
>
> In my workflow, I tend to merge develop (official updates) into my
> feature branches, and them into master.

I think the standard advice is not to contaminate feature branches
with unrelated changes, whether from an upstream updates or from
other unrelated feature breanches.

You would still want to make sure that your feature branches in
work-in-progress state would work with updated upstream from time to
time, but that is much better done by having a test integration
branch you maintain with:

    : always start from the tip of upstream
    $ git fetch upstream
    $ git checkout -B develop remotes/upstream/master

    : merge everything you want
    $ git merge feature/A
    $ git merge feature/B
    ...
    $ git merge fix/Z

And you will never merge 'develop' into 'master'.  Only after you
are satisfied with a single feature (or fix), you merge that to
'master', while your other features may still be suspect.
