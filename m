From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 81/83] apply: roll back index in case of error
Date: Mon, 2 May 2016 03:18:37 -0400
Message-ID: <CAPig+cTovkSPi3W2-46fVLOdiYMCCwUkBNKys0C40dJwZ_dL-g@mail.gmail.com>
References: <1461505189-16234-1-git-send-email-chriscool@tuxfamily.org>
	<1461505189-16234-2-git-send-email-chriscool@tuxfamily.org>
	<alpine.DEB.2.20.1604251802480.2896@virtualbox>
	<alpine.DEB.2.20.1605020906400.9313@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 02 09:18:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ax87v-0007og-8Z
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 09:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbcEBHSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 03:18:39 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33295 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbcEBHSi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 03:18:38 -0400
Received: by mail-io0-f195.google.com with SMTP id x35so21977308ioi.0
        for <git@vger.kernel.org>; Mon, 02 May 2016 00:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=CBmEAuS12pQ7ZVPHMao1wmdrlq8VXCgL8kMhm/n3LOg=;
        b=BMjvLys+sj0YVnW6YDjIQM2gaaxu12SMi/tzKS4b04c56n/QpnqP9TzldeFJBZGdEO
         RNOdPAb9Q+NWOODynPmxWZK7KHkiWk6VyWmRgsqBEP0+vAu87322jg5HxJRHBH5ThQOo
         KtkTtbRq7gddYXCTc1gVtC5j+8aMyVv83kRX6VX0PVeNcddYH+cxLyXLvlpu2w+QgotW
         NDezim1kMtj6AvHQYWVPxGpKAF3y5fJ7QS8s/WNInbEpDePr2fqJiPHFLEY3e1dSMUVI
         ugALNV6jm6UU/rec83KlBdtLWZdlbjbQ/pFwmN+xpvvJCjpCzLRqRqWweKh2T7fyNtWl
         NzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=CBmEAuS12pQ7ZVPHMao1wmdrlq8VXCgL8kMhm/n3LOg=;
        b=L2TgijEHHr+XRaU7EoPfLcl3GxyuAfob0c/zwKCApr9mO/dwdfOSiKe/hmuptfXQD5
         luuNA6wPZCb74DTlwLdi4CYcDXB8OyHLTuZqml7yxgN6xWYNZf2FUINdv6lpQRf+tLOc
         NpWnWkN6MKdrmqxccZtCQvyZEglct7Jl9XVeIE8mni3QvUQf1QFdnovbU9Uqn0SQyO9Y
         NGR1qlMcSJB7eCfWSfZorrHwRbvWczOMxLsg1JLINGJ5K3Z4O94b1BiXn1Oj3/IfGc3X
         SFXmgifh5BtYoXl7BxI+SpdRPUX9aaS0mmaClBrzPlP1k+sDv8e7JVfLFiW2nxgKNifw
         BNnQ==
X-Gm-Message-State: AOPr4FWQy8bq/0FvovlulwgL1QeidNIwVVYkWiIsZrlCg3OUmdHYbMi+GmFMdjvxORWf6HD0j/MNseMHnvdpQw==
X-Received: by 10.107.132.66 with SMTP id g63mr41181964iod.34.1462173517347;
 Mon, 02 May 2016 00:18:37 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Mon, 2 May 2016 00:18:37 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1605020906400.9313@virtualbox>
X-Google-Sender-Auth: CtW5GAAyfgFHE10JyRILjWktjt8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293225>

On Mon, May 2, 2016 at 3:07 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> apparently this mail never made it to the list???

It made it to the list[1].

[1]: http://git.661346.n2.nabble.com/PATCH-80-83-run-command-make-dup-devnull-non-static-tp7654127p7654233.html

> On Mon, 25 Apr 2016, Johannes Schindelin wrote:
>
>> Hi Chris,
>>
>> On Sun, 24 Apr 2016, Christian Couder wrote:
>>
>> > @@ -4734,16 +4737,22 @@ int apply_all_patches(struct apply_state *state,
>> >             read_stdin = 0;
>> >             set_default_whitespace_mode(state);
>> >             res = apply_patch(state, fd, arg, options);
>> > -           if (res < 0)
>> > +           if (res < 0) {
>> > +                   if (state->lock_file)
>> > +                           rollback_lock_file(state->lock_file);
>> >                     return -1;
>> > +           }
>> >             errs |= res;
>> >             close(fd);
>>
>> In case of error, this leaves fd open, which in the end will prevent the
>> "patch" file, and hence the "rebase-apply/" directory from being removed
>> on Windows. This triggered a failure of t4014 here (and possibly more, but
>> it took me quite a while to track this down, what with builtin/am.c's
>> am_destroy() not bothering at all to check the return value of
>> remove_dir_recursively(), resulting in the error to be caught only much,
>> much later).
>>
>> Could you please review all open()/close() and fopen()/fclose() calls in
>> your patch series, to make sure that there are no mistakes? A passing test
>> suite does not really make me confident here, as our code coverage is not
>> quite 100%.
>>
>> Thanks,
>> Dscho
