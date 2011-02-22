From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [1.8.0] Recursively checkout, merge and reset populated submodules
Date: Tue, 22 Feb 2011 09:11:24 +0100
Message-ID: <4D636FAC.3000105@web.de>
References: <7vwrky5f48.fsf@alter.siamese.dyndns.org>	<4D5FF6E7.8090104@web.de> <4D628F21.3050808@xiplink.com>	<4D62AF46.8030508@web.de> <4D62C385.90204@xiplink.com>	<4D62ED38.7070408@web.de> <87ei70riw1.fsf@catnip.gol.com> <4D632029.7040501@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Miles Bader <miles@gnu.org>, Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 09:11:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrnLK-0006S0-Fv
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 09:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795Ab1BVIL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 03:11:29 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:56331 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619Ab1BVIL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 03:11:28 -0500
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate03.web.de (Postfix) with ESMTP id 386211890A794;
	Tue, 22 Feb 2011 09:11:27 +0100 (CET)
Received: from [93.240.119.156] (helo=[192.168.178.43])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PrnLD-0006Kh-00; Tue, 22 Feb 2011 09:11:27 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <4D632029.7040501@cisco.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+H9IMr7v0c0WTU9vqAH7gJZC3z6bMToCrZaf8o
	AhE9zCHPP4eWq0v5lOKIGOP5OShpSkGl9wBcU4jd+SaEd3Budu
	ZX6rYRHY9iDYuu88gU+Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167534>

Am 22.02.2011 03:32, schrieb Phil Hord:
> On 02/21/2011 07:51 PM, Miles Bader wrote:
>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>>>>> So, .gitmodules initially controls recursion.  When a submodule gets
>>>>>> populated, it gets an entry in .git/config which then determines the
>>>>>> recursion behavior from then on.  Changing branches might change .gitmodules,
>>>>>> but anything in .git/config will persist so any customizations the user makes
>>>>>> will also persist.
>>>>
>>>> Yes. Upstream can give sane defaults but the user has the last word.
>> If .git/config entries are created _automatically_ based on the initial
>> .gitmodules, doesn't that means it will cease to respect the upstream
>> defaults in the case where .gitmodules changes, even if the user didn't
>> actually change anything himself...?

Yes, unfortunately that is the current behavior of the git-submodule
command, it copies the "update" entry into .git/config on init (but
not on sync, so it is not updated then if it changed). The other
submodule flags ("ignore" & "fetchRecurseSubmodules" don't show that
behavior, the user has to copy them herself to override upstream
settings). I'm in favor of removing that copy and using the setting
from .gitmodules when "update" is not found in .git/config, but this
changes behavior. But maybe that is a worthwhile change for 1.8.0
preparing for the things to come?

> Also consider that the .gitmodules'  "upstream defaults" may have many
> changes
> within the existing repository.  So, $(git checkout foo) will load some
> "defaults" and
> $(git checkout bar) may load different "defaults".

Yes, and that is a feature. E.g. when you have a "working on foo"
branch you can set the "fetchRecurseSubmodules" to "yes" there because
you want to get all commits in the submodule to be able to commit some
new ones in the superproject. But in every other branch setting that to
"on-demand" will suffice.

>  I guess the defaults
> can be migrated
> into .git/config using $(git submodule init)...?

Not with "git submodule init", as they then would be set in stone from
the beginning. But I can imagine a "git submodule config <setting>"
helper program, which copies the setting into .git/config or updates
it there when wanted.
