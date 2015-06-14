From: "Andres G. Aragoneses" <knocte@gmail.com>
Subject: Re: RFC: reverse history tree, for faster & background clones
Date: Sun, 14 Jun 2015 16:14:53 +0200
Message-ID: <mlk28u$mm4$1@ger.gmane.org>
References: <mlefli$h6v$1@ger.gmane.org>	 <1434108815.5381.3.camel@kaarsemaker.net> <mlegd8$t71$1@ger.gmane.org> <1434112410.5381.8.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 16:15:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z48h0-0006jh-LB
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 16:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbbFNOPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 10:15:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:40012 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751417AbbFNOPH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 10:15:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Z48gi-0006cF-IB
	for git@vger.kernel.org; Sun, 14 Jun 2015 16:15:04 +0200
Received: from 46.24.152.62 ([46.24.152.62])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 16:15:04 +0200
Received: from knocte by 46.24.152.62 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 16:15:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 46.24.152.62
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <1434112410.5381.8.camel@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271640>

On 12/06/15 14:33, Dennis Kaarsemaker wrote:
> On vr, 2015-06-12 at 13:39 +0200, Andres G. Aragoneses wrote:
>> On 12/06/15 13:33, Dennis Kaarsemaker wrote:
>>> On vr, 2015-06-12 at 13:26 +0200, Andres G. Aragoneses wrote:
>>>
>>>> AFAIU git stores the contents of a repo as a sequence of patches in the
>>>> .git metadata folder.
>>>
>>> It does not, it stores full snapshots of files.
>>
>> In bare repos too?
>
> Yes. A bare repo is nothing more than the .git dir of a non-bare repo
> with the core.bare variable set to True :)
>
>>>> 1. `git clone --depth 1` would be way faster, and without the need of
>>>> on-demand compressing of packfiles in the server side, correct me if I'm
>>>> wrong?
>>>
>>> You're wrong due to the misunderstanding of how git works :)
>>
>> Thanks for pointing this out, do you mind giving me a link of some docs
>> where I can correct my knowledge about this?
>
> http://git-scm.com/book/en/v2/Git-Internals-Git-Objects should help.

Wow, now I wonder if I should also propose a change to make git 
optionally not store the full snapshots, so save disk space. Thanks for 
pointing this out to me.


>>>> 2. `git clone` would be able to allow a "fast operation, complete in the
>>>> background" mode that would allow you to download the first snapshot of
>>>> the repo very quickly, so that the user would be able to start working
>>>> on his working directory very quickly, while a "background job" keeps
>>>> retreiving the history data in the background.
>>>
>>> This could actually be a good thing, and can be emulated now with git
>>> clone --depth=1 and subsequent fetches in the background to deepen the
>>> history. I can see some value in clone doing this by itself, first doing
>>> a depth=1 fetch, then launching itself into the background, giving you a
>>> worktree to play with earlier.
>>
>> You're right, didn't think about the feature that converts a --depth=1
>> repo to a normal one. Then a patch that would create a --progressive
>> flag (for instance, didn't think of a better name yet) for the `clone`
>> command would actually be trivial to create, I assume, because it would
>> just use `depth=1` and then retrieve the rest of the history in the
>> background, right?
>
> A naive implementation that does just clone --depth=1 and then fetch
> --unshallow would probably not be too hard, no. But whether that would
> be the 'right' way of implementing it, I wouldn't know.

Ok, anyone else that can give an insight here?

I imagine that I would not get real feedback until I send a [PATCH]...

I guess I would use a user-facing message like this one:

Finished cloning the last snapshot of the repository.
Auto downloading the rest of the history in background.

(Since there's already a similar "background" feature already wrt 
auto-packing the repository: `Auto packing the repository in background 
for optimum performance. See "git help gc" for manual housekeeping.`.)

Thanks
