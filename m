From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/2] push: allow --follow-tags to be set by config push.followTags
Date: Sun, 15 Feb 2015 22:02:08 -0800
Message-ID: <CAPc5daU6VOmuNp3VbYgoFDXJshkC2AnRsZQQdoRMArYpezZr=A@mail.gmail.com>
References: <1424055690-32631-1-git-send-email-cxreg@pobox.com>
 <20150216052049.GA5031@peff.net> <20150216054550.GA24611@peff.net> <20150216055422.GB24611@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dave Olszewski <cxreg@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 16 07:02:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNElN-0004WO-I0
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 07:02:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287AbbBPGC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 01:02:29 -0500
Received: from mail-ob0-f171.google.com ([209.85.214.171]:55456 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbbBPGC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 01:02:28 -0500
Received: by mail-ob0-f171.google.com with SMTP id gq1so38985344obb.2
        for <git@vger.kernel.org>; Sun, 15 Feb 2015 22:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=1yV7xhGbtkd+4cy5pvoQct6c7xCbzQuzWphZz0nM2PE=;
        b=MeJFSCKOq/w3HIWnTXFrIWEsJbvjwFWLC9D3StPuvjv/DFimR3zJjMx5cnsYY0yx1E
         mbBiK+Yp4r93yKFVwMMPWLMCIcnIGkK8KFxo/qXPj957MLavJMlIA6dJzN9KcV3SbjQ2
         IkvlhQY0bHqpPhK4i6qqNsJXw/a6z6EtDAgHzbaII60NIt1GWd1+C9zOkNoeT+CHWVMD
         /W8C/PW5rit4YxPweie+l4WkpmAf0E6AODkhvc8kQEVKBrOrTcFlHkvvfYuM8pl6aj/A
         ESL69k22sA4XLaVMozo+WNdmTSKcLDPMUPwbySfjADVd6fSGaagF5hKHfmpGzzh2hR2k
         jVvA==
X-Received: by 10.182.149.164 with SMTP id ub4mr13917139obb.1.1424066548242;
 Sun, 15 Feb 2015 22:02:28 -0800 (PST)
Received: by 10.202.48.132 with HTTP; Sun, 15 Feb 2015 22:02:08 -0800 (PST)
In-Reply-To: <20150216055422.GB24611@peff.net>
X-Google-Sender-Auth: xpAdDjGKT3x-Sqas5x8kftwiGXs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263875>

On Sun, Feb 15, 2015 at 9:54 PM, Jeff King <peff@peff.net> wrote:
>
> Or alternatively, we could pull the "flags" field from cmd_push out into
> a static global "transport_flags", and manipulate it directly from the
> config (or if we don't like a global, pass it via the config-callback
> void pointer; but certainly a global is more common in git for code like
> this). Then we do not have to worry about propagating values from
> integers into flag bits at all.

Yup, that would be my preference. The largest problem I had with the
original change was how to ensure that future new code would not
mistakenly set the global follow_tags _without_ letting the command
line option parser to override it. If the config parser flips the bit in the
same flags, it would become much less likely for future code to make
such a mistake.

Thanks.
