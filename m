From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] use generic pci_iomap on all architectures
Date: Tue, 10 Jan 2012 18:52:25 -0800
Message-ID: <CA+55aFwxaGXkJrpKXRFWEamAyF+a2+ypm7B6LLRzT0JpZp_0pg@mail.gmail.com>
References: <20120105145836.GA2751@redhat.com> <20120106083141.9c14a8d2d09539c6a6c0db75@canb.auug.org.au>
 <20120106083916.9588034bde22a6803e327aa9@canb.auug.org.au>
 <20120106084701.8f704542754db826deda318a@canb.auug.org.au>
 <CA+55aFwXj2ELrTDSgFfSC2Usz99-24uFSznAP34feJiCttwayQ@mail.gmail.com> <7vipkj7ykd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Git Mailing List <git@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Andrew Morton <akpm@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-arch-owner@vger.kernel.org Wed Jan 11 03:52:50 2012
Return-path: <linux-arch-owner@vger.kernel.org>
Envelope-to: glka-linux-arch@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-arch-owner@vger.kernel.org>)
	id 1RkoIz-0006zp-CU
	for glka-linux-arch@lo.gmane.org; Wed, 11 Jan 2012 03:52:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933758Ab2AKCws (ORCPT <rfc822;glka-linux-arch@m.gmane.org>);
	Tue, 10 Jan 2012 21:52:48 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60196 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757050Ab2AKCwr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jan 2012 21:52:47 -0500
Received: by yenm10 with SMTP id m10so124380yen.19
        for <multiple recipients>; Tue, 10 Jan 2012 18:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=JUASHDGetB1+SOn7/BTJ0X4RrbmQM5SVBJSdQd9ho/s=;
        b=NQ53PVQJ1KToTx5K3ZlobN2Jyf33M6P5583ZBV11rfEIgnxPcRphhN856hk57uNaSz
         aBQfEYinirelUZPbkYdOA3UL1kb6MaYtxxGCCTVOVHAiVkZoQDI7Hzch/TQvED8mUH9Y
         CjIXE7WSOam7yiRxrHV2olcmYwv0XEEt6lJkI=
Received: by 10.236.193.41 with SMTP id j29mr27762680yhn.12.1326250366195;
 Tue, 10 Jan 2012 18:52:46 -0800 (PST)
Received: by 10.236.175.170 with HTTP; Tue, 10 Jan 2012 18:52:25 -0800 (PST)
In-Reply-To: <7vipkj7ykd.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: CLR2uCqRyJ6dOUFahDhvCgAJLA8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188315>

On Tue, Jan 10, 2012 at 6:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> The parameter to "git shortlog" that appears later should also be updated
> to match this, by the way, even though that should not affect the outcome
> in any way.

No, don't do that part.

Why?

Remember: there can be *multiple* merge bases. The expression

    git shortlog ^$baserev $headrev

always works, but changing "baserev" to "merge_base" will suddenly
break for the multiple merge-bases case.

> I am however not sure what would happen when there are more than one merge
> bases. I guess those who throw pull requests are not supposed to be doing
> merges in reverse direction, so it should not matter ;-)

The other cases don't really care. For them, "show one merge-base" is
fine, and they are "end-point" operations (like "diff") that really
cannot handle a set of commits anyway.

But for "git shortlog", switching to using the merge base would
actually start showing commits that shouldn't be shown. It's
fundamentally a set operator, and does the right thing in the presense
of multiple merge-bases (which "diff" and "since commit XYZ" are
clearly not set operators, although arguably you could try to show all
merge bases for the "since" case).

                       Linus
