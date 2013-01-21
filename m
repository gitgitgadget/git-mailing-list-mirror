From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PULL] Module fixes, and a virtio block fix.
Date: Sun, 20 Jan 2013 18:14:06 -0800
Message-ID: <CA+55aFw=8w8Eao3iA5F5-jFaO0MtcH+jivTD8SkDtMfrhQgWHg@mail.gmail.com>
References: <87zk03wg7r.fsf@rustcorp.com.au> <CA+55aFwzdcv0LXovZobha=EH=L6DapJt+ODP0nq=TWWAqCxLYQ@mail.gmail.com>
 <87fw1vwcao.fsf@rustcorp.com.au> <CA+55aFy1nW859yaGP17epRX8A+TaJ8APvb0-Ww1zw91dCAOhoQ@mail.gmail.com>
 <7vpq0zi9c7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Rusty Russell <rusty@rustcorp.com.au>,
	Git Mailing List <git@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alexander Graf <agraf@suse.de>,
	Prarit Bhargava <prarit@redhat.com>,
	Sasha Levin <sasha.levin@oracle.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Mon Jan 21 03:14:56 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Tx6uT-0000Al-FI
	for glk-linux-kernel-3@plane.gmane.org; Mon, 21 Jan 2013 03:14:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667Ab3AUCO3 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 20 Jan 2013 21:14:29 -0500
Received: from mail-vb0-f49.google.com ([209.85.212.49]:35049 "EHLO
	mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528Ab3AUCO2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jan 2013 21:14:28 -0500
Received: by mail-vb0-f49.google.com with SMTP id s24so3785196vbi.8
        for <multiple recipients>; Sun, 20 Jan 2013 18:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=HMl2MBvAtR0Qee10mR8J7BILyH9site25OJb12bRHc4=;
        b=boFdAqR+qbWIgNrAgb1RCRAOoZfY4sWqSpMnrF2ZG9io8Oq/xONhBzasYJgin+JWAe
         /zuFu6+UFDP9oCc1mKxhNKy0+72A/OC9TJgcMJ/LLCb1+jxG1dBTx4VxgMdoCIvoehM6
         9a/LiZ2JHDgLcrHng/S4KFzCHF3VTCtqYJ3zXuF5cUG9z/9k0cnJ3Sv5lMZUHYfydafI
         djW40aGsgBz1XJDP2v1KLIj08Fa6M4TTm0XKzOILPjezHpwYmhmV+krcOD0JR23qhqFI
         ujadP6/HB1seRoWAWOKhPNEy/CQP3saSNzm5Ujh7mNjXGqIJYWIPnVgQ8Rb433ppgDeu
         nL4w==
X-Received: by 10.220.39.69 with SMTP id f5mr13029288vce.45.1358734466918;
 Sun, 20 Jan 2013 18:14:26 -0800 (PST)
Received: by 10.220.249.199 with HTTP; Sun, 20 Jan 2013 18:14:06 -0800 (PST)
In-Reply-To: <7vpq0zi9c7.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 6hPNTy2zwUlgyimM7RjN0tnRnqA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214075>

On Sun, Jan 20, 2013 at 6:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> What you mean by "corrupt" is not clear to me

Some versions would just silently change the actual name you were using.

So if you said "for-linus", it might change it to "linus", just
because that branch happened to have the same SHA1 commit ID.

That's not right.

Other versions would replace the "for-linus" with "**missing-branch**"
because "for-linus" hadn't mirrored out yet.

That's not right either.

Basically, if "git request-pull" is given a branch/tag name, that is
the only valid output (although going from branch->tag *might* be
acceptable). The whole "verify that it actually exists on the remote
side" must never *ever* actually change the message itself, it should
just cause a warning outside of the message.

I can't say from the commit message whether that's the thing that
fixed it or not, but at least some people stopped sending me broken
pull requests after updating to git. I'm just not sure which of the
two different failure cases they happened to have (Rusty seems to have
hit both)

            Linus
