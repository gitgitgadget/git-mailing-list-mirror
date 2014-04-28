From: Johan Herland <johan@herland.net>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 11:09:31 +0200
Message-ID: <CALKQrgfN-bE7KpZFadtD806Xk29N_R2sYurPQSKHLSh0UwcZiw@mail.gmail.com>
References: <CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com>
	<535D6EB1.9080208@game-point.net>
	<CALKQrgdFLc=k9i1+N2458amLMGQa99q55A=N785VfMRwfOH6Rg@mail.gmail.com>
	<20140428.084543.1615507400056684596.chriscool@tuxfamily.org>
	<535E18E0.3010507@game-point.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Git mailing list <git@vger.kernel.org>
To: Jeremy Morton <admin@game-point.net>
X-From: git-owner@vger.kernel.org Mon Apr 28 11:09:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WehZH-0005kI-6X
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 11:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754570AbaD1JJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 05:09:39 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:37988 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754559AbaD1JJh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 05:09:37 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1WehZA-0004Qh-4r
	for git@vger.kernel.org; Mon, 28 Apr 2014 11:09:36 +0200
Received: from mail-pb0-f41.google.com ([209.85.160.41])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1WehZ9-0003yp-Lz
	for git@vger.kernel.org; Mon, 28 Apr 2014 11:09:35 +0200
Received: by mail-pb0-f41.google.com with SMTP id rr13so5602475pbb.14
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 02:09:31 -0700 (PDT)
X-Received: by 10.68.231.35 with SMTP id td3mr2535973pbc.137.1398676171757;
 Mon, 28 Apr 2014 02:09:31 -0700 (PDT)
Received: by 10.70.31.162 with HTTP; Mon, 28 Apr 2014 02:09:31 -0700 (PDT)
In-Reply-To: <535E18E0.3010507@game-point.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247257>

On Mon, Apr 28, 2014 at 11:01 AM, Jeremy Morton <admin@game-point.net> wrote:
> On 28/04/2014 07:45, Christian Couder wrote:
>> Yes, it's possible. Yesterday, I sent the following patch:
>>
>> [RFC/PATCH 2/2] trailer: add examples to the documentation
>>
>> and it shows a commit-msg hook to do something like that:
>>
>> $ cat>.git/hooks/commit-msg<<EOF
>> #!/bin/sh
>> git interpret-trailers --trim-empty --trailer "git-version: \$(git
>> describe)" "\$1">  "\$1.new"
>> mv "\$1.new" "\$1"
>> EOF
>> $ chmod +x .git/hooks/commit-msg
>>
>> I think you just need to use the following if you want the branch
>> instead of the git version:
>>
>> git interpret-trailers --trim-empty --trailer "git-branch: \$(git name-rev
>> --name-only HEAD)" "\$1">  "\$1.new"
>>
>> It could even be simpler if there was an option (which has already
>> been discussed) that made it possible to modify the file in
>> place. This way one would not need the 'mv "\$1.new" "\$1"' command.
>
> This is certainly going in the right direction, but it's still implemented
> as a hook on a per-repo basis.  Do you foresee a point in the future where
> these trailers could be added through simple one-liners in someone's global
> .gitconfig file?  That's where I'd really like to get to.

It's a hack, but it works surprisingly well in practice (assuming that
you and your co-workers all agree that this is an acceptable
approach):

 1. Write the hook script and add it to your project (in a git-hooks
subdir or something)

 2. Add a post-checkout hook to install the first hook and the
post-checkout hook itself into the user's .git/hooks/ dir.

 3. Tell your co-workers to run the post-checkout hook script manually
the first time. After that, the script should take care of updating
itself and any hooks that you add to the project.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
