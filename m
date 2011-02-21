From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] perl/Git.pm: moving away from using Error.pm module
Date: Sun, 20 Feb 2011 23:20:42 -0800
Message-ID: <7v4o7xluph.fsf@alter.siamese.dyndns.org>
References: <201102202346.36410.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Alex Riesen <raa.lkml@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 08:21:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrQ52-00065G-Oy
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 08:21:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228Ab1BUHU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 02:20:57 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44936 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852Ab1BUHU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 02:20:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 08D404977;
	Mon, 21 Feb 2011 02:22:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A/M4JWVxh01tBKYicwVPgg3LgCI=; b=V15Ks7
	wsHIsf8DmjWmApXPsns5b2kSboIOgXP+4AOCaxDyUITRKWAml6pFRL5e7mz08ZTV
	Ak6lyrmAKYUC6PbibfNvwstyR/1hHPMsQhJ9TtCoRFmjK6jLWLx6hgICd5I82/xA
	52enY/+KsMwDR7Uq554FCkmd0ZZydDkVcBj/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vMW10WX/JSSqxazrd8VwB6hzhA+met11
	hrX180rwJz/+rqOv1TwaSVXmJA8AbHESw5lKGi0uq7UVYNuxEC0VqM5N8HTtQgDk
	1uoWDKHgbkgd9yTbkS84FsmQ+w63S3m3KlNm/2Mk7WkGS08j5lx46QoCPyPxOOcU
	FhKpECDPbMg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A56B74976;
	Mon, 21 Feb 2011 02:22:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1650B4975; Mon, 21 Feb 2011
 02:21:54 -0500 (EST)
In-Reply-To: <201102202346.36410.jnareb@gmail.com> (Jakub Narebski's message
 of "Sun\, 20 Feb 2011 23\:46\:33 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 46A7F436-3D8B-11E0-B09C-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167445>

Jakub Narebski <jnareb@gmail.com> writes:

> Proposal:
>
> Replace use of Error.pm module in Git.pm with either Exception::Class
> based error class, or using 'carp'/'croak' from Carp, or both by adding 
> an option to set error handler in 'Git' class (like e.g. in 'CHI' 
> module on CPAN).

Personally, I was never a big fan of the syntax magic with Error.pm, but I
refrained from commenting on it as I am not heavily involved in that part
of the system.  If we are going to change things so that everybody uses a
more traditional "eval {}; if ($@) { ... }", it would be a welcome change
from my point of view.

> Migration plan:

Do we even need one?

As far as an external caller is concerned, it would have been expecting us
to throw an exception by dying, and it wouldn't have mattered if it used
Error.pm or "eval { $call_to_Git_pm }; if ($@) {...}", I think.
