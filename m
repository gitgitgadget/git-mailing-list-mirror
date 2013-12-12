From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-submodule.sh respects submodule.$name.update in .git/config but not .gitmodules
Date: Thu, 12 Dec 2013 13:17:48 -0800
Message-ID: <xmqqppp1sr9f.fsf@gitster.dls.corp.google.com>
References: <CABYr9QtSeX=Euf73MZPq6suo+GpVA=f+tH73Ct0tP-3LYogh9w@mail.gmail.com>
	<20131209223506.GF9606@sandbox-ub>
	<xmqqlhztvbi8.fsf@gitster.dls.corp.google.com> <52A8E689.80701@web.de>
	<20131211224424.GB25409@odin.tremily.us>
	<7vtxeeuaw7.fsf@alter.siamese.dyndns.org> <52AA072F.2000105@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "W. Trevor King" <wking@tremily.us>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Charlie Dyson <charlie@charliedyson.net>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Dec 12 22:17:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrDdu-0000Ps-MN
	for gcvg-git-2@plane.gmane.org; Thu, 12 Dec 2013 22:17:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815Ab3LLVRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Dec 2013 16:17:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45806 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751621Ab3LLVRx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Dec 2013 16:17:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAC25593ED;
	Thu, 12 Dec 2013 16:17:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nlAhX3waULdZsi3SCdUuqbHSugc=; b=jUEf+d
	mGvGbKCi1cS4YJy3gqmCmrUlz9iNMloMrGmOb1W1hVi9ZnSTULhu510VtBXrJFsm
	a045F1ZH49fc/GrX4OHy7PfXJK0N7VuuK9bbqPvxhyH3rapZi+YhZUF5nPGDSdTr
	zSv7sCQjQxz7ghwLc0R94ylrXgI9scQx8Mqv8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eGY+dYxjt57Ciuqiwy+YcKdiI1WLGuxS
	4WQySV+p05jpQNn/Z/leEGd7rZ/1x8X/LMWs2AdsGpg1ObPGhy0YrWjSP7L4HnZi
	Lvv+rGbQWiYIqWRdk76jO9+/k4v0Da7bm3Tf4+2LxMIsOY0IbT3Kc4vNJMmCA7cF
	qFJklJ7Dfvs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4005593EC;
	Thu, 12 Dec 2013 16:17:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D50D5593EB;
	Thu, 12 Dec 2013 16:17:51 -0500 (EST)
In-Reply-To: <52AA072F.2000105@web.de> (Jens Lehmann's message of "Thu, 12 Dec
	2013 19:57:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DBF88784-6372-11E3-B46D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239246>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 12.12.2013 02:16, schrieb Junio C Hamano:
>> "W. Trevor King" <wking@tremily.us> writes:
>> 
>>> For
>>> safety, maybe the default `init` should copy *everything* into
>>> .git/config, after which users can remove stuff they'd like to
>>> delegate to .gitmodules.
>> 
>> Copying everything into config is "be unsafe and inconvenient by
>> default for everybody", isn't it?  Folks who want safety are forced
>> to inspect the resulting entries in their config file (which is more
>> inconvenent if you compare with the design where nothing is copied
>> and nothing dynamically defaults to what then-current .gitmodules
>> happens to contain).  Folks who trust those who update .gitmodules
>> for them are forced to update their config every time upstream
>> decides to use different settings in .gitmodules, because they have
>> stale values in their config that mask what are in .gitmodules.
>> 
>> I think the solution we want is to copy only minimum to the config
>> (and that "minimum" may turn out to be "nothing"), and to default
>> keys that are only absolutely safe to .gitmodules file.
>
> I agree and will prepare a patch for that.
>
> What about teaching "git submodule sync" the "--url", "--update",
> "--fetch", "--ignore", "--branch" and "--all" options to allow the
> user to copy the current settings he wants from .gitmodules to
> .git/config (but only safe values of course)?

An option per variable, which forms an unbounded set over time? From
the syntax point of view, "--copy-config=url,update,..."  probably
is a better option, but I think that misses the point.  Copying will
freeze the choice in stone.

Also, as long as the copying is deliberately done with such an
option, copying potentially "unsafe" ones is perfectly fine.

Reading and using what are not copied from the .gitmodules file _is_
a lot more severe security risk, so your "only safe ones, of course"
should apply more heavily on that side. In principle, by default, we
should use *nothing* from .gitmodules, and make exceptions on case
by case basis, allowing only the safe ones.

What is missing is a support for those like W. Trevor who trust what
are in .gitmodules, and want to use values from there for ones we do
not add to that default list of exceptions. They are not helped by
such an option to say "copy these keys from .gitmodules to my
config". They do not want to freeze values to what was in there at
one point. They want to just follow along, whatever values happen to
be set in the .gitmodules file of the day.

So I _think_ a better approach would be to let users say something
like:

	[submodule "frotz"]
        	useInTreeSetting = update ignore

in their .git/config file in the repository of the top-level
project, to tell Git:

    When 'submodule.frotz.update' or 'submodule.frotz.ignore' is
    needed, please read from the .gitmodules file to grab the value
    for that setting. I trust the project as a whole to set a
    suitable value for me.

and copy almost nothing to .git/config file upon 'init' time.

If we were to go this route, I would envision that this new variable
would be a list of keys to additionally allow defaulting to the
values found in .gitmodules; if we hardcode 'branch', for example,
as one of the keys that we fallback to .gitmodules, and if the user
does *not* want to follow along to the project's recommendation,
the user can just set "submodule.frotz.branch = <desired value>" in
the .git/config file, and there is no need for the useIntreeSetting
variable to support "Git by default may allow this variable 'branch'
to be read from .gitmodules but I do not like that".
