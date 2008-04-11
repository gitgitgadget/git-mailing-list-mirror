From: "Tor Arvid Lund" <torarvid@gmail.com>
Subject: Re: git-p4, msysgit, and crlf
Date: Fri, 11 Apr 2008 13:12:46 +0200
Message-ID: <1a6be5fa0804110412v5e11e761xfdf4d4c7d8545661@mail.gmail.com>
References: <20080410175338.1z2hb82xw4kk4k0o@intranet.digizenstudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jing Xue" <jingxue@digizenstudio.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 13:14:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkHCV-0000cR-6f
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 13:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759605AbYDKLMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 07:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759584AbYDKLMu
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 07:12:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:52660 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759370AbYDKLMs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 07:12:48 -0400
Received: by fg-out-1718.google.com with SMTP id l27so368092fgb.17
        for <git@vger.kernel.org>; Fri, 11 Apr 2008 04:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=85pXauOTMaQ784N9qVQzuHmo7C9DH53g475jmCAIpZA=;
        b=qSWna7uIlh7KFhdzfnX9MTfmVBmWOXC9c/3SwCFDjHFlITobArpnRsPbkoLM/djs5m/d0fgmWJDzN6WKq3v6NA24Z/0EEDg0eeNW5zAd91qJvuqaLl6H5o7CgR6vP9Q+RBqpqpvTUVTWtf179vIpmAgMD/nEFPWYup2oxElG9Fc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hwksavMU/xZTxZnLR3YjnnaTbgDC2xxv3U6G5+UbboemtxQTIOIt6dVvc9VeQ7hCRpeVo8P+Pr/wHEVFf6SZTJpBr6ZEPwW8u/ZFuoeY7OHHPAyZJ4UJEQOtH9EOYACzZceoc/G89iRjbhmssKifkjiPVWLvgTx2NmAklDiftco=
Received: by 10.86.57.7 with SMTP id f7mr1281823fga.9.1207912366905;
        Fri, 11 Apr 2008 04:12:46 -0700 (PDT)
Received: by 10.86.9.6 with HTTP; Fri, 11 Apr 2008 04:12:46 -0700 (PDT)
In-Reply-To: <20080410175338.1z2hb82xw4kk4k0o@intranet.digizenstudio.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79271>

On Thu, Apr 10, 2008 at 11:53 PM, Jing Xue <jingxue@digizenstudio.com> wrote:
>
>
>  I'm working on a client project, where everything is developed in
>  Windows, and perforce is the official SCM. All the files use crlf line
>  endings.
>
>  I'm trying to use msysgit for my personal SCM, and git-p4 to sync with
>  perforce.
>
>  The problem I'm running into is that after
>
>   git p4 clone /perforce/path@all proj
>
>  all the files in the working directory are converted to lf line endings,
>  which I'd like to avoid.
>
>  I tracked it down to at some point git-p4 executes what essentially
>  amounts to
>
>   p4 -G print /path/to/file#rev
>
>  in order to get the content of a revision. When I try to run that
>  manually from the msysgit bash, the file content returned has all
>  the line endings converted to lf.
>
>  However, if I try to run without "-G", i.e.
>
>   p4 print /path/to/file#rev
>
>  The content returned has all the original crlf endings left intact.
>
>  I know this looks like a p4 issue, but I just wanted to ask other git-p4
> users out there whether you have run into this, and how you dealt with it.

Well, I'm no expert, but I'll try:

I think if you have the core.autocrlf config option set to true, it
should automatically convert line endings to CRLF for you when
checking out files to your working dir, and converting it back to LF
when committing. This way, content is always stored with LF only, and
can be checked out on any platform using whatever is the "local" line
ending by setting this option. This is the default operation in
Perforce also, as far as I know.

This git option needs to be set before you do the clone, though. If I
remember correctly, msysgit sets this as a global option by default
when you install it, but if not (or if you turned it off), you could
probably try:

git init
git config core.autocrlf true
git p4 sync /perforce/path@all

instead of your git p4 clone

You can verify that it is set by:
cd /path/to/git-cloned/p4-repos
git config --list

... and looking for core.autocrlf=true

Best of luck.
-Tor Arvid-
