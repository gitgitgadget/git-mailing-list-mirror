From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: git-svn and renames
Date: Tue, 10 Jul 2007 16:18:52 +0200
Message-ID: <4693954C.90907@dawes.za.net>
References: <46938594.2010607@dawes.za.net> <86fy3wpf95.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jul 10 16:19:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8GYz-00025H-7K
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 16:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160AbXGJOTe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 10:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbXGJOTe
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 10:19:34 -0400
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:52625 "EHLO
	spunkymail-a15.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753120AbXGJOTd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jul 2007 10:19:33 -0400
Received: from [192.168.201.103] (dsl-146-24-230.telkomadsl.co.za [165.146.24.230])
	by spunkymail-a15.dreamhost.com (Postfix) with ESMTP id B67857F066;
	Tue, 10 Jul 2007 07:19:28 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (Windows/20070604)
In-Reply-To: <86fy3wpf95.fsf@lola.quinscape.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52077>

David Kastrup wrote:
> Rogan Dawes <lists@dawes.za.net> writes:
> 
>> However, when I try to push this change to the Google repo, git-svn
>> dies with the following error:
>>
>> $ git svn dcommit
>> RA layer request failed: PROPFIND request failed on '/svn/trunk/
>> webgoat/main/project/JavaSource/org/owasp/webgoat/lessons/DefaultLessonAction.java':
>> PROPFIND of '/svn/trunk/
>> webgoat/main/project/JavaSource/org/owasp/webgoat/lessons/DefaultLessonAction.java':
>> 400 Bad Request (https://webgoat.googlecode.com) at
>> /home/rdawes/bin/git-svn line 400
>>
>> [Yes, those paths have a space in them, however this does not seem to
>> have prevented me from committing the previous 20 or so changes.]
>>
>> I noted the following in the git-svn documentation, with regards to
>> handling renames. However, I am not renaming a directory, only a
>> couple of files.
> 
>> ---- quote ----
> 
> [...]
>> Renamed and copied directories are not detected by git and hence not
>> tracked when committing to SVN.  I do not plan on adding support for
>> this as it's quite difficult and time-consuming to get working for all
>> the possible corner cases (git doesn't do it, either).  Committing
>> renamed and copied files are fully supported if they're similar enough
>> for git to detect them.
> 
>> Any ideas?
> 
>   dcommit          Commit several diffs to merge with upstream
>                      --quiet, -q 
>                      --fetch-all, --all 
>                      --no-auth-cache 
>                      --no-rebase 
>                      --no-checkout 
>                      --rmdir 
>                      --dry-run, -n 
>                      --find-copies-harder 
>                      --follow-parent, --follow! 
>                      --authors-file, -A <arg>
>                      --copy-similarity, -C <num>
>                      --username <arg>
>                      --repack-flags, --repack-args, --repack-opts <arg>
>                      --repack <num>
>                      --verbose, -v 
>                      --edit, -e 
>                      --log-window-size <num>
>                      --config-dir <arg>
>                      -l <num>
>                      --merge, -m, -M 
>                      --strategy, -s <arg>
> 
> 
> Try playing with the --copy-similarity and --find-copies-harder flags.
> 

Thanks for the suggestion.

However, even going all the way to 50% had no impact. I get the exact 
same message.

$ git svn --find-copies-harder -C 50 dcommit
RA layer request failed: PROPFIND request failed on '/svn/trunk/ 
webgoat/main/project/JavaSource/org/owasp/webgoat/lessons/DefaultLessonAction.java': 
PROPFIND of '/svn/trunk/ 
webgoat/main/project/JavaSource/org/owasp/webgoat/lessons/DefaultLessonAction.java': 
400 Bad Request (https://webgoat.googlecode.com) at 
/home/rdawes/bin/git-svn line 400

Unfortunately, the error seems to be in the SVN::Ra library, and I can 
find no way to enable debugging output on this code.

One thing I did note is that performing a dry-run completes successfully:

$ git svn dcommit -n
diff-tree 486416188a3e49d60e1510166ac197e5e66cc4d2~1 
486416188a3e49d60e1510166ac197e5e66cc4d2
diff-tree e0100ee6353c2160eca642ec600639004d92a99e~1 
e0100ee6353c2160eca642ec600639004d92a99e
diff-tree ba64aa781efdc31a4ffceed8648ece45ac955186~1 
ba64aa781efdc31a4ffceed8648ece45ac955186
diff-tree 23202df6f1533bf79c0ad127fdcb06db35d8b634~1 
23202df6f1533bf79c0ad127fdcb06db35d8b634
diff-tree 42af98c396e66cc2c0377e267e5431414fb8d580~1 
42af98c396e66cc2c0377e267e5431414fb8d580
diff-tree 16c76a9129cb66378851bb0bec8e983354d0c936~1 
16c76a9129cb66378851bb0bec8e983354d0c936
diff-tree d1a1992abfdcba1a97989c29dd0f25257b03f16a~1 
d1a1992abfdcba1a97989c29dd0f25257b03f16a
diff-tree dc7071e954e33a0c859db575f3b4be767194fa7e~1 
dc7071e954e33a0c859db575f3b4be767194fa7e
diff-tree 107ef202137ba38325c28b95983ded23d67cae89~1 
107ef202137ba38325c28b95983ded23d67cae89
diff-tree 01891b7a0cc03234145a29582dbd5061aed0b347~1 
01891b7a0cc03234145a29582dbd5061aed0b347
diff-tree f047c06823632a10379255957302698375e62d26~1 
f047c06823632a10379255957302698375e62d26
diff-tree 634664ef291c5f33594202dec9f5e081348e10d2~1 
634664ef291c5f33594202dec9f5e081348e10d2
diff-tree 13e731927bc32e27a240cba647f1c6425cea6247~1 
13e731927bc32e27a240cba647f1c6425cea6247
diff-tree df62b0a2ef3f5556b52b933b08409dc05a2ba671~1 
df62b0a2ef3f5556b52b933b08409dc05a2ba671
diff-tree 745ec078b881cc87234a7bfe59635f7856094d8e~1 
745ec078b881cc87234a7bfe59635f7856094d8e
diff-tree 91b08b5f2bc6bc1d235cb9d624be23346c5a2749~1 
91b08b5f2bc6bc1d235cb9d624be23346c5a2749
diff-tree 8c1805e3be9595099832d9c55cdf740f3c20bd16~1 
8c1805e3be9595099832d9c55cdf740f3c20bd16
diff-tree b06b234c5dbb046e4a56ee30f4a8b1bf17758794~1 
b06b234c5dbb046e4a56ee30f4a8b1bf17758794
diff-tree 52313b6cb19fc962a7c51eacf9016870b93e2467~1 
52313b6cb19fc962a7c51eacf9016870b93e2467
diff-tree 8689b19c8fc48a603c0b9992a7ba04f7e57f4e70~1 
8689b19c8fc48a603c0b9992a7ba04f7e57f4e70
diff-tree 23e348e97ee5220e7514249a163647b187aa4f8b~1 
23e348e97ee5220e7514249a163647b187aa4f8b
diff-tree 76479ab494bd6edfa306271be0919d4b210d1296~1 
76479ab494bd6edfa306271be0919d4b210d1296

[word wrapped, unfortunately]

Thanks for your help.

Regards,

Rogan
