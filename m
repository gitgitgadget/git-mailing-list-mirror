From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Surprising 'git-describe --all --match' behavior.
Date: Thu, 19 Jun 2014 10:20:46 -0700
Message-ID: <xmqqr42khl3l.fsf@gitster.dls.corp.google.com>
References: <87ionxxbz8.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 19:21:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxg1G-0001C0-WF
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 19:21:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933467AbaFSRU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 13:20:58 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63323 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932530AbaFSRU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 13:20:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 517231E9C7;
	Thu, 19 Jun 2014 13:20:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N7XzBqP8+CEHqOiEpTnm5EFC1z4=; b=LknSxa
	7UOA1MIVeBTsFMkRDwRqflyTdTiJfgVwaBCw8PboT0r8CUIH9A7Pk9OfLHPjXxzm
	ZttG5JRGc3vGuEyHwVGAJIURm91TxJjs+E9FqEoPeIQyTCNh2ajKOHOGQ/pbVWFH
	17z4LHJVhmp0Fsv4Y2J5FB3xBlMERipTQoiCE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jjx7K/8IGvX8sCYM/3Qibb3CgDy1i66c
	O1GO5vtHcrBZaUYrruMFyDvlLHrFaJfcj93QGC68uDeoTIr90GnMiCo1/WUrXwSr
	q0jjgT50C+qrtj8kqO8bCL/Rax0ZFrJxbT6ngneEYPoTk2PRZkiHNsixJaWM8d0b
	7eXHH7VBz9E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 469471E9C6;
	Thu, 19 Jun 2014 13:20:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A56EC1E9C5;
	Thu, 19 Jun 2014 13:20:45 -0400 (EDT)
In-Reply-To: <87ionxxbz8.fsf@osv.gnss.ru> (Sergei Organov's message of "Thu,
	19 Jun 2014 17:31:07 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0C8D9BBC-F7D6-11E3-81F3-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252168>

Sergei Organov <osv@javad.com> writes:

> Just playing with it, got some surprises:
>
> $ git --version
> git version 1.9.3
>
> $ git describe --all
> heads/v3.5
> $ git describe --all --match 'v*'
> tags/v3.5.6b2-4-gab4bf78
> $ git describe --all --match 'heads/v*'
> fatal: No names found, cannot describe anything.

I think

$ git describe --help

       ...
       --match <pattern>
           Only consider tags matching the given glob(7) pattern,
           excluding the "refs/tags/" prefix. This can be used to
           avoid leaking private tags from the repository.
       ...

is poorly phrased, especially its "excluding" part.  What it wants
to say is "You give <pattern> but without refs/tags/, because the
program helpfully always prepend refs/tags/ to your pattern and
limit the output to those that match".  Hence you gave 'v*' as
<pattern> and limited the output to those that match 'refs/tags/v*'
(or you gave 'heads/v*' and limited to 'refs/tags/heads/v*').
