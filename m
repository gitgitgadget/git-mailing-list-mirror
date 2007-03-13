From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH 2/3] git-bundle: die if a given ref is not included in
 bundle
Date: Mon, 12 Mar 2007 23:16:16 -0400
Message-ID: <45F61780.2090001@gmail.com>
References: <Pine.LNX.4.63.0703090348300.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45F0D1B3.9020204@gmail.com> <7vejny7umx.fsf@assigned-by-dhcp.cox.net> <45F17EF0.5060008@gmail.com> <7v1wjy56qf.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0703101637300.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45F2D955.8050800@gmail.com> <Pine.LNX.4.63.0703101749270.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45F2F934.8060407@gmail.com> <Pine.LNX.4.63.0703110201450.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vy7m4y3cn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0703110244130.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45F41787.4080506@gmail.com> <Pine.LNX.4.63.0703112302140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 13 04:16:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQxV6-0008BA-DS
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 04:16:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082AbXCMDQW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 23:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753083AbXCMDQW
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 23:16:22 -0400
Received: from ik-out-1112.google.com ([66.249.90.183]:15527 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077AbXCMDQV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 23:16:21 -0400
Received: by ik-out-1112.google.com with SMTP id c21so1876032ika
        for <git@vger.kernel.org>; Mon, 12 Mar 2007 20:16:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=rpSIDGJTGUlhHmcwKlvZb6p0SbGsPUd5C9mW1Wk4vk/nFbPna7EibH4dGRX+8O62jETQRPgS73y4+SSTU9IB6igj8PirlU+kG0OaKw6GWJrrhdsXcFiLqgnPLymfUGcnz8xA2rhE6hLRzvBEv1CVoTwpjTAwxbgQpCxEaUamTWw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ri2M20kI0K+kI6ihKMWLUy0/ZWcgt2zhCpJ+0aMlMJ+jmZBxN/gL+y1vbL8RtQJVggTK4DJ3wCOzLMtX3rDypd2KYyfL+qVJA8n2rDd9iEHg4yC/R2ZwvPIUDkjBuaQQ6gEIPMjfWGx8IVEp1i7RWefTzcZMkxK1gUGOC9UigjA=
Received: by 10.70.132.2 with SMTP id f2mr614535wxd.1173755779604;
        Mon, 12 Mar 2007 20:16:19 -0700 (PDT)
Received: from ?192.168.100.117? ( [71.246.235.75])
        by mx.google.com with ESMTP id h13sm6483180wxd.2007.03.12.20.16.17;
        Mon, 12 Mar 2007 20:16:18 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <Pine.LNX.4.63.0703112302140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42106>

Johannes Schindelin wrote:
> FWIW my plans are to make the pack thin _only_ when there is only one 
> prereq and/or ref in the bundle (this prevents a _wanted_ object being 
> deltified against a not-wanted object).
>
>   
I am not sure that this is really necessary or accomplishes additional 
safety. The prerequisites must exist and be well connected in the target 
repo before the pack file is indexed: presumably, the reference objects 
all exist if the checks hold, or there is a logic flaw in the thin-pack 
generation.

If the prereq test is removed, then avoiding a thin pack might allow the 
pack file to be applied to a repo that held only the prereqs for a 
single head out of many in the bundle, but there is no info for the user 
to understand how or when to do this and I don't really think that is a 
good practice to encourage. I suggest waiting for a well defined 
use-case that really demands being able to apply only part of a pack 
file before implementing.

> Also, as mentioned above, I think that we have to check that "git rev-list 
> --objects <new-refs> --not --all" does not result in missing objects.
>   
This is certainly a good safety check: even though the prereqs are 
satisfied and all *should* be ok, some error might still exist and it is 
better to be safe.
> Ciao,
> Dscho
>   
