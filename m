From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP/PATCH 4/9] Teach merge the --[no-]recurse-submodules option
Date: Fri, 07 Feb 2014 14:00:23 -0800
Message-ID: <xmqqeh3etwg8.fsf@gitster.dls.corp.google.com>
References: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com>
	<52CC3E16.4060909@web.de>
	<xmqqvbxvekwv.fsf@gitster.dls.corp.google.com>
	<52EFF25E.6080306@web.de> <52EFF311.1090202@web.de>
	<xmqq4n4fdcnd.fsf@gitster.dls.corp.google.com>
	<52F54ED7.2010302@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Feb 07 23:00:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBtTQ-0005a8-9D
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 23:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbaBGWAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 17:00:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64662 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751920AbaBGWAb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 17:00:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C15E36A29D;
	Fri,  7 Feb 2014 17:00:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JcqmZc9n+Bp83mrzcNOGA7yR5ao=; b=Phy68d
	xdXBvyRSdGYatbqBg5krt5Veu0wJTdiDaedS+3kaOunj2XS3UA8LD4g+qm1pE0Jg
	reZ0jvRiBGDHkSs2qqpd/x/izLX7iKSefdTIZszpiwVY7kNX/rqr+7/Op+lBwpjq
	HN8IQCMcfYxuPVXjmvW87xu/hoL+/yq3MzQyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vg7ct5UPtI+HPi2iUGiIBb45SXtQeel2
	i8itQ7miGs411O10jp4YMoflnvfV+/wEaYLdleaEv9hmScFgX980Z00SQI9nbBV7
	VkcbVyxhKrIu4HtUTNLiWhpwyrtL3uHkAGhJpuGx8EVCRHfskSh56zQLK83dFvm6
	lFXIuB8dH5A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58C436A29C;
	Fri,  7 Feb 2014 17:00:30 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0BCFC6A298;
	Fri,  7 Feb 2014 17:00:26 -0500 (EST)
In-Reply-To: <52F54ED7.2010302@web.de> (Jens Lehmann's message of "Fri, 07 Feb
	2014 22:23:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 407FD340-9043-11E3-AE82-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241809>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> I think the user needs to sort things out, just like she has to do
> when a file has a merge conflict. But unfortunately we cannot use
> conflict markers here, so I'd propose the following:
>
> * When merge proposes a merge resolution (which it does today by
>   telling the user "Found a possible merge resolution for the
>   submodule ... [use] git update-index --cacheinfo 160000 ...")
>   that commit should be checked out in the submodule but not
>   staged. Then the user can simply add and commit.
>
> * If the merge resolution is not obvious to merge, it leaves the
>   submodule in an unmerged state, the local commit still being
>   checked out. The user has to manually do the merge in the
>   submodule and commits that in the superproject.
>
> Does that make sense?

The latter one does not worry me too much.

For the former, "add and commit" at the top-level makes perfect
sense, and the "commit should be checked out in the submodule" is a
necessary step to sanity-check and prepare for that "add and commit"
step, but what does "checked out in the submodule" exactly mean?  Do
we detach the HEAD at the commit?  Do we advance the tip of the
branch of the submodule to that commit?  Do we know/require/care if
such a move always fast-forwards?
