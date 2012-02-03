From: Gabriel Filion <lelutin@gmail.com>
Subject: Re: [RFC/PATCH git-remote-bzr] Adapt to new semantics of remote-helper
 "import" command
Date: Fri, 03 Feb 2012 04:43:35 -0500
Message-ID: <4F2BAC47.6090502@gmail.com>
References: <20120122054657.GA25103@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Simon Poirier <spoirier@rlnx.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Jelmer Vernooij <jelmer@samba.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 10:43:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtFgI-00020X-AO
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 10:43:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755464Ab2BCJnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 04:43:39 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:64137 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755486Ab2BCJna (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 04:43:30 -0500
Received: by qadc10 with SMTP id c10so607631qad.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 01:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=P1U5SknEtbs+3iiNjVu2CCqtacEcvge/GvlOtZGkqZc=;
        b=XXBtguT2PkkFrhmyJKxkcen6PBYjKDybOnfyWAYBsqcCMn/2UWHz3jAOHFOFUy9bCe
         4qyoaINlSKfqMN0FRjkBA2JwPdGZHy/fueq4saGE/l5rBBssL02+KkuC26TkvWv12bQ1
         kt8z5Qhbcjb0K7Wnk5qQ7kDw/Lh1velxXYk9k=
Received: by 10.224.214.194 with SMTP id hb2mr8264043qab.96.1328262209195;
        Fri, 03 Feb 2012 01:43:29 -0800 (PST)
Received: from [192.168.2.201] (dsl-156-155.aei.ca. [66.36.156.155])
        by mx.google.com with ESMTPS id dm8sm11736503qab.18.2012.02.03.01.43.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Feb 2012 01:43:28 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:9.0) Gecko/20111220 Thunderbird/9.0
In-Reply-To: <20120122054657.GA25103@burratino>
X-Enigmail-Version: 1.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189744>

Hello,

On 12-01-22 12:46 AM, Jonathan Nieder wrote:
> Hi Simon and Gabriel,
> 
> Here's a rough patch against git://github.com/lelutin/git-remote-bzr.git
> master.

great! thanks for your help.

I must admit that this project never got to completion and is now
getting quite the low priority for my part. I'm no longer working for
the company that was using mainly Bazaar as their VCS, and I've been a
happy git-only user for some time now.
So, I don't have the same incentive to complete the project as I had before.

But I'd be happy to see this get to a point where it's working fine.

> Without this patch, whenever I try to use "git clone bzr::<something>",
> after doing all the work it removes the resulting repo and exits with
> status 141 (SIGPIPE).  Maybe the transport-helper should mask SIGPIPE
> when writing the final newline to avoid that.
> 
> I'd have prefered to write a patch for remote-bzr that works with
> older versions of git fast-import, too, but it wasn't obvious how.
> Hints welcome.

hmm.. I can wait some time to see if some ideas come out around this,
and commit your patch as-is if there are no comments/reworks.

> BTW, would you mind if I sent a patch to include git-remote-bzr in
> git.git under contrib/?

absolutely not, that'd be great actually :)

I didn't do that up to now, though, since I bumped into so much bugs
that I couldn't work out -- some very bad performance issues, and
problems with handling mark files with bzr-fastimport.

> Thanks for git remote-bzr!  I'd be happy for any thoughts you have.

The idea behind git-remote-bzr was to be able to interact with Bazaar
from within your git repository, i.e. to expose remote branches that you
can pull from and push to using the default git commands, without having
to learn to use yet another tool since the remote-helper would be
interfacing with the tool for you.

I have dived for a short period of time into bzrlib, the python library
behind Bazaar, to see how much work it would take to put together a
simplified fast-import client.. and .... wechrk!
It was a huge maze of version-dependant code (the API undergoes big
changes frequently, and backwards compatibility is maintained pretty
far) mixed with a 40-foot-deep class hierarchy. So I quickly gave up on
that idea..

IIRC, at the time I started work on this, Simon and I used
bzr-fastimport[1] because we were able to get farther with this tool. I
haven't used bzr-git[2] that much, though, so I can't comment too
extensively on it. But I would guess that it is maintained more
frequently than bzr-fastimport is, so it could be a better choice for
the backend fast-import client.

I would guess that Jelmer would be happy to help out with interfacing
with bzr-git.

-- 
Gabriel Filion
