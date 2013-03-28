From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Composing git repositories
Date: Thu, 28 Mar 2013 21:17:59 +0100
Message-ID: <5154A577.2020103@web.de>
References: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com> <7vmwtqt8rs.fsf@alter.siamese.dyndns.org> <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com> <7vvc8comj5.fsf@alter.siamese.dyndns.org> <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com> <20130327192630.GF28148@google.com> <CALkWK0nreJZX4msFET0a7cuUMWNbQhhqy+ezrkqYGqL4_a2duA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 21:18:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULJHL-0003Jf-S4
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 21:18:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300Ab3C1USD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 16:18:03 -0400
Received: from mout.web.de ([212.227.17.11]:50328 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091Ab3C1USC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 16:18:02 -0400
Received: from [192.168.178.41] ([91.3.172.174]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0LrKEG-1Umi2e0HAy-0137bd; Thu, 28 Mar 2013 21:18:00
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <CALkWK0nreJZX4msFET0a7cuUMWNbQhhqy+ezrkqYGqL4_a2duA@mail.gmail.com>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:9TbzE0K/3oUFti+g6QI+Go1b7W6wBaTpK96xuwNjfAO
 WmQ7xWynJrEHxFjiurGRa9oOoOsqLQDGH6bdjkelCb8HRcHnKM
 Jf7yxyZyGzj+iMRIMHrYKVZsCnZMaf1iZtlKz5tFO68OsI9MR4
 F4bEaNwMrhCiEGFxM/V+kySGx4A+onWherr6CkWRQaXftXpgu1
 Fn+aS7sMka4iizM7liVQA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219455>

Am 28.03.2013 11:01, schrieb Ramkumar Ramachandra:
> Jonathan Nieder wrote:
>> Do you mean that you wish you could ignore subrepository boundaries
>> and use commands like
>>
>>         git clone --recurse-submodules http://git.zx2c4.com/cgit
>>         cd cgit
>>         vi git/cache.h
>>         ... edit edit edit ...
>>         git add --recurse-submodules git/cache.h
>>         git commit --recurse-submodules
>>         git push --recurse-submodules
>>
>> , possibly with configuration to allow the --recurse-submodules to be
>> implied, and have everything work out well?
> 
> Do you realize how difficult this is to implement?  We'll need to
> patch all the git commands to essentially do what we'd get for free if
> the submodule were a tree object instead of a commit object (although
> I'm not saying that's the Right thing to do).  Some caveats:
> 
> - If we maintain one global index, and try to emulate git-subtree
> using submodules, we've lost.  It's going to take freakin' ages to
> stat billions of files across hundreds of nested sumodules.  One major
> advantage of having repository boundaries is separate object stores,
> indexes, worktrees: little ones that git is designed to work with.

Are you aware that current Git code already stats all files across
all submodules recursive by default? So (again) no problem here, we
do that already (unless configured otherwise).

> - Auto-splitting commits that touch multiple submodules/ superproject
> at once.  Although git-subtree does this, I think it's horribly ugly.

You don't like it, but what technical argument is hidden here I'm
missing?

> - Auto-propagating commits upwards to the superproject is another big
> challenge.  I think the current design of anchoring to a specific
> commit SHA-1 has its usecases, but is unwieldy when things become big.
>  We have to fix that first.

What??? Again there is nothing to "fix" here, "anchoring to a specific
commit SHA-1" is *the* most prominent use case (think reproducibility
of the whole work tree), floating submodules are the oddball here.
