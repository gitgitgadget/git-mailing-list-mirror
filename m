From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Creating objects manually and repack
Date: Fri, 4 Aug 2006 12:11:35 -0400
Message-ID: <9e4733910608040911p443a1360k6d9d1aab00039100@mail.gmail.com>
References: <9e4733910608032043u689f431rc5408c6d89398142@mail.gmail.com>
	 <Pine.LNX.4.64.0608032052210.4168@g5.osdl.org>
	 <9e4733910608032124o5b5b69b5hda2eb8cb1e0ac959@mail.gmail.com>
	 <Pine.LNX.4.64.0608032138330.4168@g5.osdl.org>
	 <Pine.LNX.4.64.0608032150510.4168@g5.osdl.org>
	 <9e4733910608040740x23a8b0cs3bc276ef9e6fb8f7@mail.gmail.com>
	 <9e4733910608040750g3f72c07ct43f54347e47f25b4@mail.gmail.com>
	 <Pine.LNX.4.64.0608040818270.5167@g5.osdl.org>
	 <9e4733910608040841v7f4f27efra63e5ead2656e07@mail.gmail.com>
	 <44D36F64.5040404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, "Linus Torvalds" <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Aug 04 18:12:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G92Gx-0001yd-Rt
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 18:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161276AbWHDQLh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 12:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161279AbWHDQLh
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 12:11:37 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:32975 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161276AbWHDQLg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 12:11:36 -0400
Received: by wr-out-0506.google.com with SMTP id 68so19445wra
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 09:11:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B8BN1/s/sozWQc522LnEZyJqUWZcAnGOph1V9Y6Al3kIY2Qgni3wXMUgOrI6xONJNXEOVtD56fYSLdd7FG1e4dXzZYtAHUqPf0p/guflO0QUQiva/aDrduRtqC4Z9jhMTNAGn6V3bqxbtQdRliyn//6rnnuWrUKMb4KeCJpI0ho=
Received: by 10.78.193.19 with SMTP id q19mr1598533huf;
        Fri, 04 Aug 2006 09:11:35 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Fri, 4 Aug 2006 09:11:34 -0700 (PDT)
To: gitzilla@gmail.com
In-Reply-To: <44D36F64.5040404@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24802>

On 8/4/06, A Large Angry SCM <gitzilla@gmail.com> wrote:
> Jon Smirl wrote:
> > On 8/4/06, Linus Torvalds <torvalds@osdl.org> wrote:
> >> I'd suggest against it, but you can (and should) just repack often enough
> >> that you shouldn't ever have gigabytes of objects "in flight". I'd have
> >> expected that with a repack every few ten thousand files, and most files
> >> being on the order of a few kB, you'd have been more than ok, but
> >> especially if you have large files, you may want to make things "every
> >> <n>
> >> bytes" rather than "every <n> files".
> >
> > How about forking off a pack-objects and handing it one file name at a
> > time over a pipe. When I hand it the next file name I delete the first
> > file. Does pack-objects make multiple passes over the files? This
> > model would let me hand it all 1M files.
> >
>
> Why don't you just write the pack file directly? Pack files without
> deltas have a very simple structure, and git-index-pack will create a
> pack index file for the pack file you give it.

That is under consideration but the undeltafied pack is about 12GB and
it takes forever (about a day) to deltafy it. I'm not convinced yet
that an undeltafied pack is any faster than just having the objects in
the directories.

The same data in a deltafied pack is 700MB. That is a tremendous
difference in the amount of IO needed. The strategy has to be to avoid
IO, nothing I am doing is ever CPU bound.

-- 
Jon Smirl
jonsmirl@gmail.com
