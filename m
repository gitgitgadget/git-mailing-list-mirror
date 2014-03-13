From: Shawn Pearce <spearce@spearce.org>
Subject: Re: No progress from push when using bitmaps
Date: Thu, 13 Mar 2014 15:01:09 -0700
Message-ID: <CAJo=hJu1WscibwectWzrUcoOV4-9xk4hBm1JA+RjONmgvZTXwQ@mail.gmail.com>
References: <CAJo=hJth1YB+u2Y9S0X3xk7s2-HcPP4_k03qprHBU4A9721i8g@mail.gmail.com>
 <20140313212626.GA23618@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 13 23:01:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WODh1-00081y-7d
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 23:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588AbaCMWBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 18:01:31 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:56937 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753378AbaCMWBa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 18:01:30 -0400
Received: by mail-wi0-f173.google.com with SMTP id f8so4570246wiw.6
        for <git@vger.kernel.org>; Thu, 13 Mar 2014 15:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zQZKVmeM1JostqBGpYL2KS7svbekoIzBPFGI3Sy6hFk=;
        b=KgRLq8JlCwqIMlEePY4Y0bkHdd+B3JszBiC9K+uGYYc+L1INkTKmsZCeSu6B0su3UH
         wOSVrJU9IqAd5N9erIsaxawayWsgY35ANYKeYiOM+Nv7RaXX/uHaecRjG0a7DeFZJ/Na
         tRTMBwtKXpD0Hjf43hqI5X1IdfEZ7yE4QE0qI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=zQZKVmeM1JostqBGpYL2KS7svbekoIzBPFGI3Sy6hFk=;
        b=Hb0aZMT+RwCjy51ambPVm9/CNZKmiaZXNcRr3rjXh8kC1ozMWD++FQpnWQY2BNE+if
         V1FYsZebQsP3zV57mCZS+v2DPWNZ4NNo06vvGV/a9BqTbO9WMoiotpSdAWceCqvrJnVs
         2icyqE8J3hwVNOkR84D8TtWVQqVEnw/GE+2b+M5Wx4A04wqIAEkNTnuFG6n8HrahF1s3
         YZPGkTQ/W1bcOg0d3qBLF1rhd5+69zwDEh3ZID0MU2VczkAJGhb+oRTQXa7BDGxzX+bP
         nuXWD6XCEojm12pOUbBjw4+NX0qi5lrydjloIcDl0jV0/PAyowcEKeQZO7JrwYVfg3uY
         zvYQ==
X-Gm-Message-State: ALoCoQnvjg8lZeI949Xm7fAtCBGkBUbqvRB9+cRC7poUaO/+w6gY4FBeb9jpHSkA5dtlYri5APxT
X-Received: by 10.180.101.166 with SMTP id fh6mr3454592wib.2.1394748089091;
 Thu, 13 Mar 2014 15:01:29 -0700 (PDT)
Received: by 10.227.7.131 with HTTP; Thu, 13 Mar 2014 15:01:09 -0700 (PDT)
In-Reply-To: <20140313212626.GA23618@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244053>

On Thu, Mar 13, 2014 at 2:26 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Mar 12, 2014 at 05:21:21PM -0700, Shawn Pearce wrote:
>
>> Today I tried pushing a copy of linux.git from a client that had
>> bitmaps into a JGit server. The client stalled for a long time with no
>> progress, because it reused the existing pack. No progress appeared
>> while it was sending the existing file on the wire:
>>
>>   $ git push git://localhost/linux.git master
>>   Reusing existing pack: 2938117, done.
>>   Total 2938117 (delta 0), reused 0 (delta 0)
>>   remote: Resolving deltas:  66% (1637269/2455727)
>>
>> This is not the best user experience. :-(
>
> Yeah, I agree that sucks. I hadn't noticed it, as I don't typically have
> my client repos bitmapped (and on fetch, the interesting progress is
> coming from the local index-pack).
>
> It would definitely be good to have throughput measurements while
> writing out the pack. However, I'm not sure we have anything useful to
> count. We know the total number of objects we're reusing, but we're not
> actually parsing the data; we're just blitting it out as a stream. I
> think the progress code will need some refactoring to handle a
> throughput-only case.

Yes. I think JGit suffers from this same bug, and again we never
noticed it because usually only the servers are bitmapped, not the
clients.

pack-objects writes a throughput meter when its writing objects.
Really just the bytes out/second would be enough to let the user know
the client is working. Unfortunately I think that is still tied to the
overall progress system having some other counter?
