From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: submodule update and core.askpass
Date: Sat, 16 Nov 2013 23:39:41 +0100
Message-ID: <5287F42D.5090900@web.de>
References: <m28uwoxcoh.fsf@nds-macbook-air.labs.intellij.net> <87eh6gkoq9.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-15?Q?Daniel_Gra=F1a?= <dangra@gmail.com>
To: Thomas Rast <tr@thomasrast.ch>,
	Dmitry Neverov <dmitry.neverov@jetbrains.com>
X-From: git-owner@vger.kernel.org Sat Nov 16 23:39:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhoWp-0001zO-Is
	for gcvg-git-2@plane.gmane.org; Sat, 16 Nov 2013 23:39:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559Ab3KPWjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Nov 2013 17:39:44 -0500
Received: from mout.web.de ([212.227.17.11]:62275 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753202Ab3KPWjn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Nov 2013 17:39:43 -0500
Received: from [192.168.178.41] ([91.3.128.91]) by smtp.web.de (mrweb004) with
 ESMTPA (Nemesis) id 0MGCm7-1Vt2GQ2rtX-00FBGs for <git@vger.kernel.org>; Sat,
 16 Nov 2013 23:39:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <87eh6gkoq9.fsf@linux-k42r.v.cablecom.net>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:gWGYQAN0vuwz1OFpERFYQOSgNue45O8ARr5CB/Ze+pof+8wteoN
 jHJW591twRNfKPjM+j+i4IRLE6aw9IlpFUxmow6233Z6qG0xMro7Zs1qnpYj2uH9MBGi9oW
 JYjq6itgor3Vpf91BFfwUVw3hHsyTYo3InU6ewBW4VcR+onJ2JSRsfFaZEoxZY96qPYO7pH
 WCF2plDrO95nbT/5fJCug==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237942>

Am 16.11.2013 22:42, schrieb Thomas Rast:
> Dmitry Neverov <dmitry.neverov@jetbrains.com> writes:
> 
>> git -c core.askpass=pass.sh clone main-repo
>> cd main-repo
>> git submodule init
>> git submodule sync
>> git -c core.askpass=pass.sh submodule update
>>
>> The last command asks for a password interactively. 
>>
>> I've run bisect, it seems like it started failing from commit
>> be8779f7ac9a3be9aa783df008d59082f4054f67. I've checked: submodule update
>> works fine in 1.8.5.rc2 with removed call to clear_local_git_env.
> 
> Aside from GIT_CONFIG_PARAMETERS, which this needs ...

Yes, if I understand GIT_CONFIG_PARAMETERS correctly we should not
clean it as the user explicitly asked us to use that setting.

> ..., I wonder if we
> should also let other variables pass through.  For example, if the user
> went out of their way to set GIT_ALTERNATE_OBJECT_DIRECTORIES, shouldn't
> we also respect that?

Hmm, I'm not so sure. Does the user really want the setting of
GIT_ALTERNATE_OBJECT_DIRECTORIES to be honored inside the submodule
too or would he want a different setting (including none)? I suspect
different users would give different answers. And wouldn't a working
GIT_CONFIG_PARAMETERS (or configuring the submodule after the initial
clone) be the solution for that?

> The list of variables that is unset by clear_local_git_env is $(git
> rev-parse --local-env-vars), currently
> 
>   GIT_ALTERNATE_OBJECT_DIRECTORIES
>   GIT_CONFIG
>   GIT_CONFIG_PARAMETERS
>   GIT_OBJECT_DIRECTORY
>   GIT_DIR
>   GIT_WORK_TREE
>   GIT_IMPLICIT_WORK_TREE
>   GIT_GRAFT_FILE
>   GIT_INDEX_FILE
>   GIT_NO_REPLACE_OBJECTS
>   GIT_PREFIX
