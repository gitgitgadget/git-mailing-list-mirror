From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] add warning for depth=0 in git clone.
Date: Tue, 8 Jan 2013 00:12:21 -0800
Message-ID: <20130108081221.GA5722@elie.Belkin>
References: <1357632422-5686-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 09:12:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsUIj-0003f3-BM
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 09:12:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754543Ab3AHIM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 03:12:29 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:53169 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754300Ab3AHIM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 03:12:29 -0500
Received: by mail-pa0-f43.google.com with SMTP id fb10so183912pad.30
        for <git@vger.kernel.org>; Tue, 08 Jan 2013 00:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=nJ/P+cPhSIzdJHXNpeo8/2KTFrWmWD125i8tKKeDV50=;
        b=o9uw0+deGtUmjve+pn8lPgs+8arxxE/Yndyq+jiivxfYkOo7Q+wNxckkcv2buZ0tSf
         ViWTPZillJ/lPWa9k56pWTnCSTrZXTfh8SzAAcBsmAfN7Yuv4n6TREnE0ZdW0y81MslC
         fCoXTQFw9ccLRhpoC45Vc9lmC4iCeAycWptT4Q8xE6wsxIgFRdL1prF9L/MPI3OTlTvh
         X0GexcNLM2hV/wsGaQhfdHUkpZSMrJ8wAqBKyDRK6YnYQZuHCi9+bUOFbBM8sQcJi46Q
         6svwzI1Pc/Jw2WhYjSKnAOkttNtL1CJjJIjoQZeMP+/jHn+kadq+0HllPIaYR1DtRGGr
         ExGw==
X-Received: by 10.68.235.71 with SMTP id uk7mr196937788pbc.10.1357632748888;
        Tue, 08 Jan 2013 00:12:28 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id rq7sm39205258pbc.69.2013.01.08.00.12.26
        (version=SSLv3 cipher=OTHER);
        Tue, 08 Jan 2013 00:12:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1357632422-5686-1-git-send-email-stefanbeller@googlemail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212948>

Stefan Beller wrote:

> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -818,6 +818,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	remote = remote_get(option_origin);
>  	transport = transport_get(remote, remote->url[0]);
>  
> +	if (option_depth && transport->smart_options->depth < 1)
> +		die(_("--depth less or equal 0 makes no sense; read manpage."));

"Makes no sense" is a little harsh.  Presumably it made sense to the
user, or she wouldn't have passed that option.  The relevant point is
that git was not able to make sense of it.

How about something like

	fatal: shallow clone must have positive depth

?  The "see manpage" is always implied by die(), and I don't see any
particular reason to point to a specific section here.

Hope that helps,
Jonathan
