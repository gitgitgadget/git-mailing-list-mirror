From: "Suraj N. Kurapati" <sunaku@gmail.com>
Subject: Re: [PATCH/RFC v3] git add -i: Answer questions with a single keypress
Date: Thu, 6 Nov 2008 08:15:16 -0800
Message-ID: <200811060815.16797.sunaku@gmail.com>
References: <200811042215.31147.sunaku@gmail.com> <200811050959.25824.sunaku@gmail.com> <20081106084230.GA4407@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 06 17:16:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky7X9-0007cL-4Y
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 17:16:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbYKFQPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 11:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbYKFQPU
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 11:15:20 -0500
Received: from rv-out-0506.google.com ([209.85.198.237]:63855 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbYKFQPU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 11:15:20 -0500
Received: by rv-out-0506.google.com with SMTP id k40so771827rvb.1
        for <git@vger.kernel.org>; Thu, 06 Nov 2008 08:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=rPXW+hoo6XuMWnJOZV2LDyKxBq5N/KeRbIeeqZNvTbY=;
        b=AWD/uckZCQJPvJMFkGwcWYTXufhtpmq9FH6t4KrR61JN7nf8h9mLyOTKUYrXCwCXoN
         0gZQ2sSetmfIk1Uko6veD/iF78LSXu8GnvZy3wqc8SIRSeQd/9I3ogGwxEIJyn1uTJ2F
         uEwIay783plj/8R8khYKm13Ayqom5BcP6DvA8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=XlwMmEdcikVgvhuE7e/3wuVJM6XSSoZ740BFbawc9Wx+SUCU/KOcH1y54cc++XV9ca
         Y8yJFUTgJc7+3c8bigr+GpHgfg/ZpVy4hQvTUc/e8dzotpfNVyN10bJotk94dIbEaB3J
         dTcVKryEQU/BH6fU36nwjsQpGzbJRtozupcEQ=
Received: by 10.141.49.18 with SMTP id b18mr1280500rvk.96.1225988119364;
        Thu, 06 Nov 2008 08:15:19 -0800 (PST)
Received: from yantram.localnet (adsl-76-221-202-142.dsl.pltn13.sbcglobal.net [76.221.202.142])
        by mx.google.com with ESMTPS id b8sm4777443rvf.3.2008.11.06.08.15.18
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 06 Nov 2008 08:15:18 -0800 (PST)
User-Agent: KMail/1.10.1 (Linux/2.6.27-ARCH; KDE/4.1.2; i686; ; )
In-Reply-To: <20081106084230.GA4407@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100243>

On Thursday 06 November 2008 00:42:36 Jeff King wrote:
> On Wed, Nov 05, 2008 at 09:59:25AM -0800, Suraj N. Kurapati wrote:
> > Allows the user to answer 'Stage this hunk' questions with a
> > single keypress, just like in Darcs.  Previously, the user was
> > forced to press the Return key after every choice they made.
> > This quickly becomes tiring, burdensome work for the fingers.
>
> I think this is a reasonable goal, but I have a few questions/concerns.
>
>  - There are three versions of your patch, but nobody has commented.
>    Clearly we can see what changed, but it is not clear what advantage
>    one patch has over the other. Care to elaborate?

v1 and v2 make the mistake of setting raw mode, which prevent the user from 
pressing Control-C to exit the program.  v3 fixes this by using cbreak mode.

>  - Term::ReadKey, while common, is not part of base perl. So I think
>    using it needs to be conditional, and on systems without it we can
>    degrade to the current behavior.

The git-svn.perl script also uses Term::ReadKey.  Since it is already in the 
git source repository, I thought it was okay to use Term::ReadKey.

>  - There's no facility in your patch for restoring the terminal if we
>    break out of the loop in an unexpected way (e.g., via the user
>    hitting ^C).

Good point.  I'll try to address this in a v4 patch.

>  - This only enhances one particular input, the patch loop. It is
>    probably worth being consistent and allowing these behavior for other
>    menus (though the numeric inputs are a bit trickier).

Understood.
