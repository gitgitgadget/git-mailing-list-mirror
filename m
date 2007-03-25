From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Convert emailing part of hooks--update to hooks--post-receive
Date: Sun, 25 Mar 2007 08:51:02 +0000
Message-ID: <200703250951.04503.andyparkins@gmail.com>
References: <200703231023.58911.andyparkins@gmail.com> <200703241550.05590.andyparkins@gmail.com> <7vfy7tajiz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 25 10:54:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVOUK-0005RQ-TW
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 10:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484AbXCYIx5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 04:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753493AbXCYIx5
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 04:53:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:32655 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753484AbXCYIxz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 04:53:55 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1348804uga
        for <git@vger.kernel.org>; Sun, 25 Mar 2007 01:53:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GkQd9h3ZUDUVv4wYodKp0Er2a1i3+gbH4l2/lX/Tj1BHHU2vaf+9xgVMZBsY9zhRB6YbwVitGIDEiJHkXtMoX//NlSbPTttbzT6FWC0VMlYYuPrRfyGbi9zbsuuXXlGVdswkH1DbGyPKCgxuo8A/jNCUMZBJ9Ez+D3uXKg0iPk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TCl5e5i3fBj5uMbIdEge6zjUzIie18RLgjB5Qm0Ppg6Z6hzUTFFv9bddxpYVIA5bKzt1pIuiFc1t9VJ111By8MRUspyFbOg5bFk/3M0eSl72xY+W6NlYC4PIVRz+h76coeyo75nw7M0RfmHwJ8Kt/UrokznCG3d+N1lQTLINvIU=
Received: by 10.66.249.16 with SMTP id w16mr10029662ugh.1174812834735;
        Sun, 25 Mar 2007 01:53:54 -0700 (PDT)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id k1sm6697794ugf.2007.03.25.01.53.53;
        Sun, 25 Mar 2007 01:53:54 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <7vfy7tajiz.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43043>

On Sunday 2007, March 25, Junio C Hamano wrote:

> I think you can do something along the following line.
>
>  (1) You say "for-each-ref --all" to get the ref information
>      that is after update.

Would you mind if I delayed that to a separate patch?  It's a 
significant difference from the original update hook, so I think it's 
worth having that change separately documented.

> Sorry, what I meant was:
>
> 	git show -s --pretty=oneline "$oldrev"

Ah - no problem.  Done.

> Actually it was not quite "nicely done".  If taggername has an
> unusual character then dq pair you hard coded there may not
> quote the string correctly.

Devious.  Fixed as you suggest.

> > (Andreas Ericsson   54)  prev=$(git describe "$3^" | sed
> > 's/-g.*//')
>
> You could describe all the parents and see if they differ.  If
> they reach different tag, we could see which one is newer.  Or
> something like that.  In the special (but usual) case of a
> single parent commit, "describing all the parents" is what you
> are already doing, so it is not any more expensive in the normal
> case.

Again; I think I'll fix that one as a separate patch as it is a change 
from the behaviour of hooks/update.

> Please do not have cat on either side of a pipe.  That makes a
> shell script look ... eh, you know the word ;-).
>
> 	sed -e 1q "$GIT_DIR/description"

Done.  I've taken the liberty of adding a pipe-to-cat, that I hope 
you'll forgive...

# Output to the terminal in command line mode - if someone wanted to
# resend an email; they could redirect the output to sendmail themselves
  generate_email $2 $3 $1 | cat

This is to force the deactivation of the pager for all the git commands 
that generate_email calls.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
