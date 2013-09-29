From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Makefile: suppress false positive warnings of empty
 format string.
Date: Sun, 29 Sep 2013 12:00:17 -0700
Message-ID: <20130929190017.GA2482@elie.Belkin>
References: <7vfvvkpt2k.fsf@alter.siamese.dyndns.org>
 <1380456534-7582-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Sep 29 21:00:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQMEV-0003GG-6O
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 21:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754891Ab3I2TAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Sep 2013 15:00:31 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:39559 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754864Ab3I2TAa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Sep 2013 15:00:30 -0400
Received: by mail-pa0-f45.google.com with SMTP id rd3so4903859pab.4
        for <git@vger.kernel.org>; Sun, 29 Sep 2013 12:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=3eYt2xyilaR6IXL5YK5EOzDnLn2zpTpq39NM46cOnTo=;
        b=i5f57YriIO0wUhkS0GC10ODeKdAsQdAY2ggEYSGLsLKHCSMvtQolNubnxPpkj/AxS1
         Un+4gEKghmoyqTylDmIzLKtIbgEY4TdsWibTgAIYA0l34ZYallyMIQKVmL+s/disf097
         LmEqaem9ECkhohJjj60LUc+dSkzG8xe0/Cr6m8AB0fqRJIdh7B4cG0p8UJrAIDytAzc0
         3Ty9R+Qo2Qil/gW87y8Pwk1HJLVJyN/+8TJh+D3DXaKCqYN4lVJi37elXLMWLk84Ywyk
         JIhciPdndGSujljVSqT+R3tLN5sECXwvsMS5C2f6YaBQ/NruhOoj1phRJ+XSPShJ4d9J
         8cDA==
X-Received: by 10.66.102.100 with SMTP id fn4mr24044024pab.71.1380481229478;
        Sun, 29 Sep 2013 12:00:29 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id os4sm22097206pbb.25.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 29 Sep 2013 12:00:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1380456534-7582-1-git-send-email-stefanbeller@googlemail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235603>

Hi,

Stefan Beller wrote:

> --- a/Makefile
> +++ b/Makefile
> @@ -349,7 +349,7 @@ GIT-VERSION-FILE: FORCE
>  
>  # CFLAGS and LDFLAGS are for the users to override from the command line.
>  
> -CFLAGS = -g -O2 -Wall
> +CFLAGS = -g -O2 -Wall -Wno-format-zero-length

Thanks for taking this on.  Two thoughts:

 1) As Felipe mentioned, this isn't portable.  Would it make sense to
    make it conditional on the value of $(CC) or the output of
    "$(CC) --version"?

 2) I don't understand the value of -Wformat-zero-length at all.  What
    bug is it meant to prevent?  Do you know if anyone has asked the
    GCC maintainers to disable it from the default set of warnings in
    -Wall, which would give us a bug number to point to?

 3) Since we don't enable -Werror by default (which is really good ---
    use of -Werror can be a fine development tool but is a terrible
    default), the warning does not actually do much harm.  When it
    becomes harmful is when someone turns on -Werror for static
    analysis purposes and is unable to move forward from there.  Do we
    document suggested pedantic compiler flags anywhere other than the
    todo:Make script?  Should we?

    I suspect such a documentation fix would have more impact, since it
    could encourage people to experiment with flags and to check their
    code strictly even when warnings are not portable, without
    significantly slowing down the normal build.

    For reference, todo:Make suggests the following flags:

	-Wpointer-arith -Woverflow -Wunused \
	-Wno-pointer-to-int-cast -Werror \
	-Wold-style-definition std=c99 -O2 \
	-Wall -Wdeclaration-after-statement -Wno-format-zero-length -g

Hope that helps,
Jonathan
