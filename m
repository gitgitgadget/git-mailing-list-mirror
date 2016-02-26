From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG? git log --no-merges shows grafted merges in shallow clones
Date: Fri, 26 Feb 2016 12:00:01 -0800
Message-ID: <xmqqfuwfjl8e.fsf@gitster.mtv.corp.google.com>
References: <vpq4mcvs146.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Feb 26 21:00:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZOYp-00066c-U8
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 21:00:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231AbcBZUAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 15:00:11 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57709 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755201AbcBZUAH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 15:00:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B56F144D4B;
	Fri, 26 Feb 2016 15:00:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tpmw5QomrpHbW0/pZR82UGvffcU=; b=l0Xw9e
	koptOUmPyycOBhIv+KwRP57YPas+ZYr0IIbFKKP3lXu6oyiCw0umG6G1eVECPUYf
	V4J/3udLgJG9ntFqt+roLBIUlz9qjy4JMl8BYaTVRAEcPDo6PlxEfH+qf8ItPRE5
	NfZLQS1K7hn471nf3o6I7fYXkFvPEI4jhgv+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K5UuA5f4em1tOaI2WEknWIVFJ7mJyqMb
	3YuLE+161bVmZ3iO+kH18R16vDaHHkZOMI586w/Vee41tWPo04mshV5li/6VuQDX
	aqV172YeRZwHtXvg569O9k+K9l65i8LYBC0T+jESbfq/S5IMZzlAHoQplAivXXa+
	3u6Kv6wYZIs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 978D144D4A;
	Fri, 26 Feb 2016 15:00:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8700944D41;
	Fri, 26 Feb 2016 15:00:04 -0500 (EST)
In-Reply-To: <vpq4mcvs146.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	26 Feb 2016 20:49:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 86F66270-DCC3-11E5-99FB-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287616>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Hi,
>
> I don't think that's intended. When running "git log --no-merges" in a
> shallow clone, and the last commit in the history is a merge commit,
> "git log --no-merges" still shows it.
>
> I've just hit this in a test running on a --depth=50 clone on Travis-CI
> on git-multimail:
>
> $ git cat-file -p c3c1cc25b27d448e9ef67b265a11be8735ff2df4
> tree c341dd60c4b639eac1d6dcc3caffb5d7201c2245
> parent b312e3f90dfef73ba0288999981694b09affdf6b
> parent 842ac6e867885af041499723dc46f2197705204c
> author Matthieu Moy <Matthieu.Moy@imag.fr> 1441031540 +0200
> committer Matthieu Moy <Matthieu.Moy@imag.fr> 1441031540 +0200
>
> Merge remote-tracking branch 'edward/utf-8-email-support4'
>
> $ git log --no-merges c3c1cc25b27d448e9ef67b265a11be8735ff2df4
> commit c3c1cc25b27d448e9ef67b265a11be8735ff2df4 (grafted)
> Author: Matthieu Moy <Matthieu.Moy@imag.fr>
> Date:   Mon Aug 31 16:32:20 2015 +0200
>
>     Merge remote-tracking branch 'edward/utf-8-email-support4'
>
> I guess Git counts the number of parents that are actually in the
> repository, but it could check the number of "parents" field in the
> object (cat-file -p was still able to show 2).

I do not think this is limited to shallow but for grafts in
general.  cat-file is low-level to show the bare metal, but by using
these facility you asked Git to give you an imaginary history where
that commit is the root commit--and that is why it is shown, I
think.

What does it do if you say "git -c log.showRoot=false log -p"?
