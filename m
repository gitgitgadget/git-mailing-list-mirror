From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 00/12] port tag.c to use ref-filter APIs
Date: Wed, 26 Aug 2015 08:44:07 -0700
Message-ID: <xmqqy4gyukag.fsf@gitster.dls.corp.google.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
	<xmqqy4h04mx4.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZRYWNVmMeMCZSa+GcOTQ7NzuVB9RH_TFJ6-u7aFhrU=NA@mail.gmail.com>
	<xmqq8u904ix0.fsf@gitster.dls.corp.google.com>
	<xmqq37z82u2a.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZS=Mtz0ny0tUWRBY0vfAgiRzaszeF0m_pxnK3+VGn1eVg@mail.gmail.com>
	<vpqd1yap8ml.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 26 17:44:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUcs3-0008Rp-O6
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 17:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962AbbHZPoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 11:44:11 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35471 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbbHZPoL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 11:44:11 -0400
Received: by pacdd16 with SMTP id dd16so164290691pac.2
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 08:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=5xM+ok31Cix56kQSn6i3zSAxsVNJvNtVzQJH7/q58fo=;
        b=zNRwYEqZSF29MYz7D/Mx1RoOcHZcrJw0zWj5sfzq4I18JycraLF43vh7r4xSn6FldD
         Tixg2dFwtZvFrUYSC2Li77p1TEWeaH6HY+JGOnafSLswetZAOPx/rASAmtiHcUISprFb
         EuFZEcK2Cp4aG68dhdgQ8stkPuoVd4ULzmhL0crxs/G593hmuaG1Uy7MD2Qb5kUk33Fp
         62GKk3NVmNz03i08TJHnxHBkiruIkJqLutJj7a9GV19FDD2Gb6Y7K/7GL0WYrhy7Lsnh
         2Htuq5+3ClzOH9harVI9Zsv4JlS0F+a3u00fwidM1i3DZ0r0kXPSAXovSzydbX0vcyqH
         BiVA==
X-Received: by 10.68.218.65 with SMTP id pe1mr69660373pbc.2.1440603850297;
        Wed, 26 Aug 2015 08:44:10 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ac9b:ef8c:b4db:d257])
        by smtp.gmail.com with ESMTPSA id ye2sm23833008pab.31.2015.08.26.08.44.08
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 26 Aug 2015 08:44:08 -0700 (PDT)
In-Reply-To: <vpqd1yap8ml.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	26 Aug 2015 13:54:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276609>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> For the current code %(if:empty)%(align)%(end)%(then)Empty%(else)Not Empty%(end)
>> would print non-empty, I guess the documentation holds in that case.
>> Not sure if we require it to print non-empty.
>
> You don't want the %(if) condition to depend on whether
> --shell/--python/... is used. Since %(if:empty)%(align)%(end)%(then)
> holds when you don't use --shell, you also want it to hold when you
> quote. IOW, you should check for emptyness before (or actually without)
> doing the quoting. I guess this is what you're doing, and if so, I think
> it's "The Right Thing".

I agree that %(align)%(end) should expand to empty and %(if:empty)...%(then)
should look at that empty string without quoting.  So 

    %(if:empty)%(align)%(end)%(then)Empty%(else)Not Empty%(end)

should give "Empty"; otherwise the code is buggy, I think.
