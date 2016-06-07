From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: [PATCH v4 3/3] completion: add git status
Date: Tue, 7 Jun 2016 09:47:13 +0200
Message-ID: <7bf0dd4a-ec78-f415-f35c-161f42c3c17d@virtuell-zuhause.de>
References: <xmqq8tymp385.fsf@gitster.mtv.corp.google.com>
 <20160603183426.13140-1-thomas.braun@virtuell-zuhause.de>
 <20160603183426.13140-4-thomas.braun@virtuell-zuhause.de>
 <xmqqmvmyxksj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	=?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 09:47:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bABjb-0003DG-DM
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 09:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753823AbcFGHrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 03:47:21 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:49437 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753235AbcFGHrS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2016 03:47:18 -0400
Received: from p4fc87c53.dip0.t-ipconnect.de ([79.200.124.83] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1bABjH-0006bp-26; Tue, 07 Jun 2016 09:47:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
In-Reply-To: <xmqqmvmyxksj.fsf@gitster.mtv.corp.google.com>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1465285638;b1857fb7;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296611>

Am 06.06.2016 um 19:57 schrieb Junio C Hamano:
> Thomas Braun <thomas.braun@virtuell-zuhause.de> writes:
> 
>> +	case "$cur" in
>> +	--ignore-submodules=*)
>> +		__gitcomp "none untracked dirty all" "" "${cur##--ignore-submodules=}"
>> +		return
>> +		;;
>> +	--untracked-files=*)
>> +		__gitcomp "$__git_untracked_file_modes" "" "${cur##--untracked-files=}"
>> +		return
>> +		;;
>> +	--column=*)
>> +		__gitcomp "
>> +			always never auto column row plain dense nodense
>> +			" "" "${cur##--column=}"
>> +		return
>> +		;;
>> +	--*)
>> +		__gitcomp "
>> +			--short --branch --porcelain --long --verbose
>> +			--untracked-files= --ignore-submodules= --ignored
>> +			--column= --no-column
>> +			"
>> +		return
>> +		;;
>> +	esac
>> +
>> +	untracked_state="$(__git_get_option_value "-u" "--untracked-files="\
> 
> If you have a SP before that backslash, you can avoid getting
> misunderstood that you are attempting to extend that string
> "--untracked-files=".  The backslash is telling the shell that there
> are more arguments to come, and it is misleading to rely on the fast
> that the next line happens to begin with a whitespace.

Thanks, will be fixed in the reroll.

>> +		"$__git_untracked_file_modes" "status.showUntrackedFiles")"
> 
> 
>> +	case "$untracked_state" in
>> +	no)
>> +		# --ignored option does not matter
>> +		complete_opt=
>> +		;;
>> +	all|normal|*)
>> +		complete_opt="--cached --directory --no-empty-directory --others"
>> +
>> +		if [ -n "$(__git_find_on_cmdline "--ignored")" ]; then
>> +			complete_opt="$complete_opt --ignored --exclude=*"
>> +		fi
>> +		;;
>> +	esac
>> +
>> +	__git_complete_index_file "$complete_opt"
>> +}
>> +
>>  __git_config_get_set_variables ()
>>  {
>>  	local prevword word config_file= c=$cword
> 
