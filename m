From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: [PATCH v3 2/2] completion: add git status
Date: Fri, 3 Jun 2016 17:41:35 +0200
Message-ID: <8f5e515b-8efc-0160-820e-d81885fc6c36@virtuell-zuhause.de>
References: <20160601141510.Horde.M2zGuJrzBNqf_2zYLo0P2Sx@webmail.informatik.kit.edu>
 <9ef8cfd8fb89bcacd123ddbebc12f961a292ef8b.1464879648.git.thomas.braun@virtuell-zuhause.de>
 <1464880296.3720.0.camel@virtuell-zuhause.de>
 <xmqqtwhbtq46.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	=?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 17:41:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8rET-0006sY-Ds
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 17:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbcFCPlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 11:41:42 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:38453 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751689AbcFCPlk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 11:41:40 -0400
Received: from p4fc87c53.dip0.t-ipconnect.de ([79.200.124.83] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1b8rE9-0006Lr-7h; Fri, 03 Jun 2016 17:41:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
In-Reply-To: <xmqqtwhbtq46.fsf@gitster.mtv.corp.google.com>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1464968500;1358b4cb;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296339>

Am 02.06.2016 um 20:14 schrieb Junio C Hamano:
> Thomas Braun <thomas.braun@virtuell-zuhause.de> writes:
> 
>> +	untracked_state="$(__git_find_on_cmdline "--untracked-files=no\
>> +		--untracked-files=normal --untracked-files=all")"
> 
> Just wondering but does this help my use of the command like
> 
> 	$ git status -uno <TAB>
> 
> or do I now have to spell it out like
> 
> 	$ git status --untracked-files=no <TAB>
> 
> to take advantage of it?

I was unsure if I should support the short option (-u) as well. On
thinking about it again there is little use of only doing it for the
long option.
Will be handled in a reroll.

>> +	untracked_state=${untracked_state##--untracked-files=}
>> +
>> +	if [ -z "$untracked_state" ]; then
>> +		untracked_state="$(git --git-dir="$(__gitdir)" config "status.showUntrackedFiles")"
>> +	fi
>> +
>> +	case "$untracked_state" in
>> +		no)
>> +			# --ignored option does not matter
> 
> Style.  I see existing case/esac statements that use this style, but
> our preference is not to indent case arms like this; rather:
> 
> 	case "$untracked_state" in
>         no)
>         	# --ignored ...
> 
> which saves the indentation one level overall.

thanks, will be fixed.

>> +			complete_opt=
>> +			;;
>> +		all|normal|*)
>> +			complete_opt="--cached --directory --no-empty-directory --others"
>> +
>> +			if [ -n "$(__git_find_on_cmdline "--ignored")" ]; then
> 
> Same question as the "--untracked-files=no vs -uno" applies here.

Is there a short version of --ignored? I could not find one in the help,
and from a look into cmd_status in commit.c I would say there is none.
