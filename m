From: Manuel Koller <koller.manuel@gmail.com>
Subject: Re: Git Submodule Problem - Bug?
Date: Tue, 29 Nov 2011 19:15:39 +0100
Message-ID: <839E634E-76C0-40ED-8CCC-43E52F782079@gmail.com>
References: <38AE3033-6902-48AA-819B-DB4083F1F8EF@gmail.com> <201111291024.01230.trast@student.ethz.ch> <20111129101546.GB2829@kolya> <201111291125.41943.trast@student.ethz.ch> <20111129104105.GA10839@kolya> <4ED5196B.5030200@web.de>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Nov 29 19:15:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVSDc-0003UC-Ce
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 19:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756075Ab1K2SPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Nov 2011 13:15:44 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45396 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754722Ab1K2SPn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2011 13:15:43 -0500
Received: by eaak14 with SMTP id k14so3432946eaa.19
        for <git@vger.kernel.org>; Tue, 29 Nov 2011 10:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=ywcrTN1UEMXqDL0nPddlxIewBEmBkfFlkW5f0o/BhXo=;
        b=xEcFF931UJyfEDliRxWRAF2oh1rIiAEL8gEla+aNwjg3i+7lfv9FC52vvMpxLdkadr
         tN4odaClck8bcwfGE4auQ0rGr2rp4I265ukvYDUHi/Eg/PjKDExBMEG5FtK5dK4Q1J/B
         NbrVYWt4ljEadJDoLJUJfIBCkjHAtrp3e1kCg=
Received: by 10.216.132.144 with SMTP id o16mr96284wei.63.1322590541736;
        Tue, 29 Nov 2011 10:15:41 -0800 (PST)
Received: from [192.168.1.5] (178-83-214-151.dynamic.hispeed.ch. [178.83.214.151])
        by mx.google.com with ESMTPS id eg7sm4149725wib.8.2011.11.29.10.15.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Nov 2011 10:15:41 -0800 (PST)
In-Reply-To: <4ED5196B.5030200@web.de>
X-Mailer: Apple Mail (2.1251.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186067>

Thanks for taking my problem seriously.

On 29.11.2011, at 18:42, Jens Lehmann wrote:

> Am 29.11.2011 11:41, schrieb Fredrik Gustafsson:
>> On Tue, Nov 29, 2011 at 11:25:41AM +0100, Thomas Rast wrote:
>>> So maybe the right questions to ask would be: what's the *official*
>>> way of removing a submodule completely?  Do we support overwriting
>>> submodules in the way Manuel wanted to?  Why not? :-)
>> 
>> I suggest that we add a command for that;
>> git submodule remove <submodule>
> 
> Hmm, to me it looks like the problem is in "git submodule add". It
> doesn't check if the submodule repo it finds in .git/modules matches
> the one the user wants to create. So we end up reviving the first
> submodule although the user wants to use a completely different repo.

In have wrote a workaround for the problem i posted that goes into this direction. I just check whether the url has changed and remove the submodule by hand if it did. See https://github.com/kollerma/git-submodule-tools if you're interested (its in git-fix-submodules).

> One solution could be to only let "git submodule update" revive
> submodules from .git/modules and make "git submodule add" error out
> if it finds the git directory of a submodule with the same name in
> .git/modules. But currently there is no way to tell "git submodule add"
> to use a different submodule name (it always uses the path as a name),
> so we might have to add an option to do that and tell the user in the
> error message how he can add a different submodule under the same
> path.
> 
> Another solution could be that "git submodule add" detects that a
> submodule with the name "sub" did exist and chooses a different name
> (say "sub2") for the the new one. Then the user wouldn't have to
> cope with the problem himself.

What is the purpose of having two different submodules in the same path? Identifying the submodule by url however would probably make things considerably faster. At least in my case, since I have checked out different branches of the same repo at different paths as submodules. 