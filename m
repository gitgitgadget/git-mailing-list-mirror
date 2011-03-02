From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCHv2 0/3] Fix unnecessary (mtime) updates of files during merge
Date: Wed, 2 Mar 2011 16:11:44 -0700
Message-ID: <AANLkTinuK=VbNVNraBnxoMHrDvSh-W7+QBEbOJWQaC=y@mail.gmail.com>
References: <1298941732-19763-1-git-send-email-newren@gmail.com>
	<20110301193142.GA10082@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Stephen Rothwell <sfr@canb.auug.org.au>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 03 00:11:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuvCz-0006ne-I7
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 00:11:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758030Ab1CBXLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 18:11:47 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38547 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755904Ab1CBXLq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 18:11:46 -0500
Received: by fxm17 with SMTP id 17so554178fxm.19
        for <git@vger.kernel.org>; Wed, 02 Mar 2011 15:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=5xNkZBpQs5A124vVNOv/SXiN6XjVhhOes7FhUMH3KWE=;
        b=t5Xcqr51otGrx/gV/lcZwYQ2jHxUw9lIF1C3dxspkjC7S5vN7Br9pTui/W/KwBKyfe
         u2ACz8gjCrrJhiCZ66BInSMSSGDHvwSxhLpo7eAgGhdPu6XGW5s0OGTj5572dFgldrt4
         xeV2TOlIAuAqFD9GMODRy3g45v7yomS4tOyaU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=IjN96p60viqHlmrroawjMDWDDlLE6nr7FRGjAS0K1T1SH++o6QlAGPK3MA6a+0b8vQ
         o1mKcGQq2DFsN6LfZ5mtoi8tLmrawKmQOz7EzDRA/ot02s4PoNlsphssuLSs04UYQ+rO
         HgTqaYKFInSeH0F8YUXpblNlsATDUMmpNJk8M=
Received: by 10.223.86.13 with SMTP id q13mr601611fal.53.1299107505096; Wed,
 02 Mar 2011 15:11:45 -0800 (PST)
Received: by 10.223.111.6 with HTTP; Wed, 2 Mar 2011 15:11:44 -0800 (PST)
In-Reply-To: <20110301193142.GA10082@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168359>

Hi,

Thanks for all the feedback.

On Tue, Mar 1, 2011 at 12:31 PM, Jeff King <peff@peff.net> wrote:
...
> As you mention, this second testcase is not a regression at all, and
> while it would be great if we could avoid touching those files at all, I
> don't think anybody will be too upset at files being rewritten that were
> actually involved in the conflict.

Well, technically they weren't involved in a conflict.  One side had
an unmodified directory of files, the other side removed that
directory and just put a file there.  Someone starts the merge on the
side that only has a file there.  There's no conflict, but we update
the file.

Still, it's a lot better than erroring out and claiming there was a
conflict, so it's still an improvement over what we had.

> I think the fix you have for the first testcase is reasonable. It feels
> a little like a band-aid, as we are throwing away stat information early
> on and then pulling it again from the filesyste at the end. But from
> your description, the real fix to that would probably involve some
> changes to the way unpack_trees works, and that's probably complex
> enough that the band-aid is a good fix for now.

I agree, it does seem like a bit of a band-aid, but as you say I was
worried about the complexity of changing unpack_trees and wanted a
good interim fix.  Of course, Junio's point about
deleted-as-unmodified files might be sticky enough that we have to
start looking at such alternatives or do something more.  We'll have
to see what he says.
