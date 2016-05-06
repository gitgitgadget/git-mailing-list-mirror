From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pathspec: remove check_path_for_gitlink
Date: Fri, 06 May 2016 00:14:57 -0700
Message-ID: <xmqq1t5f7j4e.fsf@gitster.mtv.corp.google.com>
References: <1462487497-28394-1-git-send-email-sbeller@google.com>
	<xmqqbn4k85lm.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY65Fo4+_a1B8J0h7PymGWUSoAdb1eb5YVfG55=30oPEg@mail.gmail.com>
	<xmqqy47o6q71.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbmW5U+uFCnBhz4r2-ciGsWSwXHU5Va2r-MEca=iacfgQ@mail.gmail.com>
	<xmqqpot06oys.fsf@gitster.mtv.corp.google.com>
	<xmqq60ur7ll3.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaO+g7Dm5AgdYGADj=pYDLjV-ALGTxrmwrNGUy1NB=tNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 06 09:15:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayZyh-00044P-85
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 09:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758034AbcEFHPD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 03:15:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55235 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753180AbcEFHPC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 03:15:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9535517EAF;
	Fri,  6 May 2016 03:14:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kCQNC5z3/dBMpEZ29xlmOGEiy5s=; b=hfqApv
	zeZfc9ak2xEi7eyO0Njqa5XG6jtkYtw93+i5EuIU5qYzUFRgebZqQ4O0nhOeuQdN
	Y0IJqpl6NUgBzmz1g/Ogp87Q237pLUSnqr1NzkAhEtmXmTcAOUzO6YhkjiyQrODJ
	yJf3ZcphsIKgNhGo/QZYYkVZuizdTQ1rC+O5E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gFu5j50hJ7/jpsZRVQRgOMCgZ+0L5PxW
	lR15FjXNQuN7m9UXh45FLwwkCp0SEUWYdz355pt5sx5VoV/IJbePTNXCKW44COHD
	HKzoAv/dZK6bKX+3ozTBm7ka/Q0pJ3ojBp3dC3s1BXC/QhPdA0JTst4gDn82cE0W
	+zhWagZc9ms=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C2AE17EAE;
	Fri,  6 May 2016 03:14:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 14D8417EAD;
	Fri,  6 May 2016 03:14:59 -0400 (EDT)
In-Reply-To: <CAGZ79kaO+g7Dm5AgdYGADj=pYDLjV-ALGTxrmwrNGUy1NB=tNg@mail.gmail.com>
	(Stefan Beller's message of "Thu, 5 May 2016 23:58:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3E159FA8-135A-11E6-B4EE-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293748>

Stefan Beller <sbeller@google.com> writes:

> There are 2 fundamental cases though.
>  (1) The bug we're talking about (as explained in that blog), refers to 2
>     independent repositories, whose work trees are nested
>  (2) You seemed to bring in the notion that the nested repo is considered
>     a submodule of the outer repo, i.e. they have a relationship.
>
> I don't mind (1). It's a neat hack as these 2 repos are totally unrelated
> (except for the working tree in the file system being the same files).
> You could also achieve a similar handling by hardlinking gitk-git/gitk
> and git.git/gitk-git/gitk.
>
> In (2), we have a gitlink, which by definition takes up the whole directory.
> So any file in that directory in the file system which represents the root of
> the submodule should belong to the submodule.

I certainly didn't mean to "bring in the notion" as if it is
something entirely alien to the discussion.  Before you "git add",
it may be a "nested independent" repository, but that is merely a
submodule that is untracked, yet to be added.  Just like tracked
files were once untracked before they got added, these are possible
submodules that happened to be not tracked yet.

I do not see there is any difference between the two at all.

If deep/in is a repository yet to be added as a submodule,

    $ git add deep/in/the/tree/is-a-leaf.txt
    $ git add deep/in

in the hypothetical "git add A is equivalent to git -C $(dirname A)
add $(basename A)" world should behave the same regardless of the
order of these two commands (otherwise the behaviour is way too
confusing).
