From: Brandon McCaig <bamccaig@gmail.com>
Subject: Re: `git stash pop` UX Problem
Date: Thu, 27 Feb 2014 23:50:41 -0500
Message-ID: <CANUGeEZTeqBpf0VP4gCG9iN=v20U4axxoSjX9JbLPp_ppX3QiA@mail.gmail.com>
References: <1lho9x8.1qh70zkp477M%lists@haller-berlin.de> <vpqmwhexidi.fsf@anie.imag.fr>
 <85fvn40ws9.fsf@stephe-leake.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Stephen Leake <stephen_leake@stephe-leake.org>
X-From: git-owner@vger.kernel.org Fri Feb 28 05:51:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJFPh-0005hC-VD
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 05:51:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbaB1EvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 23:51:04 -0500
Received: from mail-we0-f171.google.com ([74.125.82.171]:42074 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114AbaB1EvD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 23:51:03 -0500
Received: by mail-we0-f171.google.com with SMTP id u56so135301wes.30
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 20:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=y4FR8Q2BUG8ToFRSK53bqbSbQP6l4DMMpWKpsQYyROI=;
        b=EmG3R2Ne65yQxInLO8hKeAT6uzWxHMjECGJbgAIs8fOcmDw8bfRmWKMUZrF5/zzdvg
         1FSZlAuQ+2zt1oBd2ww/UdNPKUBwJyVfO143UY2oNq442I/VoNaNF8lpQRYKqEAWAFbr
         70pYIgvqjDZThfpe07V3hl8Y8f9ZBpWp0Clab6kZWPmn3R/GJCvxcUQ/MLIp6haxDQLz
         t3utgpqaokF2Oc0vXSjnGYsRrEs218/2wz1m2HJ/jNkzxy49SKFwOK883GyGYeapVwsN
         w6EadpTFqQmBxmd/Jr7JY/EtqqJ1dSdpbhTPptramQ7Rgi+PDzVNmfayVUcYgEHRyCmQ
         b2nQ==
X-Received: by 10.180.165.174 with SMTP id yz14mr1386596wib.34.1393563061459;
 Thu, 27 Feb 2014 20:51:01 -0800 (PST)
Received: by 10.216.176.65 with HTTP; Thu, 27 Feb 2014 20:50:41 -0800 (PST)
In-Reply-To: <85fvn40ws9.fsf@stephe-leake.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242884>

Stephan:

On Thu, Feb 27, 2014 at 9:57 PM, Stephen Leake
<stephen_leake@stephe-leake.org> wrote:
> You might be adding other files for other reasons. But if you add a file
> that does resolve a conflict caused by 'git stash pop', it is not
> guessing.

Staging a file doesn't tell git that you resolved a conflict. Git will
happily accept a blob full of conflict markers. Git doesn't know the
difference. Git expects the user to know what is right. The user has
the freedom to manipulate the index as they see fit, which means both
adding and removing from it anytime they wish.

> So "git add" and "git stash *" are lower level tools; to get the effect
> we are asking for, we should use a front-end (which is why I'm writing
> one for Emacs :).

You *can* use a front end, but I would argue that you shouldn't
necessarily. Most third-party front ends only serve to confuse users.
In general, they only cause problems and encourage ignorance.

Git is a very pure system. It doesn't impose too may rules on you. It
basically just gives you the tools that you need to work within the
system and gets out of your way. It is up to the user to learn how to
assemble those tools for good (and many front ends exist to help;
sometimes arguably too many as it is, such as git-pull(1) for
example).

 This isn't a case of the API being wrong. This is a case of PEBKAC,
IMO. Maybe the API can be a little bit more verbose in assisting the
user to understand what has happened and what sensible options there
are, but we should avoid catering to newbies too much. You should only
be a newbie for a short time. After that you should begin to learn the
API. Hand holding at that point would be noise (as it would for most
of us here, I imagine). The worst kind of "hand holding" is the kind
that imposes rules on you that aren't universal. Dropping the stash
after adding all changes to the index after a failed pop is not
universal. At most, git stash pop should give the user a bit more
guidance to understand what the situation is. At least, the user
should RTFM and learn to use the tools. And that might involve some
mistakes, but you learn from mistakes. At least Git does a good job of
making it easy to recover from most of your mistakes. The proposed
change to git-add takes away one of those safety nets.

Git isn't always the easiest thing to wrap your head around, but I
have found that once you have wrapped your head around it Git is the
easiest thing to get the job done the way you want. I consider the
learning curve a strength of Git. Which isn't to say that there isn't
room for improvement, but when proposing improvements we should try to
make sure that they actually make things universally better.

Regards,


-- 
Brandon McCaig <bamccaig@gmail.com> <bamccaig@castopulence.org>
Castopulence Software <https://www.castopulence.org/>
Blog <http://www.bamccaig.com/>
perl -E '$_=q{V zrna gur orfg jvgu jung V fnl. }.
q{Vg qbrfa'\''g nyjnlf fbhaq gung jnl.};
tr/A-Ma-mN-Zn-z/N-Zn-zA-Ma-m/;say'
