From: "Elijah Newren" <newren@gmail.com>
Subject: Re: Trying to use git-filter-branch to compress history by removing large, obsolete binary files
Date: Sun, 7 Oct 2007 16:24:49 -0600
Message-ID: <51419b2c0710071524q16e9c593s2722dffc826e560d@mail.gmail.com>
References: <51419b2c0710071423y1b194f22gb6ccaa57303029d1@mail.gmail.com>
	 <20071007213817.GJ31659@planck.djpig.de>
	 <51419b2c0710071500x318ee734n9db6ca9e6daa3196@mail.gmail.com>
	 <20071007221920.GF2765@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Frank Lichtenheld" <frank@lichtenheld.de>, git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 00:25:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeeYY-0004Sq-I9
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 00:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756188AbXJGWYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 18:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756031AbXJGWYv
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 18:24:51 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:59802 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755975AbXJGWYu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 18:24:50 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1444826wah
        for <git@vger.kernel.org>; Sun, 07 Oct 2007 15:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=zNTr0kE8bXMG50+XWjsy/wKpSVlU/+6QtC4CDsqWyOs=;
        b=FwVuIFHOjq+guUId3vGLyIKKRYJFUCEF1rIMh4I4gAr5+8UclWJrhG4jClmLb9p9puNKMUk6VPeGIqCSgueMPnJkHfuvrAsXe3n8T40UsO1duuDtt51MPHVRfPy4ppc85XRMReC6j4fkta/M7KMLYEDaV/+l2T1l/+5SW6ismZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KZk+y2d3nKk3tLvzY0UxgwHGRAgOoO3p+XSwsRGdADefJzHQ/xzIDvmaCs3U6T8w6O0ZAMe319aW/iwe2n76doZdJiMFFLT/GCrBmlRyxDw1BaUudA54otLOcS4XZINbn1cORKKNWl6wctBM/gJtrdFdyA/lKAYRQqSKnKFhTe0=
Received: by 10.115.88.1 with SMTP id q1mr10017003wal.1191795889267;
        Sun, 07 Oct 2007 15:24:49 -0700 (PDT)
Received: by 10.114.211.8 with HTTP; Sun, 7 Oct 2007 15:24:49 -0700 (PDT)
In-Reply-To: <20071007221920.GF2765@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60233>

On 10/7/07, Alex Riesen <raa.lkml@gmail.com> wrote:
<snip>
> rm -rf .git/refs/original/refs/heads/<the branch where HEAD pointed to>
> (assuming you haven't repacked yet)
>
> or just edit .git/packed-refs and remove everything "refs/original"
> which fits the criteria
>
> > So...how do I fix the reflog, and then repack to have a
> > pack under 11MB in size?
>
> git reflog expire --all (it is a bit to much. You can just edit
> .git/logs/* in any text editor)

So...

$ du -hs .
11M     .
$ rm -rf .git/refs/original/
$ vi .git/packed-refs
# Remove the line referring to refs/original...
$ git reflog expire --all
$ git gc --aggressive --prune
$ du -hs .
11M     .

It's still 11MB.

Any other ideas?

Elijah
