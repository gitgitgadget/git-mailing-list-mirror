From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH] handle_alias: provide GIT_CWD to !alias
Date: Wed, 13 Apr 2011 15:16:24 +0200
Message-ID: <4DA5A228.2040105@drmicha.warpmail.net>
References: <4DA59B27.50506@ge.infn.it> <e8c9aa9160f922f728d56387e5e86eb50220774f.1302699792.git.git@drmicha.warpmail.net> <BANLkTimubmaV437LvdG8QcmFFjyWujQRzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Matej Batic <matej.batic@ge.infn.it>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 15:16:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9zvs-0002Ey-Eu
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 15:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753277Ab1DMNQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 09:16:27 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:58219 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752364Ab1DMNQ0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2011 09:16:26 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D753820D93;
	Wed, 13 Apr 2011 09:16:25 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute6.internal (MEProxy); Wed, 13 Apr 2011 09:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=xHyV0EyUWZuz38KFLZTr7fYvWlA=; b=dTekdsg5QsMsuKYemK9H2sGBDaX99cv8aZwrt5z3H/7F401UeRa+o2cKpU2iYmjqQfvFXPPSDpS/njIe6JM+DULwh4Zj5gICRSjAFf5VIxsZMDF22ESyhCeRMc4trSJZPfWtjfh9vb450cGKOpw8/0xFMPfxRHzI2WtiXKeKsIo=
X-Sasl-enc: xRomG5Qint7CFSXGajPZeYNCFdskpnJdVNkGnru+K6VA 1302700585
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 44E71406975;
	Wed, 13 Apr 2011 09:16:25 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <BANLkTimubmaV437LvdG8QcmFFjyWujQRzw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171454>

Nguyen Thai Ngoc Duy venit, vidit, dixit 13.04.2011 15:12:
> On Wed, Apr 13, 2011 at 8:05 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> -                       ret = run_command_v_opt(alias_argv, RUN_USING_SHELL);
>> +                       strbuf_addstr(&sb, "GIT_CWD=");
>> +                       if (subdir)
>> +                               strbuf_addstr(&sb, subdir);
>> +                       env[0] = sb.buf;
>> +                       env[1] = NULL;
>> +                       ret = run_command_v_opt_cd_env(alias_argv, RUN_USING_SHELL, NULL, env);
>> +                       strbuf_release(&sb);
>>                        if (ret >= 0)   /* normal exit */
>>                                exit(ret);
> 
> subdir can be NULL. I'm not sure if it can be empty string though. May

I'm pretty sure that my "if (subdir)" would catch that...

> need a check and set it to '.' so "cd $GIT_CWD" does not go back to
> $HOME.

Well, with the current implementation you get empty or the subdir so
that you can easily "test -n $GIT_CWD". If you want to cd around you can
do "cd ./$GIT_CWD" unconditionally. I think this is more useful than
having a "." there.

Michael
