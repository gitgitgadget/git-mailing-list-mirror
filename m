From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Allow non-developer to clone, checkout and fetch easier.
Date: Fri, 26 Jan 2007 15:20:30 +0100
Message-ID: <81b0412b0701260620v31feedecwfe0565ee846253a9@mail.gmail.com>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0701212234520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vzm8ansrt.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0701231129501.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0701231101040.3011@xanadu.home>
	 <7v7ivbc3hj.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0701250922260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vejpiaj2f.fsf@assigned-by-dhcp.cox.net>
	 <7vhcue4heq.fsf@assigned-by-dhcp.cox.net>
	 <7v1wli4g8h.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 26 15:20:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HARwW-0001Te-Rk
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 15:20:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965689AbXAZOUh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 09:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965692AbXAZOUh
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 09:20:37 -0500
Received: from an-out-0708.google.com ([209.85.132.247]:58225 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965689AbXAZOUf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 09:20:35 -0500
Received: by an-out-0708.google.com with SMTP id b33so533400ana
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 06:20:35 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hMw6TVRY5gcs5/p4wyHX9NVsGqW0E4mGzuRxMVs8kJ6D6WkQJfk0mhu1Yt/LFI4molxxBb0pSp5jAtUeaxRTWkLt2udjkxthLcxFCC+slUQPMaIEZEdgmYAu+uC4dH6+ePCYLxyDgBm1+tNT4fq3ALoYYVPfUKsFByWoJyYoTcE=
Received: by 10.78.149.15 with SMTP id w15mr921615hud.1169821230238;
        Fri, 26 Jan 2007 06:20:30 -0800 (PST)
Received: by 10.78.139.7 with HTTP; Fri, 26 Jan 2007 06:20:30 -0800 (PST)
In-Reply-To: <7v1wli4g8h.fsf_-_@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37857>

On 1/26/07, Junio C Hamano <junkio@cox.net> wrote:
> The code that uses committer_info() in reflog can barf and die
> whenever it is asked to update a ref.  And I do not think
> calling ignore_missing_committer_name() upfront like recent
> receive-pack did in the aplication is a reasonable workaround.
>
> What the patch does.
>
>  - git_committer_info() takes one parameter.  It used to be "if
>    this is true, then die() if the name is not available due to
>    bad GECOS, otherwise issue a warning once but leave the name
>    empty".  The reason was because we wanted to prevent bad
>    commits from being made by git-commit-tree (and its
>    callers).  The value 0 is only used by "git var -l".
>
>    Now it takes -1, 0 or 1.  When set to -1, it does not
>    complain but uses the pw->pw_name when name is not
>    available.  Existing 0 and 1 values mean the same thing as
>    they used to mean before.  0 means issue warnings and leave
>    it empty, 1 means barf and die.

 enum {
    CMITR_INFO_PW_NAME = -1,
    CMITR_INFO_EMPTY = 0,
    CMITR_INFO_DIE = 1,
 };

-       const char *committer = git_committer_info(CMITR_INFO_DIE);
+       const char *committer = git_committer_info(CMITR_INFO_PW_NAME);

The code becoming increasingly harder to read, doesn't it...
