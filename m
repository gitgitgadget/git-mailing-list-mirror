From: Paul Sokolovsky <pmiscml@gmail.com>
Subject: Re: git rebase is confused about commits w/o textual changes (e.g.
 chmod's)
Date: Fri, 4 Oct 2013 23:45:30 +0300
Message-ID: <20131004234530.3d3a54cc@x34f>
References: <20130924225648.48af3f4e@x34f>
	<20130927222807.GA18384@vauxhall.crustytoothpaste.net>
	<20130928023244.1ce16dc5@x34f>
	<20131004202853.GB4165@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Fri Oct 04 22:45:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VSCFp-0006OP-To
	for gcvg-git-2@plane.gmane.org; Fri, 04 Oct 2013 22:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754477Ab3JDUpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Oct 2013 16:45:35 -0400
Received: from mail-ee0-f49.google.com ([74.125.83.49]:60162 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754437Ab3JDUpe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Oct 2013 16:45:34 -0400
Received: by mail-ee0-f49.google.com with SMTP id d41so2023544eek.22
        for <git@vger.kernel.org>; Fri, 04 Oct 2013 13:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=goZ6bl1rgcdLX6hub68FntqPeCzv+lxcsLErFlfGqIs=;
        b=LivyrN9YqFPZ9KHLwpnoJ9aZyFEN2gkGDzR/fHcT8FC6DzOLtfs6kEZPXOixnWg65V
         GDM02VLsFcL9kr5DPqcpL8hU31zTd1U6LZjAIcSk1bS/CFjPm6spWvhLwq8l68rDncA0
         Y3/yRZdPNvwrWsJDxl15egsX+ySwx5beWsXYRrdnsY4B4dt+Xr2O92ln1+6bV1oTzmx7
         HxiDk+lGjoe85a2RIPGWjbz0CMGYERX6WhhGRzYSPNGAOWZiEaRhJxgsUpIxQAKPNjvv
         wbzIsHJSixkiCb8ZBKXLL82tyKh3PIFiOpDnC/thiTmEl+VK4R2T8quNEx2RrJ3wdfJ2
         +XzA==
X-Received: by 10.15.98.194 with SMTP id bj42mr24858586eeb.12.1380919533371;
        Fri, 04 Oct 2013 13:45:33 -0700 (PDT)
Received: from x34f ([95.15.202.117])
        by mx.google.com with ESMTPSA id r48sm31882048eev.14.1969.12.31.16.00.00
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Fri, 04 Oct 2013 13:45:32 -0700 (PDT)
In-Reply-To: <20131004202853.GB4165@vauxhall.crustytoothpaste.net>
X-Mailer: Claws Mail 3.9.1 (GTK+ 2.24.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235718>

Hello,

On Fri, 4 Oct 2013 20:28:54 +0000
"brian m. carlson" <sandals@crustytoothpaste.net> wrote:

> On Sat, Sep 28, 2013 at 02:32:44AM +0300, Paul Sokolovsky wrote:
> > $ git --version
> > git version 1.8.4
> > 
> > Specifically from Ubuntu PPA:
> > http://ppa.launchpad.net/git-core/ppa/ubuntu
> > 
> > 
> > Script to reproduce the issue is:
> > https://gist.github.com/pfalcon/6736632 , based on a real-world
> > case of merging histories of a fork created from a flat tree
> > snapshot with the original project it was created from.
> 
> Okay, as I suspected, the rebase would have resulted in an empty
> commit. In this particular case, the commit being rebased changed the
> permissions on the files, but those permissions are already correct,
> so the commit really is empty, even considering permissions.  It
> looks like git is doing the right thing here.

Hmm, ok, thanks for investigation!

But then, about this empty commit handling behavior by rebase.
Low-level developer in me understands the current behavior - if we
expect changes, but there're none, then it as well may be something
wrong, so let's not play smartass, but tell user outright what's
happening. But higher-level user in me knows that rebase is pretty
trusty nowadays, and real-world cause of empty commits during
rebase is that the change is already upstream. So, can we have
something like --skip-empty? Then some good time later, we can talk
about changing defaults ;-).


-- 
Best regards,
 Paul                          mailto:pmiscml@gmail.com
