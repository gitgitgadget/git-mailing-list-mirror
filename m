From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFC] Enable 'check for copy and renames' (-C) also when path filtering
Date: Wed, 16 Aug 2006 22:49:17 +0200
Message-ID: <e5bfff550608161349t29a678ccl4b211cb570a1217d@mail.gmail.com>
References: <e5bfff550608160206w606008ddv2da42ce49e98fa2b@mail.gmail.com>
	 <7v8xlo4lht.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 16 22:49:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDSKO-0004SH-6F
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 22:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWHPUtT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 16:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWHPUtT
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 16:49:19 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:3008 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932214AbWHPUtS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Aug 2006 16:49:18 -0400
Received: by py-out-1112.google.com with SMTP id z74so1076081pyg
        for <git@vger.kernel.org>; Wed, 16 Aug 2006 13:49:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HOFL5a7e+JciZgKfzj+WjuPHf0W45DAkIesa3rKaCBSL4i8pbVWKps/lgQHBCIbJRLQTwFVaYGkqvVoTroCknIVPqSkKmXjCdSLjWJUIjhMxjnyaT/EtWXDMxYqjEV+fvD6S0PVuwBZDaWE5joZPzD6IaAw5cfrknffigJcqYdE=
Received: by 10.35.114.16 with SMTP id r16mr2116802pym;
        Wed, 16 Aug 2006 13:49:17 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Wed, 16 Aug 2006 13:49:17 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v8xlo4lht.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25527>

On 8/16/06, Junio C Hamano <junkio@cox.net> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> > It seems that -C option of git-diff-tree it works only if the whole
> > changeset is retrieved.
>
> Correct (sort of).  Pathspec works on the input side not on the
> output side.  It's been specified and worked that way from the
> beginning (check the list archive to see me arguing that it
> would be easier to use on the output side, and Linus vetoing
> because following a single file is not that interesting and the
> cost outweighs the benefit of that uninteresting case).
>
> Always feeding the whole tree is wasteful, but if we are
> interested in following a single file, we could do something
> like:
>
>  - follow that file and that file only from the recent to past;
>
>  - notice when that file disappears -- that is the point the
>    file was created.  it may have created from scratch, it may
>    have been renamed or copied.
>
>  - on that commit that creates the file, look at the whole tree
>    to see if we can find an origin.
>
>  - if we find that the file was created by renaming or copying
>    another, keep following that other file from that point on.
>

Yes, I was thinking about something like this, Thanks for point me out
this, now I am quite sure it's the correct way to go ;-)

   Marco

P.S: The first thing will be to teach qgit about renames and copies,
i.e. diff-tree with -C option. I'm cooking a patch on this.

BTW, regarding copies, there are only 6 (6973dca, 8752d11, 927a503,
2276aa6, ddafa7e9 and 7ef7692) in git tree, against 181 renames.
