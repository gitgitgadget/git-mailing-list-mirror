From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCHv2 4/4] git submodule: Fix handling of // and /.. in paths
 for added submodules
Date: Wed, 25 Feb 2009 16:03:09 +0100
Message-ID: <49A55DAD.2000309@viscovery.net>
References: <49A541D3.4030001@viscovery.net> <1235568392-19705-1-git-send-email-git@drmicha.warpmail.net> <1235568392-19705-2-git-send-email-git@drmicha.warpmail.net> <1235568392-19705-3-git-send-email-git@drmicha.warpmail.net> <1235568392-19705-4-git-send-email-git@drmicha.warpmail.net> <1235568392-19705-5-git-send-email-git@drmicha.warpmail.net> <49A55056.8020504@viscovery.net> <49A556D5.7020806@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Andrei Thorp <garoth@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Feb 25 16:04:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcLJT-0006YD-1W
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 16:04:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755616AbZBYPDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 10:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754988AbZBYPDP
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 10:03:15 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:35133 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754621AbZBYPDO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 10:03:14 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LcLHx-0001pw-H3; Wed, 25 Feb 2009 16:03:09 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 35EF4A865; Wed, 25 Feb 2009 16:03:09 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <49A556D5.7020806@drmicha.warpmail.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111461>

Michael J Gruber schrieb:
> Johannes Sixt venit, vidit, dixit 25.02.2009 15:06:
>> I think we have so far avoided \+ in sed expressions for portability reasons.
> 
> Hmmpf. Is it that new, or gnu specific? I'm always afraid of portability
> issues with bash but wasn't aware of sed being an issue as well.
> 
> In any case, would 's|\\*|/|g' be better (more portable) then?

You mean 's|//*|/|g'; yes, that is definitly portable.

> Well, how is
> 
> echo a/b/c/../../d | sed -e ':start;s|\([^/]*\)/\.\./||g;tstart'
> a/d
> 
> I meant: how portable is...

I don't know... Let's see: My AIX 4.3.3 sed understands it if it is not
all on a single line, and that says a lot. Specifically, I tried this:

echo a/b/c/../../d | sed -e ':start
             s|\([^/]*\)/\.\./||
             tstart
'

and got the desired result:

a/d

Note that the 'g' flag is not necessary in this case.

OTOH, this sed doesn't understand #comments :-/

-- Hannes
