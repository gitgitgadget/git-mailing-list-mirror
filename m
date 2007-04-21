From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Possible bug in --short option of git-rev-list
Date: Sat, 21 Apr 2007 12:03:38 +0200
Message-ID: <e5bfff550704210303u195c6c3cub0df34b5e862a0c5@mail.gmail.com>
References: <e5bfff550704210232v7a214aa7jc5f55fe26edbf8e3@mail.gmail.com>
	 <7vps5yul49.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 21 12:03:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfCRT-0000Si-EY
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 12:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933112AbXDUKDk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 06:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933114AbXDUKDk
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 06:03:40 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:45000 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933112AbXDUKDj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 06:03:39 -0400
Received: by an-out-0708.google.com with SMTP id b33so1235265ana
        for <git@vger.kernel.org>; Sat, 21 Apr 2007 03:03:39 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SBSxJl+NWD/00Ri2dUuIP6ozLQ4sIhfnZRHH6vaN/n7Gke0Mhf1YqbL8h/vkCkZLhZt9/WHfeH31OX4QT7jtV3YT/tSbAcgv01xiCybbx7cNpHMXrq663V8AGtij2dnxC692oRomE97hZWez+FLL4WVlcUxEcf2puv0IlGBPr9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cssChJrnR2gwIT+uGGZkV7Qhi+x2P57xXsw7uZEfs9r1aUeCzvYrZ5oDuvOYzpQLFU/x6lw6M0XixsUekLBDF9R8JmJt3931fEij+wLXyApuid2CPk7/GBYtWOMF49yXFvcTBmfvsfzx4E9Y7LzwtPV+OU6mg8249ErxHtnLaJM=
Received: by 10.114.176.1 with SMTP id y1mr1643258wae.1177149818884;
        Sat, 21 Apr 2007 03:03:38 -0700 (PDT)
Received: by 10.114.61.6 with HTTP; Sat, 21 Apr 2007 03:03:38 -0700 (PDT)
In-Reply-To: <7vps5yul49.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45160>

On 4/21/07, Junio C Hamano <junkio@cox.net> wrote:
>
> Short is abbrev + verify.  This is not new.
>

In my implementation I pass command line arguments first to
git-rev-parse, and the output of git-rev-parse is then used to feed
git-rev-list, that starts loading of revisions.

The problem I found is that output of git-rev-parse could be veeery
long, as example in git tree:

$ git rev-parse --all | wc
    144     144    5904

When running qgit --all on a repo with hundreds of tags this could
lead to very long command line arguments for git-rev-list so to break
platform limits. One idea to *hide* this problem was to get only the
short version of a sha so to go from 40 to 7 chars and reduce command
line size of about 6 times.

Of course the *real* solution would be to pass qgit command line
arguments directly to git-rev-list and skip git-rev-parse altogether.

My question is: In case I skip git-rev-parse and feed directly
git-rev-list with command line arguments, there is some compatibility
break in current behaviour? In other words there are some command line
arguments 'args' for whom

                              git-rev-list args != git rev-parse args
| git rev-list


Thanks
Marco
