From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/2] git-rebase -i: Add key word "drop" to remove a commit
Date: Wed, 27 May 2015 13:35:30 -0700
Message-ID: <xmqq382hlpwt.fsf@gitster.dls.corp.google.com>
References: <1432676318-22852-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<c78cd2ac17333a2e70d1113d95495c41@www.dscho.org>
	<1506177855.44397.1432738386768.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpq1ti23vva.fsf@anie.imag.fr>
	<xmqqsiahltbu.fsf@gitster.dls.corp.google.com>
	<vpq8uc9yfdp.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 27 22:35:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxi38-0006sN-NP
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 22:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbbE0Ufe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 16:35:34 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:33234 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbbE0Ufd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 16:35:33 -0400
Received: by igbpi8 with SMTP id pi8so96969328igb.0
        for <git@vger.kernel.org>; Wed, 27 May 2015 13:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=JfeSGMLFFhjNItgZXDrD06PW5nvgRDvEbYKghlRJt4U=;
        b=pqz6SC4KzboVM7FkEnvG9FysxiMtqki3EH/NMMtYPUhqj03mNYA1N3ppC/2a25inbc
         ug5PaJMfkmh1MjYoXqwQEV2z+aqrbKnU0R1cUcjZ3RCtuVaezN/GbRc7Q+hQ+XzL9xGz
         KsbU2ihEVl+NzC1yMXnNvRQcZxqtsH8v17FCioLo27OM4G6+XEAsQJ+njbufoeGl1UxI
         65fynKMadFKpQNpDVUAjJO/L2ZV6KhoD9dwrPVxhuhmj1f2DAEdIU1KB/ghoN8G/rDIC
         Wst/UZD3nUgmJ6V70QEUq3rPaDv5nTWBSDEmH4pIOwMh9icIjVpmNMnngqlnQawCocDr
         O6uw==
X-Received: by 10.50.41.8 with SMTP id b8mr39329496igl.38.1432758932617;
        Wed, 27 May 2015 13:35:32 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91c7:752b:4513:7344])
        by mx.google.com with ESMTPSA id lq3sm2609152igb.3.2015.05.27.13.35.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 May 2015 13:35:31 -0700 (PDT)
In-Reply-To: <vpq8uc9yfdp.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	27 May 2015 21:44:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270086>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>
>>> I find it weird to write
>>>
>>> noop <sha1> <title>
>>
>> True, but then it can be spelled
>>
>>     # <sha1> <title>
>
> I do find it weird too. "#" means "comment", which means "do as if it
> was not there" to me. And in this case it does change the semantics once
> you activate the safety feature: error out without the "# <sha1>
> <title>", rebase dropping the commit if the comment is present.

Well, I do not agree with the premise that "A line was removed, the
user may have made a mistake, we need to warn about it" is a good
idea in the first place.  Removing an insn that is not wanted has
been the way to skip and not replay a change from the beginning of
the time, and users shouldn't be trained into thinking that somehow
is a bad practice by having such an option that warns.
