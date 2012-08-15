From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] daemon: --access-hook option
Date: Wed, 15 Aug 2012 07:08:35 -0700
Message-ID: <CAJo=hJs7cxs-4MvTovKMzLZ22a1GFPrmANZd0Srny_UKQe+u+w@mail.gmail.com>
References: <feafacf49186d7cf0eed0002a82289b318f56ff8.1344938189.git.minovotn@redhat.com>
 <7v1uj98nbj.fsf@alter.siamese.dyndns.org> <CAJo=hJtYz3OX1C6HS7ivhJKBOSg=Ex3rKEdTYSbcDfFT1Jh4hw@mail.gmail.com>
 <7vsjbp768y.fsf@alter.siamese.dyndns.org> <CAJo=hJu7W6JnNLYvahaQ43ZNqDtrurTOLCnLfZacVJKeL6VMFg@mail.gmail.com>
 <7vpq6t9v5s.fsf@alter.siamese.dyndns.org> <7vobmc7n80.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Michal Novotny <minovotn@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 16:09:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1eHS-000472-10
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 16:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754989Ab2HOOI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 10:08:57 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53802 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754342Ab2HOOI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 10:08:56 -0400
Received: by yhmm54 with SMTP id m54so1786106yhm.19
        for <git@vger.kernel.org>; Wed, 15 Aug 2012 07:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=moPQYxxKvzgstAWMtke7khYWH5AnL81YnA4xNQIwVoU=;
        b=XgGctBBaHdmLMVJmt05hUuAzvSn1uwG5TzLp4+VrehNZO1Ty7A/wpmPj1Xvzq3Ffdm
         i8Y7lTAMjNGUzj2z+gVbm18qSDvRcZPKtY1y943fKMa/B4mJFhUDn8HzIp1PDaBIwWtt
         4E/2C+Wq15IhMnQRBeOUsfq6NlOZLlXEOwD2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=moPQYxxKvzgstAWMtke7khYWH5AnL81YnA4xNQIwVoU=;
        b=H55j/FEhO5ks39KabRf0S+5avBsYHSlQWTrk2gMe9L0iPj5zwZj0VMvRlFJ02/pmLY
         JU0w4Yl3JNwQwnYgKFrcn94OvuT4Vvz4YB3NDXmCHC01QAozn9U504VecM7WFykVli5o
         Ran4K7vZ8/6yah7FyrbG3fkoMTDxDmDCtJXo/Rtea5NEyTV9MjMnnnoIWU7IO4lFKL0K
         yTAbwO3Y1pIg+/K+Qt9fOIJ11iOrU0vpB2EhnzAXusWqd3to+mCb6m0nhfHqbFsXE4+C
         9a8deDaCUc0n5Tt2MUGuu2eBg1xrtTgqC2KcgS+ViDUUe1DbzxSTv6dyToRlxg/zJnQl
         0Myg==
Received: by 10.50.220.169 with SMTP id px9mr14940229igc.8.1345039735928; Wed,
 15 Aug 2012 07:08:55 -0700 (PDT)
Received: by 10.64.22.231 with HTTP; Wed, 15 Aug 2012 07:08:35 -0700 (PDT)
In-Reply-To: <7vobmc7n80.fsf_-_@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQlOIm3n/+UUgZX3vVLDdeq34aKi0MK8Kxgd7yyrXjMBc56BDNKP2YAgmx2uM/3UbMV75LWZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203471>

On Tue, Aug 14, 2012 at 10:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The --access-hook option to "git daemon" specifies an external
> command to be run every time a client connects, with
>
>  - service name (e.g. "upload-pack", etc.),
>  - path to the repository,
>  - hostname (%H),
>  - canonical hostname (%CH),
>  - ip address (%IP),
>  - tcp port (%P)
>
> as its command line arguments.  The external command can decide to
> decline the service by exiting with a non-zero status (or to allow it
> by exiting with a zero status).  It can also look at the $REMOTE_ADDR
> and $REMOTE_PORT environment variables to learn about the requestor
> when making this decision.
>
> The external command can optionally write a single line to its
> standard output to be sent to the requestor as an error message when
> it declines the service.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks Junio, this looks like the best approach.

Acked-by: Shawn O. Pearce <spearce@spearce.org>
