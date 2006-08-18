From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Fri, 18 Aug 2006 09:15:10 -0400
Message-ID: <9e4733910608180615q4895334bw57c55e59a4ac5482@mail.gmail.com>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com>
	 <Pine.LNX.4.64.0608172323520.11359@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 18 15:18:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE4By-00044v-Q9
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 15:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbWHRNPO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 09:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWHRNPO
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 09:15:14 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:64205 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751024AbWHRNPM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 09:15:12 -0400
Received: by nz-out-0102.google.com with SMTP id x7so522655nzc
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 06:15:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PrfR/34gDOYA6yKjIhbgHtD1e3zvabXoxTm3zDjGTmSApOcl1yLzhqTstYsPqu195dfB7TyE7iysBLJQflyrFbKkTnh8mKlvm7629UdHH3bNGGVK8LvxhsmLspYSH8kDYtTcRNklFsdX41apcQ9AIk98yYObaZ2IGlWpMr8xugQ=
Received: by 10.64.193.8 with SMTP id q8mr2111804qbf;
        Fri, 18 Aug 2006 06:15:11 -0700 (PDT)
Received: by 10.65.133.17 with HTTP; Fri, 18 Aug 2006 06:15:10 -0700 (PDT)
To: "Nicolas Pitre" <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0608172323520.11359@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25660>

On 8/18/06, Nicolas Pitre <nico@cam.org> wrote:
> A better way to get such a size saving is to increase the window and
> depth parameters.  For example, a window of 20 and depth of 20 can
> usually provide a pack size saving greater than 11% with none of the
> disadvantages mentioned above.

Our window size is effectively infinite. I am handing him all of the
revisions from a single file in optimal order. This includes branches.
He takes these revisions, runs xdiff on them, and then puts the entire
result into a single zlib blob.

I suspect the size reduction is directly proportional to the age of
the repository. The kernel repository only has three years worth of
data in it.  Linus has the full history in another repository that is
not in general distribution. We can get it from him when he gets back
from vacation.

If the repository doesn't contain long delta chains the optimization
doesn't help that much. On the other hand it doesn't hurt either since
the chains weren't long.  My repository is four times as old as the
kernel one and I am getting 4x the benefit.

This is a good format for archival data that is infrequency accessed.
That is why I proposed a two pack system. One pack would contain the
archival data and be highly optimized for size and the second pack
would contain recent changes and be optimized for speed. The size
optimization is important for controlling bandwidth costs.

-- 
Jon Smirl
jonsmirl@gmail.com
