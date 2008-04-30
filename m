From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: [PATCH] cvsimport: always pass user data to "system" as a list
Date: Wed, 30 Apr 2008 08:30:42 +0100
Message-ID: <320075ff0804300030q227cee39w28bfb8456a97995f@mail.gmail.com>
References: <20080430043614.GA31019@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 30 09:31:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr6ms-0002dS-Ij
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 09:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754463AbYD3Har (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 03:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755007AbYD3Har
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 03:30:47 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:34430 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754280AbYD3Haq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 03:30:46 -0400
Received: by fg-out-1718.google.com with SMTP id 19so53454fgg.17
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 00:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=gcKgCkMH7CVWneQwTgp+lD/SBI/VTrh83ftIRR5En3A=;
        b=HS4hhuVIWb517twNMAZR9kpSoOf4236zTmAmCQUewCJy4RW9MEs0OyMOrhluPPRZQidGZWDnxxcsjhaCTHhQMJ7+Fgz3Vqk56Myx3UD6avrM6/j1Dsb76SgcEADekjk9H+zs93Wk9MiVSWKSAl8HxKVnOsftFVjcbJXUHnQMP3A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E1/NhQ3phGan3g9ybOoCSY6SL7jvIS05f0vWxh6TNMKnXE7Q8y6ljB4/t4Kw3ZvZe+vm601+nOjbITVkPmjKluDVwq+q9IsZ2S/6QZlDsLnf1xZHBOc0h6aP9Tc2c7cfmRhjFi1D8jZN66i3ACng4Kdcj3lGxFUd/q8mdL0cy4s=
Received: by 10.82.105.1 with SMTP id d1mr29731buc.26.1209540642629;
        Wed, 30 Apr 2008 00:30:42 -0700 (PDT)
Received: by 10.82.168.20 with HTTP; Wed, 30 Apr 2008 00:30:42 -0700 (PDT)
In-Reply-To: <20080430043614.GA31019@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80804>

This fixed my import problem - thanks for the swift identification (my
perl isn't so hot so it scared me :) )

On Wed, Apr 30, 2008 at 5:36 AM, Jeff King <peff@peff.net> wrote:
> This avoids invoking the shell. Not only is it faster, but
>  it prevents the possibility of interpreting our arguments in
>  the shell.
>
>  Signed-off-by: Jeff King <peff@peff.net>
>  ---
>  Nigel reported a problem with a CVS branch that had '(' in the name. No
>  report yet on whether this fixes it, but it should be done regardless.
>
>  I checked over git-cvsimport.perl, and this was the only instance I
>  found.
>
>   git-cvsimport.perl |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
>  diff --git a/git-cvsimport.perl b/git-cvsimport.perl
>  index 95c5eec..bdac5d5 100755
>  --- a/git-cvsimport.perl
>  +++ b/git-cvsimport.perl
>  @@ -772,7 +772,7 @@ sub commit {
>         waitpid($pid,0);
>         die "Error running git-commit-tree: $?\n" if $?;
>
>  -       system("git-update-ref $remote/$branch $cid") == 0
>  +       system('git-update-ref', "$remote/$branch", $cid) == 0
>                 or die "Cannot write branch $branch for update: $!\n";
>
>         if ($tag) {
>  --
>  1.5.5.1.178.gc1eb9.dirty
>
>
