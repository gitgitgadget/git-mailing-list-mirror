From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: git-cherry-pick and author field in version 1.7.6.4
Date: Thu, 06 Oct 2011 14:37:02 +0200
Organization: 6WIND
Message-ID: <4E8DA0EE.50208@6wind.com>
References: <4E8C6F0E.7000508@6wind.com> <20111005174138.GA22962@sigill.intra.peff.net> <4E8D5DEA.9010500@6wind.com> <20111006112742.GA4445@sigill.intra.peff.net>
Reply-To: nicolas.dichtel@6wind.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 06 14:38:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBnDi-0000Um-4D
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 14:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758252Ab1JFMhI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Oct 2011 08:37:08 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52994 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758246Ab1JFMhH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 08:37:07 -0400
Received: by wwf22 with SMTP id 22so4175967wwf.1
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 05:37:06 -0700 (PDT)
Received: by 10.227.20.7 with SMTP id d7mr985981wbb.16.1317904625221;
        Thu, 06 Oct 2011 05:37:05 -0700 (PDT)
Received: from [192.168.1.4] (schneckos.n1c0.com. [88.182.61.195])
        by mx.google.com with ESMTPS id fo7sm9982354wbb.20.2011.10.06.05.37.03
        (version=SSLv3 cipher=OTHER);
        Thu, 06 Oct 2011 05:37:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23) Gecko/20110921 Thunderbird/3.1.15
In-Reply-To: <20111006112742.GA4445@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182940>

Le 06/10/2011 13:27, Jeff King a =C3=A9crit :
> On Thu, Oct 06, 2011 at 09:51:06AM +0200, Nicolas Dichtel wrote:
>
>> Here is my sequence. I'm in a linux tree with a remote that point to
>> linus tree and I want to cherry-pick a patch from this remote:
>>
>> # git cherry-pick 3f78d1f210ff89af77f042ab7f4a8fee39feb1c9
>> [dev 87ce387] drivers/net/usb/asix.c: Fix unaligned accesses
>>   1 files changed, 33 insertions(+), 1 deletions(-)
>> # git log -1 --format=3D'%an<%ae>'
>> Nicolas Dichtel<nicolas.dichtel@6wind.com>
>> # git log -1 --format=3D'%an<%ae>' 3f78d1f210ff89af77f042ab7f4a8fee3=
9feb1c9
>> Neil Jones<NeilJay@gmail.com>
>> #
>
> Hmph. Odd:
>
>    $ cd linux-2.6
>    $ git checkout -b dev 3f78d1f210ff89af77f042ab7f4a8fee39feb1c9^
>    Switched to a new branch 'dev'
>    $ git cherry-pick 3f78d1f210ff89af77f042ab7f4a8fee39feb1c9
>    [dev 78929c2] drivers/net/usb/asix.c: Fix unaligned accesses
>     Author: Neil Jones<NeilJay@gmail.com>
>     1 files changed, 33 insertions(+), 1 deletions(-)
>    $ git log -1 --format=3D'%an<%ae>'
>    Neil Jones<NeilJay@gmail.com>
# git checkout -b dev 3f78d1f210ff89af77f042ab7f4a8fee39feb1c9^
Checking out files: 100% (25721/25721), done.
Switched to a new branch 'dev'
# git cherry-pick 3f78d1f210ff89af77f042ab7f4a8fee39feb1c9
[dev 693df4c] drivers/net/usb/asix.c: Fix unaligned accesses
  1 files changed, 33 insertions(+), 1 deletions(-)
# git log -1 --format=3D'%an<%ae>'
Nicolas Dichtel<nicolas.dichtel@6wind.com>
#

>
>> Maybe it is related to the problem I've reported in another thread:
>> http://comments.gmane.org/gmane.comp.version-control.git/182853
>
> Possibly. That issue is about the commit that comes _after_ the
> cherry-pick, and in this instance, things are already wrong for you b=
y
> the time the cherry-pick has completed.
>
> However, the problem has to do with leaving a stale state file in .gi=
t,
> so perhaps a previous partially-completed cherry-pick has left cruft =
in
> .git that is confusing this cherry-pick (i.e., I can't reproduce beca=
use
> it is being affected by something that happened before the commands
> above). So let's see what Jay comes up with for solving the other
> problem, and I suspect it may just fix this issue, too.
I think so too. Will wait.

>
> You might also repeating the commands above. If it still fails, maybe
> try removing ".git/CHERRY_PICK_HEAD" if it exists and see if that hel=
ps.
No, it just allow the commit --amend, but this will not change the auth=
or.


Regards,
Nicolas
