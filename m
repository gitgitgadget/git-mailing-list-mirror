From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [GSOC/RFC] GSoC Proposal Draft | Git Beginner
Date: Mon, 21 Mar 2016 09:29:01 +0100
Message-ID: <vpqd1qo5j5e.fsf@anie.imag.fr>
References: <56EED10B.4010604@gmail.com> <vpq4mc1asmy.fsf@anie.imag.fr>
	<56EFA558.5020301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, philipoakley@iee.org,
	Kevin Daudt <me@ikke.info>,
	Jacob Keller <jacob.keller@gmail.com>,
	Elijah Newren <newren@gmail.com>
To: Sidhant Sharma <tigerkid001@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 09:32:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahvGM-0001rF-9W
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 09:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbcCUIcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 04:32:31 -0400
Received: from mx2.imag.fr ([129.88.30.17]:32904 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826AbcCUIc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 04:32:28 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u2L8T38G021249
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 21 Mar 2016 09:29:04 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u2L8T1qp025554;
	Mon, 21 Mar 2016 09:29:01 +0100
In-Reply-To: <56EFA558.5020301@gmail.com> (Sidhant Sharma's message of "Mon,
	21 Mar 2016 13:10:08 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Mon, 21 Mar 2016 09:29:05 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u2L8T38G021249
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1459153748.26207@LKjo6xVdXYUfqzPzlV5j/A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289410>

Sidhant Sharma <tigerkid001@gmail.com> writes:

> On Monday 21 March 2016 12:22 AM, Matthieu Moy wrote:
>
>> Note that it implies writting an almost full-blown option parser to
>> recognize commands like
>>
>> ggit --work-tree git --namespace reset --git-dir --hard git log
>>
>> (just looking for "git", "reset" and "--hard" in the command-line would
>> not work here).
>
> Could you please elaborate on the above command, I'm unable to
> understand its syntax. I thought all git commands follow the
> `git command <arguments>` syntax, so using simple string
> manipulations and regexes would work. Am I missing something?

The full syntax is

git [global options] <command> [options and arguments for a command]

For example:

git -p log => -p is the option for "git" itself, which means "paginate"
git log -p => -p is the option for "git log", which means "patch"

Options can have stuck or non-stuck form, for example

git --work-tree=foo <=> git --work-tree foo

git --work-tree git --namespace reset --git-dir --hard git log
<=>
git --work-tree=git --namespace=reset --git-dir=--hard git log

(This is probably a stupid command to type, but it's legal)

The later is source of issues for a parser since you can't just iterate
through argv[] and search for problematic commands/options, since you
have to distinguish options themselves (--work-tree above) and option
arguments (foo above).

In my example above, I played with global options (before "git" in the
command-line), but I could also have done that with per-command options
taking arguments, like

git push --repo --force

Here, --force is the name of the repo (again, probably a stupid name,
but why not), not the --force option.

> I wasn't sure if we are allowed to code before the actual coding period begins
> so I kept it that way. I'll update it now.

You're not "forced" to, but you can write code whenever you like. We've
already seen code written before the application!

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
