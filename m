From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 10/20] git-submodule.sh: avoid "test <cond> -a/-o <cond>"
Date: Tue, 10 Jun 2014 10:19:54 +0200
Message-ID: <5396BFAA.3000003@viscovery.net>
References: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>	<1402066563-28519-11-git-send-email-gitter.spiros@gmail.com> <xmqqoay1d5vi.fsf@gitster.dls.corp.google.com> <5396AB10.8020603@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>,
	Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 10:20:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuHHy-0005RE-27
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 10:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936052AbaFJIUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 04:20:05 -0400
Received: from so.liwest.at ([212.33.55.14]:36409 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932209AbaFJIT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 04:19:59 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WuHHe-0007xp-Ph; Tue, 10 Jun 2014 10:19:55 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 81BCF16613;
	Tue, 10 Jun 2014 10:19:54 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <5396AB10.8020603@viscovery.net>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251173>

Am 6/10/2014 8:52, schrieb Johannes Sixt:
> Am 6/10/2014 1:23, schrieb Junio C Hamano:
>> Elia Pinto <gitter.spiros@gmail.com> writes:
>>
>>> @@ -1059,13 +1059,17 @@ cmd_summary() {
>>>  		while read mod_src mod_dst sha1_src sha1_dst status sm_path
>>>  		do
>>>  			# Always show modules deleted or type-changed (blob<->module)
>>> -			test $status = D -o $status = T && echo "$sm_path" && continue
>>> +			case "$status" in
>>> +			[DT])
>>> +				printf '%s\n' "$sm_path" &&
>>> +				continue
>>> +			esac
>>
>> I think this conversion is wrong and causes parse error.  The
>> surrounding code cannot be seen in the context of thsi patch, but
>> looks somewhat like this:
>>
>> 	modules=$( ....
>>                    case "$status" in
>>                    [DT])
>>                            ...
>>                    esac
>>                    .... )
>>
>> Perhaps you would need to spell it with the extra opening
>> parenthesis, like so:
>>
>> 	case string in
>>         ([DT])
>>         	...
>> 	esac
>>
>> or something.
> 
> Do you just think that it causes parse errors or did you actually observe
> them? Because I think that no parse error should occur.

(I should not talk, but test...) bash and zsh get it wrong, dash and ksh
get it right.
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_03
item 5 does leave some leeway for interpretation. So it's better to adjust
as you suggest.

-- Hannes
-- 
"Atomic objects are neither active nor radioactive." --
Programming Languages -- C++, Final Committee Draft (Doc.N3092)
