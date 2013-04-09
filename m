From: John Koleszar <jkoleszar@google.com>
Subject: Re: [PATCH] http-backend: respect GIT_NAMESPACE with dumb clients
Date: Tue, 9 Apr 2013 15:13:25 -0700
Message-ID: <CAAvHm8M+rijJipDsx-juUonoLGGho80AOVy1n2hE4vmY3pRE0Q@mail.gmail.com>
References: <CAAvHm8PCQx18Gk2S7dicG+_GksjFqVLfPNCbism1sHnPUMDNzg@mail.gmail.com>
	<1365091293-23758-1-git-send-email-jkoleszar@google.com>
	<87wqscr9yk.fsf@linux-k42r.v.cablecom.net>
	<20130408214512.GA11227@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Josh Triplett <josh@joshtriplett.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 10 00:13:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPgnD-0000DY-TE
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 00:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936011Ab3DIWN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 18:13:27 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:49242 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763205Ab3DIWN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 18:13:26 -0400
Received: by mail-wg0-f47.google.com with SMTP id y10so7321520wgg.2
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 15:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=2wHHsS8A38Q/Rv4/Fg93YqbqIqk66m8dlNHfi0tVxlQ=;
        b=PISr0ZqVPiMxlVzZK6aKFctGPC0h9jCwEUcjk80/+xTCAbREIba8HY9sdlhs10fOfC
         Laccqd3gpCAXkQUQ5PuWbPsPVzS8MDotAGZQCN+RcMJ4zkDpJ+pSg50jPhE/Ipeka5MU
         Dz1mc+781iL3B/z1fFzSX0Q6plrhRdgdLD2jwa0VSKQhKuAGSigslEdWHKIuhwhLJi0n
         CEkCw/MfaSIswf3RnChaWPOgTT1wENsvvIFWm/M/sVmTJWe7NLMQ4at+W/M8vKJo1svp
         6laGTWZlhYAYeTbukkvIeFpI/TULPbqaS350Jd0DByGgqD4AhRW+1IMc0eZNXjq4pcWt
         jhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:x-gm-message-state;
        bh=2wHHsS8A38Q/Rv4/Fg93YqbqIqk66m8dlNHfi0tVxlQ=;
        b=TcUNR/bHJxIAvatGPXs6wQRUTaybkWmey8sTNioTafTC8Qxy0sODiOzx4Rwe5P/xfq
         8/yuuHILNrJjAsqb3WQ1kbi9865yWSXXI6XIVS+Ibf3eysougSdGZYCJ6Vg9i3IRkILy
         zmamjRSVR1ZK/erOpy42WPEzMEebu2Zm1g/FAeFP4/U/uvaO5cd3MwkpqbNPLw6QNyzg
         8+F+A/IIpDfkAv77vM1DUA0UQLLt+w4hAVR2R8FLUFPkdIoOHW6vRNoBdqFwOiGTIeGJ
         z2oIdWZj8kH4DI4LdcbdVu1FiXmr7p7GcNudbOm/IkvbNvC62YQ8PVexmHjuObg8igVa
         Bt3A==
X-Received: by 10.194.81.40 with SMTP id w8mr41290032wjx.14.1365545605647;
 Tue, 09 Apr 2013 15:13:25 -0700 (PDT)
Received: by 10.194.62.165 with HTTP; Tue, 9 Apr 2013 15:13:25 -0700 (PDT)
In-Reply-To: <20130408214512.GA11227@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQmOT8N4PGim58IN9sUoU5A8LKjPGhoAJ/jtn+HBJIfBO3L1rMDoX+5Lti0+26NAs/RvmInYnyTjwVMn79ZV3vVfuL2Kg0+kbXbE1wX6nc3d0yCu1y8PzMbX9+9E0kc1Mefu+RIWKCjAnXBsrc0F2siqjETRJPNYHcMicB2/sqB47FEf0kgQNZ4W3UyCDHxb+oomhULL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220643>

On Mon, Apr 8, 2013 at 2:45 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Apr 08, 2013 at 11:25:39PM +0200, Thomas Rast wrote:
>
>> At the risk of repeating something that's been said already -- I only
>> skimmed the thread -- this test breaks in today's pu on my machine.  I
>> get:
>> [...]
>> --- expect    2013-04-08 21:24:36.571874540 +0000
>> +++ actual    2013-04-08 21:24:36.579874619 +0000
>> @@ -1,3 +1,2 @@
>> -453190505bf07f7513bed9839da875eb3610f807     HEAD
>>  453190505bf07f7513bed9839da875eb3610f807     refs/heads/master
>>  453190505bf07f7513bed9839da875eb3610f807     refs/namespaces/ns/refs/heads/master
>> not ok 14 - backend respects namespaces
>
> I think what is in pu is not yet reflecting the latest discussion. HEAD
> should not be included in the simulated info/refs, but should be
> generated, respecting namespaces, whenever a client retrieves the HEAD
> file directly.
>
> It looks like the thread was left here;
>
>   http://article.gmane.org/gmane.comp.version-control.git/220237
>
> and we are just waiting for John's re-roll.
>

I should be able to get this done either later today or later this
week. Life/$DAYJOB has been taking up the time slot I was spending on
this the past few days.

John
