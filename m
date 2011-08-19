From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v2] xdiff/xprepare: improve O(n*m) performance in xdl_cleanup_records()
Date: Sat, 20 Aug 2011 01:12:49 +0800
Message-ID: <CALUzUxoPwNhziRX3WU-YhSEXkjm_FvVLmN=pAffexr-QpmhGgg@mail.gmail.com>
References: <7vd3g5i7ci.fsf@alter.siamese.dyndns.org>
	<1313546037-4104-1-git-send-email-rctay89@gmail.com>
	<20110817052147.GA11253@sigill.intra.peff.net>
	<CALUzUxovdmhnRKPaEq01-q0pvez91s_Z_rHWg-FkwcU0VD3HQQ@mail.gmail.com>
	<20110818224427.GB8481@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Marat Radchenko <marat@slonopotamus.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 19 19:12:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuScq-0006bW-Fb
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 19:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756219Ab1HSRMv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Aug 2011 13:12:51 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64516 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743Ab1HSRMu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Aug 2011 13:12:50 -0400
Received: by fxh19 with SMTP id 19so2058435fxh.19
        for <git@vger.kernel.org>; Fri, 19 Aug 2011 10:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=k6ipm2HBUqwIYPGqdi7Whuw3YjCPw+OEzWSp6fUwHvc=;
        b=JssXe6DxG13EXUaewpBBIxfqgqCpmPwM7pZQobB0mb+tCdTpfFTINq3oOeFFxAKI3S
         CpnzRpRunDKukhTjKR/vqsztCmSOiHhoA2rUIz3LwYRRF399gA8h5pUdC6JYKPEsuQBS
         buOT1dmImyVinMj2QUOM70+6378aAFvRuSqns=
Received: by 10.223.22.8 with SMTP id l8mr3187964fab.105.1313773969044; Fri,
 19 Aug 2011 10:12:49 -0700 (PDT)
Received: by 10.223.95.198 with HTTP; Fri, 19 Aug 2011 10:12:49 -0700 (PDT)
In-Reply-To: <20110818224427.GB8481@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179710>

On Fri, Aug 19, 2011 at 6:44 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Aug 17, 2011 at 11:55:32PM +0800, Tay Ray Chuan wrote:
>
>> On Wed, Aug 17, 2011 at 1:21 PM, Jeff King <peff@peff.net> wrote:
>> > Wait, what? It was using 0 seconds of user time before, but still =
taking
>> > 8.5 seconds? What was it doing? Did you actually warm up your disk=
 cache
>> > before taking these measurements?
>>
>> Three runs on the same machine, after a restart.
>>
>> =A0 $ time git show >/dev/null
>>
>> =A0 real =A0 =A00m6.505s
>> =A0 user =A0 =A00m0.031s
>> =A0 sys =A0 =A0 0m0.015s
>> [...]
>
> So it is spending only .046s of CPU time, but is taking 6.5 seconds o=
f
> wall clock time. Which implies to me that the dataset doesn't fit in
> your disk cache, or it is swapping a lot. Or you are on a really
> bogged-down multiuser system. :)
>
> But if I understand correctly, your patch is about increasing runtime
> performance of a slow algorithm. So is actually the improvement of an
> O(m*n) algorithm to an O(n) one, or does your new algorithm have bett=
er
> memory access patterns that avoid trashing swap?
>
> [snip]
>
> So I think your patch _is_ an improvement in algorithmic runtime. I j=
ust
> don't see how your numbers make any sense. Am I missing something? Is
> msysgit's bash "time" just broken?

Nope, available memory is more than enough, so I don't believe
swapping is taking place. I think it's more likely that it's an issue
with time on msysgit.

Johannes, care to shed some light on this?

--=20
Cheers,
Ray Chuan
