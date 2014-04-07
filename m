From: Junio C Hamano <gitster@pobox.com>
Subject: Re: The fetch command should "always" honor remote.<name>.fetch
Date: Mon, 07 Apr 2014 11:23:21 -0700
Message-ID: <xmqqioqlm21y.fsf@gitster.dls.corp.google.com>
References: <5340871D.8070503@lewisdiamond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lewis Diamond <git@lewisdiamond.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 20:23:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXECg-0005mf-26
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 20:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755588AbaDGSXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 14:23:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38431 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755432AbaDGSXY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 14:23:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD6797811E;
	Mon,  7 Apr 2014 14:23:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aU+fQnKxwP50CSVibQLlbjlACsg=; b=xXxmQN
	tIGpTlIHaCczX2obnfRKn0+jQKowliz+RvcbjkVaYR4YJskj0CgSRZwrk/oDkCUk
	At8puL7iezblW4d6tV3+YhSZ+CUCjJH3BkjVbvdFOZ5W833aD1Si1rZh9HM/xblG
	IYuT6DEPLE2nKEAPYPZej5J7AzT/5Xf9MNkoE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cWc2RBXWjml6CH+LbTpWLJzr3ChVcYRt
	ZcJE0S2hnU+HmXieYnWrg8AFZWoB5++c1sBbQkNlYCHrN7Zqy9cFFmBOxNMDoiha
	ant1Zks8ZFdc4FmrnvyQlU3mf0NBiZjZkxDnN/Ld4wv5VpEQQqishzmJEu3lmlwW
	Oa72skSnVZY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 955E37811D;
	Mon,  7 Apr 2014 14:23:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9EA727811B;
	Mon,  7 Apr 2014 14:23:22 -0400 (EDT)
In-Reply-To: <5340871D.8070503@lewisdiamond.com> (Lewis Diamond's message of
	"Sat, 05 Apr 2014 18:43:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B3B9ECF8-BE81-11E3-AE95-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245871>

Lewis Diamond <git@lewisdiamond.com> writes:

> 'git fetch foo develop' would result in:
> fatal: Couldn't find remote ref test2 //Not OK, (case 1)

I have no idea where the "test2" comes from, as it does not appear
anywhere in the above write-up, and it could be a bug.

> 'git fetch foo master' would result in (FETCH_HEAD omitted):
> [new ref] refs/heads/master -> foo/master //OK, but missing another
> ref! (case 2)
> //It should also fetch refs/users/bob/heads/master -> foo/bob/master

This is an incorrect expectation.

The user who gave the command line said only "master", and did not
want to grab "users/bob/heads/master".  If the user wanted to get it
as well, the command line would have said so, e.g.

	git fetch there master users/bob/heads/master

> If you remove this configuration line: fetch =
> +refs/heads/*:refs/remotes/foo/*
> Then you run 'git fetch foo master', this would result in:
>  * branch master -> FETCH_HEAD //Debatable whether this is OK or not,
> but it's definitely missing bob's master! (case 3)

Likewise.

The 'master' short-hand is designed not to match refs/users/any/thing.
