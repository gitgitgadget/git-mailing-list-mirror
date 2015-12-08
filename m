From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] config: add core.untrackedCache
Date: Tue, 08 Dec 2015 14:43:14 -0800
Message-ID: <xmqqfuzck1dp.fsf@gitster.mtv.corp.google.com>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
	<1449594916-21167-8-git-send-email-chriscool@tuxfamily.org>
	<xmqqsi3ckadi.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gersh?= =?utf-8?Q?ausen?= 
	<tboegi@web.de>, Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 23:43:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6Qz7-0004dv-0B
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 23:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbbLHWnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2015 17:43:17 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61497 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750912AbbLHWnR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2015 17:43:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EAB2F32D9C;
	Tue,  8 Dec 2015 17:43:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ccLyspqHBrGvZXdF9dTTWSvpJAQ=; b=GvXGl7
	RutsqWbkZokgBoU9ed4YJSqRW5Uoz1cHSikM30ThD1SUvD4rL9DNqU4S0bh4wf4F
	rlPShH8UHVzYZ64L0XLM6Moug+PKUF6cIpCZSPTn93vTzkoQrX8enBV9FfBuoRlP
	Lnped6JmEyM73ednI2jdRlKIsVHrbh2vzzt4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fbFdCq+heTBC00vvAB85kUQNYnVOXAxJ
	vqoy4b+PIiPGFgYvFlg1zwHvG/Zr08Ng+DFuvCnlDUXwalV04jlJHgOg5+9Xrq5J
	PWtH+YiBGDkIbdsRHjwImS24SIQdUiqZc6eFYciAI9Q+xDFysSU7Oae28VbuZCFJ
	B+V4X+X8cUc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D5D7A32D9B;
	Tue,  8 Dec 2015 17:43:15 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2C57532D9A;
	Tue,  8 Dec 2015 17:43:15 -0500 (EST)
In-Reply-To: <xmqqsi3ckadi.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 08 Dec 2015 11:28:57 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 119F220A-9DFD-11E5-9BB4-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282178>

Junio C Hamano <gitster@pobox.com> writes:

> Christian Couder <christian.couder@gmail.com> writes:
>
>> When we know that mtime is fully supported by the environment, we
>> might want the untracked cache to be always used by default without
>> any mtime test or kernel version check being performed.
>>
>> Also when we know that mtime is not supported by the environment,
>> for example because the repo is shared over a network file system,
>> then we might want 'git update-index --untracked-cache' to fail
>> immediately instead of preforming tests (because it might work on
>> some systems using the repo over the network file system but not
>> others).
>> ...
> The logic in this paragraph is fuzzy to me.  Shouldn't the config
> give a sensible default, that is overriden by command line options?
> I agree that it is insane to do a runtime check when the user says
> "update-index --untracked-cache" to enable it, as the user _knows_
> that enabling it would help (or the user _knows_ that she wants to
> play with it).  Similarly, shouldn't the config be ignored when the
> user says "update-index --no-untracked-cache" (hence removing the
> untracked cache from the resulting index no matter the config is set
> to)?  ...

As I think about this more, it really seems to me that we shouldn't
need to make this configuration variable that special.  Because I
think it is a *BUG* in the current implementation to do the runtime
check even when the user explicitly tells us to use untracked-cache,
I'd imagine something along the lines of the following would be a
lot simpler, easier to understand and a generally more useful
bugfix:

 1 Add one boolean configuration variable, core.untrackedCache, that
   defaults to 'false'.

 2 When creating an index file in an empty repository, enable the
   untracked cache in the index (even without the user runninng
   "update-index --untracked-cache") iff the configuration is set to
   'true'.  No runtime check necessary.

 3 When working on an existing index file, unless the operation is
   "update-index --[no-]untracked-cache", keep the current setting,
   regardless of this configuration variable.  No runtime check
   necessary.

 4 "update-index --[no-]untracked-cache" should enable or disable
   the untracked cache as the user tells us, regardless of the
   configuration variable.  No runtime check necessary.

It is OK to then add an "auto-detect" on top of the above, that
would only affect the second bullet point, like so:

 2a When creating an index file in an empty repository, if the
    configuration is set to 'auto', do the lengthy runtime check and
    enable the untracked cache in the index (even without the user
    runninng "update-index --untracked-cache").

without changing any other in the first 4-bullet list.

Am I missing some other requirements?
