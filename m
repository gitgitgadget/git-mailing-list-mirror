From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Push to all repositories
Date: Thu, 9 Dec 2010 13:52:04 -0600
Message-ID: <20101209195204.GB6884@burratino>
References: <1291829983410-5816069.post@n2.nabble.com>
 <20101208180049.GC5687@burratino>
 <1291849156593-5817177.post@n2.nabble.com>
 <1291898174244-5818757.post@n2.nabble.com>
 <AANLkTik9CxVD9A-2QEyD_tZiyYoCOitfViWucGCudzh-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Sheedy <kevinsheedy@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 20:52:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQmXU-0005rd-4K
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 20:52:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756501Ab0LITwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 14:52:23 -0500
Received: from mail-wy0-f194.google.com ([74.125.82.194]:57090 "EHLO
	mail-wy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756049Ab0LITwW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 14:52:22 -0500
Received: by wyf23 with SMTP id 23so953778wyf.1
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 11:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=h5gTPG7ns+HuKukjAdPQEwUfTJxLEKZbRl3Oomltn6s=;
        b=x9LXksw4c7ZvQNjTBXcymdb19T9kzE198g9sd9wEoKhwlPcm8eCtRzium/m5G547L4
         9pkwtHc/6S5cgwfZxPFdhpQvtN1eW+TJIy3vf5yqoX4F4Fz+UAxVwG8yEsZE78Nhtofj
         irMkA8A54o8aZ+nmSlYXLEVOenesFwCUm9E+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Snpa4l+V9vLRmo/qicbOfrhC5oDGOGmKm2gBVlSkmzXiezu1thHQuoC92dw+hRbmIO
         IVXsvN8TSQYhGFAr2V2XOSOa3zicFaSjI2bLxJ/KBpyXcunHUYfeZqLtCI82aSRgUKDu
         iTZTf7aT/yyOyQFpQigHSLtLlxZtVfUVlG8gw=
Received: by 10.227.68.201 with SMTP id w9mr11180187wbi.59.1291924339885;
        Thu, 09 Dec 2010 11:52:19 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.ameritech.net [69.209.58.175])
        by mx.google.com with ESMTPS id w41sm1075860weq.8.2010.12.09.11.52.17
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 11:52:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTik9CxVD9A-2QEyD_tZiyYoCOitfViWucGCudzh-@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163307>

Martin von Zweigbergk wrote:

> However, rather than trying to make Git behave just like ClearCase
> dynamic views (there are many other things to consider than automatic
> updates), I think you would be better off if you actually use
> ClearCase dynamic views instead.

Yes.  Or a network filesystem + unionfs.  Or a wiki.

The part I did not mention is why git does not work this way out of
the box.  It has something to do with the nature of projects it has
been used on traditionally (computer programs that occasionally undergo
global changes in API).

Consider a project in a patches+tarballs workflow.  It begins like
this:

 1. Acquire a tarball with the version you want to base your work on.
 2. Untar.
 3. Copy the result to save the current state.
 4. Test it.
 5. Fix a bug or add a feature.
 6. Make a patch with "diff -pruN"
 7. Return to step 3.
    ...
 8. Looks good; email out the patches to get some feedback.

Now another person wants to test the patches; so she tries:

 1. Acquire a tarball with the version you want to test against.
 2. Untar.
 3. Apply patches with "patch -p1".

Wait a second --- the patches don't apply!  Or worse, they
apply but the result is broken.  Okay:

 4. Complain to the patch author.

Finally the patch author has more work to do:

 9. Acquire a newer tarball, and use either "patch --reject-file"
    or rcs "merge" to reconcile the differences.  Email out the
    result.

The result is a sequence of snapshots that have been _tested_ to work
correctly.  Now compare the svn workflow I briefly used at work:

 1. svn update
 2. hack hack hack
 3. svn update
 4. hack hack hack
 5. svn update
 6. hack hack hack
 7. send out a patch for feedback

Now another person wants to test the patch.  So she tries:

 1. svn update
 2. Apply patch with "patch -p1".

The result applies okay and works great.  So:

 8. svn update
 9. ... test ...
 10. svn commit

Unfortunately, the version committed (1) does not reflect the
development history and (2) is not even tested, if changes
happened in trunk between step 9 and step 10.

That is, letting projects briefly diverge from upstream

 - avoids unnecessary interruptions to work;

 - allows the development history to be published, even when that was
   "first write some code, then tweak it to match the new API";

 - increases the likelihood that each commited revision actually
   works, making later mining for the code that introduced a feature
   or bug ("git bisect") much easier.

Of course in the opposite direction is

 - changes to workflow can be hard for a team to adjust to

(i.e., "don't fix what isn't broken").

Sorry, that ended up more longwinded than I hoped.  Still,
hope that helps.

Regards,
Jonathan
