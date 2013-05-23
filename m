From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Geolocation support
Date: Thu, 23 May 2013 14:15:26 +0530
Message-ID: <CALkWK0kHEDn4Wt3Y+XUE59_9ZDf504yopMp9QtBUk49Sd+EXbg@mail.gmail.com>
References: <87mwrncfkh.fsf@ethzero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Alessandro Di Marco <dmr@ethzero.com>
X-From: git-owner@vger.kernel.org Thu May 23 10:46:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfRA6-00075z-U0
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 10:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757155Ab3EWIqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 04:46:09 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:55845 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477Ab3EWIqH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 04:46:07 -0400
Received: by mail-ie0-f169.google.com with SMTP id u16so8068469iet.0
        for <git@vger.kernel.org>; Thu, 23 May 2013 01:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=laWLc9JWxJs+2esP2u5FJRhP9Y6fA74CJr7E/NGHbts=;
        b=x0LBzLro9mFNELeRwXIEzS9G9LdcqyIUPqyp0c+7QjfFxHGihGiKquwccYHeaBMo+P
         S8HM/2ejG6427wSb1KRRwijcrQ+YQ+MqZe+bpfzD4ILt1jMD7Xyq4fRwnR3uDtrMwxA5
         YcoTxtu/IWpxCQDq19QqX1Twp4XS/E+geGbxJxhHIJtn2vIpMvxbZjWki6neak2NbuXz
         f6UppXxKV4MKGeYufzDQQdgmLEQRLZp2gbgj1CTwbdCP5RDZMywswExZa5ngsiqbgW3D
         Bt6sOQ6/ynz+3hMYA3m32BDqqhkGXU2F5PHzu1PIN2tUjN0MhRobKlYkIoe50GUWMj9A
         ym8g==
X-Received: by 10.50.3.38 with SMTP id 6mr4451232igz.44.1369298767096; Thu, 23
 May 2013 01:46:07 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 23 May 2013 01:45:26 -0700 (PDT)
In-Reply-To: <87mwrncfkh.fsf@ethzero.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225224>

Alessandro Di Marco wrote:
> this is a hack I made a couple of years ago in order to store my current
> location in git commits (I travel a lot and being able to associate a
> place with the commit date helps me to quickly recover what were doing
> at that time). Long story short, the screeenshot at
> http://tinypic.com/r/wars40/5 shows the new gitk interface once this
> patch has been integrated. Geolocation is controlled by two envvars
> GIT_AUTHOR_PLACE and COMMITTER_PLACE, respectively. You can set them via
> something like this:

Obviously very interesting.  Now, how do we mainline (parts of) this
feature?  I'll raise some questions here:

0. We already have timezone information, but this is obviously
insufficient for any sensible geolocation data.

1. Does it make sense to make it an optional field in the commit
object?  I can see how generic optional fields in the commit object
can be useful: a lot of code-review systems put the code-review ID in
the commit message, and I can see how an optional field would benefit
them.  Will it break existing parsers (shouldn't they ignore unknown
fields)?

2. How accurate should this geolocation information for it to be
invariant enough?  If we blindly store what a GPS gives us, the
centering error is obviously a problem.  What should be the resolution
of the lat/long that we store?

3. Failing (2), can we put the geolocation data in the commit message,
and proceed?  If so, does it need to be part of git-core, or should an
external client (gitk, or other clients) write/ parse the geolocation
information?
