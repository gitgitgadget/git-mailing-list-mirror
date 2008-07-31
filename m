From: cte <cestreich@gmail.com>
Subject: Re: linking libgit.a in C++ projects
Date: Thu, 31 Jul 2008 04:10:47 -0700
Message-ID: <ac9f0f090807310410u461f5584ved74769d8452c539@mail.gmail.com>
References: <ac9f0f090807310253v1d97e2a1n4ddf34aa4fdc79f0@mail.gmail.com>
	 <20080731105727.GF7008@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 13:12:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOW4U-0002xh-Fn
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 13:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbYGaLKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 07:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbYGaLKt
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 07:10:49 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:52657 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727AbYGaLKs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 07:10:48 -0400
Received: by yw-out-2324.google.com with SMTP id 9so290088ywe.1
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 04:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=h7NE7FgB2+4AJ/XJNDmz/4L5qMH7+ttZ27ZkyyqyWM8=;
        b=fLcaqnpzrPXo/EE3qUHm/16fKqK0XSbQvnmL2AzsWQijJasd4mpl54tmZ0sU9RH+uK
         muAEsPz5YpHkXW+CIg9mJApgGvZUvU6tw/rDPfXcrPjF+NSMeqKHxTaeIm3RIDgQk0t7
         pQ1ih0s0zT62ChVa51Pnmbs0FEOREaVk6ZdJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=S726+rje4SqcxLj0KcjZNcTSN4WNvwNfisMW4eMCtoP3aF7Jx91ze5SHe2d3dwRls4
         ZBZI8O1j3oaijUu9XG2D2HbhdUgmGvrPNAIit/2CqYVMVfmLG3FLNblTDxUzbakaAJLx
         OoS3IfYKLUd/KUhUrum7mHFMXozR9FoGXJDk4=
Received: by 10.151.99.3 with SMTP id b3mr1034050ybm.133.1217502647681;
        Thu, 31 Jul 2008 04:10:47 -0700 (PDT)
Received: by 10.151.78.17 with HTTP; Thu, 31 Jul 2008 04:10:47 -0700 (PDT)
In-Reply-To: <20080731105727.GF7008@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90927>

On Thu, Jul 31, 2008 at 3:57 AM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> On Thu, Jul 31, 2008 at 02:53:37AM -0700, cte wrote:
>> I'm writing a git gui for OS X using cocoa/Objective-C++, and rather
>> than being lame and parsing the output the various git commands, I'm
>> using libgit.a to provide all of the needed functionality for my app.
>
> Don't do that! libgit.a is an internal library used solely to build
> git binaries. It means that its interface can be cahnged at any time.
> Though, there is an idea of creating the real git library that other
> applications can use, but AFAIK no one is working on it. So parsing
> output is the only correct solution right now. In fact, it is not
> difficult to do, because most plumbing commands are rather flexibly
> in what they output and how.

I'm not worried about the interfaces changing; the gui is tied to a
particular version of git, and I will update the code that calls into
libgit I pull new changes from the mainline into my local clone. Also,
who's to say that the output of the various commands won't change
formats with future releases of git? There is no correct solution if
you are worried about forward compatibility, unless a well defined API
is created (which would be sweet btw, but is probably not a priority).

>> However, the git source uses a few reserved C++ keywords; namely
>> 'typename', and 'new'.
>
> Because this source code are meant to be compiled by C and not by C++!
> Even if we will have real git library for other applications to use,
> it still be compiled only by C. Thus, C++ keywords are not issue.

Clearly ;)

Fortunately, g++ can compile C programs and link static libraries that
were compiled by C compilers, unless of course, they use C++ keywords.
I don't think it is unreasonable to rename the _very few_ C++ keywords
in git's source in the interest of allowing C++ projects to leverage
libgit.
