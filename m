From: Johan Herland <johan@herland.net>
Subject: Re: question about: Facebook makes Mercurial faster than Git
Date: Mon, 10 Mar 2014 13:10:07 +0100
Message-ID: <CALKQrgcfTKy0d_BGAZ-bSx5i-=MVEF-WuRfW6T3Q-YxvVSqY_A@mail.gmail.com>
References: <531D8ED9.7040305@gmx.net>
	<CANgJU+W+f3KUxehDGxd+f77RO24VadsnOV=szE2MkBXjs8wDCQ@mail.gmail.com>
	<531DA519.8090509@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Dennis Luehring <dl.soluz@gmx.net>
X-From: git-owner@vger.kernel.org Mon Mar 10 13:10:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMz2Q-0005sX-UP
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 13:10:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427AbaCJMK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 08:10:26 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:39269 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936AbaCJMKO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 08:10:14 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1WMz24-0002JO-4K
	for git@vger.kernel.org; Mon, 10 Mar 2014 13:10:12 +0100
Received: from mail-pb0-f52.google.com ([209.85.160.52])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1WMz23-0000xZ-RZ
	for git@vger.kernel.org; Mon, 10 Mar 2014 13:10:12 +0100
Received: by mail-pb0-f52.google.com with SMTP id rr13so7203500pbb.39
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 05:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VENInx9wdXnjyMThddl53l3pLC/oB7HXs3mLTvLq4Wc=;
        b=lb5ynbVe1cPA+QMAyp47Qvw/T+RXdnZ6acxSHvqMgbP7b1n1oEab8DsHRyYfpHvXfo
         LwVKRH19idOQFxJJMQ+tXzoDAiOaNqQTIlYD5fnGIj0R5bAeoNRXNShIMzqm7KDMfXOn
         7hcuekProllnTzOhUcfm/42OZNBgfo0geBTxluJKqSVx00S9tD9NZp5GpLS6Kg7c8en5
         FffsprwjPJ6/hWBluuHzWFA8J95yPpwoXvjhdHJMFbKeDWGc/dPYBBdTBNlSB5l9Eb+h
         EjbFqC1HDr9ah+qNcq7GLWJ3EnvIqSd3cccf+4TH0P7wguszMLijIKYN8L4kw9f+3n8k
         l/GA==
X-Received: by 10.68.190.163 with SMTP id gr3mr39727194pbc.103.1394453407873;
 Mon, 10 Mar 2014 05:10:07 -0700 (PDT)
Received: by 10.70.48.228 with HTTP; Mon, 10 Mar 2014 05:10:07 -0700 (PDT)
In-Reply-To: <531DA519.8090509@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243730>

On Mon, Mar 10, 2014 at 12:42 PM, Dennis Luehring <dl.soluz@gmx.net> wrote:
> Am 10.03.2014 12:28, schrieb demerphq:
>
>> I had the impression, and I would not be surprised if they had the
>> impression that the git development community is relatively
>> unconcerned about performance issues on larger repositories.
>
> so the question is if the git community is interested in beeing competive in
> such large scale scenarios - something what mercurial seems to be now out
> of the box

AFAIK, David Lang's comment is not far off the mark. Facebook has made
a tool called Watchman (https://github.com/facebook/watchman) that
watches your work tree (i.e. wrapping inotify on Linux) and triggers
various commands when files within are changed (e.g. do an auto-build
whenever a file in your project changes). Since this tool will
discover when files change, they have adjusted Mercurial to discover
changes by querying Watchman instead of stat-ing the entire work tree.

AFAICS, this is basically a tradeoff between the time it takes to stat
your work tree and the overhead/administrivia of running a daemon to
monitor the work tree. It seems Facebook has organized their code and
infrastructure in a way that makes the latter approach worthwhile for
them, and has contributed their solution back to Mercurial.

It should be possible to teach Git to do similar things, and IINM
there are (and have previously been) several attempts to do similar
things in Git, e.g.:

 - http://thread.gmane.org/gmane.comp.version-control.git/240339

 - http://thread.gmane.org/gmane.comp.version-control.git/217817

I haven't looked closely at these attempts (it is not my scratch to
itch), and I don't know if/how they would work on top of Watchman, but
in principle I don't see why Git shouldn't be able to leverage
Watchman the same way Mercurial does.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
