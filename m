From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: GSoC - Some questions on the idea of
Date: Tue, 10 Apr 2012 20:24:48 -0500
Message-ID: <4F84DD60.20903@gmail.com>
References: <CA+M5ThS2iS-NMNDosk2oR25N=PMJJVTi1D=zg7MnMCUiRoX4BQ@mail.gmail.com> <CACsJy8APtMsMJ=FrZjOP=DbzuFoemSLJTmkjaiK5Wkq9XtA4rg@mail.gmail.com> <loom.20120328T131530-717@post.gmane.org> <CA+M5ThTPyic=RhFL2SvuNB0xBWOHxNTaUZrYMB144UjpjCiLoQ@mail.gmail.com> <20120330203430.GB20376@sigill.intra.peff.net> <CA+M5ThR6jtxqs0-Kz-8fcRuOFRbLr-GvsJcTmrOQ7_geNspDLg@mail.gmail.com> <4F76E430.6020605@gmail.com> <4F772E48.3030708@gmail.com> <20120402210708.GA28926@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Bo Chen <chen@chenirvine.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 11 03:24:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHmIt-0005dK-4m
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 03:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759922Ab2DKBYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 21:24:54 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:49904 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754747Ab2DKBYx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 21:24:53 -0400
Received: by obbtb18 with SMTP id tb18so551395obb.19
        for <git@vger.kernel.org>; Tue, 10 Apr 2012 18:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=VO0gwFiFiSl2fudt0DhwiZR8LQmwLE9o01Bu5W+WTX4=;
        b=s9a6AXlfcFCV9cLeSBR2EPD1TcmhGapM3lgqj+jT48iN4k8S9//CsmNlZL3uEdvO/I
         0tXNVsDlPpJhS1f/3pWGfh3MGa5lYpBD5IbOw67ykwQVmHZ5KeVvoqsXrJpFJA2Sa/vy
         bnwQ8EhmuCI4ghDBNX2+kaIRs41XptylelcWaKh3SPm3Am0h22qoHxfV1evDLuqO8YY8
         aj6jgws2Wtub1Vtd5zAZQJqxudSu41tnQ3DrWnskIdM2Gz3jXSyjxL0uGXwyv75802Ub
         ptrFFKBcv2OrXDihFrittQmFtUYb0odYfEOsBRyPsaY7p28sB+vvKYQPeACUmXEAIrJ/
         2JpA==
Received: by 10.182.74.4 with SMTP id p4mr11957859obv.79.1334107492886;
        Tue, 10 Apr 2012 18:24:52 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id t5sm1067151oef.10.2012.04.10.18.24.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Apr 2012 18:24:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <20120402210708.GA28926@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195141>

On 4/2/2012 4:07 PM, Jeff King wrote:

> ...I think we need to first find out exactly
> how well the generic algorithm can perform. It may be "good enough"
> compared to the hassle that inconsistent application of a content-aware
> algorithm will cause.  So I wouldn't rule it out, but I'd rather try the
> bup-style splitting first, and see how good (or bad) it is.
>
(I read bup DESIGN doc to see what bup-style splitting is.) When you use 
bup delta technology in git.git I take it that you will use it for 
big-worktree-files *and* big-history-files (not-big-worktree-files that 
are not xdelta delta-friendly)?  IOW, all binaries plus 
big-text-worktree-files.  Otherwise, small binaries will become large 
histories.

If small binaries are not going to be bup-delta-compressed, then what 
about using xxd to convert the binary to text and then xdelta 
compressing the hex dump to achieve efficient delta compression in the 
pack file?  You could convert the hexdump back to binary with xxd for 
checkout and such.

Maybe small binaries do xdelta well and the above is a moot point.  This 
is all theory to me, but the reality is looming over my head since most 
of the components I should be tracking are binaries small (large 
history?) and big (but am not yet because of "big-file" concerns -- I 
don't want to have to refactor my vast git ecosystem with filter branch 
later because I slammed binaries into the main project or superproject 
without proper systems programming (I'm not sure what the c/linux term 
is for 'systems programming', but in the mainframe world it meant making 
sure everything was configured for efficient performance)).

Now that I say that out loud I guess a superproject with binaries in 
separate repos could be easily refactored by creating new efficient 
repos and making a new commit that points to them instead of the old 
inefficient repos.  That way, when someone checks out the binary repo 
(submodule) into their worktree they get the new efficiency instead of 
the old inefficiency.  Over time, as folks are less likely to check out 
old stuff the old inefficiency goes away on its own.  I think. 
(Submodules are mostly theory to me at this point also.)

v/r,
neal
