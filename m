From: David Lang <david@lang.hm>
Subject: RE: Question re. git remote repository
Date: Wed, 16 Jan 2013 18:49:12 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1301161843390.21503@nftneq.ynat.uz>
References: <A0DB01D693D8EF439496BC8B037A0AEF322098A4@xmb-rcd-x15.cisco.com> <alpine.DEB.2.02.1301161617240.21503@nftneq.ynat.uz> <A0DB01D693D8EF439496BC8B037A0AEF32209A54@xmb-rcd-x15.cisco.com> <alpine.DEB.2.02.1301161721110.21503@nftneq.ynat.uz>
 <A0DB01D693D8EF439496BC8B037A0AEF32209AD2@xmb-rcd-x15.cisco.com> <alpine.DEB.2.02.1301161756240.21503@nftneq.ynat.uz> <A0DB01D693D8EF439496BC8B037A0AEF32209B45@xmb-rcd-x15.cisco.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"ishchis2@gmail.com" <ishchis2@gmail.com>
To: "Matt Seitz (matseitz)" <matseitz@cisco.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 03:51:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvfZG-0005rV-58
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 03:51:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757922Ab3AQCul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 21:50:41 -0500
Received: from mail.lang.hm ([64.81.33.126]:60987 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756292Ab3AQCul (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 21:50:41 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id r0H2obXC029097;
	Wed, 16 Jan 2013 18:50:37 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <A0DB01D693D8EF439496BC8B037A0AEF32209B45@xmb-rcd-x15.cisco.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213838>

On Thu, 17 Jan 2013, Matt Seitz (matseitz) wrote:

>> From: David Lang [mailto:david@lang.hm]
>>
>> On Thu, 17 Jan 2013, Matt Seitz (matseitz) wrote:
>>
>>> 1. a bare repository that is normally accessed only by "git push" and
>>> "git pull" (or "git fetch"), the central repository model.
>>
>> pulling from it would not be a problem, I could see issues with multiple
>> pushes taking place (the underlying repository would not get corrupted, but you
>> will very quickly hit conflicts where the push is not a fast forward and you
>> need to merge, not just push)
>
> How is that different on a network file system, as opposed to using http, ssh, or git-daemon?  Don't you get a "not a fast-forward" error, regardless of the protocol?

true.

>>> 2. a repository where only one user does "git add" and "git commit",
>> while
>>> other users will do "git pull", the peer-to-peer model (you pull changes
>> from
>>> me, I pull changes from you).
>>
>>
>> pulling from a shared repository is probably safe, but I wouldn't bet
>> against
>> there being any conditions where a pull at the same time someone is doing
>> an
>> update being able to cause problems.
>
> Why do you think there would be a problem?
>
>> The normal thing is to do the pulls through git-daemon, and that does make
>> sure
>> that what you are pulling is consistant.
>
> What does "git pull" via git-daemon do to ensure consistency that is different from "git pull" on a network file system?

git pull via the daemon looks at what tree items you have on each end, and then 
it sends you the items needed to make you match the server. If there are partial 
updates on the server (due to some update in process) the daemon should not see 
that, but if you are grabbing the files directly, I would be less confident that 
you are always safe.

you may _be_ safe, and if others who really know the internals speak up, take 
their word on it. But, absent assurances that we know that everything is done in 
the right order in the face of a networked filesystem (which may break 
visibility of changes due to caching), I would not trust such raw access for 
updates at all, and only somewhat trust it for read-only use.

David Lang
