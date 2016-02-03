From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: git submodule should honor "-c credential.helper" command line argument
Date: Wed, 3 Feb 2016 15:44:22 -0800
Message-ID: <CA+P7+xpGTvbyLOKQ=DHFBLOuVNN8WocraaZQhFD36oDiFrY+sA@mail.gmail.com>
References: <56B0E3AA.30804@syntevo.com> <20160203042554.GA21179@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marc Strapetz <marc.strapetz@syntevo.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 04 00:45:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aR77B-0004b9-1Y
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 00:45:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbcBCXpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 18:45:32 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:33567 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932863AbcBCXon (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 18:44:43 -0500
Received: by mail-io0-f182.google.com with SMTP id f81so74518314iof.0
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 15:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0fEet3zOKSSGVJo5j0jbpMt2DSfdF9HqvZdQE5QQXTs=;
        b=0N1H55zTrx5bRU28UpMDY6h7zOLilYhZcCIXtUJkDSi3y0vDzLXl1PwPdY1UzwYBps
         2F0FWuIeoJP75a05mIYiKM/RsGx/sXjfrDWuQSMB2D3U9svx6tE6QThtF45l55ZGWDuX
         L4b6gJoEya7buz6lJjTMK8O6RHOXbrkaQsCg3Sk0iazf4SHqEYw+SWVcESNvnWJG7Eq/
         atmwgGhFuOP6h0pkHKZyyrET16CURFvpz12F1eHnHOdI44S28fH2cQiJWjayrZVpoQJq
         wZojZqa4KR8neFC8AR34u2ObHEwZ0DazUCJJ2YYJ9rXP854UphEGgrqbTlCZI8ekxa7O
         GyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=0fEet3zOKSSGVJo5j0jbpMt2DSfdF9HqvZdQE5QQXTs=;
        b=ISDVMipnlS/nZ/EGGCM8AtjMLPO4Ubw6g87YJopA91TIcUFPSLZ3cV8+ogv2y4F14o
         NPw1KD9E2yOHW9YPcOWVfH/veQgBhTCfnFjCC5WKto/wcnWS+VqxNPgDiCfdM6NqUJgS
         PwhqJqOOrs89hu8y+cRPeFTW8bcCKNx8fuqvgv8mu9PG7XW9x+Jd+Bxf+HfqlNdiQpkR
         UDEueIjPwgbdumbw/ZNUZojW7EZQs1jp0PLQcCxkiub6pVAP/ON2fCMNjZcxK9STdG9i
         rSv8vEMmEMJHIYXwVFukimv58sHNLLDdBipCDYwWE7dLcU2x04NlfsZ9shU18+vLCLEl
         bJ4Q==
X-Gm-Message-State: AG10YOR/jy5MFzv+x2WmwEJ/20xTTY4k1/OFaZEUQGVysccxfqs52/SeJVCU/XBhKaRgydzi6UBIIzWRO6dIHA==
X-Received: by 10.107.170.79 with SMTP id t76mr1687809ioe.71.1454543082256;
 Wed, 03 Feb 2016 15:44:42 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Wed, 3 Feb 2016 15:44:22 -0800 (PST)
In-Reply-To: <20160203042554.GA21179@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285385>

On Tue, Feb 2, 2016 at 8:25 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Feb 02, 2016 at 06:13:14PM +0100, Marc Strapetz wrote:
>
>> git -c credential.helper=helper submodule update --init submodule
>>
>> does not invoke "helper", but falls back to the default strategies.
>> When configuring in ~/.gitconfig:
>>
>> [credential]
>>   helper=helper
>>
>> git submodule update --init submodule
>>
>> works fine. This behavior is somewhat unexpected -- is this a bug or by
>> intention? In case intention, what's the recommended way to "inject"
>> credentials helpers to work on submodules without modifying Git's config
>> files?
>>
>> Tested with Git 2.5.0 (Windows).
>
> I think the problem is that when git "switches" to working in the
> submodule repository, it clears the environment, which includes any "-c"
> command switches. This makes sense for some situations, but not for
> others. This thread shows a similar problem:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/264840
>
> Jens suggested there adding an option to tell clone to pass specific
> variables to the submodule, which I think makes sense. AFAIK, nobody has
> done any work yet on that approach.
>
> -Peff
> --

Ok so I am not sure we even really need to use "-c" option in
git-clone considering that we can just use the same flow we do for
setting core.worktree values. I'll propose a patch with you two Cc'ed,
which I think fixes the issue. There may actually be a set of
configuration we want to include though, and the main issue I see is
that it won't get updated correctly whenever the parent configuration
changes.

Thanks,
Jake
