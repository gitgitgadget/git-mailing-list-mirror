From: Jeff Mitchell <jeffrey.mitchell@gmail.com>
Subject: Re: propagating repo corruption across clone
Date: Tue, 26 Mar 2013 09:43:01 -0400
Message-ID: <CAOx6V3ZWB1ZpmXcaBeSaPOvHqmAMF3U1rTXuwinFGmEZQwFGYQ@mail.gmail.com>
References: <20130324183133.GA11200@sigill.intra.peff.net> <CACBZZX6czzJRF9TEsc8c+=LND6SxaVvrZdbcZ+TfUZTWQOpW0Q@mail.gmail.com>
 <20130324192350.GA20688@sigill.intra.peff.net> <CAOx6V3YtM-e8-S41v1KnC+uSymYwZw8QBwiCJRYw0MYJXRjj-w@mail.gmail.com>
 <20130325145644.GA16576@sigill.intra.peff.net> <CACsJy8A0eOWEJ2aqPSLof_CodJM6BadFxQHy5Vb0kAwwTSTS3w@mail.gmail.com>
 <20130325155600.GA18216@sigill.intra.peff.net> <CAOx6V3a6vGJvJ4HEmAXdTRKKCzRJS23OYd_em1b3aQLzPNEtQA@mail.gmail.com>
 <20130325200752.GB3902@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 26 14:43:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKUAM-0004CT-GW
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 14:43:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934351Ab3CZNnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 09:43:25 -0400
Received: from mail-vc0-f178.google.com ([209.85.220.178]:62285 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933906Ab3CZNnX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 09:43:23 -0400
Received: by mail-vc0-f178.google.com with SMTP id hz11so5582384vcb.9
        for <git@vger.kernel.org>; Tue, 26 Mar 2013 06:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=dxrRruU7Y+iSFMuC1xo9qqCPhpZ1gahdhOIdZCmN9tU=;
        b=gEnGHM4ZL+vd6zznqJlKBSgnard6gH2TfhqyydkwHdJK3SBPVuGOyXsbUc+X9dIg7G
         WEvvYkQTOkSXEnjxIlZaLS/g2Wk+RnAbbewEoLxAW4WgSiwENYiBnLrmNJl+XTkO2XaM
         IxGza8DCHFrorbQW4MeqLu3imC8e0g9lyIXtg0Ln8mqLFBgFzgaux7IeEApWmdMrF68l
         rArKEjPbPUaFL6cvsIRxQocuSENo5Msp5kNNxXIzFr04FvbZm+D+aQ4+RBUyXzMv2a/z
         lpAj43Nd/l+pr4OFHHdVu4qg9zFMhPLmREWodX7GxYViq/hi+/t49Pg0I9xS64Y0iRJL
         ltMA==
X-Received: by 10.58.205.179 with SMTP id lh19mr19098667vec.7.1364305402393;
 Tue, 26 Mar 2013 06:43:22 -0700 (PDT)
Received: by 10.59.7.37 with HTTP; Tue, 26 Mar 2013 06:43:01 -0700 (PDT)
In-Reply-To: <20130325200752.GB3902@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219159>

On Mon, Mar 25, 2013 at 4:07 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Mar 25, 2013 at 12:32:50PM -0400, Jeff Mitchell wrote:
>> For commit corruptions, the --no-hardlinks, non --mirror case refused
>> to create the new repository and exited with an error code of 128. The
>> --no-hardlinks, --mirror case spewed errors to the console, yet
>> *still* created the new clone *and* returned an error code of zero.
>
> I wasn't able to reproduce this; can you post a succint test case?

This actually seems hard to reproduce. I found this during testing
with an existing repository on-disk, but when I tried creating a new
repository with some commit objects, and modifying one of the commit
objects the same way I modified the an object in the previous
repository, I was unable to reproduce it.

I do have the original repository though, so I'll tar.gz it up so that
you can have exactly the same content as I do. It's about 40MB and you
can grab it here:
https://www.dropbox.com/s/e8dhedmpd1a1axs/tomahawk-corrupt.tar.gz (MD5
sum: cde8a43233db5d649932407891f8366b).

Once you extract that, you should be able to run a clone using paths
(not file://) with --no-hardlinks --mirror and replicate the behavior
I saw. FYI, I'm on Git 1.8.2.

Thanks,
Jeff
