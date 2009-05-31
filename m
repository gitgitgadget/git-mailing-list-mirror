From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH v3] add --abbrev to 'git cherry'
Date: Sat, 30 May 2009 21:53:57 -0700
Message-ID: <4A220D65.4040708@gmail.com>
References: <20090530140349.GA25265@unpythonic.net>	<200905301826.11924.markus.heidelberg@web.de>	<20090530165306.GA1142@unpythonic.net>	<780e0a6b0905301413o2686fe34qaa076209c26c0b55@mail.gmail.com> <7v63fiyyrz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff Epler <jepler@unpythonic.net>, git@vger.kernel.org,
	markus.heidelberg@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 31 06:54:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAd3g-0002uV-RI
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 06:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbZEaEyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 00:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbZEaEx7
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 00:53:59 -0400
Received: from mail-px0-f191.google.com ([209.85.216.191]:54532 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555AbZEaEx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 00:53:58 -0400
Received: by pxi29 with SMTP id 29so2187024pxi.33
        for <git@vger.kernel.org>; Sat, 30 May 2009 21:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=6WpyIt83pojoTtG7hZOoDRedsCqrVW+IdpK4xVxkrOs=;
        b=mRKQURf8bXC/sdUCkOSzMZcNM065T8/+rzs3HylVjVe7m9t0vWYuBYXPo2lUSN9mcJ
         XUaKkxCYpFA+zqxjJpzTl4TIXS63ATj/K4oqOkk6/mgfuv0mHK1iP3+RlnK7FrPYX1Bf
         a8Qgklxt4RL5n0oIfr24sPQFJ57E9IjplpsxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=JSqF5DPe1ThQ/P00XYpY7WThNwmSAuChPvo8Sib/8ue6pqvSP8jyYnLttt6UUsJXjV
         dY5NtxUMTLv4aJRxxBhpcHcqI4mutP2NlMsCMzxRe6c9BGU3dk4B13V/+8n+DzWUxG4U
         VT+bGpNRFVD6MOiXfbmt727Gsrm6q/Xe473KE=
Received: by 10.141.151.18 with SMTP id d18mr3918186rvo.134.1243745639918;
        Sat, 30 May 2009 21:53:59 -0700 (PDT)
Received: from ?192.168.1.2? ([76.89.212.195])
        by mx.google.com with ESMTPS id g31sm10061800rvb.23.2009.05.30.21.53.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 30 May 2009 21:53:59 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
In-Reply-To: <7v63fiyyrz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120380>

Junio C Hamano wrote:
> Stephen Boyd <bebarino@gmail.com> writes:
>> You might want to look at using the parse options API. It has options
>> for verbose and abbrev builtin, so you don't have to do any extra
>> work....
>
> Why do people even think a change like this to a _plumbing_ command is
> desirable?
>
> Admittedly, there already is "verbose" option that adds redundant
> information to the output of this particular plumbing, which might
> arguably be equally wrong as what this patch does, but I think it is
> excusable.  At least it lets the Porcelain script that uses the command
> avoid calling 'git cat-file commit' to find out the title of the commit.
>
> But --abbrev does not even add any information.  If implemented correctly
> (which earlier iteration did not even do), it may not lose information by
> choping the output too short to make it ambiguous, but as others pointed
> out about using grep in the calling Porcelain to filter (or more likely,
> sift the lines into "+" and "-" bins) to shoot down -d/-D options, I do
> not see the point of adding --abbrev to this plumbing command very much.

I was tempted to say the same thing, but I decided to leave it up to the
maintainer ;-) Maybe if there was a compelling use case it would make
more sense?

Or, would it make more sense to just use git-log? Right now you can do
git log --oneline --cherry-pick <head>..<upstream> and get close. Maybe
we can add a "--cherry" option to git-log which will act like git-cherry
by finding unmerged commits?
