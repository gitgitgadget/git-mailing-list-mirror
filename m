From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: does a successful 'git gc' imply 'git fsck'
Date: Sun, 2 Dec 2012 14:16:33 +0530
Message-ID: <CAMK1S_gUB6tpNQTLGTPPAvQ87+mX2HGiN1xpA7KoH33MX9tFBw@mail.gmail.com>
References: <CAMK1S_iBq1ReGkjuy2UBENSQXOWyKj2ZzSCcg7Z89FVtVL2wMw@mail.gmail.com>
	<CAJo=hJvHeA4g1fJZXm9VxpdvMFoHeEJW_r5YtXTDACEp09Xm_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Dec 02 09:47:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tf5CV-0004NX-PY
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 09:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089Ab2LBIqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2012 03:46:35 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:37151 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918Ab2LBIqf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2012 03:46:35 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so1471663lag.19
        for <git@vger.kernel.org>; Sun, 02 Dec 2012 00:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=c//3dqS0dZ3BPeCQcBI6zLcatJwy25KPhf2ZWXHXIo4=;
        b=Gf+ZDSxHJtba0LMgo3ZFNQqF8C+aSLRtg7/1OY/6BgEqBZB0C8xoRHDmLr/+sQ+tBd
         9Da6Uyv22DDFBxfk8wBhzN6b2VJXLotKnr3XeuQfg+sebQ1qPczHXkvRHWgtMmihdyoh
         Xg7CEAvEdMEigIlcmNUOp2VHNEcjkzhqw6QMwSkWan+gkCcsJihXGS/tVbvNU9DrrMMN
         14dNYcWUmW9t1Ke51+vmbks3PxYkvD4ubF0mGzcKUYSnzrM41R9zTOkxZHPx66WHj9tx
         AHTyTQTgkhyEvjNs7tfuovUkrxa0en3GKD/I+1W4kK5VHo6pQRk4W/oZKxi3FcpgjgNn
         GkBA==
Received: by 10.152.103.100 with SMTP id fv4mr6047519lab.39.1354437993812;
 Sun, 02 Dec 2012 00:46:33 -0800 (PST)
Received: by 10.112.113.103 with HTTP; Sun, 2 Dec 2012 00:46:33 -0800 (PST)
In-Reply-To: <CAJo=hJvHeA4g1fJZXm9VxpdvMFoHeEJW_r5YtXTDACEp09Xm_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211004>

On Sun, Dec 2, 2012 at 9:58 AM, Shawn Pearce <spearce@spearce.org> wrote:
> On Sat, Dec 1, 2012 at 6:31 PM, Sitaram Chamarty <sitaramc@gmail.com> wrote:
>> Background: I have a situation where I have to fix up a few hundred
>> repos in terms of 'git gc' (the auto gc seems to have failed in many
>> cases; they have far more than 6700 loose objects).  I also found some
>> corrupted objects in some cases that prevent the gc from completing.
>>
>> I am running "git gc" followed by "git fsck".  The majority of the
>> repos I have worked through so far appear to be fine, but in the
>> larger repos (upwards of 2-3 GB) the git fsck is taking almost 5 times
>> longer than the 'gc'.
>>
>> If I could assume that a successful 'git gc' means an fsck is not
>> needed, I'd save a lot of time.  Hence my question.
>
> Not really. For example fsck verifies that every blob when
> decompressed and fully inflated matches its SHA-1. gc only checks

OK that makes sense.  After I posted I happened to check using strace
and kinda guessed this from what I saw, but it's nice to have
confirmation.

> connectivity of the commit and tree graph by making sure every object
> was accounted for. But when creating the output pack it only verifies
> a CRC-32 was correct when copying the bits from the source to the
> destination, it does not verify that the data decompresses and matches
> the SHA-1 it should match.
>
> So it depends on what level of check you need to feel safe.

Yup; thanks.

All the repos my internal client manages are mirrored in multiple
places, and they set (or were at least told to set, heh!)
receive.fsckObjects so the lesser check is fine in most cases.

-- 
Sitaram
