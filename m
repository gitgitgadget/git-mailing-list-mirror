From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 81/83] apply: roll back index in case of error
Date: Tue, 3 May 2016 14:57:52 +0200
Message-ID: <CAP8UFD0tGruUTrk5aJ7oGM9jj1HzpM2afqEsJfKyuDB+CWc=fQ@mail.gmail.com>
References: <1461505189-16234-1-git-send-email-chriscool@tuxfamily.org>
	<1461505189-16234-2-git-send-email-chriscool@tuxfamily.org>
	<alpine.DEB.2.20.1604251802480.2896@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 03 14:57:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZtl-0004VC-SE
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933259AbcECM5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 08:57:54 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37227 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932903AbcECM5x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:57:53 -0400
Received: by mail-wm0-f49.google.com with SMTP id a17so37654270wme.0
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=qPPZzx9bAYPy/xBfPyBI0LazSKTz7eNtttgVYFNLaVM=;
        b=I/A2Q5oG8gKvNdbYFlDCJOMUlwTYWQhakLXgp6NB41YI6tTSEfW92tfoCnC7euDVV2
         dHSUVZXaDohcdDE/mJgpZVJ0Jm0WccvAW9eExhz5hDJhMcw+nh3Ea3nJAe6M6xtABmN4
         +a8TI+mGA7cdSwgX3fbRjl1Z7jY0pahJz6WUZ8hgL8Yb6A59aqKjeIlZtscxLa3jdWd2
         eetrpE4Kz5uvyV1vrV96ZPeKi5ddkSOhXsurZAKX8dFEsOuQcWgOaevz1bLkTgyW8Mof
         ZwX1DN0qCIW+LQpX8AWOC057+z3R5wEsSq6F/h2uMKQpFta3qIqjWvYUwQCmz3PGPhDr
         kuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=qPPZzx9bAYPy/xBfPyBI0LazSKTz7eNtttgVYFNLaVM=;
        b=FcWeKX47joGKyvZEC5+w3dXByggQWeSIqjaywTXYIQryE3urn8/s0HlCr7qr2PbJhy
         f032hMuq1G6ZOjt/Uo0tZnUAS8lHAde6xP7jjcwxGzFKg3/472YHGRqOqGpTevFXhez/
         111oTOF5NVCQ/yiWuFQ9pdz7J6oPY+wLLCP2x7w8LjnqA2G7nifuyPSHwJbfvzZBOJ7P
         mPm2evqm4qSQOfqEWVvImN+HUeExhvMcJvdH/nsgmDjEcXcG8Y9f9hCoBtdLO+JPaaIy
         cohFY6Yjtaa7bhkJJ0zQ0mENTrdPtOCaHlUcRhIj+npMzVH66LSC+PbKLgtn7PY5k8nE
         ajsA==
X-Gm-Message-State: AOPr4FXHLKPb0GvYxgxbK/93bGFzeg9JNMfj4ClFPL+ERlgb5q9e9HGzYrHHYWuS/JAARs61CIjwsf1fm9Pkdg==
X-Received: by 10.194.20.162 with SMTP id o2mr2767190wje.78.1462280272064;
 Tue, 03 May 2016 05:57:52 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Tue, 3 May 2016 05:57:51 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1604251802480.2896@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293396>

Hi Dscho,

On Mon, Apr 25, 2016 at 6:06 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Chris,
>
> On Sun, 24 Apr 2016, Christian Couder wrote:
>
>> @@ -4734,16 +4737,22 @@ int apply_all_patches(struct apply_state *state,
>>               read_stdin = 0;
>>               set_default_whitespace_mode(state);
>>               res = apply_patch(state, fd, arg, options);
>> -             if (res < 0)
>> +             if (res < 0) {
>> +                     if (state->lock_file)
>> +                             rollback_lock_file(state->lock_file);
>>                       return -1;
>> +             }
>>               errs |= res;
>>               close(fd);
>
> In case of error, this leaves fd open, which in the end will prevent the
> "patch" file, and hence the "rebase-apply/" directory from being removed
> on Windows. This triggered a failure of t4014 here (and possibly more, but
> it took me quite a while to track this down, what with builtin/am.c's
> am_destroy() not bothering at all to check the return value of
> remove_dir_recursively(), resulting in the error to be caught only much,
> much later).

Sorry about that and thanks for tracking down the source of the test failure.
I fixed this by moving the "close(fd)" call just after the "apply_patch()" call.

> Could you please review all open()/close() and fopen()/fclose() calls in
> your patch series, to make sure that there are no mistakes? A passing test
> suite does not really make me confident here, as our code coverage is not
> quite 100%.

Ok, I will have another look at the 2 other places where there are
open()/close() or fopen()/fclose() calls.

Thanks,
Christian.
