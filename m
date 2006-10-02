From: "Michael Cassar" <m.e.cassar@gmail.com>
Subject: Re: [BUG] 'git mv a/fileA b/fileB' causes 'c/fileC' to be deleted
Date: Mon, 2 Oct 2006 11:33:09 +1000
Message-ID: <750170aa0610011833n39271704q349d86af76832783@mail.gmail.com>
References: <750170aa0610010721p66899ba5pcc7efa13be4cd10a@mail.gmail.com>
	 <7vpsdc0wkz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 02 03:33:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUCgI-0007Yo-Vf
	for gcvg-git@gmane.org; Mon, 02 Oct 2006 03:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932585AbWJBBdL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 21:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932586AbWJBBdL
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 21:33:11 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:3036 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932585AbWJBBdK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Oct 2006 21:33:10 -0400
Received: by wx-out-0506.google.com with SMTP id s14so1553762wxc
        for <git@vger.kernel.org>; Sun, 01 Oct 2006 18:33:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ti3woND6SFIV2qbV05UQpRxRVtOOLae3bC38gFBcVUH7p0UuOkKPp3ONs/vlBpvSTyjTf79YTbUtZB8k2XCJ44WZj4uep5FGRq+uzzDPRa9toALUMGfrw6fBn79tVPIYTJ7vS+Sd4ZN0pbxsP7WE6/Kx5RLST7EV9Euu7bdpXEc=
Received: by 10.70.18.11 with SMTP id 11mr5695487wxr;
        Sun, 01 Oct 2006 18:33:09 -0700 (PDT)
Received: by 10.70.42.9 with HTTP; Sun, 1 Oct 2006 18:33:09 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vpsdc0wkz.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28210>

On 10/2/06, Junio C Hamano <junkio@cox.net> wrote:
> There could be a bigger problem, but it does not seem to easily
> reproduce as you noted in the message.  It could be that some
> unrelated thing in the working tree is playing a role in this
> breakage, but I do not think of offhand what that is.

> [...]  Care to show a bit more details
> on your working tree?

Okay, I should stop being lazy and actually produce a minimal test-case.

Here we go:

--CUT--
#!/bin/bash

git init-db

mkdir papers
mkdir papers/unsorted
mkdir papers/all-papers
mkdir partA
echo 'moo' > papers/unsorted/Thesis.pdf
echo 'cow' > partA/outline.txt
echo 'this file has brackets in its filename' > 'papers/unsorted/(brackets).pdf'

git add  papers partA
git commit -m 'intial commit'

git mv papers/unsorted/Thesis.pdf papers/all-papers/moo-blah.pdf
git commit -m 'move a file'

cg log -f
--CUT--

The problem seems to have come from the fact that a file in the source
directory of the move contained brackets in its filename.Removing the
file causes the problem to go away.

Hope this helps a little,

Mike
