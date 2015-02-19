From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: Re: [PATCH v2] submodule: Fix documentation of update subcommand
Date: Thu, 19 Feb 2015 18:54:36 +0100
Message-ID: <87d255zt0j.fsf@steelpick.2x.cz>
References: <xmqqvbj0yx6c.fsf@gitster.dls.corp.google.com> <1424299716-21138-1-git-send-email-sojkam1@fel.cvut.cz> <xmqqbnkq23a0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 18:54:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOVJF-0001DU-9X
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 18:54:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbbBSRyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 12:54:41 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:34747 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751597AbbBSRyk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2015 12:54:40 -0500
Received: from localhost (unknown [192.168.200.7])
	by max.feld.cvut.cz (Postfix) with ESMTP id 49D613CFEA6;
	Thu, 19 Feb 2015 18:54:38 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.7]) (amavisd-new, port 10044)
	with ESMTP id Pyhyb9Vpuarj; Thu, 19 Feb 2015 18:54:36 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 5E16D4CC658;
	Thu, 19 Feb 2015 18:54:36 +0100 (CET)
Received: from wsh by steelpick.2x.cz with local (Exim 4.84)
	(envelope-from <sojkam1@fel.cvut.cz>)
	id 1YOVJ6-0001Ig-3J; Thu, 19 Feb 2015 18:54:36 +0100
In-Reply-To: <xmqqbnkq23a0.fsf@gitster.dls.corp.google.com>
User-Agent: Notmuch/0.19+54~g0747f5c (http://notmuchmail.org) Emacs/24.4.1 (x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264105>

On Thu, Feb 19 2015, Junio C Hamano wrote:
> Michal Sojka <sojkam1@fel.cvut.cz> writes:
>
>> The documentation of 'git submodule update' has several problems:
>>
>> 1) It says that submodule.$name.update can be overridden by --checkout
>>    only if its value is `none`.
>
> Hmm, I do not read the existing sentence that way, though.  The
> "only if" above is only in your head and not in the documentation,
> no?

Yes, you're right.

> The way I understand it is that the explanation does not even bother
> to say that it is overridable when update is set to something that
> clearly corresponds to --option (e.g. 'update=rebase' is for people
> too lazy to type --rebase from the command line), but because it is
> unclear when it is set to 'update=none', it specifically singles out
> that case.

I updated the commit message a bit.

>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index ae6791d..f30cbbc 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -2411,12 +2411,29 @@ status.submodulesummary::
>>
>>  submodule.<name>.path::
>>  submodule.<name>.url::
>> +	The path within this project and URL for a submodule. These
>> +	variables are initially populated by 'git submodule init';
>> +	edit them to override the URL and other values found in the
>> +	`.gitmodules` file. See linkgit:git-submodule[1] and
>> +	linkgit:gitmodules[5] for details.
>> +
>
> OK.
>
>>  submodule.<name>.update::
>> -	The path within this project, URL, and the updating strategy
>> -	for a submodule.  These variables are initially populated
>> -	by 'git submodule init'; edit them to override the
>> -	URL and other values found in the `.gitmodules` file.  See
>> -	linkgit:git-submodule[1] and linkgit:gitmodules[5] for details.
>> +	The default updating strategy for a submodule, used by `git
>> +	submodule update`. This variable is populated by `git
>> +	submodule init` from linkgit:gitmodules[5].
>> +
>> +	If the value is 'checkout' (the default), the new commit
>> +	specified in the superproject will be checked out in the
>
> Have you formatted this?  I _think_ this change would break the
> typesetting by having an empty line there.

Right. I need to add a '+' and deindent.

>> +	submodule on a detached HEAD.
>> +	If 'rebase', the current branch of the submodule will be
>> +	rebased onto the commit specified in the superproject.
>> +	If 'merge', the commit specified in the superproject will be
>> +	merged into the current branch in the submodule. If 'none',
>> +	the submodule with name `$name` will not be updated by
>> +	default.
>> +	If the value is of form '!command', it will cause `command` to
>> +	be run. `command` can be any arbitrary shell command that
>> +	takes a single argument, namely the sha1 to update to.
>
> I have a feeling that it is better to leave the explanations of
> these values in git-submodule.txt (i.e. where you took the above
> text from) and say "see description of 'update' command in
> linkgit:git-submodule[1]" here to avoid duplication.

OK

>>  submodule.<name>.branch::
>>  	The remote branch name for a submodule, used by `git submodule
>> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
>> index 8e6af65..c92908e 100644
>> --- a/Documentation/git-submodule.txt
>> +++ b/Documentation/git-submodule.txt
>> @@ -154,14 +154,13 @@ If `--force` is specified, the submodule's work tree will be removed even if
>>  it contains local modifications.
>>
>>  update::
>> -	Update the registered submodules, i.e. clone missing submodules and
>> -	checkout the commit specified in the index of the containing repository.
>> -	This will make the submodules HEAD be detached unless `--rebase` or
>> -	`--merge` is specified or the key `submodule.$name.update` is set to
>> -	`rebase`, `merge` or `none`. `none` can be overridden by specifying
>> -	`--checkout`. Setting the key `submodule.$name.update` to `!command`
>> -	will cause `command` to be run. `command` can be any arbitrary shell
>> -	command that takes a single argument, namely the sha1 to update to.
>> +	Update the registered submodules to match what the superproject
>> +	expects by cloning missing submodules and updating the working
>> +	tree of the submodules....
>
> This part is better than the original.

Indeed. You wrote this in a previous email :)

>>  The "updating" can take various forms
>> +	and can be configured in .git/config by the
>> +	`submodule.$name.update` key or by explicitely giving one of
>> +	'--checkout' (the default), '--merge' or '--rebase' options. See
>> +	linkgit:git-config[1] for details.
>
> Because submodule.<name>.update is interesting only to those who run
> "git submodule update", and also the command line options that
> interact with the setting are only described here not in config.txt,
> I think it is better to have the description of various modes here.
>
> And the description, if it is done here, can clarify the precedence
> (i.e. command line trumps configuration) and semantics
> (i.e. configuration 'update=checkout' and option --checkout are both
> to trigger the same behaviour), perhaps like this:
>
> 	The updating can be done in one of three ways:
>
>         checkout;; detaches the HEAD in the submodule at the commit
>             that is recorded by the superproject.  This is done when
>             --checkout option is given, or no option is given, and
>             submodule.<name>.update is unset, or if it is set to
>             'checkout'.
>         rebase;; EXPLAIN IN A SIMILAR WAY, talk about --rebase,
>             'rebase', etc.
>         merge;; EXPLAIN IN A SIMILAR WAY, talk about --merge,
>             'merge', etc.
>
>         When no option is given and submodule.<name>.update is set
>         to 'none', the submodule is not updated.
>
> It would be awkward to talk about --option in any of the other pages
> like config.txt and gitmodules.txt, but the relationship between the
> options and configurations must be explained somewhere, so....

Agreed expect that there is a fourth way: !command. But this could be
easily added here as well.

I'll send an updated patch in a while.

Thanks.
-Michal
