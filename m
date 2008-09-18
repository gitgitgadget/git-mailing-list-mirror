From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: failure doing massive revert
Date: Thu, 18 Sep 2008 14:26:59 -0400
Message-ID: <32541b130809181126v4ba4acd7pc5bda085740ab6ba@mail.gmail.com>
References: <1221728946.8516.14.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: "Mike Galbraith" <efault@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 18 20:28:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgOEe-0004P2-FS
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 20:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756731AbYIRS1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 14:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756683AbYIRS1D
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 14:27:03 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:42283 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756595AbYIRS1B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 14:27:01 -0400
Received: by gxk9 with SMTP id 9so31644628gxk.13
        for <git@vger.kernel.org>; Thu, 18 Sep 2008 11:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=1YqeV1Qj0uw295DxmLkcYPighDzm1ejUVGkb12SoVTM=;
        b=kNdM/gj0r5kswxiVa4YcUkTIMLDnMU7PSjx65h8M9VjUWw0y6by8gPYHJoAsT04/ol
         EUy6qwgrxaQO5fbWqsI/DvyF3hNRgKH+cMGU2RHjGXGe+4nf+mZ0qaamPodfbd06+gZ/
         1G28xusESWA1zdHeewafpbKaYBY9470pSm6V0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=AVvJFf6ZJkgQZFU2Y7n6vlWLhBsMMHA4cPrVdUCA2Y10QBoRXBO3Ybn2EE7hbrbISN
         vO26/M2v0TIrRULFmgWEObP2SpxzHknWF3X7XgQtd484tejwyVYN4ukls5JJlkb/loUs
         o56GUZguza+GEgceB24FQzvtEokqw3Jn1zrSw=
Received: by 10.150.155.13 with SMTP id c13mr1714729ybe.164.1221762419588;
        Thu, 18 Sep 2008 11:26:59 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Thu, 18 Sep 2008 11:26:59 -0700 (PDT)
In-Reply-To: <1221728946.8516.14.camel@marge.simson.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96235>

On Thu, Sep 18, 2008 at 5:09 AM, Mike Galbraith <efault@gmx.de> wrote:
> For reasons I'd rather not go into, I decided to create a merge free
> tree to try to bisect.  I did this yesterday for a smaller range, and it
> worked fine, and I was able to revert the reverts to re-apply.  Trying
> to revert everything from v2.6.26..today croaked.
>
> for i in `git rev-list --no-merges v2.6.26..HEAD`; do git revert $i < /dev/null; done

Hmm, I don't think you can revert every single patch on a merged tree
that way for the same reason you can't just rebase it: history wasn't
linear.

I think something involving 'git rev-list --first-parent' and some
variant of "git diff $i $i^ | git apply" might work better, as it
would inherently squash merge commits, thus making them linearly
reversible (although throwing away large parts of history).

Throwing away history might not be what you want, but then again,
maybe it is.  It's the only way I know of to 100% reliably linearize
the history, anyway.

Also, if you use "&& done" instead of "; done" then it'll abort right
away when it has a problem.

Have fun,

Avery
