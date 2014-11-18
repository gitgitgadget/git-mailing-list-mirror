From: Paul Smith <paul@mad-scientist.net>
Subject: Re: [PATCH] git-new-workdir: Don't fail if the target directory is
 empty
Date: Tue, 18 Nov 2014 15:54:26 -0500
Message-ID: <1416344066.3899.25.camel@mad-scientist.net>
References: <1416073760.9305.174.camel@homebase>
	 <xmqqy4r9yc5u.fsf@gitster.dls.corp.google.com>
	 <s934mtwo0zv.fsf@mad-scientist.net>
	 <xmqq8uj8wbhl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 21:54:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqpnV-0003dD-L5
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 21:54:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755275AbaKRUym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 15:54:42 -0500
Received: from qproxy4-pub.mail.unifiedlayer.com ([66.147.248.250]:38700 "HELO
	qproxy4-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755183AbaKRUyl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Nov 2014 15:54:41 -0500
Received: (qmail 15548 invoked by uid 0); 18 Nov 2014 20:54:40 -0000
Received: from unknown (HELO CMOut01) (10.0.90.82)
  by qproxy4.mail.unifiedlayer.com with SMTP; 18 Nov 2014 20:54:40 -0000
Received: from box531.bluehost.com ([74.220.219.131])
	by CMOut01 with 
	id H8ud1p00t2qhmhE018ugWG; Tue, 18 Nov 2014 13:54:40 -0700
X-Authority-Analysis: v=2.1 cv=dfgTgxne c=1 sm=1 tr=0
 a=GcR8MKwCKDX7fzHfRD/fNg==:117 a=GcR8MKwCKDX7fzHfRD/fNg==:17 a=cNaOj0WVAAAA:8
 a=f5113yIGAAAA:8 a=IkcTkHD0fZMA:10 a=pBbsfl06AAAA:8 a=cdVwids0oJMA:10
 a=2NV5t7OSZ7cA:10 a=5y4faFyK3SkA:10 a=uZvujYp8AAAA:8 a=M24uMKvO1RJT9yKdvm0A:9
 a=QEXdDO2ut3YA:10 a=1HKXXHNaku4A:10 a=wmmLBvuHnAUA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mad-scientist.net; s=default;
	h=Content-Transfer-Encoding:Mime-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID; bh=z8dxCO2QRWw3etcO7An+3suaNDYHuxVkS4H9uVRR8p4=;
	b=NduHFaxCZtGaYx8B98aezJ+ErEgO79Wl//mlJN8P+y/AEI84AoDF3xv1mL2ylVENUkIu7J7nDIOm5v7uX62BKG6DSJVaeIFA/BGAX4sP1NW78+CfqKywLbcIXPDo6KVz;
Received: from [173.9.45.73] (port=35189 helo=pdsdesk)
	by box531.bluehost.com with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.82)
	(envelope-from <paul@mad-scientist.net>)
	id 1XqpnJ-0005B0-8u; Tue, 18 Nov 2014 13:54:37 -0700
In-Reply-To: <xmqq8uj8wbhl.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.7-0ubuntu1 
X-Identified-User: {678:box531.bluehost.com:madscie1:mad-scientist.us} {sentby:smtp auth 173.9.45.73 authed with paul@mad-scientist.us}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2014-11-18 at 12:15 -0800, Junio C Hamano wrote:
> Paul Smith <paul@mad-scientist.net> writes:
> 
> > Getting rid of ls/wc was not as simple as I'd hoped,
> 
> I didn't say ls/wc was not portable.  Assuming that a directory for
> which the output from "ls -a" has two entries is empty may be.

Yes, I didn't get your email before I sent the latest patch.  Sorry
about that.

On Tue, 2014-11-18 at 11:32 -0800, Junio C Hamano wrote:
> Even on network mounts from esoteric filesystems and such?  When
> 
>     http://pubs.opengroup.org/onlinepubs/9699919799/utilities/ls.html
> 
> mentions the "-A" option, it says:
> 
>     -A
>         Write out all directory entries, including those whose names
>         begin with a <period> ( '.' ) but excluding the entries dot
>         and dot-dot (if they exist).
> 
> The "if they exist" part suggests, at least to me, that it is valid
> for a POSIX filesystem to lack these two (I suspect that one may be
> able to find a more definitive answer from other parts of the POSIX
> but I didn't bother).

Hm.  Well, POSIX clearly reserves "." and ".." to be special and
requires that directories containing only those values are considered
empty (rmdir(2) says so).  The definitions section contains special
wording for "dot" and "dot-dot".

Looking at
http://pubs.opengroup.org/onlinepubs/9699919799/xrat/V4_xbd_chap04.html

        Each directory has exactly one parent directory which is
        represented by the name dot-dot in the first directory.

which implies that every directory must have "..".  This is in the
Rationale, I realize.

There are also various mentions to using "." as a synonym for the
current directory.

I can't find a clear statement that both are required and that "ls -a"
must show them.  I've used a wide range of UNIX-en and filesystems for
30 years or so and never seen one that didn't provide them.  It seems
like it would break quite a few scripts, at least.  Even virtual
filesystems like ClearCase's MVFS provide "." and "..".

If you want to allow for this possibility I can do so but it would be a
bit crufty.  Personally I think it would be overkill but you're the
boss: let me know :-).

Cheers!
