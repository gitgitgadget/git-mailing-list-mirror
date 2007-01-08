From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] cvsimport: skip commits that are too recent
Date: Mon, 8 Jan 2007 20:17:25 +1300
Message-ID: <46a038f90701072317h9bede00o939d4c078ccd569c@mail.gmail.com>
References: <11682386193246-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jan 08 08:17:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3olD-0001CZ-SH
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 08:17:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161176AbXAHHR0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 02:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161174AbXAHHR0
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 02:17:26 -0500
Received: from wx-out-0506.google.com ([66.249.82.237]:17290 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbXAHHR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 02:17:26 -0500
Received: by wx-out-0506.google.com with SMTP id h27so7951867wxd
        for <git@vger.kernel.org>; Sun, 07 Jan 2007 23:17:25 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tCcniKkNFF8FsdvSRiKKoqkh9cyOfBinfnrNhNgFC4jeGSJjP36yKtlxN7OgeB7kEZwv/UT5dwm8tUJO4y60yLtxo3KJrjvWPml7+G8DLMotswmrqCNRMUfH60okStvIvgxBQr7gv2nR57EpzBScwByGUsDzQ6EaABxk/W86V68=
Received: by 10.90.105.20 with SMTP id d20mr1901846agc.1168240645486;
        Sun, 07 Jan 2007 23:17:25 -0800 (PST)
Received: by 10.90.28.1 with HTTP; Sun, 7 Jan 2007 23:17:25 -0800 (PST)
To: git@vger.kernel.org, junkio@cox.net
In-Reply-To: <11682386193246-git-send-email-martin@catalyst.net.nz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36240>

On 1/8/07, Martin Langhoff <martin@catalyst.net.nz> wrote:
> With this patch, cvsimport will skip commits made
> in the last 10 minutes. The recent-ness test is of
> 5 minutes + cvsps fuzz window (5 minutes default).

Here is the repost with appropriate doco and an override ;-)

In related news, I am trying to debug an import that consistently
skips over remote commits... which is bad, bad news. The culprit seems
to be cvsps -- it skips commits it clearly knows about, and I'm not
sure why. I do think those were commits that cvsps saw half-baked in
the first place.

Passing -x to cvsps does bring those commits back, cvsps with -x can
afford to rewrite history a little bit. As long as the history being
rewritten is not too old we are safe. So with this patch, passing -x
is safer, assuming that 10 minutes is enough of a time window for
cvsps to change opinion about the project history.

 (Before you ask: from a data correctness, this is a fine mess.)

For this repo, I'll start running cvsimport with -o ' -x ' and see how
it behaves. Time-wise, the bandwidth usage and cpu times are roughly
similar for me using --cvs-direct. The patch to do it by default in
cvsimport is trivial, but I'm not entirely happy with the concept just
now.

In any case -- this should be a bit of a warning. cvsps is not
particularly reliable (not that cvs data ever is!), and passing -o '
-x' may help.

cheers,


martin
