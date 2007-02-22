From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-am failed, what's next ?
Date: Thu, 22 Feb 2007 08:48:05 +0000
Message-ID: <200702220848.06637.andyparkins@gmail.com>
References: <38b2ab8a0702220022wab25519hbb57629934e7f104@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Francis Moreau" <francis.moro@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 22 09:48:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HK9ci-00073I-0t
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 09:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbXBVIsR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 03:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbXBVIsR
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 03:48:17 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:16411 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbXBVIsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 03:48:16 -0500
Received: by nf-out-0910.google.com with SMTP id o25so465552nfa
        for <git@vger.kernel.org>; Thu, 22 Feb 2007 00:48:15 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=duScY2T7JcUM4EJirFJk1GTZ1Wp1dJjry/TLwTaq+nroLw1zLVh9xTeAuhNJEtLLMYlOv3KaK7olfTwYv1Mt0UlB0+Ax2FPhUJ2m9lXSeipqTqa16w59jszFpHI0mXLqMZzilTJHOvy1KKMblIC6o0vTzChPkCrji2JDNBcCMBA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PQlJF7DHsKzgdS0hrFz1gtXmMznNQnZ3XqNwq9Ix9Agcry0ZSab6gZ5lopEvE8Duu9kGgDV1oEgIr4MRkZg6K9DedxeQuDA85i/413/SCPlLeUOdP2WzXIyb1qlpC/zVK0PUDsl8Yiq6Kldi+LW7EyeuZODKUDkzcuv1d87fH5A=
Received: by 10.49.54.3 with SMTP id g3mr3203704nfk.1172134095221;
        Thu, 22 Feb 2007 00:48:15 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id i1sm5097619nfe.2007.02.22.00.48.09;
        Thu, 22 Feb 2007 00:48:09 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <38b2ab8a0702220022wab25519hbb57629934e7f104@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40341>

On Thursday 2007 February 22 08:22, Francis Moreau wrote:

> ----
> error: patch failed: foo:1
> error: foo: patch does not apply
>
> Patch failed at 0001.
> When you have resolved this problem run "git-am --resolved".
> If you would prefer to skip this patch, instead run "git-am --skip".
> ---

I've often wished for more information from git-am (or more correctly, 
git-apply).  However, you can sometimes get what you need to know another 
way.

 * First, make sure that your current tree is checked in so you can get back
   to it easily.  Maybe switch to a new temporary branch to make it easy to
   return to your current point.
 * Then run git-am to get the number of the failing patch, in your example 
   it's "0001"
 * Now, try and apply the patch manually, but turn on verbose and reject in 
   git-apply
    $ git-apply --verbose --reject .dotest/0001
   This is the only way I've found to get git to tell you which hunk of the
   patch is being rejected.  Unfortunately, it will also leave you with that
   patch partially applied.
 * Sometimes the partially applied patch will be enough.  Have a look at the
   *.rej files that have been created and see if you can resolve the conflict
   by hand - you could apply the patch by hand if it's only a small hunk.
   If you do this, you can then continue with the git-am by first updating the 
   index (git-add somefile.c), then running git-am --resolved
 * If you wanted to you could just skip that patch with "git-am --skip"
 * If you wish you hadn't started any of this you can obviously use git-reset 
   to get you back to the start point.

Hope that helps.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
