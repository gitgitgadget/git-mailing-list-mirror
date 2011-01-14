From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: weird github capitalization problem
Date: Fri, 14 Jan 2011 13:11:09 +0100
Message-ID: <4D303D5D.6090108@web.de>
References: <1294146242606-5888573.post@n2.nabble.com> <4D26DA12.50002@futurelab.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: bolfo <boflor@gmail.com>, git@vger.kernel.org, tboegi@web.de
To: Andreas Stricker <astricker@futurelab.ch>
X-From: git-owner@vger.kernel.org Fri Jan 14 13:11:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdiUw-0000jM-6D
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 13:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756907Ab1ANMLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 07:11:14 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:34816 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884Ab1ANMLM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 07:11:12 -0500
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate03.web.de (Postfix) with ESMTP id E7CF61840D34A;
	Fri, 14 Jan 2011 13:11:10 +0100 (CET)
Received: from [213.64.3.195] (helo=birne.lan)
	by smtp01.web.de with asmtp (WEB.DE 4.110 #24)
	id 1PdiUo-0005Kp-00; Fri, 14 Jan 2011 13:11:10 +0100
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <4D26DA12.50002@futurelab.ch>
X-Sender: tboegi@web.de
X-Provags-ID: V01U2FsdGVkX190IvDwbylVBVpTTnWS+Q0+CMrL8eANCn1/TfJd
	rWlZLvehgJZLT0DtWGHpSlJHgJ25MZ/wMbqSKEqcWlE8S98Dtk
	fHz18/ZNo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165095>

On 07.01.11 10:17, Andreas Stricker wrote:
> Am 04.01.11 14:04, schrieb bolfo:
>> I first installed everything on my laptop, coded some stuff and then pushed
>> to github. Apparently something went wrong because there was a new
>> directory, while at first the directory was OurProjectsources, there now was
>> a new directory called OurProjectSources. Weird since my local directory has
>> the s not capitalized.
>
>> I work on a windows PC while the original author works on a Mac, could this
>> be the problem?
>
> Yes, Mac OSX HFS+ filesystem ignores the case by default (you'll need
> to reformat to change this). So OurProjectSources and OurProjectsources
> both refers to the same directory on Mac OS X. On Linux there are two
> different directories
>
> This frequently causes issues here too. An example:
>
> me@mac:t $ git init r
> Initialized empty Git repository in /private/tmp/t/r/.git/
> me@mac:r (master) $ mkdir OurProjectsources
> me@mac:r (master) $ touch OurProjectsources/a
> me@mac:r (master) $ git add OurProjectsources/a
> me@mac:r (master) $ git commit -m "initial import"
> [master (root-commit) c2cb2f3] initial import
>   0 files changed, 0 insertions(+), 0 deletions(-)
>   create mode 100644 OurProjectsources/a
> me@mac:r (master) $ mv OurProjectsources/ OurProjectSources
> me@mac:r (master) $ touch OurProjectSources/b
> me@mac:r (master) $ git add OurProjectSources/b
> me@mac:r (master) $ git commit -m "added b"
> [master 4de780c] added b
>   0 files changed, 0 insertions(+), 0 deletions(-)
>   create mode 100644 OurProjectSources/b
> me@mac:r (master) $ git stat
> # On branch master
> nothing to commit (working directory clean)
> me@mac:r (master) $ scp -r .git linux:t.git
> me@mac:r (master) $ ssh linux
>
> me@linux:~ $ git clone t.git/
> Initialized empty Git repository in /home/me/t/.git/
> me@linux:~ $ cd t
> me@linux:~/t $ ls
> OurProjectsources  OurProjectSources
> me@linux:~/t $ find *
> OurProjectsources
> OurProjectsources/a
> OurProjectSources
> OurProjectSources/b
>
> And there it is, our mess. The mac user accidentally created
> two different directories but didn't see them.
>
> ~/Andy
>

The following is on next from git.git:
(And more commits fixing more core.ignorecase issues)
You might give it a try.
HTH
/Torsten



commit 50906e04e8f48215b0b09841686709b92a2ab2e4
Author: Joshua Jensen <jjensen@workspacewhiz.com>
Date:   Sun Oct 3 09:56:46 2010 +0000

     Support case folding in git fast-import when core.ignorecase=true

     When core.ignorecase=true, imported file paths will be folded to match
     existing directory case.

     Signed-off-by: Joshua Jensen <jjensen@workspacewhiz.com>
     Signed-off-by: Johannes Sixt <j6t@kdbg.org>
     Signed-off-by: Junio C Hamano <gitster@pobox.com>
