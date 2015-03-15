From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC][GSoC] make "git diff --no-index $directory $file" DWIM better.
Date: Sun, 15 Mar 2015 15:00:32 -0700
Message-ID: <xmqqzj7dsyyn.fsf@gitster.dls.corp.google.com>
References: <CAHLaBN+93mp6PQmtfjOHSvfW7iwDXwPitGQ5W1am9KBm9EZV2Q@mail.gmail.com>
	<CAPig+cQgvwd=5hLGeOpY1r_476HbpUarumsu_QDU4HwB7ynXmw@mail.gmail.com>
	<CAHLaBN+RVpDrG9OewUS7LCYaEOvVqsTY3znapgMj7VrMJWHaDw@mail.gmail.com>
	<CAPig+cRFCktpG2ksNnRZiFxDqmQnq38MafkA1E-LC6CHtcuk9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Yurii Shevtsov <ungetch@gmail.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 23:00:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXGaZ-00014D-Bb
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 23:00:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbbCOWAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 18:00:40 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63213 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750776AbbCOWAj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 18:00:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AA61F405F2;
	Sun, 15 Mar 2015 18:00:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EzVQYhFBCTyd/2zzNl2PLKfUGdk=; b=cSf6ky
	UOZtTsmaecA4cmg5zEbp2BqzciYaVJATvHOyiN4tE7N1sCWXEF+DvS49jJCdj8l9
	WFaqO5Jaif3gThxG3k5GD3Yv7d9FUSQMrGaTI4mUUr7LulFlG8P0bg2IAsmfjcQP
	OZBlr+vtSLNlU9EU4jrd+hLMUb4omKHnuujkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g2W8ULQKdbYYZsVbwnZXLFL9sD09SjIu
	HMQvJGo++Yf3b1BU2O7/3wGCfkMmT14rnd3H+zo0x3+EVJgf7tXvRG/U8HfjpkMR
	QixX3dCqQfVptPGS2ibA7YG1lbEBiSPkUj5Z3qIchs8uLbTCOhLSq7wG+9d+mR/e
	/W0gScqdX2k=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D3B8405F1;
	Sun, 15 Mar 2015 18:00:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 18F85405E5;
	Sun, 15 Mar 2015 18:00:33 -0400 (EDT)
In-Reply-To: <CAPig+cRFCktpG2ksNnRZiFxDqmQnq38MafkA1E-LC6CHtcuk9g@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 15 Mar 2015 17:28:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B3C36342-CB5E-11E4-BB78-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265528>

Eric Sunshine <sunshine@sunshineco.com> writes:

>>> Is this name supposed to stand for "dir'n'file",...
> ...I personally find the idiomatic name 'path'
> easier to grok, however, Junio, of course, has final say-so.

If I were presented two identical patches, one calling it "path" and
the other calling it "dirnfile", I would definitely take the former,
but I agree that this is more of a preference than a taste, the
latter of which implies that you could make a value judgement,
i.e. "good taste" vs "bad taste".

If for some reason we had a code that called a variable "dirnfile"
already in our official codebase and we saw a patch to "correct"
that to "path", I would likely say that it is not worth the churn to
apply such a "correction" patch.  If the new name were "pathname",
however, I might be pursuaded to take it, simply because a
"pathname" is a lot more familiar word than "dirnfile".
