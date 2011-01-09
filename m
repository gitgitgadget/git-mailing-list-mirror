From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug? in checkout with ambiguous refnames
Date: Sat, 08 Jan 2011 23:31:18 -0800
Message-ID: <7v1v4m8reh.fsf@alter.siamese.dyndns.org>
References: <20110107104650.GA5399@pengutronix.de>
 <20110107194909.GB6175@sigill.intra.peff.net>
 <alpine.DEB.1.10.1101081449220.12031@debian>
 <20110108214011.GA4753@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 09 08:31:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pbpka-0003hf-FT
	for gcvg-git-2@lo.gmane.org; Sun, 09 Jan 2011 08:31:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869Ab1AIHbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jan 2011 02:31:33 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58170 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab1AIHbc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jan 2011 02:31:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E18794702;
	Sun,  9 Jan 2011 02:32:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E4ty8YGPFfPe+6dBbXs00KivyX0=; b=UdBJKQ
	7yaz4bUXvE4aMOClIMGxWIjB2DqPwArUkbXX9iDYW1ukjYUI6U/5Hy61CXwRrnEm
	+S6gOcb/Mj8ybCrOU24ZkRLlGMerZRbrbIbuwPGGeuT5vXp+O7/ME6btDMS5jmCk
	rdk5IUhGIb7eYKKU4HAwFOMdGoCEI9/N6Py6M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GuHIZ0bQrOwgffJiCt+Nkro+A/IMU8NV
	o7Q4SGQ198PAmySOpQ9arbuYacaVmINRYyWvbl1wcJvre+riKyZw6TsmJzS/KqSl
	bCcPC/l52l/NqlcHY2mCNfGu9Lxg8LP1sWPsMH2Q3Y1L7zS6NWNxggbyTiTnghn3
	hwgwzkho1KM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9F0F84701;
	Sun,  9 Jan 2011 02:32:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2243B4700; Sun,  9 Jan 2011
 02:32:00 -0500 (EST)
In-Reply-To: <20110108214011.GA4753@sigill.intra.peff.net> (Jeff King's
 message of "Sat\, 8 Jan 2011 16\:40\:11 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8F7DE48A-1BC2-11E0-8327-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164845>

Jeff King <peff@peff.net> writes:

> On Sat, Jan 08, 2011 at 03:40:33PM -0500, Martin von Zweigbergk wrote:
>
>> > Yeah, we generally resolve ambiguities in favor of the tag (and that
>> > warning comes from deep within get_sha1_basic). So the real bug here is
>> > that it still said "Switched to branch", which is totally wrong.
>> > 
>> > That being said, it probably would make more sense for "git checkout" to
>> > prefer branches to tags.
>> 
>> What was the rationale for generally favoring tags?
>
> I don't recall hearing any specific argument, but it has always been
> that way from early on. I think it is from a vague sense of "tags are
> more important than branch tips because they are about marking specific
> points, not lines of development". But maybe other old-timers can say
> more.
>
> I don't necessarily buy that argument; my only reasoning is that we
> should probably keep historic behavior.

I don't think "tags are more important" has ever been a serious argument,
either.  We prefix refs/tags/ and refs/heads/ to see if what the user gave
us is a short hand, and we have to pick one to check first, and we
happened to have chosen to check tags/ before heads/.  Majority of people
have been trained by the ambiguity warning not to use the same name for
their tags and branches, and the rest have learned to live with this
convention.

Among those "rest who have learned to live with" minority are people who
use v1.0 branch to maintain v1.0 codebase after it is tagged, and they
would want to work on v1.0 branch (by checking out v1.0 branch) and
measure their progress by disambiguating between heads/v1.0 and tags/v1.0
when driving "git log" family.  There is no strong reason to forbid them
from doing this by requiring uniqueness if that is what they want,
although I personally would suggest them to use maint-1.0 branch that
forks from v1.0 tag.

Aside from your "'checkout branch' is about checking out a branch"
explanation, there are two reasons to favor branches over tags in
"checkout" command:

 (1) You cannot disambiguate "git checkout heads/master" when you have
     "master" tag, as this notation is used to tell the command "I want to
     detach HEAD at that commit"; and

 (2) The command already treats an unadorned branch name specially by not
     complaining ref/path ambiguity when you said "git checkout master"
     and you have a file called "master" in your working tree, so users
     already expect that an unadorned branch name is special to it.
