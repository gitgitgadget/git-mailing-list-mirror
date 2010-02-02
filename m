From: Arun Raghavan <ford_prefect@gentoo.org>
Subject: Re: [PATCH 0/2] upload-pack: pre- and post- hooks
Date: Tue, 2 Feb 2010 11:20:16 +0530
Message-ID: <6f8b45101002012150k784b6d78ibffa5092507eee32@mail.gmail.com>
References: <6f8b45101001150414r2661001ep10819b601953c05b@mail.gmail.com> 
	<1265013127-12589-1-git-send-email-ford_prefect@gentoo.org> 
	<20100201152010.GC8916@spearce.org> <6f8b45101002010750t5541faefv5b4640dfb9949306@mail.gmail.com> 
	<20100201160141.GG8916@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 02 06:50:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcBet-0000Pb-6x
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 06:50:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054Ab0BBFui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 00:50:38 -0500
Received: from mail-qy0-f185.google.com ([209.85.221.185]:34853 "EHLO
	mail-qy0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736Ab0BBFuh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 00:50:37 -0500
Received: by qyk15 with SMTP id 15so506962qyk.20
        for <git@vger.kernel.org>; Mon, 01 Feb 2010 21:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type;
        bh=Q/kSKtEYBsEeaqkBfOahFsZqncV0TFi8P6L7L1XJptc=;
        b=fFBEsBIZ0GxA5RmHFr2eJeZuFOXTxHHUND1r6RphJGfGbtHfpiW/2OYU4+vFnQZALz
         TzD8JOg/UIlg2utXwatbE9uNHD9A8b32p94eMYsYwr6Na2cnond5fivRFCLDdzNW2h1+
         Q3gjxWY4/DRLCwRz1brY4l4s4EfRWGvnAEfAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=iTJ+QPxB7m4z3VMjCbTPDJt/ck1vwh/UimzjZRmp/vZR91tYokXEJ5sg4ZkUde2rTC
         XonVc36SauTz4xBeXBhqlVR1Z4CjoPkzpvS2t51FSTa0Jqr72lItD6bv1uucxT+AHmJS
         p53QjxCs1Jf+OQMFrkd6+h03TaOsUh8O4J+MI=
Received: by 10.229.218.210 with SMTP id hr18mr1201889qcb.98.1265089836109; 
	Mon, 01 Feb 2010 21:50:36 -0800 (PST)
In-Reply-To: <20100201160141.GG8916@spearce.org>
X-Google-Sender-Auth: 177df86039bcf425
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138682>

On 1 February 2010 21:31, Shawn O. Pearce <spearce@spearce.org> wrote:
> Arun Raghavan <ford_prefect@gentoo.org> wrote:
>> On 1 February 2010 20:50, Shawn O. Pearce <spearce@spearce.org> wrote:
>> > Arun Raghavan <ford_prefect@gentoo.org> wrote:
[...]
>> >> At some point if the future, if needed, this could also be made a part of the
>> >> negotiation between the client and server.
>> >
>> > I'm not sure I follow.
>> >
>> > Are you proposing the server advertises that it wants to run hooks,
>> > and lets the client decide whether or not they should be executed?
>>
>> Something like that. I was thinking the client could always advertise
>> whether the it wants to allow the hooks to be executed or not (which
>> would override the default value of the global variable I introduced).
>> Either approach would work, though the second is simpler but also
>> dumber.
>>
>> Again, this might be over-complicating things, which is why I did not
>> implement it. I just wanted to make a note of the fact that this could
>> be done if the need is felt.
>
> My concern with this is, users might disable the hook all of the
> time, and then servers that actually want the hook (e.g. gentoo's
> use of the pre-upload-pack to avoid initial clones over git://)
> would be stuck, just like they are today.
>
> No, its just not sane to give the user a choice whether or not they
> should execute something remotely.

Ah, sorry I wasn't clear about this. I've made it so that when
pre-upload-pack fails, the entire operation fails. This makes sense
because pre-upload-pack is meant to check things like "do we want
allow the user to get the pack". For post-upload-pack, failure only
results in a warning, since the actual upload is already done and
there's not much to do other than log the failure.

-- 
Arun Raghavan
http://arunraghavan.net/
(Ford_Prefect | Gentoo) & (arunsr | GNOME)
