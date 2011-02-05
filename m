From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] git pull: Remove option handling done by fetch
Date: Sat, 05 Feb 2011 12:26:31 +0100
Message-ID: <4D4D33E7.4000303@web.de>
References: <4D4C5EBC.2090100@web.de> <201102042326.08607.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Feb 05 12:27:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlgIM-0004zm-GF
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 12:27:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929Ab1BEL06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 06:26:58 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:40943 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792Ab1BEL05 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 06:26:57 -0500
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate03.web.de (Postfix) with ESMTP id A1F4E1877C539;
	Sat,  5 Feb 2011 12:26:46 +0100 (CET)
Received: from [93.240.102.193] (helo=[192.168.178.43])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PlgHu-00075U-00; Sat, 05 Feb 2011 12:26:46 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <201102042326.08607.j6t@kdbg.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/xlNlKTsumd6mm8mMpX3ricn2WKcEUs+PdY4eh
	D5O8NB5xGQzj+3Oiq4Cu5q/o+0FEzOdbc5RpJrOo/m43vVAxWo
	HCgQkkOadOGbYsUzOtOQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166088>

Am 04.02.2011 23:26, schrieb Johannes Sixt:
> On Freitag, 4. Februar 2011, Jens Lehmann wrote:
>> In commits be254a0ea9 and 7dce19d374 the handling of the new fetch options
>> "--[no-]recurse-submodules" had been added to git-pull.sh. This was not
>> necessary because all options to "git fetch" are passed to it and handled
>> there, so lets remove them.
>>
>> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
>> ---
>>
>> I noticed this while implementing the on-demand recursive fetch.
>>
>>  git-pull.sh |   10 ++--------
>>  1 files changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/git-pull.sh b/git-pull.sh
>> index eb87f49..20a3bbe 100755
>> --- a/git-pull.sh
>> +++ b/git-pull.sh
>> @@ -38,7 +38,7 @@ test -z "$(git ls-files -u)" || die_conflict
>>  test -f "$GIT_DIR/MERGE_HEAD" && die_merge
>>
>>  strategy_args= diffstat= no_commit= squash= no_ff= ff_only=
>> -log_arg= verbosity= progress= recurse_submodules=
>> +log_arg= verbosity= progress=
>>  merge_args=
>>  curr_branch=$(git symbolic-ref -q HEAD)
>>  curr_branch_short="${curr_branch#refs/heads/}"
>> @@ -105,12 +105,6 @@ do
>>  	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase)
>>  		rebase=false
>>  		;;
>> -	--recurse-submodules)
>> -		recurse_submodules=--recurse-submodules
>> -		;;
>> -	--no-recurse-submodules)
>> -		recurse_submodules=--no-recurse-submodules
>> -		;;
>>  	--d|--dr|--dry|--dry-|--dry-r|--dry-ru|--dry-run)
>>  		dry_run=--dry-run
>>  		;;
>> @@ -223,7 +217,7 @@ test true = "$rebase" && {
>>  	done
>>  }
>>  orig_head=$(git rev-parse -q --verify HEAD)
>>  -git fetch $verbosity $progress $dry_run $recurse_submodules 
>> --update-head-ok "$@" || exit 1
>>> +git fetch $verbosity $progress $dry_run 
>> --update-head-ok "$@" || exit 1 test -z "$dry_run" || exit 0
>>
>>  curr_head=$(git rev-parse -q --verify HEAD)
> 
> Huh? What will, for example,
> 
>    git pull --recurse-submodules --no-ff origin
> 
> do before and after your patch? Doesn't your patch force users to 
> write --[no-]recurse-submodules last?

Yes, but isn't that exactly what the pull man-page says? Quote:
"Options meant for git pull itself and the underlying git merge
must be given before the options meant for git fetch."
(The reason I added this option handling in the first place was
that I hadn't been aware of this at that time either ... ;-)

Thanks for your review!
