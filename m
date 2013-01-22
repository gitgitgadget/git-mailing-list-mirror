From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: Lockless Refs? (Was [PATCH] refs: do not use cached refs in repack_without_ref)
Date: Mon, 21 Jan 2013 23:31:03 -0500
Message-ID: <CAM9Z-nmJb3LGO3wLxPYhwc+7Cyw7J8q1E_PppNYQSmXKQ2ieQQ@mail.gmail.com>
References: <20121221080449.GA21741@sigill.intra.peff.net>
	<50DAB447.8000101@alum.mit.edu>
	<201212271611.52203.mfick@codeaurora.org>
	<201212310330.53835.mfick@codeaurora.org>
	<20130105161215.GA24900@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Martin Fick <mfick@codeaurora.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Shawn Pearce <sop@google.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 22 05:31:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxVWD-0003I4-ER
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 05:31:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837Ab3AVEbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 23:31:06 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:61049 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404Ab3AVEbE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 23:31:04 -0500
Received: by mail-ie0-f175.google.com with SMTP id qd14so11100995ieb.34
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 20:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Hox5SHhnweTXlUu1YFHgtR+TZElbs/KADrO1OiXllaU=;
        b=NLE5qAQEj+1na8dpFQLdrMHeTvTE+wr5Tg8a2+QQalLmkCcbYbSgzdYdItuUIoEORD
         WdC2mbG14Yrr2FO7KFf76Vgm2EuNyiwxcqPn4g5P04glyIBJ+EyKWNs4kxNPID7M3YWz
         Rij5waJD1fOJCI1sTZGPU984nHmGRgFdSiWrbelk+UaqBC3hNkK2b0fIpUOilLsjtKuz
         vupv68p1RDGOoFLXj+k7qFEGYR/UKS3aLdx9/xn/6B4SD8ccoRQfaWWe8Vd5/v7BDh2e
         nHZcf+lBc1eCZ9HWrjb9AdR0lHF+t5xggcS7D+wQ1/hWcovDDAJ53p2f7yx014CJYh2H
         A5og==
X-Received: by 10.50.15.138 with SMTP id x10mr10788089igc.16.1358829063532;
 Mon, 21 Jan 2013 20:31:03 -0800 (PST)
Received: by 10.42.134.199 with HTTP; Mon, 21 Jan 2013 20:31:03 -0800 (PST)
In-Reply-To: <20130105161215.GA24900@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214191>

On Sat, Jan 5, 2013 at 11:12 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Dec 31, 2012 at 03:30:53AM -0700, Martin Fick wrote:
>
>> The general approach is to setup a transaction and either
>> commit or abort it.  A transaction can be setup by renaming
>> an appropriately setup directory to the "ref.lock" name.  If
>> the rename succeeds, the transaction is begun.  Any actor can
>> abort the transaction (up until it is committed) by simply
>> deleting the "ref.lock" directory, so it is not at risk of
>> going stale.
>
> Deleting a directory is not atomic, as you first have to remove the
> contents, putting it into a potentially inconsistent state. I'll assume
> you deal with that later...

I know I'm a bit late to the dance here, but FWIW the apparent atomicy
(odd conjugation there) of directory deletion depends largely upon the
filesystem and VFS api in use. It is not unheard of that a delete
operation actually consist of moving the reference to the item's own
allocation marker into a "trashcan" to be cleaned up after later.
In other words, I'd not advise planning on directory deletes always
being atomic nor always not being atomic.

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
