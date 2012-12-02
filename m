From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] submodule: add 'deinit' command
Date: Sun, 02 Dec 2012 20:55:22 +0100
Message-ID: <50BBB22A.7050901@web.de>
References: <20121130032719.GE29257@odin.tremily.us> <50B54A68.60309@web.de> <20121130175309.GA718@odin.tremily.us> <CABURp0qNBcFnxbvhn7PsKWLUOsTiK4u5vx-=6cG3JQHw9aUeHA@mail.gmail.com> <50BA2892.7060706@web.de> <50BA3412.60309@web.de> <7vy5hhmcwp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <phil.hord@gmail.com>,
	"W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 20:55:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfFdt-0004VW-8b
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 20:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194Ab2LBTzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2012 14:55:33 -0500
Received: from mout.web.de ([212.227.15.4]:63697 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754110Ab2LBTzb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2012 14:55:31 -0500
Received: from [192.168.178.41] ([91.3.176.235]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0LrarZ-1TDOCs05zJ-013l0A; Sun, 02 Dec 2012 20:55:23
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vy5hhmcwp.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
X-Provags-ID: V02:K0:M1CsbLApjA7gT3Bo+Za68JadhssKsocy2SNDwKB+9Fn
 KIAldQ3AiOwAt2tLzZdVR051uw1ZkaUpZzp+RjiwIQJusAH8GA
 FVffhSKjXZNb95iMJemuGnpvzQH1mFUlsDhr9kbZWTReRwsVYS
 k4kRzAfwsUbr9KXIggyLwYSJUPswCtrIsOipU9qjgZCdepQ5cP
 1z+V+DmdPby2n0bJ1ETog==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211016>

Am 02.12.2012 03:00, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> With "git submodule init" the user is able to tell git he cares about one
>> or more submodules and wants to have it populated on the next call to "git
>> submodule update". But currently there is no easy way he could tell git he
>> does not care about a submodule anymore and wants to get rid of his local
>> work tree (except he knows a lot about submodule internals and removes the
>> "submodule.$name.url" setting from .git/config himself).
>>
>> Help those users by providing a 'deinit' command. This removes the url
>> setting from .git/config either for the given submodule(s) or for all
>> those which have been initialized if none were given. Complain only when
>> for a submodule given on the command line the url setting can't be found
>> in .git/config.
>>
>> Add tests and link the man pages of "git submodule deinit" and "git rm" to
>> assist the user in deciding whether removing or unregistering the submodule
>> is the right thing to do for him.
>>
>> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
>> ---
> 
> I fully agree with your analysis on the reason why the "url" element
> is special and has to be copied to $GIT_DIR/config, but when you
> deinit (or uninit) a submodule to say you are no longer interested
> in it and do not want it populated in the context of the
> superproject, I am not sure if removing only submodule.$name.url (so
> that when you later decide to "init" it again, you will keep the
> values for submodule.$name.update and other things from the previous
> life) is the sane thing to do, or it is better to remove
> submodule.$name.* altogether as if an earlier "init" has never
> happened.  Would it be worth analyzing the pros-and-cons here?

Sure. I was worried about throwing away other settings the user
might have set in the submodule.$name section and the first reflex
was to protect them. But thinking about that again I noticed we are
already throwing away a possibly user customized "url" setting, so
we already remove a possibly customized setting.

Maybe the principle of least surprise is better followed when we
nuke the whole section, as it might surprise the user more to have
a setting resurrected he customized in the last life cycle of the
submodule than seeing that after an deinit followed by an init all
former customizations are consistently gone. So I tend to think now
that removing the whole section would be the better solution here.

Opinions by other submodule users?
