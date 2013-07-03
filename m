From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Feature request: prevent push -f from pushing all branches at
 once
Date: Wed, 3 Jul 2013 16:38:04 -0700
Message-ID: <20130703233804.GW408@google.com>
References: <ADE9FE42-FC10-4976-8E6A-290B101DD17A@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dany <nessup@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 04 01:38:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuWco-0003Vr-Sa
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 01:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756043Ab3GCXiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 19:38:10 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:63358 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754099Ab3GCXiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 19:38:09 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa11so720679pad.33
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 16:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=sWxqYXaptfk4jogA5m0+vPgTHDVt1qwtRtBdcSsfadM=;
        b=v88bQ5jMeVJECBEy733I116snv4VqVOoAHAW3BKRLv6vFFvaDYsKjqQspAiqlSxAGA
         aRlxz++VnAvHb/vWXLmoCzHnySxpDWJA3ZGCDusQgc0h3muUIjNWUOfZyGDLhPTH9lCU
         fnuqXEfXoh/mpNMFR1YCDJJx1J7pNWNu1fpUuOk409PdXeJ5xAXDGV7q7BT0jaAUJ/DE
         DcWyH/SbBFEodIGIoncgDxgL7hXb/Xxz8+j+u4D3VrGz68rV6M7IjtG/U5/w4SX+8oWL
         1fHm4hSWz2JxK4CNSi9WgqwXgurquKPQXdiT65mhN9WqFT0xQrr9Pv/JV8zcgkZgPE1M
         oNoA==
X-Received: by 10.68.69.108 with SMTP id d12mr2826167pbu.187.1372894688662;
        Wed, 03 Jul 2013 16:38:08 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id zn4sm655579pac.21.2013.07.03.16.38.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Jul 2013 16:38:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <ADE9FE42-FC10-4976-8E6A-290B101DD17A@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229547>

Hi Dany,

Dany wrote:

> I had a pretty sucky thing happen to me today: while remote tracking
> a non-master branch, I force pushed. This had the intended effect of
> force pushing the branch I was working on, but also the unintended
> function of force pushing all branches I wasn't on.

Yeah, I agree that this is lousy.

When you run "git push" or "git push -f" without further arguments,
current versions of git print a long message:

| $ git push
| warning: push.default is unset; its implicit value is changing in
| Git 2.0 from 'matching' to 'simple'. To squelch this message
| and maintain the current behavior after the default changes, use:
| 
|   git config --global push.default matching
| 
| To squelch this message and adopt the new behavior now, use:
| 
|   git config --global push.default simple
| 
| See 'git help config' and search for 'push.default' for further information.
| (the 'simple' mode was introduced in Git 1.7.11. Use the similar mode
| 'current' instead of 'simple' if you sometimes use older versions of Git)

This is intended as a warning that git is not necessarily going to
push the branches that you intended, with instructions for teaching
git what you actually meant.  For historical reasons (to support
habits and scripts) the current default is the "push matching
branches" behavior you ran into, but in the future the default will be
a more conservative "push the current branch, and only if it is
configured to pull from the matching branch", allowing this long
message to go away.

What version of git are you using?  Any ideas about how that message
could be improved?  (Perhaps it is too long to work as an effective
warning.)

Thanks and hope that helps,
Jonathan
