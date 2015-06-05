From: Jonathan Kamens <jkamens@quantopian.com>
Subject: Re: [PATCH 3/3] stash: require a clean index to apply
Date: Thu, 4 Jun 2015 20:43:00 -0400
Message-ID: <5570F094.10007@quantopian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 02:43:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0fj2-0007by-G3
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 02:43:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430AbbFEAnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 20:43:04 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:34367 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbbFEAnC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 20:43:02 -0400
Received: by qkoo18 with SMTP id o18so33126858qko.1
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 17:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=b1breUBiBJjbk6w2YIjKJ3SvOx0NI9sCJEyWgnrj5Bk=;
        b=mXH5BimUM9fLSMRGQEQRavmndzOd8q7dxo5wYeeYWxC0cxJJ4BnZMG5EMeDG3pt57D
         57cNInhQqvbQEjGUlA2xA0+KiUpzfj3S5alXA8/adiYieR8lH906ZOz+E0dJAI2fe4dN
         5ynZiHcBm52iCG+EcxSFE6344EgbQv1Y1XaS7Kwpcc2zOWy8kDZ8I6rbAEv2Il+6WMJC
         y0uQt/ZZ09DYs40Z8ajvJOzQKIYaGbqr7kqbzFP3K2n9lUoR/+2Zc/he18BNYAhlOT4y
         oP3iHsfLVt5nvLLYinONWBQb5+teyrCGZ/aPT+V6E0obKAdR6Sx7+10eUD3VctDbzgGm
         vT4w==
X-Gm-Message-State: ALoCoQkkkR0u/AvEkiJycMvjo/5yRb2x9crWIL30bsorSqIrkrW3+NR4HG95PNzCNyvT5FLics1q
X-Received: by 10.55.18.9 with SMTP id c9mr1619646qkh.50.1433464981874;
        Thu, 04 Jun 2015 17:43:01 -0700 (PDT)
Received: from jik2.kamens.brookline.ma.us (146-115-42-232.c3-0.abr-ubr1.sbo-abr.ma.cable.rcn.com. [146.115.42.232])
        by mx.google.com with ESMTPSA id c80sm3303241qge.49.2015.06.04.17.43.01
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jun 2015 17:43:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:41.0) Gecko/20100101
 Thunderbird/41.0a1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270809>

I'm writing about the patch that Jeff King submitted on April 22, in 
<20150422193101.GC27945@peff.net>, in particular, 
https://github.com/git/git/commit/ed178ef13a26136d86ff4e33bb7b1afb5033f908 
. It appears that this patch was included in git 2.4.2, and it breaks my 
workflow.

In particular, I have a pre-commit hook whith does the following:

1. Stash unstaged changes ("git stash -k").
2. Run flake8 over all staged changes.
3. If flake8 complains, then error out of the commit.
4. Otherwise, apply the stash and exit.

This way I am prevented from committing staged changes that don't pass 
flake8. I can't imagine that this is a terribly uncommon workflow.

This worked fine until the aforementioned comment, after which my hook 
complains, "Cannot apply stash: Your index contains uncommitted changes."

The reason I have to do things this way is as follows. Suppose I did the 
following:

1. Stage changes that have a flake8 violation.
2. Fix the flake8 violation in the unstaged version of the staged file.
3. Commit the previously staged changes.

If my commit hook runs over the unstaged version of the file, then it 
won't detect the flake8 violation, and as a result the violation will be 
committed.

If anyone has a suggestion for how I can achieve the desired goal within 
the constraints of the 2.4.2 version of git-stash.sh, I'd love to hear 
it. Otherwise, I'd like to ask for this patch to be reconsidered.

Thank you,

Jonathan Kamens
