From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 04/14] msvc: Fix macro redefinition warnings
Date: Wed, 8 Dec 2010 11:32:40 +0100
Message-ID: <AANLkTimpj31CSzaxH4ZuYdADvtV4KSwfk04eGSRYSLFH@mail.gmail.com>
References: <4CFA8FE3.1050009@ramsay1.demon.co.uk>
	<201012042204.52002.j6t@kdbg.org>
	<4CFECBB8.2070900@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>, patthoyts@gmail.com,
	pharris@opentext.com
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Dec 08 11:32:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQHKJ-0006Eh-9Z
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 11:32:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753729Ab0LHKcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 05:32:42 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:41654 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753607Ab0LHKcl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 05:32:41 -0500
Received: by vws16 with SMTP id 16so818071vws.19
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 02:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=46aUbnwFjhw+HM5APirs5JyG/Yg6FTSeGQS3ZtkTTgM=;
        b=il+nsAS0yv/xNGVVE+oP16N2FZcRAuWS6ipP12NmqipzyKD6FbhBAABdcnUZa5tQqp
         Iu/hMYVbyZOtyGbF9Iikg6dzo9oEiLdNUO3dWHXJsk9GYyE2VLyChKMR1MI7lax3uJp1
         WNe4Y52BmOXfzO9sMFEDEQtwULgw+P8lzm0oE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=t1y5LLZkULjcc5W8EFKv3fZSGMAcwEGT7ihjEUeEl8cxNVQD7Xn+edO/U7xBvXyws2
         0nfstrRm/Hz5o1BsGekiUyuuAIZ4qly7vCSREgsV+8yeLx3v23sgjV/xGrsQifq8XTKH
         JK8iIfpLKRQF8j2JMUqs7xWjb0PFkH1kRid5U=
Received: by 10.229.100.76 with SMTP id x12mr6782715qcn.6.1291804360562; Wed,
 08 Dec 2010 02:32:40 -0800 (PST)
Received: by 10.229.25.81 with HTTP; Wed, 8 Dec 2010 02:32:40 -0800 (PST)
In-Reply-To: <4CFECBB8.2070900@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163185>

On Wed, Dec 8, 2010 at 01:05, Ramsay Jones <ramsay@ramsay1.demon.co.uk> wrote:

> Johannes Sixt wrote:

>> Instead of removing the macros, wouldn't we be much safer with just
>>
>> #ifndef S_IWUSR
>>
>> ? ...
>
> Er... no.
>
> Commit 4091bfc (which added these macros) does not provide any motivation
> for the change, and I'm having a hard time trying to imagine a useful
> purpose for this part of the commit. (I'm not saying there isn't one - just
> that I can't see it :-P )

Sorry for not finding the time to respond to the thread in [1] about
two months ago where this issue about my commit was first raised.
While it's true that my commit message does not contain any detailed
information about its motivation, it says the defines were "missing",
suggesting a compile error. Indeed, I remember that back then my
msysgit working tree did not compile with MSVC if I didn't have these
defines (and I vaguely remember that this was caused by MSVC using
different a header file than MinGW, or in a different order, or
something similar).

However, I'm not able to reproduce this anymore. I checked out
4091bfc^ and 4091bfc, and both compile file with MSVC for me now, the
latter just giving a lot of the mentioned macro redefinition warnings.
Maybe this was caused my me using older MSVC project files with a
newer code base ... I probably should have run
contrib/buildsystems/generate again.

After defining LF_FACESIZE and TMPF_TRUETYPE in winansi.c, and
INTMAX_MAX in git-compat-util.h, I was also able to compile the
v1.7.3.2.msysgit.0 tag with MSVC. If I revert 4091bfc on top of it, it
still compiles fine for me.

> So, once again, I see no reason to keep them ... Unless you know otherwise.

I agree to remove the lines and vote in favor of Ramsay's patch. Feel
free to add me as Signed-off-by or Acked-by.

[1] http://thread.gmane.org/gmane.comp.version-control.git/158144/focus=158409

-- 
Sebastian Schuberth
