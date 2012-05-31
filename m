From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Remove perl dependency from git-submodule.sh
Date: Thu, 31 May 2012 13:25:20 +0200
Message-ID: <4FC75520.2090601@viscovery.net>
References: <1338454126-30441-1-git-send-email-iveqy@iveqy.com> <4FC73788.6070805@viscovery.net> <20120531104036.GB30500@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jens.lehmann@web.de, gitster@pobox.com
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Thu May 31 14:03:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa46F-0001Ev-Vw
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 14:03:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757495Ab2EaMD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 08:03:28 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:35242 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757290Ab2EaMD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 08:03:27 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Sa3VJ-0007NO-1t; Thu, 31 May 2012 13:25:21 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id BFEE51660F;
	Thu, 31 May 2012 13:25:20 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <20120531104036.GB30500@paksenarrion.iveqy.com>
X-Enigmail-Version: 1.4.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198886>

Am 5/31/2012 12:40, schrieb Fredrik Gustafsson:
> On Thu, May 31, 2012 at 11:19:04AM +0200, Johannes Sixt wrote:
>> Be prepared for backslashes in the path name:
>>
>> 	while read -r mode sha1 stage path
> 
> We are not using -r on any place in git-submodule.sh. Maybe we should? I
> can provide a patch if needed.

I can imagine that this would fix a bug or two with paths that contain
to-be-quoted characters.

>>> +	do
>>> +		if test $mode -eq 160000
>>
>> $mode is not a number, but a string: test "$mode" = 160000
> 
> okay, fixed in next iteration.
> 
>>
>>> +		then
>>> +			if test $stage -ne 0
>>
>> That $stage looks like a number is of no importance, either.
> 
> Actually I don't know what stage does and if it's important here. This
> part is just to mimic the perl code. Should it be removed?

No; you should 'test "$stage" != 0'.

>>> +			then
>>> +				if test -z "$(echo $unmerged | grep "|$path|")"
>>> +					then
>>> +					echo "$mode $null_sha1 U\t$path"
>>> +				fi
>>> +				unmerged="$unmerged|$path|"
>>
>> IIUC, the purpose of $unmerged and this check is to avoid that an unmerged
>> path is dumped for each stage that is listed by ls-files. Therefore it
>> should be sufficient to just check that the current path is different from
>> the last path.
> 
> That requires that submodules always is in the same order, right?

ls-files guarantees a suitable order: different stages of the same
submodule path appear on consecutive lines.

-- Hannes
