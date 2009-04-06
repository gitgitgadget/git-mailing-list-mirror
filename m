From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: Re: [question] how can i verify whether a local branch is tracking a 
	remote branch?
Date: Tue, 7 Apr 2009 00:00:20 +0200
Message-ID: <4d8e3fd30904061500m7857f0f1i2b76a2113f30c562@mail.gmail.com>
References: <4d8e3fd30904050332w394cccbaq5b82d2a53ed357a3@mail.gmail.com>
	 <20090405144413.GC2076@sigill.intra.peff.net>
	 <4d8e3fd30904051425w6739a12fp5666e71e8b2d7958@mail.gmail.com>
	 <20090406043426.GC12341@coredump.intra.peff.net>
	 <4d8e3fd30904060130l985b0a5x331d215ca6106fd4@mail.gmail.com>
	 <20090406212516.GA882@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 07 00:04:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqwtJ-0005dT-Je
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 00:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761245AbZDFWA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 18:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761168AbZDFWA1
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 18:00:27 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:52094 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761234AbZDFWAY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 18:00:24 -0400
Received: by fg-out-1718.google.com with SMTP id 16so302119fgg.17
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 15:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Pzj/wSTOLRaTzg9YbnHtir+bQxzuGcMiIKuXv3hhzOg=;
        b=ryv0NhISirQmdHtoL+5Ksg7Pe92XYXWC6g/nyVVoohJTfVLFvfHNibQJl6rvvDAnyD
         jPQQFDyxXdZfb01qvFO3ra2LmMbBlhqR9wsBc53F2j3DDPWdX43FfcW3PNxoUPkKZoF0
         IFEuqqSR+gX7Q4tC/PrZtoFDtJOIScFsEP5tA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=q3pI7Ry9EEFSXM2dYbhaHf+y3xNlVJDt3u3L5uqCzouKGZi1B70SbD2M1xIDvBAOTW
         +klSBawmJgnymhwH9H4TN8hRPrN68m3eiLf15iqbZKq4dNgKKWqWr2TKAFADQd4O7Y2s
         VTQPhL2jRNIJWsStf4VKWkL6OqmoqZGCuScD4=
Received: by 10.86.95.8 with SMTP id s8mr3521344fgb.39.1239055220447; Mon, 06 
	Apr 2009 15:00:20 -0700 (PDT)
In-Reply-To: <20090406212516.GA882@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115886>

On 4/6/09, Jeff King <peff@peff.net> wrote:
> On Mon, Apr 06, 2009 at 10:30:21AM +0200, Paolo Ciarrocchi wrote:

>> I mean something like:
>> $ git branch
>>  * foo <-> origin/foo
>>
>> What do you think?
>
> Ah. Well, if you just want it for human consumption, that is much
> easier. :) That information is already shown by "git status":
>
>   $ git status
>   # On branch next
>   # Your branch is ahead of 'origin/next' by 8 commits.
>   ...

right, but it can only ne used for the current branch.

> "git branch -v" is already looking at the information, but it
> prints only the "ahead/behind" summary. E.g.,:
>
>   $ git branch -v
>     bar    1e0672d [behind 5] some commit
>   * baz    dccc1cd [ahead 1, behind 3] other commit
>     foo    787d5a8 [ahead 1] another commit
>     master a0e632e actual upstream master
>
> It would be pretty trivial to make it do something fancier. The
> (extremely rough) patch below shows the tracking branch when
> double-verbosity is given:
>
>   $ git branch -vv
>   * next 2d44318 [origin/next: ahead 9] branch -vv wip

I like it!

> So the questions are:
>
>   - is this worth it? The verbose information is already available via
>     git status, but only for the current branch.

I think it's a very usefull information.
I feel like it would be nice to have this information being part of
the basic git branch output and not associated to the -vv option.

>   - should it be the default with "-v", or require "-vv"? It take up a
>     bit of screen real estate, which is already in short supply for
>     "branch -v"

How about be just part of the default git branch output?


>   - in both the "status" and "branch" cases, we show nothing if they
>     are equivalent. I guess you would want to see
>
>       * next 2d44318 [origin/next] branch -vv wip
>
>     or
>
>       * next 2d44318 [origin/next: uptodate] branch -vv wip

Sure.

Thanks!

Ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
http://mypage.vodafone.it/
