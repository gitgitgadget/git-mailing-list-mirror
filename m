From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] git exproll: steps to tackle gc aggression
Date: Tue, 6 Aug 2013 19:24:50 +0700
Message-ID: <CACsJy8CGWJ07Uk8EBjfejdyshKB1NKk=_7VUoeyZWZgJFqCSkg@mail.gmail.com>
References: <1375756727-1275-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Tue Aug 06 14:25:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6gKM-0007Vs-8D
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 14:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756254Ab3HFMZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 08:25:22 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:60898 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756168Ab3HFMZV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 08:25:21 -0400
Received: by mail-ob0-f173.google.com with SMTP id ta17so629083obb.4
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 05:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3Papzx7DMcrNK3tV5IGVv4fCidg6t3bINO8YtGJ+4FM=;
        b=JWUNu7aHcqpGrtPzL+0teFmldJEwvdutBFTD7uKofVXIHwGaYfxyZ1BgJ1b63RR2AS
         U0I1EsQ3W7cX5oaHSUTNPLXh/iKxyuHeDJ4AHBFBsELjIVfp/UlYcT4TRvMNHpg+mIcl
         YkYwN7KdqkDufEFjWq7k6hILH2o9pg30fHHpAA4fFb4MgeLBT+Zq/3pHtOyIWqrwn8Vc
         Hq4/OhZIk6G/8JE4hKQEzPIzs3bTUeOFLl5vA0XwPxhoX+cScs6LmuEOEQNQ/Lc5vl2P
         /Te6e5bv1Q8QgyZVMCkoPFn729jr+h+zBM7s+sbuoOV2oI1mqjc0fbynW7aaIZkp80TT
         aH3Q==
X-Received: by 10.182.237.50 with SMTP id uz18mr812505obc.37.1375791920325;
 Tue, 06 Aug 2013 05:25:20 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Tue, 6 Aug 2013 05:24:50 -0700 (PDT)
In-Reply-To: <1375756727-1275-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231736>

On Tue, Aug 6, 2013 at 9:38 AM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> +               Garbage collect using a pseudo logarithmic packfile maintenance
> +               approach.  This approach attempts to minimize packfile churn
> +               by keeping several generations of varying sized packfiles around
> +               and only consolidating packfiles (or loose objects) which are
> +               either new packfiles, or packfiles close to the same size as
> +               another packfile.

I wonder if a simpler approach may be nearly efficient as this one:
keep the largest pack out, repack the rest at fetch/push time so there
are at most 2 packs at a time. Or we we could do the repack at 'gc
--auto' time, but with lower pack threshold (about 10 or so). When the
second pack is as big as, say half the size of the first, merge them
into one at "gc --auto" time. This can be easily implemented in
git-repack.sh.
-- 
Duy
