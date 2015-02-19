From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Feature Request - show current branch
Date: Thu, 19 Feb 2015 10:10:07 -0800
Message-ID: <xmqqr3tlzsao.fsf@gitster.dls.corp.google.com>
References: <13b.3lxh{.41MsIT3sthY.1KvU6v@seznam.cz>
	<001801d04c48$732f9980$598ecc80$@nexbridge.com>
	<54E60D71.6050906@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Randall S. Becker" <rsbecker@nexbridge.com>, mdconf@seznam.cz,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 19 19:10:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOVYM-0000Ua-Gx
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 19:10:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612AbbBSSKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 13:10:15 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55409 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751996AbbBSSKN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2015 13:10:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B662385C6;
	Thu, 19 Feb 2015 13:10:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d1lhmKpOQAhVzcaohazw4LIqlqs=; b=PKuGtx
	K9sUTTv76G3R//o3C8+TQRB2Jely6hEUAaVDJOAEqa2louPtNKYtxNG9QBl6pVf1
	NvkWpYVjeC/UOiRNXpRhQyZJ0+bhrhENW58NLbA59om1NytgGzmFEU+rzhz44woA
	uiOt/CSND0etMPjv5tPWsAIOTLiXpptSr4yWE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eEhgnc1WAMeiKRGQsV8o4fvDRmDGQogO
	6OiKladPWaXuneQtihrg2beN0cw/fX41K7EuQgIrxvrIgZ35m2rIUPSBrhxojlqd
	L8A01E5ViXYr9AQo3qv9L7A4XRLax66wNwH69r0YUepG8+o/gETsQxbevMiiMU64
	zpnDKzD4/+k=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 09A7A385C5;
	Thu, 19 Feb 2015 13:10:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 315E8385C3;
	Thu, 19 Feb 2015 13:10:09 -0500 (EST)
In-Reply-To: <54E60D71.6050906@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Thu, 19 Feb 2015 17:21:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8A3D1432-B862-11E4-A639-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264108>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Randall S. Becker venit, vidit, dixit 19.02.2015 14:32:
>> git symbolic-ref --short HEAD
>
> That errors out when HEAD is detached.

Isn't that what you would want to happen anyway?

	if current=$(that command)
        then
        	you know $current is checked out
	else
        	you know HEAD is detached
	fi

If you used another command that gives either the name of the
current branch or 4-letter H-E-A-D without any other indication, you
cannot tell if you checked out the "HEAD" branch aka refs/heads/HEAD
or you are not on any branch.  The former would happen after doing
this:

    $ git update-ref refs/heads/HEAD HEAD
    $ git checkout HEAD

Of course, this is not a recommended practice, and "git branch"
these days refuses to create refs/heads/HEAD to discourage you from
doing so by mistake, but there is no guarantee that the repository
whatever script you are writing to work in was created and used by
sane people ;-) so you would want to be defensive, no?
