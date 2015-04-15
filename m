From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Odd broken "--date=now" behavior in current git
Date: Wed, 15 Apr 2015 09:20:36 -0700
Message-ID: <CA+55aFwbEnneEvUDhxGaWw=fSwY2WbtGy6Uc3aQzpiUY6GH1uQ@mail.gmail.com>
References: <CA+55aFxvcN8Dz-t6fi6etycg+AiyR0crXv5AcfCdv8ji-iNBpw@mail.gmail.com>
	<xmqqzj6ayp3p.fsf@gitster.dls.corp.google.com>
	<20150415072223.GA1389@flurp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 18:21:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiQ3r-0003wL-JN
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 18:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756300AbbDOQVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 12:21:06 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:36799 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756276AbbDOQVD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 12:21:03 -0400
Received: by obbeb7 with SMTP id eb7so26795880obb.3
        for <git@vger.kernel.org>; Wed, 15 Apr 2015 09:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/4MRjqvsoQlLy1ayV76AerTrjCW1f90MkpN+prhdHpY=;
        b=ILUxxQ3+VVuMOtbiQWEk7VdanimKv+S52doZDcu3VY15I47O4ZmY+6pBill7R6LHcU
         BUGiprHHvRJDacnOc8gy1XJLeuZXZAoQ0ZsDjhAP7gdi8exutGwpA73otWHOmqRVa/ep
         knsmsl1aTJXB5FFAKLLND32pSYc4PhD1YiEeWgAvNItyqRcyvsUuKC6ugP3YRpnpZrQq
         bgFHUT5dHClZe8wceetBBipK9Rdkr0iOUJyenO+YAdib8FwVS9lUuebUYvq7yOhqdv52
         YZ+jHrcigSL2lFVl5MMWZHKBEpi+q24Ce76yf41o9rYPGBDEQC5VcEwgt/jSvmYf/X/v
         sBAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/4MRjqvsoQlLy1ayV76AerTrjCW1f90MkpN+prhdHpY=;
        b=afVwkyV4bJ/7KzWl2xPmq/XC595Kfs087upbkt33whCphOmJw52m8ScvcCDx06zhcH
         B0XgpELbXPQNGn96Ujkin7v5kn94gGYFIA12k5duMyteOTomWpxm97vTeNn4s5JRmErF
         j+4vVgadJ9XaGTVNW5DepQ7vqPx9mygKnV44w=
X-Received: by 10.50.79.195 with SMTP id l3mr13854484igx.30.1429114836433;
 Wed, 15 Apr 2015 09:20:36 -0700 (PDT)
Received: by 10.36.53.141 with HTTP; Wed, 15 Apr 2015 09:20:36 -0700 (PDT)
In-Reply-To: <20150415072223.GA1389@flurp.local>
X-Google-Sender-Auth: vWed_KS2l6AOLV46Z89yFRXCVPc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267209>

On Wed, Apr 15, 2015 at 12:22 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> The fix seems to be simply:

Yup, that seems to do it for me. I'm not sure how we get to
"match_digit()" with the time string "now", though.

So your patch fixes things for me, but I think:

 - we should move the "tm.tm_isdst = -1;" up a bit and add a comment

 - I'd like to know why it affected the author date but not the
committer date, and how it got to match_digit() with that date string
that didn't contain any digits.

I'd spend the time on this myself, but I'm in the middle of the kernel
merge window, so..

Thanks,
                     Linus
