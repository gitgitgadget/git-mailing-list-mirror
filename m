From: Christopher Rorvick <chris@rorvick.com>
Subject: Re: [PATCH] git-cvsimport: support local timezone
Date: Thu, 11 Oct 2012 19:14:44 -0500
Message-ID: <CAEUsAPYaYGDHWkixf9U27_Hsa7QqCWq3csKtBH7MrjnMD6kKJQ@mail.gmail.com>
References: <1349988497-6158-1-git-send-email-chris@rorvick.com>
	<50774BA9.40609@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Oct 12 02:15:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMSu2-0004Il-E0
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 02:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759529Ab2JLAOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 20:14:46 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:39814 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759525Ab2JLAOq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 20:14:46 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so1714043lbo.19
        for <git@vger.kernel.org>; Thu, 11 Oct 2012 17:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=zilgWLSCNE6BlJVK7pn54MQ59mr+np6CCKMHqCy6afI=;
        b=pgrf/mX9fgHci5lWJLT4I5hhI8yfezje1cOFE7/6UCEr5fWnLI62aItqNPtnc3sk++
         OnTlN04UdGn/MdvNEDD9OnFmgGSAHsVqwxbmcJlzPpbn4HzAD4YawqHoy2uHVCmpGVPE
         fTc8Kc3M/skTNB55t2G7QXE1CuEdnV/uyDyIFXC13DMVhX3ZX4nIZw+qayBFNeYYOacY
         eNvJUNTVObnuJk0AKc4sSo9Eeig4xvmph3VyTYyF1lPf+uBze3NCsrC+Pw2fZwj23wWQ
         +Fg98zHRMrwLLnPcqmMmozWiK3lSQa6ugBy3l52O+Sjj1twdGemA4aU8ftlVD8sR1lU6
         bUSg==
Received: by 10.152.106.110 with SMTP id gt14mr2391981lab.1.1350000884621;
 Thu, 11 Oct 2012 17:14:44 -0700 (PDT)
Received: by 10.114.2.45 with HTTP; Thu, 11 Oct 2012 17:14:44 -0700 (PDT)
In-Reply-To: <50774BA9.40609@alum.mit.edu>
X-Google-Sender-Auth: CHpAzL8fM9sFNpyh15rRDHix2xw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207523>

On Thu, Oct 11, 2012 at 5:43 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 10/11/2012 10:48 PM, Chris Rorvick wrote:
>> CVS patches are unconditionally imported with a UTC timezone.  Allow
>> the local timezone by adding -l to the command line or specifying
>> cvsimport.l in the config.
>>
>> This could be made the default behavior, as setting TZ=UTC in the
>> environment before doing the import is equivalent to the current
>> behavior.  But since a new default may be an unwelcome surprise to
>> some, make this new behavior available os an option.
>
> According to rcsfile(7), all times in RCS/CVS files are recorded in UTC.
>  So why do you need this feature?
>
> Michael

Hi Michael,

Precisely because of this limitation.  RCS files are not as expressive
as a Git commit so I need a way to fill in the blanks.

This is analogous to the cvs-authors file.  The RCS files in a CVS
repository say the author of my commits is "crorvick" but that is
neither my name nor email.  cvsimport allows me to overcome this
limitation by specifying a mapping from author username to full name
and email.

Likewise, just because the RCS file has a UTC timestamp does not mean
the commit originated in Greenwich, UK.  Git includes the timezone
offset in its timestamps, so it is reasonable to allow me to specify
what is appropriate.

This is not a big deal for a one-time import as a simple filter-branch
run can fix this pretty quickly.  But this feature would be nice when
running cvsimport incrementally.

Thanks!

Chris Rorvick
