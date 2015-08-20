From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] generate-cmdlist: re-implement as shell script
Date: Thu, 20 Aug 2015 14:11:41 -0400
Message-ID: <CAPig+cROaXkRVbpRJYiAL1yiXB1HV_12To=VMO8kZVk_AFE+2w@mail.gmail.com>
References: <1440015528-7791-1-git-send-email-sunshine@sunshineco.com>
	<xmqqegiy9a4d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Renato Botelho <garga@freebsd.org>,
	=?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 20 20:11:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSUJX-0007PP-7E
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 20:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbbHTSLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2015 14:11:42 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:34161 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbbHTSLm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 14:11:42 -0400
Received: by ykdt205 with SMTP id t205so46488116ykd.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2015 11:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=MVtfcnZtoPCjxYoBKbes5FvqEI4MkRqF3vfS5SFMd2I=;
        b=ql8w6Gphe7NAzb9VXEAQWZwKHsCPWk/Rn3TAFOPfTLfViSyoFi8X0l6Wkq6jZeli5I
         x1RCjwR6Pwqicm7nRs2fdyHaPYZ3iOCj14F2lqm/ffiuW+W2QtVFFuZJ5AY6CV7DMGpH
         QYFQ6icBa8k7qC432DvGutwIhyZx/+WcCgyIBZB9vGBGfHTKadkScETJ2sW/ux13kBGb
         MfsSn0jN0DgxqVdEgG3BJXzjqf8XzxAoPhUpOq8B0DALTLsYSvBtP5s1r4WHZggSn79D
         WULiA9176Nk3NRq2FsJ8TE4eUkSzBKACCn96xFx5X5eR2iBAhzKXKXRZ/9SqBKHHIgfM
         4j3w==
X-Received: by 10.170.55.70 with SMTP id 67mr5429430ykx.82.1440094301450; Thu,
 20 Aug 2015 11:11:41 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Thu, 20 Aug 2015 11:11:41 -0700 (PDT)
In-Reply-To: <xmqqegiy9a4d.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: 0wfcEFbpD8DNDbqSQCJK-7Z_Yqs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276256>

On Wed, Aug 19, 2015 at 6:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> In addition to reviving 527ec39^:generate-cmdlist.sh and extending it, I
>> also re-indented it with tabs instead of spaces, so it's helpful to
>> ignore whitespace changes when comparing the old and new versions of the
>> shell script.
>
> Hmph.  Perhaps we can view it as part of reverting 527ec39 and then
> redoing it in shell.

I'm having trouble understanding. Are you asking that this be
presented as a series of patches which first revert 527ec39, then do
the whitespace cleanup, and then augment the script for the extended
functionality? If so, it's a bit problematic because the original
script still expects the 'common' tag to be present, but that tag was
removed by the subsequent patch 2f5b495 (command-list.txt: drop the
"common" tag, 2015-05-21). So, reverting 527ec39 would also require
reverting 2f5b495.

> The way the shell script accumulates matchgrp
> variable (i.e. the literal LF in ${var:+string}) makes me feel some
> possible portability scare, which might be solved in a more stupid
> (i.e. not giving various reimplementations of Bourne shells a chance
> to screw it up) way by using another temporary file[...]

In addition to the literal newline and the temporary file, other
options I considered included assigning the newline to a variable and
then interpolating that variable (${var:+$LF}), or expanding the list
of patterns into a set of '-e' arguments for grep. But, I think I'll
just go with the temporary file.
