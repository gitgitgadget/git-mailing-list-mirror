From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] cvsserver: detect early of we are up to date and avoid costly rev-list
Date: Tue, 9 Jan 2007 15:39:46 +1300
Message-ID: <46a038f90701081839r5727c6a0qbcab1cb02dcef580@mail.gmail.com>
References: <11683086324018-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 09 03:39:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H46u0-0006tO-Bw
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 03:39:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbXAICjs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 21:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbXAICjs
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 21:39:48 -0500
Received: from wr-out-0506.google.com ([64.233.184.231]:46007 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbXAICjs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 21:39:48 -0500
Received: by wr-out-0506.google.com with SMTP id 71so1323179wri
        for <git@vger.kernel.org>; Mon, 08 Jan 2007 18:39:47 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZW86iSMfnwRiR3GTZ2fUNNSvDwGVYUoAP3YqQA26T1TJ2PxPDuAZpoE5MHarQRh/mlyOzE4RaN3/5hddUvpTpVbjG1ZA7/+OpLT1JuTZQT7wYYuO4Ug1AEHUeOD6W0d0S+Y3LQTOw5FiJbbJEG1PfTblMteJ2uCenL+Fh/z7w/c=
Received: by 10.90.116.6 with SMTP id o6mr2630477agc.1168310387000;
        Mon, 08 Jan 2007 18:39:47 -0800 (PST)
Received: by 10.90.28.1 with HTTP; Mon, 8 Jan 2007 18:39:46 -0800 (PST)
To: git@vger.kernel.org, junkio@cox.net
In-Reply-To: <11683086324018-git-send-email-martin@catalyst.net.nz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36298>

On 1/9/07, Martin Langhoff <martin@catalyst.net.nz> wrote:
> @@ -2194,6 +2197,10 @@ sub update
>      my $git_log;
>      my $lastcommit = $self->_get_prop("last_commit");
>
> +    if ($lastcommit eq $commitsha1) { # up-to-date
> +         return 1;
> +    }
> +
>      # Start exclusive lock here...
>      $self->{dbh}->begin_work() or die "Cannot lock database for BEGIN";

Actually, that generates a warning on the initial checkout. The fix is
to run the if as

  if (defined $lastcommit && $lastcommit eq $commitsha1) { # up-to-date

Junio -- is it easy for you to fixup  when you apply the patch?
Otherwise, I'll be happy to repost it patch.

cheers


m
