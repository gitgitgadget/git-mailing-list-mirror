From: Jaime Medrano <overflow5@gmail.com>
Subject: Re: proposal: delta based git archival
Date: Fri, 22 Apr 2005 11:49:20 +0200
Message-ID: <b008c6a40504220249477e70ae@mail.gmail.com>
References: <20050422090341.GC22479@zoy.org>
Reply-To: Jaime Medrano <overflow5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 11:45:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOuii-0006LM-67
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 11:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbVDVJtZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 05:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbVDVJtZ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 05:49:25 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:60286 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262017AbVDVJtU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 05:49:20 -0400
Received: by wproxy.gmail.com with SMTP id 68so856312wri
        for <git@vger.kernel.org>; Fri, 22 Apr 2005 02:49:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YwmOzXqw/gJu3GLAtCgW6lO7xbJlJn+4fY4McOTcjuDrIoyK28dVEwAbXsAH0Xwo68UoOU2K2YOdqO0wvWRLQ/kFvjbJbmG9LolJuXjIWBPWM0ZzNktmOzsQnE4wRSiKdR2Xe02T8Hiezefhn6Jl6avpIPyu+8ZPYh+dGcN9z8w=
Received: by 10.54.50.15 with SMTP id x15mr380195wrx;
        Fri, 22 Apr 2005 02:49:20 -0700 (PDT)
Received: by 10.54.38.25 with HTTP; Fri, 22 Apr 2005 02:49:20 -0700 (PDT)
To: Michel Lespinasse <walken@zoy.org>
In-Reply-To: <20050422090341.GC22479@zoy.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 4/22/05, Michel Lespinasse <walken@zoy.org> wrote:
> I noticed people on this mailing list start talking about using blob deltas
> for compression, and the basic issue that the resulting files are too small
> for efficient filesystem storage. I thought about this a little and decided
> I should send out my ideas for discussion.
> 

I've been thinking in another simpler approach.

The main benefit of using deltas is reducing the bandwith use in
pull/push. My idea is leaving the blob storage as it is by now and
adding a new kind of object (remote) that acts as a link to an object
in another repository.

So that, when you rsync, you don't have to get all the blobs (which
can be a lot of data), but only the sha1 of the new objects created.
Then a remote object is created for each new object in the local
repository pointing to its location in the external repository.

Once the rsync is done, when git has to access any of the new objects
they can be fetched from the original location, so that only necessary
objects are transfered.

This way, the cost of a sync in terms of bandwith is nearly zero.

I've been working on this, so if you think it to be a good idea, I can
send a patch when I get it fully working.

Regards,
Jaime Medrano.
http://jmedrano.sl-form.com
