From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 3/7] pack-protocol.txt: Mark all LFs in push-cert as required
Date: Fri, 3 Jul 2015 11:43:33 -0700
Message-ID: <CAJo=hJsoKSB23KNNF9Xr-NUAqUXvq+O-ZYOSyb4wAC1TZKZ2-g@mail.gmail.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
 <1435774099-21260-4-git-send-email-dborowitz@google.com> <xmqqfv578x87.fsf@gitster.dls.corp.google.com>
 <xmqq8uaz8vjb.fsf@gitster.dls.corp.google.com> <xmqq4mln8ve2.fsf@gitster.dls.corp.google.com>
 <20150702135309.GA18286@peff.net> <xmqq38155e3s.fsf@gitster.dls.corp.google.com>
 <20150703180718.GB9223@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Dave Borowitz <dborowitz@google.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 03 20:44:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZB5wO-0004na-Rs
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 20:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755199AbbGCSn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 14:43:56 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:38884 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755013AbbGCSny (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 14:43:54 -0400
Received: by wibdq8 with SMTP id dq8so106630699wib.1
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 11:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dbMgj31ZPAQCAY1uAdji+gdz7lSDikJ8p572PcA0R7I=;
        b=Z78fArTT4Dd2DTxSVAj5oA1VBYbyLu3wxnbpM9KiE2QnpeR9ipORH3FsKSUeHguEiZ
         DPKwa7SDlI72uIOx+Pp24tVaA+l/4d31NvJ/xEkwhkrdyr+UBfiiERaGGVSLB++/HyPf
         gQHXrtlhBjaDnY16o2rum1SLD1yN0EXlCV0lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=dbMgj31ZPAQCAY1uAdji+gdz7lSDikJ8p572PcA0R7I=;
        b=ZcykMDW8fHKz/HrBgPFNvOiGN4q+FEwxQu/GexSxIfG1YJBhdM8pYOkWiFSkyiVpC8
         BT0fWJReWLfxOOyoq2AHcn8MtP0DEP0ydKc0w7bjA046pynj5LmXwnSUDsKxZqThxxCM
         brRYhjMu6rA6iSi0TJGbemnG3hDUmrFuzdGJUPluYjzNP97WXAjbfwm3HQVF6LFnI006
         Fd4GvpXW9OZSSUK8rm+B9w4rLQl1rqFgprl3N3S23ePqRdw8OU3cwx4W5mFdGRXOZGM9
         vyPtdG/U5wYaNQaKELGC74eBikzDoKvxNO1H5ofAOdOFE3i/1HLY7IwNV8qhVxnQ+Ict
         wwpQ==
X-Gm-Message-State: ALoCoQmqrsxXVX737UvuVOKpjGKtkSzeiIEhCKWYe8xn1zacPrI8xMU2nZ28VKrsYzaV29i182Ie
X-Received: by 10.194.185.8 with SMTP id ey8mr71399144wjc.118.1435949033261;
 Fri, 03 Jul 2015 11:43:53 -0700 (PDT)
Received: by 10.28.46.5 with HTTP; Fri, 3 Jul 2015 11:43:33 -0700 (PDT)
In-Reply-To: <20150703180718.GB9223@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273310>

On Fri, Jul 3, 2015 at 11:07 AM, Jeff King <peff@peff.net> wrote:
> I wondered briefly whether this impacted the keepalives we added to
> `upload-pack` in 05e9515; those are implemented as 0-byte data packets,
> which we send during the potentially long counting/delta-compression
> phase before we send out pack data. It works there because the packets
> actually contain a single sideband byte, so they are never mistaken for
> a flush packet.

Interesting. I didn't know about 05e9515. This is a great hack. We
have similar issues in our server-server system at $DAY_JOB, they use
--quiet as no human is watching. So we did a different hack for the
same reason.

> Related, I recently ran into a case where I think we should do the same
> for pushes. After receiving the pack, `index-pack` may chew on the
> result for literally minutes (try pushing up the entire linux.git
> history sometime). We say nothing at all on the wire until we've
> finished that, run check_everything_connected, and run all hooks.  Some
> clients (or intermediates on the connection) may give up after a few
> minutes of silence.
>
> I think we should have:
>
>   1. Some progress eye-candy from the server to tell us that something
>      is happening, and how close we are to finishing (basically
>      "index-pack -v").

JGit receive-pack has done this for years. We output a progress
monitor for the resolving delta phase, and the counting during the
graph connectivity check, as JGit being in Java is slow as snot and
cannot digest the linux kernel instantly.

>   2. When progress is disabled, similar keepalive packets saying "nope,
>      no output yet".

Yea this is a problem so I think JGit ignores the client's request for
"quiet" here and shovels progress messages anyway as a hack to force
keep-alive. Never considered the empty side-band message that 05e9515
introduces.

> For (2), hopefully we can implement it in the same way, and rely on
> empty sideband-0 packets. I haven't tested it in practice, though (I
> have some very rough patches for (1) already).

sideband-0 is not going to work for JGit clients.

JGit clients are strict about the sideband stream being 1,2,3 and fail
hard if they get any other stream from the server[1].

[1] https://eclipse.googlesource.com/jgit/jgit/+/master/org.eclipse.jgit/src/org/eclipse/jgit/transport/SideBandInputStream.java#169
