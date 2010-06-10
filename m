From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH next 2/2 v2] Remove python 2.5'isms
Date: Thu, 10 Jun 2010 11:28:15 +0200
Message-ID: <4C10B02F.9050107@drmicha.warpmail.net>
References: <201006100040.54375.johan@herland.net> <5ep6Hc9Nl3QLKwV46xET5ZLhqo2uNlnUL1-nNsG9p2IWyX-odykArvT4ontRdeBUA9ouCPQGFwQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: johan@herland.net, git@vger.kernel.org, srabbelier@gmail.com,
	davvid@gmail.com, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Jun 10 11:29:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMe4h-0005Lg-CS
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 11:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755748Ab0FJJ3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 05:29:18 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:47626 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753038Ab0FJJ3R (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jun 2010 05:29:17 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 85404F881C;
	Thu, 10 Jun 2010 05:28:53 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 10 Jun 2010 05:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Ao35eS5+WmkQjTpGnKYrYkgDGIo=; b=oJ81jXO8UGSPMKdR2hcwFo5kAHvBPHxR4uTmkXx30jIGsCuoDtJpIPcBeOkZcNfV2ACIGDu/GiFw8EEdlZun8FYMJt5FJrs/aUc8v8/ji8/BOddLdXiaH3TyidyH1wm+N0UKRlOh7A6zZFgYN501oobYMqoTIW8MHI9/4NR50Bs=
X-Sasl-enc: zTiPU5yMGrZFfLCaEsPbzCFh8C2T3aSXhziWAW/jGb24 1276162128
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 52FA46067D;
	Thu, 10 Jun 2010 05:28:47 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100610 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <5ep6Hc9Nl3QLKwV46xET5ZLhqo2uNlnUL1-nNsG9p2IWyX-odykArvT4ontRdeBUA9ouCPQGFwQ@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148848>

Brandon Casey venit, vidit, dixit 10.06.2010 02:24:
> From: Brandon Casey <drafnel@gmail.com>
> 
> The following python 2.5 features were worked around:
> 
>     * the sha module is used as a fallback when the hashlib module is
>       not available
>     * the 'any' built-in method was replaced with a 'for' loop
>     * a conditional expression was replaced with an 'if' statement
>     * the subprocess.check_call method was replaced by a call to
>       subprocess.Popen followed by a call to subprocess.wait with a
>       check of its return status
> 
> These changes allow the python infrastructure to be used with python 2.4
> which is distributed with RedHat's RHEL 5, for example.
> 
> t5800 was updated to check for python >= 2.4 to reflect these changes.
> 
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
> 
> 
> On 06/09/2010 05:40 PM, Johan Herland wrote:
> 
>> On my Python v2.6.5. I get the following:
>>
>>>>> import sha
>> __main__:1: DeprecationWarning: the sha module is deprecated; use the 
>> hashlib module instead
>>
>> This is added to the output of every python program that imports sha. I 
>> believe we should really try to use the hashlib module when available, and 
>> only fall back to sha when necessary. Please use something like this 
>> instead:
>>
>>   # hashlib is only available in python >= 2.5 
>>   try: 
>>       import hashlib 
>>       _digest = hashlib.sha1 
>>   except ImportError: 
>>       import sha
>>       _digest = sha.sha 
>>
>> so that we don't get the hideous DeprecationWarning.
> 
> Like this? ...
> 
> 
>  git-remote-testgit.py               |   15 ++++++++++++---
>  git_remote_helpers/git/exporter.py  |    4 +++-
>  git_remote_helpers/git/importer.py  |    4 +++-
>  git_remote_helpers/git/non_local.py |   16 ++++++++++++----
>  git_remote_helpers/git/repo.py      |    9 +++++++--
>  t/t5800-remote-helpers.sh           |    4 ++--
>  6 files changed, 39 insertions(+), 13 deletions(-)
> 
> diff --git a/git-remote-testgit.py b/git-remote-testgit.py
> index 9253922..df9d512 100644
> --- a/git-remote-testgit.py
> +++ b/git-remote-testgit.py
> @@ -1,6 +1,12 @@
>  #!/usr/bin/env python
>  
> -import hashlib
> +# hashlib is only available in python >= 2.5
> +try:
> +    import hashlib
> +    _digest = hashlib.sha1
> +except ImportError:
> +    import sha
> +    _digest = sha.new
>  import sys
>  import os
>  sys.path.insert(0, os.getenv("GITPYTHONLIB","."))

Doesn't P2.4 have

	from hashlib import sha1 as _digest

etc.? I haven't checked for "as".

Michael
