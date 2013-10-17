From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: pack corruption post-mortem
Date: Thu, 17 Oct 2013 08:06:50 +0700
Message-ID: <CACsJy8ArdCrqn58wnx9c6wx148CfnQrWPfuxH5D7s1bvwr=cjQ@mail.gmail.com>
References: <20131016083400.GA31266@sigill.intra.peff.net> <201310160941.16904.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Thu Oct 17 03:07:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWc3i-0006om-S2
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 03:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761668Ab3JQBHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 21:07:22 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:59207 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762043Ab3JQBHV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 21:07:21 -0400
Received: by mail-oa0-f54.google.com with SMTP id n5so1430428oag.27
        for <git@vger.kernel.org>; Wed, 16 Oct 2013 18:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7FYZV+8PiOTOmT/lXhBPwvakpLG9QR6HG/6ikYc5OsY=;
        b=FvOn4Rg5uJkt9msoXGBV0TNdM8L1mUFq5pAvIO6ptL3THwZwKWSmYoX7Eds5DKHEic
         FEmoLtQ9J92mdjvHbnaus7sFZ7U82n8/sZgIqdrNRLjX8IxBVsEipmtf4QquNyuSprIO
         K2y0BmhmZr/RD/Vutpp/3EcnPlKMbNCLApKCwHlqtWJBPYGMXFbHubWWaGgD9gP4g3Kx
         IMrIaWsH2919TFDYhIQRZlmL5tbR9rAof2TTIKeRq1dmHWyvgEc2rv6wauxhUCj9o6SD
         JYsG7N2ILDeiKt8Fdkkh6gJLqgLaQ7gN7+8KEq9maKRpEYc6RZzR+JYydcV0ERuSGBSK
         Rr1w==
X-Received: by 10.182.129.42 with SMTP id nt10mr9373760obb.19.1381972040507;
 Wed, 16 Oct 2013 18:07:20 -0700 (PDT)
Received: by 10.76.0.41 with HTTP; Wed, 16 Oct 2013 18:06:50 -0700 (PDT)
In-Reply-To: <201310160941.16904.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236286>

On Wed, Oct 16, 2013 at 10:41 PM, Martin Fick <mfick@codeaurora.org> wrote:
>> and then running "git index-pack tmp.pack" in the
>> debugger (stop at unpack_raw_entry). Doing this, I found
>> that there were 3 bytes of header (and the header itself
>> had a sane type and size). So I stripped those off with:
>>
>>   dd if=object of=zlib bs=1 skip=3
>
> This too feels like something we should be able to do with a
> plumbing command eventually?
>
> git zlib-extract

Not an official plumbing, but I faced similar problems with pack v4. I
needed to verify that the output is correct and low level decoding
like this is generally a good thing to start with. So I wrote
test-dump [1] that can take an offset, a format and try to decode it.
It does not support zlib inflation yet, but adding one should be easy.
And because this is just a test program we don't really need to think
hard before adding something.

[1] http://article.gmane.org/gmane.comp.version-control.git/235388
-- 
Duy
