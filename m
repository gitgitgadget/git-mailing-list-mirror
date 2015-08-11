From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 13/16] lock_repo_for_gc(): compute the path to "gc.pid"
 only once
Date: Tue, 11 Aug 2015 13:20:15 -0700
Message-ID: <CAPc5daXW-uP+3t+7fXvhyb9TkyeTJL9=Phc9PJJ-iwr4uyfS_w@mail.gmail.com>
References: <cover.1439198011.git.mhagger@alum.mit.edu> <e34adde5b2cc3adbcd011ee06aeab93b3459a883.1439198011.git.mhagger@alum.mit.edu>
 <xmqq4mk5r3nf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Aug 11 22:20:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPG2X-0005LV-Qx
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 22:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932810AbbHKUUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 16:20:42 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:34581 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932674AbbHKUUf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 16:20:35 -0400
Received: by iodb91 with SMTP id b91so154639961iod.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 13:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ITSstL5vbBzhzQNSSG1QVSbovFYE13OlNAP5ljxkXOw=;
        b=VjuQbSTp2iSuFE+HPNVFiAfatNWmhaUoNIbcQD4dH/OS5k3jwWUq8QnZRskCTUfgMB
         M4iNy7TdgWMTOwnJgce6KId+qemVxTjTSccz7/g7YkYYMmuPFPtkjG3OZamomOyHLtYH
         Zxxw/0Vtp5VdtK1ltMKs7X78nX0AKC1y07ykHpyXNIY4f1rEXyI2W2yYPCpj/lOeIXzj
         bUjENBOa0eO4ahzjMK+EVITmLo6RRVGND4uurpREYMADS+tQVdsB6jx0SCqEiBQ5LZXX
         WEV8Kin1C0LeR3a8YVsbm8NSFoj4vKVvcXYsqqDbOtzq7pZBk7wC/WOLRTc3GTLldV2n
         v1vg==
X-Received: by 10.107.3.33 with SMTP id 33mr30353792iod.132.1439324434615;
 Tue, 11 Aug 2015 13:20:34 -0700 (PDT)
Received: by 10.36.41.149 with HTTP; Tue, 11 Aug 2015 13:20:15 -0700 (PDT)
In-Reply-To: <xmqq4mk5r3nf.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: utESDMOgyHZ0qIcHUHZIuI0L2Ho
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275718>

On Tue, Aug 11, 2015 at 1:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Looks correct; somehow this reminded me of the other topic from Peff
> to reduce use of git_path() ;-)
>
>> -     pidfile = git_pathdup("gc.pid");
>> +     pidfile = pidfile_path;
>>       sigchain_push_common(remove_pidfile_on_signal);
>>       atexit(remove_pidfile);
>
> I wonder if you can reduce the atexit() here by registering this as
> a tempfile to be cleared?

Heh, I should have been slightly more patient. That is what 14/16 is about ;-)
