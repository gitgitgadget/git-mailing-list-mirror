From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/4] fast-import: only store commit objects
Date: Fri, 3 May 2013 19:01:09 -0500
Message-ID: <CAMP44s3CPNyrWQoXoNDGaKfH6qniosfFMdjWVD_8FKD+Vge_8Q@mail.gmail.com>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com>
	<1367555502-4706-5-git-send-email-felipe.contreras@gmail.com>
	<87y5bw3q1s.fsf@hexa.v.cablecom.net>
	<7v61yzyavo.fsf@alter.siamese.dyndns.org>
	<CAMP44s2o2EvmSwB0P_WkudxQWigUV20+ECio1rUGPt8qF5=0Ow@mail.gmail.com>
	<7vr4hnwru7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 04 02:01:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYPuo-000599-Sh
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 02:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934373Ab3EDABL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 20:01:11 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:35487 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760119Ab3EDABL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 20:01:11 -0400
Received: by mail-la0-f54.google.com with SMTP id fd20so1977966lab.13
        for <git@vger.kernel.org>; Fri, 03 May 2013 17:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=y05s5tuUCLe+HqMw/JhvhVkZnNIsMqupASR+rGWxc5A=;
        b=z9htjds46qxfhMkbKD6AQDa70CwO1lCJn+irHa5JAmq2CDfiahN2Zc+EDw5uOodv0O
         Mzg67JnPPMYz7SmVUwicezze8Cii4Sjoy5yHomtnwmjwBRxAkkLK54fAwGxJKWDn54J1
         mrsLOOXk8RpPUWscoDJqAjKwzhLThkKu7QgpYaTE3wRZHVW68clRddWGvC4EGia9ErCL
         v+WgT82be+LVVV0U1gMiKCiwS5e2xPbwCtBJB8by6z+Xzr8KBo9E9xmxtg4WCfT8ktCy
         qXzYTy0PuHEpX+Pk/L5JpMXhPermm95Nh9vvJmuLFs+l+8ykFpmEOdpO2/2eLGKO/bJh
         6wrA==
X-Received: by 10.152.22.168 with SMTP id e8mr4879984laf.20.1367625669355;
 Fri, 03 May 2013 17:01:09 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Fri, 3 May 2013 17:01:09 -0700 (PDT)
In-Reply-To: <7vr4hnwru7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223336>

On Fri, May 3, 2013 at 6:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> A safe and sane approach may be to teach these an option to tell
>>> them to omit non-commits or to emit all kinds, and make remote-bzr
>>> use that to exclude non-commits.
>>
>> This has nothing to do with remote-bzr, or any remote helper. These
>> objects are not useful, not even to 'git fast-export'.
>>
>>> If the defaults is matched to the
>>> current behaviour, nobody will get hurt
>>
>> Changing nothing always ensures that nobody will get hurt, but that
>> doesn't improve anything either.
>
> I do not quite follow.  Allowing existing code to depend on old
> behaviour, while letting new code that knows it does not need
> anything but commits, will get the best of both worlds. The new code
> will definitely improve (otherwise you won't be writing these
> patches), and the old code will not get hurt. Where is this "doesn't
> improve anything" coming from?

So let's suppose we add a new 'feature no-blob-store' to 'git
fast-import', and some clients of 'git fast-import' enable it, and
benefit from it.

How does that benefit the rest of fast-import clients? You are
worrying about clients that most likely don't exist, and don't let
existing real clients benefit for free. This is like premature
optimization.

But whatever, let's keep writing and discarding these blobs, at least
the previous patches do make such operations fast.

You can drop this patch, because I'm not going to write code for
clients that don't exist. And it seems clear that even if I
investigate client apps of 'git fast-import' and I'm unable to find a
single one that utilizes blobs, you still wouldn't apply this patch.
So there's no point in investigating what are the *actual* users, if
all we are every going to do is worry about hypothetical ones.

My main interest is the previous patches, if anybody has any issues
with the way this patch is handled, they can either work on the patch
itself, or start a new thread in which I will not participate, I will
rather concentrate on issues that affect *real* users, and have real
fixes reachable today, and the previous patches in this series fit
that bill.

Cheers.

-- 
Felipe Contreras
