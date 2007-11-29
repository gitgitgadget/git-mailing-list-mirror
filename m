From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] Replace instances of export VAR=VAL with VAR=VAL;
 export VAR
Date: Thu, 29 Nov 2007 08:39:52 +0100
Message-ID: <474E6CC8.8000301@viscovery.net>
References: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com>	<C3971B37-F75A-40EE-B30A-E88E5DAFAD55@lrde.epita.fr>	<D21294CA-6FD0-40F5-B0D6-5155865DA69A@wincent.com>	<CDF48716-F198-4B33-A5F5-8A2DE1F177EB@wincent.com>	<474AC136.8060906@viscovery.net>	<451492C9-F3EA-4C37-A1AD-59FC72E0A0A2@wincent.com>	<Pine.LNX.4.64.0711261340470.27959@racer.site>	<97F6E8DE-4022-4458-B6A9-C644A6EDC1E3@wincent.com>	<7vir3m94ku.fsf@gitster.siamese.dyndns.org>	<50645A3B-C5F0-4A99-A2B8-AD9251024244@wincent.com>	<7v1waa7lcv.fsf@gitster.siamese.dyndns.org>	<1570EAD5-9F47-4105-B3DA-49CA6FA57369@wincent.com>	<Pine.LNX.4.64.0711281355460.27959@racer.site>	<474D7956.8050401@viscovery.net>	<Pine.LNX.4.64.0711281428180.27959@racer.site>	<474D7D92.2000106@viscovery.net>	<Pine.LNX.4.64.0711281552440.27959@racer.site>	<85
 ve7m8iix.fsf@lola.goethe.zz>	<7vzlwy2dkm.fsf@gitster.siamese.dyndns.org> <85sl2q6kyu.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wincent Colaiuta <win@wincent.com>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Nov 29 08:40:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixe0X-00005k-4i
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 08:40:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761603AbXK2Hj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 02:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761591AbXK2Hj7
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 02:39:59 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:30808 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761579AbXK2Hj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 02:39:57 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IxdzJ-0003or-Lh; Thu, 29 Nov 2007 08:39:09 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 89A79546; Thu, 29 Nov 2007 08:39:52 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <85sl2q6kyu.fsf@lola.goethe.zz>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66510>

David Kastrup schrieb:
> Junio C Hamano <gitster@pobox.com> writes:
>> I thought somebody already mention that ash mishandles "export VAR=VAL"
>> but otherwise Ok.
> 
> dak@lola:~$ ash
> $ export JUNK=woozle
> $ sh -c 'echo $JUNK'
> woozle
> $ exit
> dak@lola:~$ dash
> $ export JUNK=woozle
> $ sh -c 'echo $JUNK'
> woozle
> $ exit
> 
> What problem are we talking about exactly, and with what shell?

$ export foo="bar    baz"
$ bash
bash$ export JUNK=$foo
bash$ sh -c 'echo "$JUNK"'
bar    baz
bash$ exit
exit
$ ash
ash$ export JUNK=$foo
ash$ sh -c 'echo "$JUNK"'
bar
ash$ exit

The problem is $foo not being quoted on the RHS of the assignment of the 
export command: bash doesn't word-split, but ash does. Hence, *if*
export VAR=VAL is used, always quote VAL.

-- Hannes
