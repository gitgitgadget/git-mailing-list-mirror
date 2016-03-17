From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: Re: [PATCH/RFC/GSoC 1/3] path.c: implement xdg_runtime_dir()
Date: Thu, 17 Mar 2016 18:20:14 +0800
Message-ID: <CAKqreuxBtu3hXVxY27_u-9ZxSP_AfSqeoB=d_UJdUsSTphgf=g@mail.gmail.com>
References: <CAKqreux4aYhXTE9kUHKoKCJ2-4KDWyi58ioCm-CWqXhUYCtEEw@mail.gmail.com>
	<1458122865-29447-1-git-send-email-huiyiqun@gmail.com>
	<20160316170623.GB4039@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Your friend <pickfire@riseup.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 17 11:20:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agV2Y-0005XZ-Nw
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 11:20:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965896AbcCQKUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 06:20:18 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:32956 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935295AbcCQKUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 06:20:16 -0400
Received: by mail-oi0-f47.google.com with SMTP id d205so59549330oia.0
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 03:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=UNbyUzUPcdV7S+Oqq4y5PI/U2FyrCsqsNz7nUl953Q4=;
        b=mbN8I1U6f9mEDWGAxfEGb1bbYz3thpeXqGm601lUreCX4U58pYrCMjFeF6dc7gxGyl
         Bz0FjUYSlfHZBrM9qxoS4Be11Ug0z6ToiS+jARUkYHg/AhWpQSJQCoVEmVk2KQ2yGRW3
         vHdwbB1O6dpLJF/k9LXvSjE9gx5gCIYeAQUiOWWiW0XM9R9weeXPJ6ci+tbAsUig10o6
         pbwPrIjqiCujB5CSv7OqasJv9ku7sWmYk5QV19VBaC/prxRWw+IbsR2cyUm1ynEzTgMF
         TsdRDKOKDxioW1BbfGn/NHYIugCk+eL3Lj43haybiaUexuBaqjVh4c44OFN706wK1Lck
         6kAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=UNbyUzUPcdV7S+Oqq4y5PI/U2FyrCsqsNz7nUl953Q4=;
        b=acyR/6CO7N/I0yz0aygYZ3v93/DkaOJfKJ80RNZkHNTSlwSi8GRE9zrunNbUJ/E0TJ
         uQm/oKdoFPLU6QmH0034iOEVGObifPegUG59dzm2TvRF2uGEwbjI4BWf3q0gjLJPBVud
         38ghb0r7v3eqsDA+3SpoNS3dYPGDuWo+lNYpufeaayhglvC4nObQPSGhqjbjld4yqrWM
         dJG9o9gsynMNKpGWTKXM8c1FSoif6LDmmmHgKEEsvuY23xNR0j/5hHBDQcVwkJ+K9WpI
         LTxpJTcJ9jp7gQa545Eyjb/mtluEJS2ZvILSzO5MnSp1HusuHOOUYnC3zUzJb6lWhVzv
         yOUQ==
X-Gm-Message-State: AD7BkJIbRuIy2P5FSgHpIj4kpnyRkEzZSIICdrM2Nv/cOOlXIHLCCOOVtLHQ0Wch8R7yR9Lg/qytBsrv+2HePw==
X-Received: by 10.202.66.5 with SMTP id p5mr5315215oia.65.1458210014919; Thu,
 17 Mar 2016 03:20:14 -0700 (PDT)
Received: by 10.157.43.68 with HTTP; Thu, 17 Mar 2016 03:20:14 -0700 (PDT)
In-Reply-To: <20160316170623.GB4039@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289095>

2016-03-17 1:06 GMT+08:00 Jeff King <peff@peff.net>:
> On Wed, Mar 16, 2016 at 06:07:43PM +0800, Hui Yiqun wrote:
>
>> +     if (runtime_dir && *runtime_dir)
>> +             git_runtime_dir = mkpathdup("%s/git/", runtime_dir);
>> +     else
>> +             git_runtime_dir = mkpathdup("/tmp/git-%d", uid);
>
> Here we allocate the string, but later we may return NULL on error,
> leaking the allocated memory.

Yes, do you think goto is a good solution for clearup?

>
>> +     if (!lstat(git_runtime_dir, &st)) {
>> +             /*
>> +              * As described in XDG base dir spec[1], the subdirectory
>> +              * under $XDG_RUNTIME_DIR or its fallback MUST be owned by
>> +              * the user, and its unix access mode MUST be 0700.
>> +              *
>> +              * Calling chmod or chown silently may cause security
>> +              * problem if somebody chdir to it, sleep, and then, try
>> +              * to open our protected runtime cache or socket.
>> +              * So we just put warning and left it to user to solve.
>> +              *
>> +              * [1]https://specifications.freedesktop.org/basedir-spec/
>> +              * basedir-spec-latest.html
>> +              */
>
> OK. I think these checks should be sufficient to deal with the /tmp race
> I mentioned elsewhere in the thread (assuming that an attacker cannot
> flip the uid back and forth in the same way, but that should be true on
> Unix systems).
>
>> +             if ((st.st_mode & 0777) != S_IRWXU) {
>> +                     fprintf(stderr,
>> +                                     "permission of runtime directory '%s' "
>> +                                     "MUST be 0700 instead of 0%o\n",
>> +                                     git_runtime_dir, (st.st_mode & 0777));
>> +                     return NULL;
>> +             } else if (st.st_uid != uid) {
>> +                     fprintf(stderr,
>> +                                     "owner of runtime directory '%s' "
>> +                                     "MUST be %d instead of %d\n",
>> +                                     git_runtime_dir, uid, st.st_uid);
>> +                     return NULL;
>> +             }
>
> Should these be using warning(), rather than a raw fprintf?

Well, I will replace it.

During the greping. I found that I should also wrap my warning strings
with _() for i18n.

>
>> +     } else {
>> +             if (safe_create_leading_directories_const(git_runtime_dir) < 0) {
>> +                     fprintf(stderr,
>> +                                     "unable to create directories for '%s'\n",
>> +                                     git_runtime_dir);
>> +                     return NULL;
>> +             }
>> +             if (mkdir(git_runtime_dir, 0700) < 0) {
>> +                     fprintf(stderr,
>> +                                     "unable to mkdir '%s'\n", git_runtime_dir);
>> +                     return NULL;
>> +             }
>> +     }
>
> And this retains the un-racy mkdir(). Good.
>
>> +     free(git_runtime_dir);
>> +     return mkpathdup("%s/%s", git_runtime_dir, filename);
>
> This mkpathdup accesses the string we just freed?
>
> It might be easier to just use a strbuf here, and then you can append to
> it at the end.

I think so. Thanks.

>
> -Peff
