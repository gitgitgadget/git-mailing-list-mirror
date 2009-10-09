From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Merging non-git releases of a project
Date: Fri, 9 Oct 2009 17:27:23 -0400
Message-ID: <32541b130910091427i7c8a2426hb69a9914aabde8bc@mail.gmail.com>
References: <26ae428a0910091411i39a03650o51163f794b984524@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Fri Oct 09 23:34:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwN5z-00081o-GH
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 23:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934431AbZJIV2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 17:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934276AbZJIV2W
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 17:28:22 -0400
Received: from mail-gx0-f212.google.com ([209.85.217.212]:52257 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934285AbZJIV2V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 17:28:21 -0400
Received: by gxk4 with SMTP id 4so8305092gxk.8
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 14:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=4XKuMTJ/ir8iRlFz+J8lB/dxJvuISm0uGDKji1DN4Wc=;
        b=HYrXMYbwySduIHQLC81qvixd1RWbwUk2mFjTA+TqK4VGFxil5eqTmVMj9Grqmw5Bgj
         TyUiI3braEfOON92Yd36zHHc2P1C18Gz4P5viKd+l9VUnQz6G7wXWtA8I8Qqrx4ZV1f4
         /1rlXp5MRzjYJ3F20A+yr8ekUCqCIbP50z+b8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=WUaPt+/vKgWIWQx/FQ9/pBIA6I9hs8AamIN5wvNoD19dXCK2m9zW8WNMQmyeyJE2kL
         gCvZElz/wy+ag5vI6P/S35USZXUg9Mu+OF/zj1PGeETFqYq7xD3oLRZRAA557SdF9R9Q
         gcUvW/FTdJokyfD18pFQwtHI2ExhMiBq+yJxY=
Received: by 10.151.4.5 with SMTP id g5mr5582739ybi.159.1255123663958; Fri, 09 
	Oct 2009 14:27:43 -0700 (PDT)
In-Reply-To: <26ae428a0910091411i39a03650o51163f794b984524@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129843>

On Fri, Oct 9, 2009 at 5:11 PM, Howard Miller
<howard@e-learndesign.co.uk> wrote:
> Here's my dilemma.... I've used git extensively to track modifications
> made to a reasonably large source tree. I do not have access to the
> repository for that project, just a given release. I have now acquired
> the latest version of that project and I want to 'merge' (not sure
> that's the right word in this case) my changes into the new version.
> Then I need to carry on using git for further changes. I think it
> should be simple but I can't get my head around the best way to do
> this.

Find out the commitid of the first commit when you checked in the
upstream project into git, and call it C1.

  git checkout -b vendor C1

(replacing C1 with the commitid).  This creates a branch called
'vendor' which is for checking in *only* the pristine code provided by
the vendor.  It also checks out this new branch.

Next, import the new upstream version of the project and commit it to
the 'vendor' branch.

Now, switch back to your branch and merge in the vendor changes:

  git checkout master
  git merge vendor

Or, if you want to produce a clean set of patches on top of the vendor
version (ie. for submitting the individual patches upstream), you
might want something like this instead:

  git rebase vendor

But be careful, rebasing can make a mess of your history and you
shouldn't do it unless you have a good reason.

Good luck.

Avery
