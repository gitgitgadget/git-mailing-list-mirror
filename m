From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: [PATCH 2/2] git: continue alias lookup on EACCES errors
Date: Thu, 29 Mar 2012 19:21:49 +0200
Message-ID: <op.wbxzunjh0aolir@keputer>
References: <20120327175933.GA1716@sigill.intra.peff.net>
 <20120327180503.GB4659@sigill.intra.peff.net>
 <7v4nt9j1m3.fsf@alter.siamese.dyndns.org>
 <20120328043058.GD30251@sigill.intra.peff.net>
 <7vaa30wrjx.fsf@alter.siamese.dyndns.org>
 <20120328174841.GA27876@sigill.intra.peff.net>
 <7v62dowpdu.fsf@alter.siamese.dyndns.org>
 <20120328194045.GC29019@sigill.intra.peff.net>
 <CAH6sp9Pw75x6YrmEyLmbsbvHrbs8r6xSp3YC2NP-jOed-zZ3+g@mail.gmail.com>
 <20120329171525.GB12318@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"James Pickens" <jepicken@gmail.com>,
	"Git ML" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 19:21:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDJ2s-0002Jv-Bf
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 19:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759749Ab2C2RVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 13:21:54 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57687 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758145Ab2C2RVx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 13:21:53 -0400
Received: by eaaq12 with SMTP id q12so1150481eaa.19
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 10:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=GNHos1FjHm59hcPds8mLhDiFy8nlQaF5XmZgSCoCeBg=;
        b=Flkyk38xyyHVNObvmkWVEgMef1OeAFI8kWxaaJqgAECpUPfcjyAYeUpgA1wS6wYPnp
         unoSLyUXvwmVuwv3qkzH5v6SlJOdRJmTVe4QYVI94RYJlylyJ5h6ky9BMp2cEMSYGE4m
         WPXTLvPzLTZQAKQ42hblF4iHamY01spJHy/o9WMbrMARSO6J40Sle9I77KzZX7BqiWkz
         2OD3DIb1OyBiLhoY4MhdGh9inHAA+Iim0ih4IIaQ6WrVseFmdV0J/y7yBi1L7V+SWrMI
         STRSuGEHcYbMj3b/BztdnmhSPvKgSD9BVWitXFxorY14j0FSsDptpCpmDUWsWiXdggVN
         NTzQ==
Received: by 10.14.204.3 with SMTP id g3mr5175635eeo.75.1333041712044;
        Thu, 29 Mar 2012 10:21:52 -0700 (PDT)
Received: from keputer (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id p57sm23666934eei.8.2012.03.29.10.21.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 10:21:51 -0700 (PDT)
In-Reply-To: <20120329171525.GB12318@sigill.intra.peff.net>
User-Agent: Opera Mail/12.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194274>

On Thu, 29 Mar 2012 19:15:25 +0200, Jeff King <peff@peff.net> wrote:

> On Thu, Mar 29, 2012 at 01:16:47PM +0200, Frans Klaver wrote:
>
>> > Yes, we can differentiate after the fact. Though I think it ends up
>> > being almost the same code as just implementing execvp in the first
>> > place.
>>
>> It will, but doesn't stock execv*() also provide access to shell
>> builtins? If that's the case then I wouldn't be bothered by the extra
>> bit of code we need to understand what execvp has been doing. I think
>> it would be sane to keep sane_execvp a wrapper instead of a
>> reimplementation.
>
> No, definitely not. Handling builtins is the responsibility of the
> shell, not of execvp. It is responsible for falling back to "/bin/sh
> $file" if execve returns ENOEXEC.
>
> Anyway, I think the last round I posted is good enough. It is
> approaching execvp in complexity, but it is still a little bit simpler.
> And because it's on the error code path, if we are incompatible the
> worst thing we can screw up is the error message, not the actual exec.

Good. In that case I think this last looks good, indeed.

Frans
