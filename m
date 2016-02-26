From: Pranit Bauva <pranit.bauva@zoho.com>
Subject: Re: [PATCH/RFC] git-commit: add a commit.verbose config variable
Date: Fri, 26 Feb 2016 13:26:45 +0000
Message-ID: <56D05295.6020102@zoho.com>
References: <56CFBF19.6040004@zoho.com>
 <CAPig+cQE6ytRKFjqRRLrPHCYqJuf52NKvy8sZs8rX3t5_kDRVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>,
	Lars Schneider <larsxschneider@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Feb 26 08:21:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZCiZ-0005CG-VB
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 08:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbcBZHSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 02:18:49 -0500
Received: from sender153-mail.zoho.com ([74.201.84.153]:22834 "EHLO
	sender153-mail.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932099AbcBZHSs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 02:18:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=subject:to:references:cc:from:message-id:date:mime-version:in-reply-to:content-type; 
  b=SyJwtNnY5/bAZXPGw8V94/B7SKywxSIgHt/vA+J41FKwIqQ4b82qhglrdrDDHu6by/0Y92lfM5/o
    QF5CKcsoXZi3u1M9AmAXQL38eeCLmgWMoqXvOYH5NKpAf7xoCer7  
Received: from 127.0.0.1 (193.90.12.88 [193.90.12.88]) by mx.zohomail.com
	with SMTPS id 1456471123160150.64967302839887; Thu, 25 Feb 2016 23:18:43 -0800 (PST)
In-Reply-To: <CAPig+cQE6ytRKFjqRRLrPHCYqJuf52NKvy8sZs8rX3t5_kDRVg@mail.gmail.com>
X-Zoho-Virus-Status: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287540>

Matthieu Moy:
> Using "git send-email" normally does the right thing. You may want to
> look at https://submitgit.herokuapp.com/ too.
git send-email does not work as my institute proxy does not allow
IMAP/SMTP connections. But I will take care of this from hence forward.

> The commit message should not try to rephrase what the patch aleady
> says.

I am dropping this statement off because of one another reason which
Eric Sunshine gave.

> If you know you haven't finished, you may use WIP (work in progress)
> instead of RFC in the title.

I wasn't familiar with this tag. I will keep it in mind. And this is not
included in Documentation/SubmittingPatches , so I will send a patch to
include WIP tag.

> "the git-config" is not proper English. You mean "a configuration file".
> I'd write "the configuration variable `commit.verbose` can be set to
> true".

I actually was facing problem in phrasing it. Thanks for your
suggestion. I will update this.

>> +	with git-config.
>
> Did you mean "git commit"?
Sorry for my carelessness. I will update this.


> Doesn't this override any value that --verbose or --no-verbose may >
 have set before?
Yes, this was the problem. I have fixed it now. But there is a glitch.
See below.

Eric Sunshine:
> On Thu, Feb 25, 2016 at 9:57 PM, Pranit Bauva <pranit.bauva@zoho.com> wrote:
>> From c273a02fc9cab9305cedf6e37422e257a1cc3b1e Mon Sep 17 00:00:00 2001
>> From: Pranit Bauva <pranit.bauva@zoho.com>
>> Date: Fri, 26 Feb 2016 07:14:18 +0530
>> Subject: [PATCH/RFC] git-commit: add a commit.verbose config variable

>From hence forth I will take that into consideration.

> Talking about this in the commit message misleads the reader into
> thinking that there is some potential oddity going on where a careful
> decision needs to be made about which variable to set, when that's not
> in fact the case. The 'verbose' member of wt_status is just one
> consumer of the "verbose" flag, not the sole consumer. Another
> consumer is found in builtin/commit.c:cmd_commit():
> 
>     if (verbose ||
>         cleanup_mode == CLEANUP_SCISSORS)
>             wt_status_truncate_message_at_cut_line(&sb);
> 
> So, it would not be correct for the configuration ever to set only
> wt_status::verbose.
> 
> Consequently, it would be better to drop this paragraph altogether
> from the commit message, so as to avoid confusing readers.

I guessed this parent-child behavior and I wanted the commit to sound
like that but now that I read it again, I can understand that it might
confuse readers who aren't familiar with the code base.

> Some tests to consider:
> 
> * commit.verbose unset

This was working perfectly fine!

> * commit.verbose=true

This was working perfectly fine!

> * commit.verbose=false

This was working perfectly fine!

> * --verbose overrides commit.verbose

This was showing errors. So I now included an if statement and then
placed the whole code after the method parse_and_validate_options()
otherwise it would just ignore the behavior. Now even this is working
perfectly fine.

> * --no-verbose overrides commit.verbose

This is a problematic one as currently `git-commit` does not have such a
behavior. I tried printing value of `verbose` in both the cases ie. with
`git commit` and `git commit --no-verbose` and in both of them it
printed the value 0. So currently, the program won't understand the
"overriding" nature. I have an idea for implementing this. We can keep
the default nature to point out to 0 and `--no-verbose` to point to -1.
But I guess this problem would have been faced/implemented in other part
of the code. I will have to look in different parts of code and see how
this has been done in those so as to maintain the practices followed
with git. I am currently not quite familiar with `parse-options.c` so I
will read about it. But you could help by pointing out specific commits
or email threads which are related to `--no-verbose` option in other git
commands to speed up the process.

> I haven't fully digested builtin/commit.c, but the placement of this
> new code seems suspect. My expectation would have been to see
> git_commit_config() updated to recognize the new "commit.verbose"
> variable. Am I missing something?

I too had a lot of confusing regarding this. But it seems to me that the
method git_commit_config() shows a "different" behavior and I don't
think such "complicated" behavior is required for reading the boolean
variable `commit.verbose`.
