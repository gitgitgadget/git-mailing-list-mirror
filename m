From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] post-receive-email: explicitly set Content-Type header
Date: Tue, 20 Sep 2011 13:10:49 +0200
Message-ID: <4E7874B9.2060909@viscovery.net>
References: <1316505154-3904-1-git-send-email-zapped@mail.ru> <1316506023-5098-1-git-send-email-zapped@mail.ru> <4E785DC6.80105@viscovery.net> <20110920104256.GA11656@zapped.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: zapped@mail.ru
X-From: git-owner@vger.kernel.org Tue Sep 20 13:11:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5yE9-0002W9-7r
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 13:11:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696Ab1ITLKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 07:10:55 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:19350 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123Ab1ITLKz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 07:10:55 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1R5yDy-0003WT-29; Tue, 20 Sep 2011 13:10:50 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id CA15C1660F;
	Tue, 20 Sep 2011 13:10:49 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.22) Gecko/20110902 Thunderbird/3.1.14
In-Reply-To: <20110920104256.GA11656@zapped.homeip.net>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181755>

Am 9/20/2011 12:42, schrieb Shumkin Alexey:
> On Tue, Sep 20, 2011 at 11:32:54AM +0200, Johannes Sixt wrote:
>> Am 9/20/2011 10:07, schrieb Alexey Shumkin:
>>> +# hooks.emailcharset
>>> +#   The charset used in Content-Type header. UTF-8, if not
>>> specified.
>>
>> How can you be sure that the output produced by git log etc. that are
>> used in the script are in the encoding specified by this variable?
>> IOW, wouldn't log.outputencoding be the better choice to use in the
>> Content-Type header?
> Yes, you're right, we cannot be sure in UTF-8 encoding of output
> and using i18n.logoutputencoding would be a better choice
> instead of new config variable.
> 
> But at the present
> 1. post-send-mail uses description file of a repo
> 2. gitweb also uses this file and AFAIK it assumes one to be in UTF-8
>   (I do not know whether it can be changed there but I tested gitweb once long
>     time ago)
> 3. So if i18n.logoutputencoding is not UTF-8 we get a message composed
> 	with mixed encodings. This fact oblidge us to encode headers
> 	(as quoted printable at least) and synchronize body message that contain
> 	repo description (in UTF-8) and diffstat (in i18n.logoutputencoding).
> 	This is a more complicated task for a shell script
> 	than just specifying Content-Type header (may be git-send-email suits here?)

In this case, it may make sense to have a separate setting, but you should
call git like this:

   git -c "i18n.logoutputencoding=$emailcharset" show ...
   git -c "i18n.logoutputencoding=$emailcharset" rev-list --pretty ...

-- Hannes
