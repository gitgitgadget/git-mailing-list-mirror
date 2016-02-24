From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] git config: do not create .git/ if it does not exist yet
Date: Wed, 24 Feb 2016 18:01:15 +0700
Message-ID: <CACsJy8BETTY82RuEPD_Hthi3eXRK6WDutjO1RGscfCSun2SfUQ@mail.gmail.com>
References: <c4027d758b0914dbc2e1ff5df344b0669aac4447.1456299545.git.johannes.schindelin@gmx.de>
 <20160224082657.GD12511@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 24 12:01:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYXCd-00011w-6W
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 12:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756615AbcBXLBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 06:01:49 -0500
Received: from mail-lb0-f178.google.com ([209.85.217.178]:34380 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754394AbcBXLBq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 06:01:46 -0500
Received: by mail-lb0-f178.google.com with SMTP id of3so8138348lbc.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 03:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SKUer7z0ELyzFL42QhQi8k2VYEknDYARlukwOEDMjyU=;
        b=gE7bJ4/9Wu34lyU3lhLNewoEEMySrouTCSVdEoMdwiiZrhI2NlbRL30tD35bYiIIM7
         3Fe9UZ1Xzga1rgJNtXWS1tnEWzlARKR20JiCuLz/wWM0HiYs6NDCoK77qoI5NvpliHmt
         hceJw9C6gpRcLSO2/shUd/sQmCit1RqE+hY1RBFj5XlGxObJ3igyb9ABklJ+def1Ih/O
         UPFpAciLmFxxUwETK93erwlr7jKe9Pir1KzuOsWByxjXDDDZ1+q0YH7iFh2HnQ1Ma0vS
         SksYq/fm4Qb6YqBL8AU7+p/4MaWT3GBt1w9aMznAZCofC5VjT3DRhibMz/i5seOoxBrs
         sxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=SKUer7z0ELyzFL42QhQi8k2VYEknDYARlukwOEDMjyU=;
        b=dUpB/jlnFabBeVo0ZPhAqSb0d1dJU7xU0gvckcntBx9zNTMyPxYgDFm4CuGA15CReU
         gnRHLAsad6WIOwm7argtWKvLJJo3/KUF0zX3cSnjWSdH9W8EM3dDHCNK9809kOgvAKsK
         GNqym1kRGgy3g5o2AaCHWLOq83AMeAYROylXGFL7TuByLU6QMRy2AZMuXXHDMh2jkvOx
         01uRGVl09WX1XKQXi1GfwicR1SfZ7h5rm/Bwb4xH9I3MOPrnshBJ3P0lSqMhygmswds+
         sIRkjdIfxRR9COrg9EYoEmyUb9l3VtpohFhZp5ZFfRm3rJpIaUih1/qO2r32U0P7bvZ8
         9vVg==
X-Gm-Message-State: AG10YOQTgrdrPTY1vv3Ifg3kcQIpMt9IkLQsdwahww9aGt/3GDnBx7OLjq13dn2fGNuY8IMCa3chq7rrgWLMPA==
X-Received: by 10.112.130.41 with SMTP id ob9mr13983842lbb.81.1456311705325;
 Wed, 24 Feb 2016 03:01:45 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Wed, 24 Feb 2016 03:01:15 -0800 (PST)
In-Reply-To: <20160224082657.GD12511@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287198>

On Wed, Feb 24, 2016 at 3:26 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Feb 24, 2016 at 08:47:00AM +0100, Johannes Schindelin wrote:
>
>> It is a pilot error to call `git config section.key value` outside of
>> any Git worktree.
>>
>> Let's report that error instead of creating the .git/ directory and
>> writing a fresh config into it.
>
> Hmm.  I get (on my Linux machine):
>
>   $ git config foo.bar baz
>   error: could not lock config file .git/config: No such file or directory

Yep, tried the same thing before I asked about the .git dir thing on
gfw list. Same result.

> which makes sense (though still isn't a great error message, and is kind
> of weird if you happen to have a .git directory that isn't a real
> repository).

Known bug. If setup fails to find git dir and somebody (plenty of them
in fact) calls get_git_dir(), we automtaically assume git dir is
".git".

> Is Git more aggressive about auto-creating the directory for lockfiles
> on Windows? I tried the exact recipe you gave in the linked thread, just
> to be sure, but I couldn't replicate it.

If .git is created before lockfile code, then the lock should be
successfully created.  The fix in check_write() fixes it for Johannes,
so it must be something between

// if (action == ACTION_SET) {...
check_write();
check_argc(argc, 2, 2);
value = normalize_value(argv[0], argv[1]);
ret = git_config_set_in_file(given_config_source.file, argv[0], value);

I don't see where mkdir() can be called either.

Johannes, maybe you can force a crash in mingw_mkdir to pinpoint this
code? Just in case the bug is outside config code.
-- 
Duy
