From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH/RFC v2] git-submodule: multi-level module definition
Date: Thu, 6 Mar 2008 13:48:06 +0800
Message-ID: <46dff0320803052148wd4fe5e3hfde72b4362b0cc8b@mail.gmail.com>
References: <1204646661-7776-1-git-send-email-pkufranky@gmail.com>
	 <7vd4q8kbey.fsf@gitster.siamese.dyndns.org>
	 <46dff0320803051754o4b45222es524a62a7cac50b94@mail.gmail.com>
	 <7vejaoldgu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 06:49:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX8ye-0002Qq-6z
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 06:49:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755051AbYCFFsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 00:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753901AbYCFFsK
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 00:48:10 -0500
Received: from an-out-0708.google.com ([209.85.132.243]:48965 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087AbYCFFsI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 00:48:08 -0500
Received: by an-out-0708.google.com with SMTP id d31so374473and.103
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 21:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=1oYyJZTNkGNXCFLKsAELzP9O4KHwE68DFixkiPsb1pY=;
        b=idyAfMzVqEYhELoTCqwPY8uCZTM8GANH/cdct/zdZyFIlSq33uwrs0a3fVGG//AYDvCZQbUeercPhmV/t2CVdSGUqgDHA8R/FU433oNcBh9urMi9AwY9LgD5OelMTzu9ebfq1fuUxVNo7pEiGytuT8IZ12PlFPTJRGAlDAKpmN8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IDofv4uNugSQs9FSse24dtc4innFWDMwd7Z8cc+fcotD6F2G1pUg/d24ZPMFo/emM+G7AePInMKlcQn0s66fHSTOmHti1AseExTOtBpPcGDomCEFlForKyDvPCWxXKYn/qTDXdKdnvUFPfYRJWXWYTHgsfILThYL7f7e1BVSsuk=
Received: by 10.101.71.16 with SMTP id y16mr9080897ank.66.1204782486754;
        Wed, 05 Mar 2008 21:48:06 -0800 (PST)
Received: by 10.100.5.18 with HTTP; Wed, 5 Mar 2008 21:48:06 -0800 (PST)
In-Reply-To: <7vejaoldgu.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76337>

On Thu, Mar 6, 2008 at 11:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Ping Yin" <pkufranky@gmail.com> writes:
>
>

>  I think we are saying the same thing, and I do not understand why you
>  sound so upset about my comments.  I never said it is bad to copy the
>  "hints" supplied by .gitmodules verbatim to $GIT_DIR/config.
>
>  See how the current cmd_init() uses the information in .gitmodules.  It
>  could later become interactive to allow users to override what's in there,
>  but by default it simply uses the information from .gitmodules verbatim.
>
>  However, a short-hand to name groups of submodules is not just about
>  naming one thing with one name, but has user convenience aspect too.
>  There should be per-user customizability built into the design.  You could
>  probably fix this by making the code first consult $GIT_DIR/config and
>  then fall back on in-tree .gitmodules file.

We agree on this point and 'fall back' is what i will try to do. Our
difference is the
 way to implement it. Since finally we can fall back to .gitmodules
when information
 is not found in .git/config, why always use 'git init' at the first.

'git init' should be useful when a user has many special requirements which can
help the user copy info from .gitmodules to .git/config and then edit
.git/config.
But in many cases (at least in my company), users may not have special
requirements,
so he needn't use 'git init'.

So now 'git init' is not the first class citizen, it's just a util to
help users when they need it.

And there may be inconsistence between .git/config and .gitmodules
when always using 'git init'
at first. If .gitmodules has changed in the upstream, what should user
do? run 'git init' again? That's
not so easy.  Since .git/config has a whole copy of .gitmodules, the
user has no easy way to know
which entries he has changed which shouldn't follow the upstream changes.

>
>  By the way, in your patch, I notice that quoting of $name is often very
>  loosely done.  I do not think we have officially defined what the allowed
>  repertoire of module name characters are, but we probably should declare
>  the rules and make sure the code actively enforces it to prevent future
>  grief.  I'd say the same restriction as we have for refnames, except
>  that we do not allow slashes either, is good enough?
>
I think it's enough.

In this bash script, there are many places which don't/can't handle
names containing whitespace
well. So the decaring a naming rule for the modue name sounds good.



-- 
Ping Yin
