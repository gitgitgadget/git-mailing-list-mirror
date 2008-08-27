From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] be paranoid about closed stdin/stdout/stderr
Date: Wed, 27 Aug 2008 14:22:39 -0400
Message-ID: <32541b130808271122t45031cc7n497da8da6ca52bd3@mail.gmail.com>
References: <quack.20080825T0128.lthr68djy70@roar.cs.berkeley.edu>
	 <48B29C52.8040901@gnu.org> <E1KXawS-0001gg-Ty@fencepost.gnu.org>
	 <48B2AFC2.20901@viscovery.net>
	 <7vbpzgb94q.fsf@gitster.siamese.dyndns.org>
	 <E1KXsL9-0004ef-Co@fencepost.gnu.org> <48B3A948.3080800@viscovery.net>
	 <20080826074044.GA22694@cuci.nl>
	 <32541b130808262201v4d7c1aa5r781720a80b79fcd0@mail.gmail.com>
	 <20080827091800.GB484@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Paolo Bonzini" <bonzini@gnu.org>,
	"Karl Chen" <quarl@cs.berkeley.edu>,
	"Git mailing list" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Aug 27 20:23:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYPgK-0007Sc-Rx
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 20:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbYH0SWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 14:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbYH0SWl
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 14:22:41 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:34828 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbYH0SWk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 14:22:40 -0400
Received: by gxk9 with SMTP id 9so4231118gxk.13
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 11:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=FoqW7e3G1gNtohVRc3mW38rOpEKtF3bmaPl6/4Ny+88=;
        b=OBU0/48qlN0kOuiolqWamx/4jolT5xyj5/jKQgfzQKn8r42FV5xC2KVeT7h4XWPpWm
         fTztV/BDOz5meewG0/Ce9ABd4b5XPutzxKC6xfVFTMZpmzy4/WBgGFEU4ukyswxpVXEa
         xoAiN27YSqBCV7M7gViQk6HMCtphRRTjqS7mw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=kfXDbytawcyMX358rfYahYjglRHMGrEG2a00zBtWUj3+TAxYahb5XvpGpb2afbMjYO
         1BGw/gddGhT1fG1iObMl2pZPLl8biGB5y+Etrbo5xLlYCR/LAiOmfVselS9KBMp+eeOw
         sbczqD05m9L1igq9cvHHqo5oJCCudEvBeWkHo=
Received: by 10.151.111.15 with SMTP id o15mr606181ybm.7.1219861359705;
        Wed, 27 Aug 2008 11:22:39 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Wed, 27 Aug 2008 11:22:39 -0700 (PDT)
In-Reply-To: <20080827091800.GB484@cuci.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93914>

On Wed, Aug 27, 2008 at 5:18 AM, Stephen R. van den Berg <srb@cuci.nl> wrote:
> Avery Pennarun wrote:
>>In general I'd mostly agree with you, but fd 0/1/2 are super-special
>>and I've personally been bitten by insane, rare problems that occur
>>when programs are started with one or more of those fds closed.
>
> Key words: "insane, rare problems"

Yes, I used those words on purpose.

> Well, as you say, "you're writing a new daemon".  This means that you
> need to make sure that *if* this daemon ever forks/execs it leaves the
> environment in a sane state which does not open up security holes.

Well, *I* know that.  But this is far from well-documented.

>>Does this sound rare?  It is!  But it's also hellish to debug when it
>>happens, precisely because of its rarity.  For example, in one case, I
>>had this problem because an sfdisk process started by my custom
>
> Thing is, by making git (and some other programs) hide this problem
> from you, this problem will get even *harder* to debug.  Whereas as a
> daemon author you should be thankful that something breaks and shows you
> your daemon needs fixing.

True enough, unless it was worked around in libc or the kernel as I
suggested.  That said, if git opens a file and writes random log
messages to it, I'd still consider that to be git's fault for doing
so.

I'm just feeling protective of the future sanity of other developers
here, hoping they don't have to go through what I did on a multi-week
bug hunt.  (We were even blaming reiserfs for a while for our boot
sector getting zapped...)  The fact that someone *other* than me has
suggested this change implies that I'm not the only one who has seen
such insanity in the wild.

It'd be fine if git simply died if fd 0, 1, or 2 isn't open when it
starts.  Printing a warning message wouldn't work, for hopefully
obvious reasons.  But it would be a shame to simply ignore this sort
of problem now that it's been brought up.

Have fun,

Avery
