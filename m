From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Fetch from remote A, push to remote B
Date: Thu, 31 May 2007 19:28:39 +1200
Message-ID: <46a038f90705310028y6f180214s9018f8af5e71d0ed@mail.gmail.com>
References: <46a038f90705302253s68b70311h3feac7404fa23933@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 31 09:28:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Htf5W-0003Ez-1l
	for gcvg-git@gmane.org; Thu, 31 May 2007 09:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755714AbXEaH2l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 03:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755771AbXEaH2l
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 03:28:41 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:53469 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755714AbXEaH2k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 03:28:40 -0400
Received: by wx-out-0506.google.com with SMTP id t15so76120wxc
        for <git@vger.kernel.org>; Thu, 31 May 2007 00:28:40 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M/YbIkkIU38u96PmcZqF90xQZ9R/0iyGVIaPKXsVfKrn+iyCxbIynjDrA5fWakSvuATI5+9d/FOPpvbO/cMo7KMACAljh3AEQhxPYUq/iAbGw3zRV6Rim7PmkdwdrAQub3knhcAacFkAlPXWz8HXTnGIBOt3jx9KWut+PXHOB08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MD69WNj3H7Aw+h2fxl2d3q3sLyg/oFrNJMGqHJ3CBqixgc5KT+cKOgzuqmg2vxVxkY+W/iPXF+mWz8dYK5AIXGFHDAb7WTcA8Lk5N/5QEqp0zj8AQ/NQRdOZhRJw5HTOW1jzNeEWjehOal46Jcd34091+m8b+O4Tusvm2AUvTkw=
Received: by 10.90.87.5 with SMTP id k5mr118214agb.1180596519958;
        Thu, 31 May 2007 00:28:39 -0700 (PDT)
Received: by 10.90.53.18 with HTTP; Thu, 31 May 2007 00:28:39 -0700 (PDT)
In-Reply-To: <46a038f90705302253s68b70311h3feac7404fa23933@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48804>

On 5/31/07, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> Is there an easy way to get a "passthrough" repo setup so I can say on a cronjob
>
>   git-fetch remoteA
>   git-push ssh+git://host/path/to/repoB.git remotes/remoteA/<all>

After mucking about with stuff like...

find .git/refs/remotes/origin -type f -printf '%P\0' | xargs -0
-IHEADNAME git-push
git+ssh://git.catalyst.net.nz/var/git/moodle-r2-testing.git
origin/HEADNAME:HEADNAME

I figured out that a bare repo did the trick

  # set things up
  git-clone --bare git+ssh://host-a/bla.git bla-transfer.git

  # on cron do
  GIT_DIR=bla-transfer.git git-fetch git+ssh://host-a/bla.git
  GIT_DIR=bla-transfer.git git-push --all git+ssh://host-b/bla.git

cheers!


martin
