From: Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com>
Subject: Re: Unexpected behaviour after removing submodule
Date: Fri, 26 Oct 2012 12:05:24 +0200
Message-ID: <508A6064.4060706@morey-chaisemartin.com>
References: <50895580.9080408@morey-chaisemartin.com> <5089C192.2050903@web.de>
Reply-To: devel-git@morey-chaisemartin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Oct 26 13:24:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRi1F-0006zF-K3
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 13:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758360Ab2JZLXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 07:23:53 -0400
Received: from 9.mo4.mail-out.ovh.net ([46.105.40.176]:46515 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755707Ab2JZLXw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 07:23:52 -0400
Received: from mail247.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id 93EA2104FD02
	for <git@vger.kernel.org>; Fri, 26 Oct 2012 12:12:25 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 26 Oct 2012 12:05:28 +0200
Received: from unknown (HELO sat.lin.mbt.kalray.eu) (devel-git@morey-chaisemartin.com@5.23.40.158)
  by ns0.ovh.net with SMTP; 26 Oct 2012 12:05:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
X-Ovh-Mailout: 178.32.228.4 (mo4.mail-out.ovh.net)
In-Reply-To: <5089C192.2050903@web.de>
X-Ovh-Tracer-Id: 6945676525466214327
X-Ovh-Remote: 5.23.40.158 ()
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeehfedrudduucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfhrhhomheppfhitgholhgrshcuofhorhgvhidqvehhrghishgvmhgrrhhtihhnuceouggvvhgvlhdqghhithesmhhorhgvhidqtghhrghishgvmhgrrhhtihhnrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecujfgurhepkfffhfhrfgggvffufhgjtgfgsehtjegrtddtfedu
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeehfedruddtucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfhrhhomheppfhitgholhgrshcuofhorhgvhidqvehhrghishgvmhgrrhhtihhnuceouggvvhgvlhdqghhithesmhhorhgvhidqtghhrghishgvmhgrrhhtihhnrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecujfgurhepkfffhfhrfgggvffufhgjtgfgsehtjegrtddtfedu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208434>

On 26/10/12 00:47, Jens Lehmann wrote:
> Am 25.10.2012 17:06, schrieb Nicolas Morey-Chaisemartin:
>> At work, we use a lot of submodules (several levels of submodules actually).
>> As we also work with development branches, we use scripts to resync the whole checked-out tree (mainly in automated integration)
>>
>> We recently run across an issue where a branch (dev) contained a submodule while it had been removed in master and the files were imported in a subdirectory with the same name (probably using git-subtree).
>>
>> Basically:
>>
>> On dev:
>> * top/refs(submodule)/file1
>> On master:
>> * top/refs(dir)/file1
>>
>> Outside the fact that it is quite hard to move from one branch to the other while having a perfectly clean tree checked out underneath, we manage to end up into a weird (invalid) state
>> that was neither clearly described nor "easy" to cleanup (using standard git clean/checkout/reset commands).
> <snipped example without submodules>
>
>> The issue is, there is no way from folder2 to see that something "wrong" is going on inside your tree!
>> As we manage to reach this state using only standard git commands (I'll try to reproduce it) with submodules, and this being part of an automated flow, it is quite worrying.
>> We may actually be committing in the wrong repo and pushing the wrong things around.
>>
>> Is there or should there be a way to look for such issues? And is this an expected behaviour?
> Unfortunately this is how things work at the moment. If you remove a
> submodule its work tree will currently stay around nonetheless. And
> when you replace it with a directory containing files tracked by git,
> things start to get really weird when you do checkouts crossing that
> conversion.
>
> But the solution to that problem is coming closer. The first step was
> to move the .git directory out of the submodule's work tree, so that
> we are able to remove it without loosing any history. The next step
> will be to enable git to remove and re-add submodules on checkout. The
> "remove a submodule" part already works in my - still experimental -
> recursive_submodule_checkout branch at my github repo. The thing that
> is still missing - apart from tests ;) - is that checkout has to learn
> to look into the to-be-checked-out .gitmodules to be able to populate
> a re-appearing submodule. I plan to add that for git fetch first (so
> it can fetch submodules the user showed interest in but which aren't
> currently checked out) and after that I'll reuse it for checkout.
>
> But that's still some work to do and will take some time ...
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

That's what I figured. I just wished there was at least a way to see that there's a .git directory that does not really belong.
To check that now we'd have to do a git-ls tree and look for .git that shouldn't be here but with the amount of file we have, a shell script doing that would take ages !

We'll wait for a more submodule aware version of checkout then !

Thanks

Nicolas
