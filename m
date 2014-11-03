From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: Re: [PATCH] submodule: Fix documentation of update subcommand
Date: Mon, 03 Nov 2014 23:55:31 +0100
Message-ID: <87k33bao7w.fsf@steelpick.2x.cz>
References: <1415009391-14979-1-git-send-email-sojkam1@fel.cvut.cz> <xmqqegtkrtt9.fsf@gitster.dls.corp.google.com> <5457E7DF.5070500@web.de> <xmqqbnooq863.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Nov 03 23:55:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlQXP-0002XB-3e
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 23:55:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbaKCWzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 17:55:47 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:36474 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810AbaKCWzq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 17:55:46 -0500
Received: from localhost (unknown [192.168.200.7])
	by max.feld.cvut.cz (Postfix) with ESMTP id 4D8095CCFF2;
	Mon,  3 Nov 2014 23:55:44 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.7]) (amavisd-new, port 10044)
	with ESMTP id 0fkAPYgz0pAR; Mon,  3 Nov 2014 23:55:37 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 892FC5CCFF8;
	Mon,  3 Nov 2014 23:55:37 +0100 (CET)
Received: from wsh by steelpick.2x.cz with local (Exim 4.84)
	(envelope-from <sojkam1@fel.cvut.cz>)
	id 1XlQX5-0003U1-AH; Mon, 03 Nov 2014 23:55:31 +0100
In-Reply-To: <xmqqbnooq863.fsf@gitster.dls.corp.google.com>
User-Agent: Notmuch/0.18.2+157~ga00d359 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 03 2014, Junio C Hamano wrote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>
>> This was introduced in e6a1c43aaf (document submdule.$name.update=none
>> option for gitmodules), and I agree with Michal that we should fix it.
>> But I think we should rather say "This can be overridden by specifying
>> '--merge', '--rebase' or `--checkout`." here, as the other two options
>> also override the update setting. So I think we should queue this:
>>
>> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
>> index 8e6af65..84ab577 100644
>> --- a/Documentation/git-submodule.txt
>> +++ b/Documentation/git-submodule.txt
>> @@ -158,7 +158,7 @@ update::
>>  	checkout the commit specified in the index of the containing repository.
>>  	This will make the submodules HEAD be detached unless `--rebase` or
>>  	`--merge` is specified or the key `submodule.$name.update` is set to
>> -	`rebase`, `merge` or `none`. `none` can be overridden by specifying
>> +	`rebase`, `merge` or `none`. This can be overridden by using '--merge',
>> +	'--rebase' or
>>  	`--checkout`. Setting the key `submodule.$name.update` to `!command`
>>  	will cause `command` to be run. `command` can be any arbitrary shell
>>  	command that takes a single argument, namely the sha1 to update to.
>>
>> Apart from that I'm all for it.
>
> But read the whole thing again.  Isn't that a bit roundabout and
> tortuous?
>
> The paragraph is about the "update" subcommand, and then mentions
> how the subcommand is affected by options and configuration.  And
> "OVERRIDING" the topic of this thread is only about configuration.
>
> Disecting what each sentence in the existing paragraph says:
>
>     - This is about updating the submodule working tree to match
>       what the superproject expects.
>
>     - There can be three ways how it is "updated" (and one way to
>       leave it not updated), by setting submodule.$name.update
>       and/or giving --rebase, --merge or --checkout option, and one
>       way to leave it not "updated" by setting .update=none.
>
>     - The .update=none can be defeated with --checkout
>
> which I think is a mess.
>
> It is a fairly common and uniform pattern that command line options
> override configured defaults, so I think it could be argued that
> "you can override .update=none or .update=anything with command line
> option" is not even worth saying.  Definitely not by piling yet
> another "oh by the way, if you have this, things behave differently
> again" on top of existing description.
>
> 	Update the registered submodules to match what the superproject
> 	expects by cloning missing submodules and updating the
> 	working tree of the submodules.  The "updating" can take
> 	various forms:
>
> 	(1) By default, or by explicitly giving `--checkout` option,
>             the HEAD of the submodules are detached to the exact
>             commit recorded by the superproject.
>
> 	(2) By giving `--rebase` or `--merge` option, the commit
>             that happens to be checked out in the submodule's
>             working tree is integrated with the commit recorded by
>             the superproject by rebasing or merging, respectively.
>
> 	Setting submodule.$name.update configuration to `rebase` or
>         `merge` will make `git submodule update` without these
>         command line options to default to `--rebase` or `--merge`,
>         respectively.
>
> 	Also, setting submodule.$name.update configuration to `none`
>         marks the named submodule not updated by "submodule update"
>         by default (you can still use `--checkout`, `--merge`, or
>         `--rebase`).

This sounds good, but it doesn't mention the `!command` value of
.update. I'd call this form (3). But then different update forms would
mix config settings and command line options.

> Or something perhaps?  Or the detailed description of
> submodule.$name.update should be dropped from here and refer the
> reader to config.txt instead?

I guess you mean gitmodules.txt.

The `!command` form is not documented in gitmodules.txt. Maybe it would
be best to fully document .update in gitmodules.txt and just refer to
there. Having documentation at two places seems to be confusing not only
for users, but also for those who send patches :)

I'm no longer able to formulate my proposal properly as a patch tonight,
but if needed I'll try it later.

-Michal
