From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rev-list pretty format behavior
Date: Sun, 05 Apr 2015 14:12:18 -0700
Message-ID: <xmqqlhi6cma5.fsf@gitster.dls.corp.google.com>
References: <CAHaCNWJZQRVxp3ponvh3pPEk=sOHGYypyhi1Dc8HX5gkKEBGrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Oliver Runge <oliver.runge@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 23:12:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YerqE-0006oA-Kt
	for gcvg-git-2@plane.gmane.org; Sun, 05 Apr 2015 23:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686AbbDEVMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2015 17:12:22 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62311 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752562AbbDEVMV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2015 17:12:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B6A404631B;
	Sun,  5 Apr 2015 17:12:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eXJjLaqBrOr6oZNlJgr04XD3gi0=; b=HTyj3N
	IYjD2Ay1fqPhxirUobNaxgy4ZOCf1yqL0+iU6e79HS3/WPAR4sv0cGKjSIsUxn45
	9rUexhNDEkTVoao0lK4yxA63kkoBYZQsSynarl0q7wTk8FW2vWSp6kt3AkE0blwS
	ZRlaPxoAJYvtdZMh7y2NUQsaGa8eVqnsoWT2s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iXqYu33u684IJnwpnN1J4uGTO9FqTN+c
	vp+USdKYe6xXn4qafWjtZ40FmzCor+jqMs8ogHlLkzLhZGq39FihEINEPccQgf2S
	gk6cWqXE42NcibeuSzsOi9CelHUT84MM1SPlmA+PUI2NfDGkEDoW9Z07UGopidzK
	4DnsfDaQwzI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B00454631A;
	Sun,  5 Apr 2015 17:12:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 38E1C46319;
	Sun,  5 Apr 2015 17:12:20 -0400 (EDT)
In-Reply-To: <CAHaCNWJZQRVxp3ponvh3pPEk=sOHGYypyhi1Dc8HX5gkKEBGrQ@mail.gmail.com>
	(Oliver Runge's message of "Sun, 5 Apr 2015 01:27:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7225A35C-DBD8-11E4-A243-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266820>

Oliver Runge <oliver.runge@gmail.com> writes:

> I'm using git version 2.4.0-rc1. The same behavior exists in 2.1.0.
>
> Trying the same with rev-list results in:
>> git rev-list --pretty=format:"%h ..." HEAD~3...HEAD
> commit 826aed50cbb072d8f159e4c8ba0f9bd3df21a234
> 826aed5 ...
> commit 915e44c6357f3bd9d5fa498a201872c4367302d3
> 915e44c ...
> commit 067178ed8a7822e6bc88ad606b707fc33658e6fc
> 067178e ...

This is very much the designed behaviour, I would think.  IIRC, the
user-format support of "rev-list" was designed so that the scripts
can customize the output from "rev-list -v", which was how scripts
were expected to read various pieces of information for each commit
originally.  And the 40-hex commit object name and/or a line that
begins with "commit ..." when a user format is used are meant to
serve as stable record separator (in that sense, having %H or %h in
the userformat given to rev-list is redundant) when these scripts
are reading output from "rev-list".

A new option to tell "rev-list" that "I am designing an output that
is a-line-per-commit with the userformat and do not need the default
record separator" or "I will arrange record separator myself" would
be an acceptable thing to add, provided if many scripts yet to be
written would benefit from such a feature, though.
