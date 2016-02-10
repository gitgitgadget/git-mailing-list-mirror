From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv9 4/6] git submodule update: have a dedicated helper for cloning
Date: Wed, 10 Feb 2016 09:49:36 -0800
Message-ID: <CAGZ79kb70tXVsb0DCpwdU9QJB2PQh_4zxZ6Ab7CLQkxCHG6Xuw@mail.gmail.com>
References: <1455051274-15256-1-git-send-email-sbeller@google.com>
	<1455051274-15256-5-git-send-email-sbeller@google.com>
	<CA+P7+xo=GK79DRvV6ZYds3wx6bayoWHC49UmkWL20=xo=jpS2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git mailing list <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 18:49:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTYtZ-0002vw-Rf
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 18:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403AbcBJRti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 12:49:38 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37924 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbcBJRth (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 12:49:37 -0500
Received: by mail-ig0-f182.google.com with SMTP id mw1so19361279igb.1
        for <git@vger.kernel.org>; Wed, 10 Feb 2016 09:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iVURlDDD+4cOv4eOeotSqoqA4vtMWcMUBVAr4W6MRVA=;
        b=Ge3TQ09EgSVz1+FDwV4tdN9S7kJywJjlxeeA774Vd+Jh5G5XElyjlcz5tCGcIzxbJa
         jEmKjvSLlVdi76e/DQdQNaf4jQZYagr/T70MZVFJyo1nqPknG+3/DR8y+tRodBWf5e7B
         cpZLI61o2EytaSzBbXT8t2o04BmrftepQHNMfgAtW3Fla2Q2jA8RCgu64m1UhW1tywM+
         N5Gm01Rq20bg4yaTJpxOGsVy3HMYOVlO32c7kdxFqguPXzBsduFCx2t2vgbP8aAaTIS7
         Yw0xcq4ee9jsrlftxAaIw5ZyT1OH+HXzZuUhMkY3GU6cTlOmd1SqC8wlLXE7rDcrGZ+s
         Aiug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=iVURlDDD+4cOv4eOeotSqoqA4vtMWcMUBVAr4W6MRVA=;
        b=bqUc+Ywf6aC4qCeHPaiW/LagEMDcFBhTifVEOucLEWw1kN+dxjeNukcHJ9F2kHi3Bh
         NXWXS8gDwC+G0P0xW+1SEzh9mF/Bg7ytHLrhhlvQM31s3iRoJmUais3+TCqOQVNFVtKf
         6t/6cwicuKjHoCf61Y71urTaRgIwF+ZTEkR1XgjLt/nMFC0KC9rSwsCmarhSiufb05BA
         kNo2fMut8o7J0bG1Plr+99hZ389jwHC7pZo2MyjLVpvDR63JoVHLBmvsqVBzG4gJr/lr
         a7sj6GiU8pmUAZzbwYNgnntznpICSiYqWsiu8XswL16wWEhkk/hzMh0QfXAIx5bHFlrX
         prAQ==
X-Gm-Message-State: AG10YOT7pOmS7kH6P1JoRN0TkU4hHqr9RaMV3ESYsVp3RsGAV44KB0MkdH5vLmTokPEadla5hTmmmpPEFy+Nefr0
X-Received: by 10.50.138.76 with SMTP id qo12mr11615529igb.85.1455126576228;
 Wed, 10 Feb 2016 09:49:36 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Wed, 10 Feb 2016 09:49:36 -0800 (PST)
In-Reply-To: <CA+P7+xo=GK79DRvV6ZYds3wx6bayoWHC49UmkWL20=xo=jpS2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285919>

On Tue, Feb 9, 2016 at 6:26 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Tue, Feb 9, 2016 at 12:54 PM, Stefan Beller <sbeller@google.com> wrote:
>> This introduces a new helper function in git submodule--helper
>> which takes care of cloning all submodules, which we want to
>> parallelize eventually.
>>
>> Some tests (such as empty URL, update_mode=none) are required in the
>> helper to make the decision for cloning. These checks have been
>> moved into the C function as well (no need to repeat them in the
>> shell script).
>>
>> As we can only access the stderr channel from within the parallel
>> processing engine, we need to reroute the error message for
>> specified but initialized submodules to stderr. As it is an error
>> message, this should have gone to stderr in the first place, so it
>> is a bug fix along the way.
>>
>
> I was recently working on a way to make submodule pass some parameters
> from the parent project into the submodule project (specifically
> settings regarding authentication such as using an authentication
> helper), and I think this would make it easier to do.

Do you mean the separate bug fix patch as proposed by Jonathan or
this patch in general helps your idea of passing settings?

Thanks,
Stefan

>
> Thanks,
> Jake
