From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] mergetool: run prompt only if guessed tool
Date: Tue, 22 Apr 2014 10:19:51 -0700
Message-ID: <xmqqbnvt703s.fsf@gitster.dls.corp.google.com>
References: <1398039454-31193-1-git-send-email-felipe.contreras@gmail.com>
	<1398039454-31193-3-git-send-email-felipe.contreras@gmail.com>
	<20140422045951.GA60610@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Charles Bailey <charles@hashpling.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 19:20:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WceMg-00074F-Ji
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 19:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933417AbaDVRUC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 13:20:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53629 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932199AbaDVRT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 13:19:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 713FB7FFE8;
	Tue, 22 Apr 2014 13:19:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RILdlHlCo26XboxopIComZ35l1k=; b=kTPc5j
	L/vtI9tntm42nTxYGdLvb/Y0JbQ8Or6X941s9rqW7PvFt43DXbRU1KzZbsu7yi3D
	CpSjKENYvR0iEFOlkbEcH7C5bMvk9cjeAJWqgOnJ88muPUCkFv66T5MD3ouegncJ
	AhtzLRv2dnINFl54+WU479iUNgtAROudchyA0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k/4TUOrvPu6dd50TtmDfUcf8xNAxU+Ja
	zs6/A6RJaQdrd4Ub2X43HzvyDF1/iBhlqWbHEB9h2sxqowuaZWWAg9NlbPJhg512
	MY855OeqKH0m7CBX5aZxQZE9ka1w6y/WqrO3ijfORTfQGLoKk6mP0c4TMj2KNsRO
	ZtIHF1hSXMM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59A3E7FFE7;
	Tue, 22 Apr 2014 13:19:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 532217FFE3;
	Tue, 22 Apr 2014 13:19:53 -0400 (EDT)
In-Reply-To: <20140422045951.GA60610@gmail.com> (David Aguilar's message of
	"Mon, 21 Apr 2014 21:59:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 516C1C3E-CA42-11E3-B686-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246754>

David Aguilar <davvid@gmail.com> writes:

> [Cc:ing Charles in case he has an opinion, this behavior dates back to the original MT]
>
> On Sun, Apr 20, 2014 at 07:17:34PM -0500, Felipe Contreras wrote:
>> It's annoying to see the prompt:
>> 
>>   Hit return to start merge resolution tool (foo):
>> 
>> Every time the user does 'git mergetool' even if the user already
>> configured 'foo' as the wanted tool.
>> 
>> Display this prompt only when the user hasn't explicitly configured a
>> tool.
>
> I agree this is probably helpful.
> Most users I've met end up configuring mergetool.prompt=false.
>
> Thanks

OK, is it an Ack?

Thanks for CC'ing Charles, by the way.  I think his point about
mentioning the change of default somewhere in the documentation
has some merits, and it can be done in a follow-up patch on top.




>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  git-mergetool.sh | 14 +++++++++++---
>>  1 file changed, 11 insertions(+), 3 deletions(-)
>> 
>> diff --git a/git-mergetool.sh b/git-mergetool.sh
>> index 332528f..d08dc92 100755
>> --- a/git-mergetool.sh
>> +++ b/git-mergetool.sh
>> @@ -277,7 +277,7 @@ merge_file () {
>>  	echo "Normal merge conflict for '$MERGED':"
>>  	describe_file "$local_mode" "local" "$LOCAL"
>>  	describe_file "$remote_mode" "remote" "$REMOTE"
>> -	if "$prompt" = true
>> +	if test "$guessed_merge_tool" = true || test "$prompt" = true
>>  	then
>>  		printf "Hit return to start merge resolution tool (%s): " "$merge_tool"
>>  		read ans || return 1
>> @@ -315,7 +315,8 @@ merge_file () {
>>  	return 0
>>  }
>>  
>> -prompt=$(git config --bool mergetool.prompt || echo true)
>> +prompt=$(git config --bool mergetool.prompt)
>> +guessed_merge_tool=false
>>  
>>  while test $# != 0
>>  do
>> @@ -373,7 +374,14 @@ prompt_after_failed_merge () {
>>  
>>  if test -z "$merge_tool"
>>  then
>> -	merge_tool=$(get_merge_tool "$merge_tool") || exit
>> +	# Check if a merge tool has been configured
>> +	merge_tool=$(get_configured_merge_tool)
>> +	# Try to guess an appropriate merge tool if no tool has been set.
>> +	if test -z "$merge_tool"
>> +	then
>> +		merge_tool=$(guess_merge_tool) || exit
>> +		guessed_merge_tool=true
>> +	fi
>>  fi
>>  merge_keep_backup="$(git config --bool mergetool.keepBackup || echo true)"
>>  merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo false)"
>> -- 
>> 1.9.2+fc1.1.g5c924db
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
