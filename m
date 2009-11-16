From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pushing remote branches
Date: Mon, 16 Nov 2009 12:05:13 -0800
Message-ID: <7vlji6p75y.fsf@alter.siamese.dyndns.org>
References: <hdneuv$nc8$2@ger.gmane.org>
 <2e24e5b90911141645n59680856ja21f2f3c7063f7c0@mail.gmail.com>
 <hdoko1$s78$1@ger.gmane.org>
 <2e24e5b90911150304i1472ed13k6c60611ef2e9ba19@mail.gmail.com>
 <hdrr1e$oub$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lorenzo Bettini <bettini@dsi.unifi.it>
X-From: git-owner@vger.kernel.org Mon Nov 16 21:05:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NA7pK-0007y2-NM
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 21:05:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbZKPUFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 15:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752181AbZKPUFR
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 15:05:17 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39536 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbZKPUFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 15:05:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D27C59DE43;
	Mon, 16 Nov 2009 15:05:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y83kvhd6YPz41rt3IqmEUmhKKkc=; b=rLvhMj
	OoZ9rX19oJL8eIMAHquIOmjY4/YZyXj+PIOJ05umyPiiyAs+WJccyDzbw+Lmt8dj
	AoHrm0r3oL04sCRsLut1KjX6Rh4jGNIvaTRxWGPenGQm1vx0eJity/MFub5Um5tG
	KQhNnWwLPCYhWcGxcC5cGFC42UqhJDJm7Jmqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bY9sAXHNGupqNvBLEVVtLFLVkuK7/zDy
	46Vq4YQya/xXnGPj6JphQkheAbmWrpA8b6kzDZNvdhfSLCtcLTfDmLxV7bj8mGIs
	ZHptjJCcVhmpthiPJFvuDAAJIJ8Riomv9Cskr94ejkJ473UAlngj2qujR8k9EfjK
	N8GG53tKX78=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B1A1D9DE42;
	Mon, 16 Nov 2009 15:05:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B3B2B9DE40; Mon, 16 Nov 2009
 15:05:15 -0500 (EST)
In-Reply-To: <hdrr1e$oub$1@ger.gmane.org> (Lorenzo Bettini's message of
 "Mon\, 16 Nov 2009 16\:27\:32 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5CFBCE3A-D2EB-11DE-8C3F-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133023>

Lorenzo Bettini <bettini@dsi.unifi.it> writes:

>> Anyway to answer your question, I do not see the refspec line as the issue
>> here, but the URL for the repo, which determines how you access it.
>
> so this would have been enough:
>
>>> [remote "origin"]
>>>            fetch = +refs/heads/*:refs/remotes/origin/*
>>>            url = git://...
>>> [branch "master"]
>>>            remote = origin
>>>            merge = refs/heads/master
>>> [branch "experiments"]
>>>            remote = origin
>>>            merge = refs/heads/experiments

Because "git://" is almost always read-only, you wouldn't be able to push
back to the origin with that configuration.  If you are only following the
project that is perfectly fine.

Otherwise, either use "git@..." in remote.origin.url to use git-over-ssh
in both directions, or you can use pushurl if you have recent enough
version of git, like:

    [remote "origin"]
        fetch = +refs/heads/*:refs/remotes/origin/*
        url = git://...
        pushurl = git@...

When you primed your repository with "git clone git://...", it would be
nice if "clone" added a "corresponding" pushurl for you.  But ... part of
the two lines are often different, depending on how hosting site is
organized, so unfortunately "clone" cannot do so.
