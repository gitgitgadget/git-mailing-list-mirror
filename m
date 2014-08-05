From: =?UTF-8?Q?Vicent_Mart=C3=AD?= <tanoku@gmail.com>
Subject: Re: [PATCH] pack-bitmap: do not use gcc packed attribute
Date: Tue, 5 Aug 2014 20:38:21 +0200
Message-ID: <CAFFjANRwnd4u1Axs64xZNvc1kHynjswX_t4pS3EjBsTsZP0Y7w@mail.gmail.com>
References: <20140728171743.GA1927@peff.net> <53D806AC.3070806@gmail.com>
 <20140801223739.GA15649@peff.net> <20140801231044.GA17960@peff.net> <53DFDCD2.2090803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 20:38:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEjdQ-0005wS-9N
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 20:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755232AbaHESio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2014 14:38:44 -0400
Received: from mail-vc0-f170.google.com ([209.85.220.170]:65216 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951AbaHESim (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2014 14:38:42 -0400
Received: by mail-vc0-f170.google.com with SMTP id lf12so2264220vcb.15
        for <git@vger.kernel.org>; Tue, 05 Aug 2014 11:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ifnt+Q72Ar0+TyovQ8AeWvAf19QndgESp4giAzAJJZg=;
        b=bJ/R9HHVG/rkh07+aeIW78GX08bExzhxeLtG8ajxfBmd931M549Fs8dN2AOLXFTHJL
         zjI/hRq3KjOZp7l3zR0veWES0a7x3/dRQW95HzLNvDC9X63yBHjQclQNwu31PvtnzXqs
         ZYBIty2m93RKWixbUeqk3YybRm7rUh5RfciI3k87r+FobB7qgNK/wA9IOy+sNEkrj0Zh
         N58Aictf2mtO0uSgklNS9sonj+RFvbLW59b/ckej4FVh6Kog814ow8Tp/CgcF/5OG6/A
         CJwDjDQWGShbdKDtzW4qJIExZYwZAh4VV+UY7D3VzjQ+V5jgGIPepkceKqbi+/aZkHZ1
         0HoA==
X-Received: by 10.220.172.8 with SMTP id j8mr5972187vcz.32.1407263921848; Tue,
 05 Aug 2014 11:38:41 -0700 (PDT)
Received: by 10.221.30.15 with HTTP; Tue, 5 Aug 2014 11:38:21 -0700 (PDT)
In-Reply-To: <53DFDCD2.2090803@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254819>

On Mon, Aug 4, 2014 at 9:19 PM, Karsten Blees <karsten.blees@gmail.com> wrote:
> This raises the question why we read via mmap at all

The first version of the pack bitmap format I wrote for GitHub was 50%
faster to load than this one because it was designed to be mmapable.
Eventually we moved to the JGit-compatible bitmap format (because I
get paid a lot of money to do as I'm told -- not because of some
inherent benefit of the JGit format), which needs to be read
sequentially, but I never bothered to change the mmap reading code.

I believe your patch makes a lot of sense -- at this point we could as
well remove the mmaping altogether and read the file sequentially.

Cheers,
vmg
