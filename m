From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Missing Refs after Garbage Collection
Date: Sun, 23 Dec 2012 01:26:53 +0300
Message-ID: <CAHkcotjJ8nyPVEbDFcGVYqirY4HBNBPN-PNCMriLyeU8iBEKXg@mail.gmail.com>
References: <C0A16EC8-D05A-41D0-BF2A-34BF3B1B839E@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Earl Gresh <egresh@codeaurora.org>
X-From: git-owner@vger.kernel.org Sat Dec 22 23:32:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmXcI-0004T7-TM
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 23:32:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227Ab2LVW04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 17:26:56 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:34089 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071Ab2LVW0z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 17:26:55 -0500
Received: by mail-ie0-f176.google.com with SMTP id 13so7722835iea.21
        for <git@vger.kernel.org>; Sat, 22 Dec 2012 14:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4vrPikJY9NUPM+2N0zeN/rtGmf89S0TsDhfuAYoPidI=;
        b=hMjItNJ4mpOns3l7z3GnsBYIzn9SC5yWKIErfJpWcYzEqYXRK5A/en7qAyklndYS+z
         EwB10oJV6Pj7eC3pUDeKhY3KAPAGmVn9LoSmk9ANTulZDt9B1vPyD4FJvhQLHPjsYwYj
         qt/az9ENeK2kEup59OZ9M8SII9hJd97cVof1trp0rKvufj0l0o6Qw9urtfwvRkfm2Qm5
         qc4JJcf/pP+qQ5QZpOytsiXZtV73NTJvMFRWlP5ct8BsCqMwm7VojdLiwNj959MBKq8i
         wDgbCzOznUVBO0qYEYOnf/FoKW8HFSS+plkVR5q4fGnTMWPiWd3XTnCKSPitLEGD4dzE
         AROA==
Received: by 10.50.11.226 with SMTP id t2mr11952985igb.99.1356215213445; Sat,
 22 Dec 2012 14:26:53 -0800 (PST)
Received: by 10.43.92.194 with HTTP; Sat, 22 Dec 2012 14:26:53 -0800 (PST)
In-Reply-To: <C0A16EC8-D05A-41D0-BF2A-34BF3B1B839E@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212072>

Hi,

On Sat, Dec 22, 2012 at 5:41 AM, Earl Gresh <egresh@codeaurora.org> wrote:
>
> Is anyone familiar with git gc deleting valid references? I'm running
> git version 1.7.8. Have there been any patches in later git releases
> that might address this issue ( if it is a git problem )?

I have not seen any relevant changes in git. I have looked at the code,
and what git-gc is running "git pack-refs --all --prune", which is very
careful in packing and fsyncing the new file with all packed references
before deleting anything. Only those references that were packed can be
deleted. Also, it does not matter whether a reference is valid or not,
or whether it is stored in refs/changes or in some other place, like
refs/heads. So if references were really lost as you described, I think
other people would notice that by now.

The only plausible explanation that comes to my mind now is that file
creation using O_EXCL is not atomic on your system, then the lock did
not work and one process could overwrite packed references created by
another.


Dmitry
