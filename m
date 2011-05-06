From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] t1507: change quoting in test_did_you_mean to a more
 general one
Date: Fri, 06 May 2011 12:22:39 +0200
Message-ID: <4DC3CBEF.6080303@viscovery.net>
References: <20110505191027.GA3242@camk.edu.pl> <7vsjss6hmf.fsf@alter.siamese.dyndns.org> <4DC3A685.4080300@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Fri May 06 12:22:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIIBO-0002FP-E2
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 12:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878Ab1EFKWp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 06:22:45 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:16148 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825Ab1EFKWo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 06:22:44 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QIIBD-00009Y-Up; Fri, 06 May 2011 12:22:40 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A7D551660F;
	Fri,  6 May 2011 12:22:39 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <4DC3A685.4080300@drmicha.warpmail.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172968>

Am 5/6/2011 9:43, schrieb Michael J Gruber:
> Junio C Hamano venit, vidit, dixit 05.05.2011 22:02:
>> Kacper Kornet <draenog@pld-linux.org> writes:
>>> -	printf "fatal: Path '$2$3' $4, but not ${5:-'$3'}.\n" >expected &&
>>> -	printf "Did you mean '$1:$2$3'${2:+ aka '$1:./$3'}?\n" >>expected &&
>>> +	printf "fatal: Path '$2$3' $4, but not ${5:-\'$3\'}.\n" >expected &&
>>> +	printf "Did you mean '$1:$2$3'${2:+ aka \'$1:./$3\'}?\n" >>expected &&
> Other than that, I have no objections if this patch makes more shells
> happy and no happy ones unhappy.
> 
> Is your ksh OK with all other tests?

Note that:

- With the proposed change, bash now prints the backslashes.

- The printfs should be echos, really.

- The behavior of quoting at the right of :- when the ${...:-...} exansion
appears in double-quotes was debated recently at length at the Austin
group (which revises the POSIX standard). You better move the expansions
to assignments of temporary variables, where you don't need the
surrounding double-quotes:

	butnot=${5:-\'$3\'} aka=${2:+ aka \'$1:./$3\'}

Here, the backslash unambiguously quotes the next character.

-- Hannes
