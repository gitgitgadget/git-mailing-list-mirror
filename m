From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG?] Patches created with 'diff.noprefix=true' don't 'git
 apply'.
Date: Mon, 5 May 2014 18:59:27 -0700
Message-ID: <20140506015927.GV9218@google.com>
References: <CAO8RVvdgN3U5hUEsJjYY9urfeVUDWwHiEur4NQp=H93W37RRnw@mail.gmail.com>
 <20140501024042.GX9218@google.com>
 <CAO8RVveV4SgXmJzWpYnyB3rnQALQkrrLNtLL5Ej5Y9Mjjekmmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Nathan Collins <nathan.collins@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 20:00:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiGq-0007Xo-0X
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:31:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933667AbaEFB7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 21:59:33 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:43331 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933507AbaEFB7d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 21:59:33 -0400
Received: by mail-ie0-f175.google.com with SMTP id rl12so9057080iec.34
        for <git@vger.kernel.org>; Mon, 05 May 2014 18:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=IKCAPU5tCXrQiB34kQGgvTJfgeXTHS+P36Rf6E/5JTs=;
        b=BPQPh07/qAP27DAzEFiv8x3YoIWGvw3xK6WK9SjddEA+rB2Cax+Y0hIqcygZ349ctN
         M9o2p9XmCUGkAXOFC9UI5RhJcnpFXkWyt9Z5wumveBe25CQTZcI40Uiy60xS/WreBQg4
         PI3KivR1UTMEAz1bmPOfUEzDLnv6XtXjI8UWG5ZLyhkpe9/OQPver7Ni48NIljRff3Hu
         pHjF0IzClacV7XPeNM5zId055X/UOOARM3tbdJuFUHgdg/RZzAG1ibJgASbzfJW4LtV7
         CUl+IylgCkJEtTNNaSf61egSd66KZKrCgvgQmZ9wcdbn4zqt8c3Mc2H/kx/Y+Ev7Kvr5
         nT9g==
X-Received: by 10.43.65.145 with SMTP id xm17mr7854036icb.44.1399341572691;
        Mon, 05 May 2014 18:59:32 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id kr5sm33145333igb.9.2014.05.05.18.59.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 05 May 2014 18:59:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAO8RVveV4SgXmJzWpYnyB3rnQALQkrrLNtLL5Ej5Y9Mjjekmmw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248198>

Nathan Collins wrote:
> On Wed, Apr 30, 2014 at 7:40 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Nathan Collins wrote:

>>> git show | git apply --reverse
>>
>> The following which only uses plumbing commands should work:
>>
>>         git diff-tree -p HEAD^! |
>>         git apply --reverse
>
> Nice! However, I don't now how to generalize this solution to other
> (probably insane) use cases, e.g.
>
>   git log -S<string> --patch | git apply --reverse

This should do it:

	git rev-list HEAD |
	git diff-tree --no-commit-id -p -S<string> --stdin |
	git apply --reverse

More generally, when scripting plumbing commands tend to do the right
thing.

Will think more about the documentation and other parts (or if someone
else sends a patch before I can, I won't mind).

Thanks,
Jonathan
