From: David Lang <david@lang.hm>
Subject: Re: Recording the current branch on each commit?
Date: Tue, 29 Apr 2014 15:14:17 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1404291512420.14881@nftneq.ynat.uz>
References: <CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com> <535D6EB1.9080208@game-point.net> <CALKQrgdFLc=k9i1+N2458amLMGQa99q55A=N785VfMRwfOH6Rg@mail.gmail.com> <20140428.084543.1615507400056684596.chriscool@tuxfamily.org>
 <535E18E0.3010507@game-point.net> <CALKQrgfN-bE7KpZFadtD806Xk29N_R2sYurPQSKHLSh0UwcZiw@mail.gmail.com> <535E1C7A.3040504@game-point.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johan Herland <johan@herland.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Git mailing list <git@vger.kernel.org>
To: Jeremy Morton <admin@game-point.net>
X-From: git-owner@vger.kernel.org Wed Apr 30 00:14:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGIU-0004zf-29
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933262AbaD2WOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:14:38 -0400
Received: from mail.lang.hm ([64.81.33.126]:42261 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752537AbaD2WOh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:14:37 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id s3TMEHTP020397;
	Tue, 29 Apr 2014 15:14:22 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <535E1C7A.3040504@game-point.net>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247625>

On Mon, 28 Apr 2014, Jeremy Morton wrote:

> On 28/04/2014 10:09, Johan Herland wrote:
>> On Mon, Apr 28, 2014 at 11:01 AM, Jeremy Morton<admin@game-point.net> 
>> wrote:
>>> On 28/04/2014 07:45, Christian Couder wrote:
>>>> Yes, it's possible. Yesterday, I sent the following patch:
>>>> 
>>>> [RFC/PATCH 2/2] trailer: add examples to the documentation
>>>> 
>>>> and it shows a commit-msg hook to do something like that:
>>>> 
>>>> $ cat>.git/hooks/commit-msg<<EOF
>>>> #!/bin/sh
>>>> git interpret-trailers --trim-empty --trailer "git-version: \$(git
>>>> describe)" "\$1">   "\$1.new"
>>>> mv "\$1.new" "\$1"
>>>> EOF
>>>> $ chmod +x .git/hooks/commit-msg
>>>> 
>>>> I think you just need to use the following if you want the branch
>>>> instead of the git version:
>>>> 
>>>> git interpret-trailers --trim-empty --trailer "git-branch: \$(git 
>>>> name-rev
>>>> --name-only HEAD)" "\$1">   "\$1.new"
>>>> 
>>>> It could even be simpler if there was an option (which has already
>>>> been discussed) that made it possible to modify the file in
>>>> place. This way one would not need the 'mv "\$1.new" "\$1"' command.
>>> 
>>> This is certainly going in the right direction, but it's still implemented
>>> as a hook on a per-repo basis.  Do you foresee a point in the future where
>>> these trailers could be added through simple one-liners in someone's 
>>> global
>>> .gitconfig file?  That's where I'd really like to get to.
>> 
>> It's a hack, but it works surprisingly well in practice (assuming that
>> you and your co-workers all agree that this is an acceptable
>> approach):
>>
>>   1. Write the hook script and add it to your project (in a git-hooks
>> subdir or something)
>>
>>   2. Add a post-checkout hook to install the first hook and the
>> post-checkout hook itself into the user's .git/hooks/ dir.
>>
>>   3. Tell your co-workers to run the post-checkout hook script manually
>> the first time. After that, the script should take care of updating
>> itself and any hooks that you add to the project.
>> 
>> 
>> ...Johan
>
> I don't understand why the co-workers need to run the post-checkout hook 
> script manually the first time?

because git does not trust the contents of the repository, so it won't 
auto-execute a hook that's part of the respository.

You can include a hook, and then have someone run it, and after that it will be 
installed locally and run after every pull (and can therefor replace itself), 
but it requires that they run it manually the first time.

David Lang
