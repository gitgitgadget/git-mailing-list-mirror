From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Subtree with submodule inside?
Date: Wed, 6 Aug 2014 15:08:32 -0700
Message-ID: <20140806220832.GA12427@google.com>
References: <CAHd499CaCeHYGZSQeY8MRVnnjXBTgDy=OUqBYqNd1e5GiKre_A@mail.gmail.com>
 <xmqqk36lmrpl.fsf@gitster.dls.corp.google.com>
 <CAHd499AmY+EYXAK8h_oYiOn-amnNrE1+a7qsQ4x7bCOVsJDxcw@mail.gmail.com>
 <53E28CAB.4040800@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Dailey <rcdailey.lists@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Aug 07 00:08:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF9Nx-0001JV-5E
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 00:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589AbaHFWIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 18:08:37 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:65224 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013AbaHFWIg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 18:08:36 -0400
Received: by mail-pa0-f51.google.com with SMTP id ey11so4191522pad.10
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 15:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=YDLvw2sP6fTvcZUptbyM4Zyp+Fn4zeogQVmx+7JV2QU=;
        b=n677Z96BScVa/bYDmUOZ5q4qZNT8R6nCsdT9SpmwxIvwHt2jFghj4i3PCvFwj40o0I
         boo1tNvN+OzZat4orMnH3MDJjMfSPlz0vbjrT5P3mTLsFqexLMOs86Oz6yXCve3Zoeuf
         GeOv8l4E/eim9ZSINmQtXHHeGqrSIdxyz9Iq806Rv1eY0IHgfVNDoS9ZS+wIq0RUX+M3
         j7tg8PfZj1bZ1IHGgy/eV6xvV1HFdMjZMCTwTZCIVIUcDOCR6Ze9XASLee7pl1i8aYbh
         lvjvns8+OSvrIwvUEKT3y+jUu74Z39znVXyB0zQRz8tpHbB71ChrQ/qjqdKGGcx05GLB
         MsAw==
X-Received: by 10.68.105.197 with SMTP id go5mr13721564pbb.73.1407362915999;
        Wed, 06 Aug 2014 15:08:35 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:6468:14d6:3fee:7b4e])
        by mx.google.com with ESMTPSA id bt5sm3313465pdb.95.2014.08.06.15.08.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 06 Aug 2014 15:08:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <53E28CAB.4040800@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254908>

Jens Lehmann wrote:

> There were thoughts about having "git branch" optionally create a
> branch in the submodule too. But in a lot of real world scenarios
> that won't help because the same branch name won't necessarily make
> sense in superproject and submodule at the same time

So, here is how I think git could behave to make that into a
non-issue:

 1. Commands like 'git checkout' able to recurse into submodules, so
    when you switch branches in the superproject, the files in the
    submodule are at the right commit, too.

    Luckily your series does that.  Ronnie was helping me with thoughts
    about how to simplify the patch a little, and I'd be happy to talk
    with or coordinate with anyone else interested (by email or on IRC
    --- I am jrnieder on Freenode).

 2. Submodules aware of their superproject and of the parent's branches.
    In other words, submodules would act as thought under refs/ they
    had a symlink

	parent -> ../../../refs

    So you could do

	git checkout --recurse-submodules master

	cd path/to/submodule
	git checkout parent/heads/next

    This would avoid danger from "git gc" in submodules and would
    get rid of most of the motivation for named branches in the
    submodule, I'd think.

 3. That's it.

Sensible?

Thanks,
Jonathan
