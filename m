From: Dmitry Neverov <dmitry.neverov@jetbrains.com>
Subject: Re: submodule update and core.askpass
Date: Fri, 22 Nov 2013 16:33:44 +0400
Message-ID: <m2wqk0zkd3.fsf@nds-macbook-air.labs.intellij.net>
References: <m28uwoxcoh.fsf@nds-macbook-air.labs.intellij.net> <87eh6gkoq9.fsf@linux-k42r.v.cablecom.net> <5287F42D.5090900@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Daniel =?utf-8?Q?Gra=C3=B1a?= <dangra@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>, Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Fri Nov 22 13:33:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vjpvg-00026D-Dy
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 13:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755260Ab3KVMdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 07:33:44 -0500
Received: from mail1.intellij.net ([46.137.178.215]:50789 "EHLO
	mail1.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956Ab3KVMdo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 07:33:44 -0500
Received: (qmail 1120 invoked by uid 89); 22 Nov 2013 12:33:42 -0000
Received: from unknown (HELO nds-macbook-air.labs.intellij.net) (Dmitry.Neverov@jetbrains.com@81.3.129.2)
  by ip-10-62-119-91.eu-west-1.compute.internal with ESMTPA; 22 Nov 2013 12:33:41 -0000
In-Reply-To: <5287F42D.5090900@web.de>
User-Agent: Notmuch/0.16 (http://notmuchmail.org) Emacs/24.2.92.1 (x86_64-apple-darwin12.2.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238181>

BTW, a workaround is to pass a path to askpass script in the GIT_ASKPASS
environment variable. 
Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 16.11.2013 22:42, schrieb Thomas Rast:
>> Dmitry Neverov <dmitry.neverov@jetbrains.com> writes:
>> 
>>> git -c core.askpass=pass.sh clone main-repo
>>> cd main-repo
>>> git submodule init
>>> git submodule sync
>>> git -c core.askpass=pass.sh submodule update
>>>
>>> The last command asks for a password interactively. 
>>>
>>> I've run bisect, it seems like it started failing from commit
>>> be8779f7ac9a3be9aa783df008d59082f4054f67. I've checked: submodule update
>>> works fine in 1.8.5.rc2 with removed call to clear_local_git_env.
>> 
>> Aside from GIT_CONFIG_PARAMETERS, which this needs ...
>
> Yes, if I understand GIT_CONFIG_PARAMETERS correctly we should not
> clean it as the user explicitly asked us to use that setting.
>
>> ..., I wonder if we
>> should also let other variables pass through.  For example, if the user
>> went out of their way to set GIT_ALTERNATE_OBJECT_DIRECTORIES, shouldn't
>> we also respect that?
>
> Hmm, I'm not so sure. Does the user really want the setting of
> GIT_ALTERNATE_OBJECT_DIRECTORIES to be honored inside the submodule
> too or would he want a different setting (including none)? I suspect
> different users would give different answers. And wouldn't a working
> GIT_CONFIG_PARAMETERS (or configuring the submodule after the initial
> clone) be the solution for that?
>
>> The list of variables that is unset by clear_local_git_env is $(git
>> rev-parse --local-env-vars), currently
>> 
>>   GIT_ALTERNATE_OBJECT_DIRECTORIES
>>   GIT_CONFIG
>>   GIT_CONFIG_PARAMETERS
>>   GIT_OBJECT_DIRECTORY
>>   GIT_DIR
>>   GIT_WORK_TREE
>>   GIT_IMPLICIT_WORK_TREE
>>   GIT_GRAFT_FILE
>>   GIT_INDEX_FILE
>>   GIT_NO_REPLACE_OBJECTS
>>   GIT_PREFIX
>
>

-- 
Dmitry Neverov
JetBrains
http://www.jetbrains.com
"Develop with pleasure!"
