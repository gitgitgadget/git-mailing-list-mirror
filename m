From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/1] Honor $(prefix) set in config.mak* when defining
 ETC_GIT* and sysconfdir
Date: Wed, 04 May 2011 07:52:30 +0200
Message-ID: <4DC0E99E.6090402@viscovery.net>
References: <20110428022922.GC4833@camk.edu.pl> <7v62py5nbp.fsf@alter.siamese.dyndns.org> <20110428192751.GE4833@camk.edu.pl> <4DBFA3C6.8060209@viscovery.net> <7vzkn3itb5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kacper Kornet <kornet@camk.edu.pl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 07:52:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHV0s-0005dm-OA
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 07:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215Ab1EDFwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 01:52:37 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:64443 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752103Ab1EDFwg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 01:52:36 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QHV0h-0004gh-D5; Wed, 04 May 2011 07:52:32 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 216A71660F;
	Wed,  4 May 2011 07:52:31 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <7vzkn3itb5.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172716>

Am 5/3/2011 19:32, schrieb Junio C Hamano:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> Please do not set Mail-Followup-To!! It makes communication on this list
>> extremely inconvenient.
>>
>> Am 4/28/2011 21:27, schrieb Kacper Kornet:
>>> Definitions of ETC_GITCONFIG, ETC_GITATTRIBUTES and sysconfdir depend on
>>> value of prefix. As prefix can be changed in config.mak.autogen, all if
>>> blocks with conditions based on prefix should be placed after the file
>>> is included in Makefile.
>> ...
>> Does this patch do anything useful? After the patch is applied, sysconfdir
>> is set-but-not-used. Therefore, you can remove the assignments. But then
>> you lose the reference to $(prefix) that the commit message claims is so
>> important. Puzzled...
> 
> The only thing it does is to to allow you to set prefix in config.mak and
> then have it propaget to the selection of ETC_GITCONFIG (if prefix is /usr,
> then it is always /etc/gitconfig, otherwise it is always etc/gitconfig).
> The importance of prefix is not that the value is prefixed to ETC_GIT*,
> but it is used in the conditional to choose between the two.

Fair enough.

> We can get rid of assignments to sysconfdir in that sense. But you spotted
> a regression. If sysconfdir is set to somewhere else, even if you set prefix
> to /usr, we should set ETC_GIT* using the value given to sysconfdir.  The
> original code did so, but the patch lost it.

Looking closer, the patch introduces git_etcdir for no good reason, IIUC.
It should just re-use sysconfdir (the meaning of this variable is to point
to the etc directory).

-- Hannes
