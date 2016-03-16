From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH] help.c: strip suffix only if the STRIP_EXTENSION defined
Date: Wed, 16 Mar 2016 23:36:49 +0600
Message-ID: <CANCZXo6KGtuuiZ3aha=Tqkwj3d8qytmA_rvw7fPHfevzz9Qyfg@mail.gmail.com>
References: <1458138449-26690-1-git-send-email-kuleshovmail@gmail.com> <20160316173127.GD4039@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 16 18:37:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agFOA-0000gb-S9
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 18:37:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934826AbcCPRhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 13:37:12 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:33101 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753659AbcCPRhK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 13:37:10 -0400
Received: by mail-lb0-f179.google.com with SMTP id oe12so52928569lbc.0
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 10:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qaSzi6aORgsaAeiy2BmJaOaopsTkh8fLlHRkKWUq5GY=;
        b=nk1eKYunX/5rHNQfwpLGWBfmORalZeKnJFUIBSV0hT0/AYVdbFQU5dqyEMyiLEacm8
         Fmu6e2949ChMxLCXraRsOkBIJO3z3fk3KWjnH4bN6+FgBT0RUH1ZhimuspV/IinXwNCA
         lNTH/vMaVbz51pHL2fPjyr7gMIVPViMj06xYj2/IgCMEWeYmwiO+Mzxk/nFD28vew/mN
         NIsH47IMY/4z4gr4YyWLdTXZBtIjI0XKhCHICAE/SAfDFn3qebax3nD+uIQc5D5VRREc
         LOWeXrCabi6TC2CMwy9j3dPM5htbZh87Q2U+OVbZtemirO2jmcVrtz8grWoAmCddhOSy
         Ugpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qaSzi6aORgsaAeiy2BmJaOaopsTkh8fLlHRkKWUq5GY=;
        b=lg7RErxyjLgjRNYbsJNFSVY9a9f2KLY9if1y8J2O0j1xFb8JVRHZMF2L7Q8LVa1zde
         Je0ns8hFo/YTpQc6NNZytEFOCSapqVuPVngMMfcQls+VLIHKlQ58FjEG8nakG8k/r/K0
         XZdfgT5THqN6RmzdR2vKMUoT7hNOfThfWaXeeaMuBoNwTjGQkwgaDMtY6SnsJYTvag1u
         sGmFB5ol35E+OdnRwWv7M1znOPvZw+qTUi5d8PT5TGjQ56YGt2230yZ707bf4glPvDEV
         Bf66ax3Kw4QjIdQb8TVWyL0oUBD9AF6tQBrDfqfM6mb6pt1pvHBVpruwmlmtb3YV3zB2
         Humw==
X-Gm-Message-State: AD7BkJIgL2Zxd5z90sxgive5xRfBelAF+DefSYJPJGhDEmGk64Ip1uI8B/5YFWfmvDEIbv8ZEFin+yYfVp/NIg==
X-Received: by 10.112.163.102 with SMTP id yh6mr1929572lbb.4.1458149828533;
 Wed, 16 Mar 2016 10:37:08 -0700 (PDT)
Received: by 10.112.77.65 with HTTP; Wed, 16 Mar 2016 10:36:49 -0700 (PDT)
In-Reply-To: <20160316173127.GD4039@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289003>

Hello Jeff,

On Wed, Mar 16, 2016 at 11:31 PM, Jeff King <peff@peff.net> wrote:
> This is billed as an optimization in the commit message, but these two
> pieces of code are not the same. The original always strips ".exe",
> whether or not STRIP_EXTENSION is defined, and whether or not it is
> ".exe".
>
> In practice it works out because people on Unix systems do not have
> "git-foo.exe", and nobody sets STRIP_EXTENSION to other things.  But I
> tend to think this is an improvement in robustness.
>
> I also wonder if this should be sharing the strip_extension() helper
> added in your 63ca1c0.

Yes, I want to move strip_extension() (from 63ca1c0) to the git-compat-util.h
and adapt/reuse it in the help.c. What do you think about this?

Thank you.
