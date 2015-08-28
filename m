From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/9] fetch: fetch submodules in parallel
Date: Fri, 28 Aug 2015 10:01:41 -0700
Message-ID: <20150828170141.GB8165@google.com>
References: <1440724495-708-1-git-send-email-sbeller@google.com>
 <1440724495-708-8-git-send-email-sbeller@google.com>
 <CAGZ79kbTAVDVmw+MrXvky6tJWZcG97tT_KAxV7S-pKCiNqRp3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 19:01:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVN2E-0000rh-UU
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 19:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692AbbH1RBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 13:01:46 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35793 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbbH1RBp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 13:01:45 -0400
Received: by pacdd16 with SMTP id dd16so68268850pac.2
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 10:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0m3FSQNNDNNOb+iQH3mLd0bGaqsqCUDk9/KGXKclRiI=;
        b=TVOWNx/ocehEYpS/uFbgWCP70EMmrD+dpNzey9QRy7U4PVaYDD/Mi8ASoGvfnkzgxz
         fTcdc6LLiK12pBIoF6bQdKwPCDrDSQqSWp192yRXh37O4nTFSLloJ4qUdctUIGjr1N72
         c/nUkkWpZzAbjSA8u1g8xzsqGFul+76BZbitBJQi/grdrWoi74vYf2XxYRFI/7QjsFZR
         BDYZOnaUEYlzoU800dUqdQ5TLeOi7TfTbB2CBHuRPPnVlR9p3yD6dUu49+iGCNS3vmqS
         EPt32LZHQnXatvmSHrUAX/WnZJkop9Ip0wYL1IlWVEYD5xy2oK/i5lk0Raj5cqfABhnd
         WiLg==
X-Received: by 10.68.65.47 with SMTP id u15mr16904337pbs.127.1440781305093;
        Fri, 28 Aug 2015 10:01:45 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:d830:475:d6b6:5fa8])
        by smtp.gmail.com with ESMTPSA id vq5sm715104pbc.84.2015.08.28.10.01.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 28 Aug 2015 10:01:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAGZ79kbTAVDVmw+MrXvky6tJWZcG97tT_KAxV7S-pKCiNqRp3g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276731>

Stefan Beller wrote:
> On Thu, Aug 27, 2015 at 6:14 PM, Stefan Beller <sbeller@google.com> wrote:

>> This makes use of the new task queue and the syncing feature of
>> run-command to fetch a number of submodules at the same time.
>>
>> The output will look like it would have been run sequential,
>> but faster.
>
> And it breaks the tests t5526-fetch-submodules.sh as the output is done
> on stderr only, instead of putting "Fetching submodule <submodule-path>
> to stdout. :(
>
> I guess combining stdout and stderr is not a good strategy after all now.

IMHO the "Fetching submodule <submodule-path>" output always should have
gone to stderr.  It is not output that scripts would be relying on ---
it is just progress output.

So a preliminary patch doing that (and updating tests) would make sense
to me.

Thoughts?
Jonathan
