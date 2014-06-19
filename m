From: Sergei Organov <osv@javad.com>
Subject: Re: Surprising 'git-describe --all --match' behavior.
Date: Thu, 19 Jun 2014 22:58:00 +0400
Message-ID: <87d2e4d8w7.fsf@osv.gnss.ru>
References: <87ionxxbz8.fsf@osv.gnss.ru>
	<xmqqr42khl3l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 20:58:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxhXF-0003xm-1e
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 20:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933596AbaFSS6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 14:58:04 -0400
Received: from mail.javad.com ([54.86.164.124]:44811 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933024AbaFSS6D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 14:58:03 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id C617F60BFF;
	Thu, 19 Jun 2014 18:58:01 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <s.organov@javad.com>)
	id 1WxhX6-0006xJ-3k; Thu, 19 Jun 2014 22:58:00 +0400
In-Reply-To: <xmqqr42khl3l.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 19 Jun 2014 10:20:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252172>

Junio C Hamano <gitster@pobox.com> writes:

> Sergei Organov <osv@javad.com> writes:
>
>> Just playing with it, got some surprises:
>>
>> $ git --version
>> git version 1.9.3
>>
>> $ git describe --all
>> heads/v3.5
>> $ git describe --all --match 'v*'
>> tags/v3.5.6b2-4-gab4bf78
>> $ git describe --all --match 'heads/v*'
>> fatal: No names found, cannot describe anything.
>
> I think
>
> $ git describe --help
>
>        ...
>        --match <pattern>
>            Only consider tags matching the given glob(7) pattern,
>            excluding the "refs/tags/" prefix. This can be used to
>            avoid leaking private tags from the repository.
>        ...
>
> is poorly phrased, especially its "excluding" part.  What it wants
> to say is "You give <pattern> but without refs/tags/, because the
> program helpfully always prepend refs/tags/ to your pattern and
> limit the output to those that match".  Hence you gave 'v*' as
> <pattern> and limited the output to those that match 'refs/tags/v*'
> (or you gave 'heads/v*' and limited to 'refs/tags/heads/v*').

OK, thanks, at least I now see how it works. So no <pattern> can ever
match any reference but tag, even when --all switch is given? If so,
appearance of --match effectively turns --all into --tags, that is still
rather confusing, isn't it?

Will something break if it won't helpfully prepend refs/tags/ once
--all is given?

-- 
Sergei.
