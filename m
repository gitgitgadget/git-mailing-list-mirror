From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 59/83] builtin/apply: move init_apply_state() to apply.c
Date: Sun, 1 May 2016 22:19:31 +0200
Message-ID: <CAP8UFD2T6naSMqK+yvBysw9-4hjN1yhUi33Cc73+ChFsistDBQ@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-60-git-send-email-chriscool@tuxfamily.org>
	<CAPig+cTxZf=oMB=V5JoZNUO6eTtnabv7LinNo1LUeah6ofrbEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun May 01 22:19:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awxq8-0006Al-M2
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 22:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173AbcEAUTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2016 16:19:33 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36731 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbcEAUTc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 16:19:32 -0400
Received: by mail-wm0-f49.google.com with SMTP id n129so86180755wmn.1
        for <git@vger.kernel.org>; Sun, 01 May 2016 13:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=eCXSM6HZTNCkIwQ0vF6T8qcX0mQ402rf2b/fPgOm9oo=;
        b=zRISqLIlUTwvSoVMEWV/XGLoAj5rHTBkjgFvPZY+TiHc4Es9ctTMs/rjTlfdVRN3D0
         A2s8UjrhixUjeYZKhDCnIj7pPBxEhYgiDc0SGpfkppQCzprL/ZEGOtzdIaie4SorqmLP
         bJy6aNZ29Rxni4P+GdFn9XFQUoHpSFwQyUKa7oXQSbQz7McNDSg53Hm0fz8Ntsl+SMen
         Ff1gv1nGtUd12ptq5MifFUve3ymp5XG6Z237i8Vq56sljTarwzpWcWeifl7SteK8B9UM
         CYL/szwLlKKY9BWQ5Xrj4AebibGj6lFhKYUMP++iYSEOFdVnGZSB231REPa5mKu2MbKO
         PXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=eCXSM6HZTNCkIwQ0vF6T8qcX0mQ402rf2b/fPgOm9oo=;
        b=CWTmPTQQsqDD5YvU0NlrrvHBADBiGHvTLpOCGlOnoYiPQPZdIzhgWkZ+RbmkRvRqIE
         RuiuqfAGdaP891GxEXgaG+6FxVafbT9m898/3755Nz/11cHMMZIdXRqenNjLdy4Y5O8/
         IPeW82B9aLC7nQ7b9CtUMQDvR//4h/LmlXjdMA2onWksiXK6/rGOtqajpQwDTrZczGAf
         b1pPUPHmbUjQrc+cB0Yuhe7lQ/PEMZgKk0lEoVabfBrkVwBckrcOHB/NYFkl1ogRFTRh
         A5oJMf5d75aP8WXHC9R9fckHki3ky0p71NQi113jhw2xYLXwi1uWlmWUbXQrpDb4Q4IU
         5KVA==
X-Gm-Message-State: AOPr4FVtvhnVzBPZK1CXa4AdwcvmrykZ10N3fAWIirm4vy2fRF0dJxrOgHHxEZgixrs4JqggDW+6AhXqbWg6LQ==
X-Received: by 10.28.129.22 with SMTP id c22mr15950219wmd.89.1462133971401;
 Sun, 01 May 2016 13:19:31 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Sun, 1 May 2016 13:19:31 -0700 (PDT)
In-Reply-To: <CAPig+cTxZf=oMB=V5JoZNUO6eTtnabv7LinNo1LUeah6ofrbEA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293213>

On Sun, May 1, 2016 at 9:37 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Apr 24, 2016 at 9:33 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>> diff --git a/apply.c b/apply.c
>> @@ -0,0 +1,80 @@
>> +#include "cache.h"
>> +#include "apply.h"
>> +
>> +
>> +
>
> Too many blank lines?

Ok, I will remove 2 of them.
