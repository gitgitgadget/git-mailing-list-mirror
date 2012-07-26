From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC 1/4 v2] Implement a basic remote helper for svn in C.
Date: Thu, 26 Jul 2012 06:40:39 -0500
Message-ID: <20120726114039.GA6712@burratino>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1374057.qfvOg1c6C6@flobuntu>
 <23122876.7xH9dZiP4M@flobuntu>
 <20120702110741.GA3527@burratino>
 <358E6F1E-8BAD-4F82-B270-0233AB86EF66@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Steven Michalske <smichalske@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 13:40:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuMR4-00068c-H8
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 13:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257Ab2GZLkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 07:40:49 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:60535 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758Ab2GZLkt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 07:40:49 -0400
Received: by ghrr11 with SMTP id r11so1833040ghr.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 04:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=yUFZhDECyya8RjEmaHM8HZZlSvrqf8SAk6rCNOMRmTE=;
        b=N2ROA+eK6evxIkHuxOw6bLw0T+5g7lcfki5VczmYa6ZMnKmzW1pWBJWRze4JF3n+64
         S52Cj1/30Rp3hJelC8du/w+iHVPiB8evAbYMdR4N6JcVpzP8qJoguM2CHpZl2vmtRkMw
         ZhNIZEoOkoJoLbNVurydfbmcL3ALQIJDaornY8KhKyBhMIFhjUGQy741WnvXoukYS5VU
         xf09sYM93ItNyxeL230Z3EUaQHsFburov9csW7mYlXfzCDLOWOG0CVFa6AIMTb4KWDWr
         xV2aoKC1v3Uz6pgIn9ZYNoHrY0+wvUXbRDzM0x+VvjoycIzLecnlnMCwU5XNy5coF/jf
         2Fog==
Received: by 10.42.31.5 with SMTP id x5mr8291009icc.40.1343302848517;
        Thu, 26 Jul 2012 04:40:48 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id gh2sm7070256igb.9.2012.07.26.04.40.47
        (version=SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 04:40:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <358E6F1E-8BAD-4F82-B270-0233AB86EF66@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202256>

Steven Michalske wrote:
> On Jul 2, 2012, at 4:07 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> [...]
>>> diff: Use fifo instead of pipe: Retrieve the name of the pipe from env and open it
>>> for svndump.
>>
>> I'd prefer to avoid this if possible, since it means having to decide
>> where the pipe goes on the filesystem.  Can you summarize the
>> discussion in the commit message so future readers understand why
>> we're doing it?
>
> Crazy thought here but would a socket not be a bad choice here?

Not crazy --- it was already mentioned.  It could probably allow using
--cat-blob-fd even on the platforms that don't inherit file
descriptors >2, though it wuld take some tweaking.  Though I still
think the way forward is to keep using plain pipes internally for now
and to make the bidirectional communication optional, since it
wouldn't close any doors to whatever is most convenient on each
platform.  Hopefully I'll hear more from Florian about this in time.

> Imagine being able to ssh tunnel into the SVN server and run the helper with
> filesystem access to the SVN repo.

We're talking about what communicates between the SVN dump parser the
version control system-specific backend (git fast-import) that reads
the converted result, so that particular socket wouldn't help much.

Jonathan
