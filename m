From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH] contrib/completion: suppress stderror in bash
Date: Wed, 04 Mar 2015 15:04:47 +0100
Message-ID: <20150304150447.Horde.t4rJ5Q_QdRg1uznQKWetMg1@webmail.informatik.kit.edu>
References: <1423515508-40109-1-git-send-email-MKorostoff@gmail.com>
 <xmqqy4o6aj1w.fsf@gitster.dls.corp.google.com>
 <20150210031008.Horde.1WYJ_81O2E96Rgv2xrVmqw1@webmail.informatik.kit.edu>
 <xmqqegpxwrdc.fsf@gitster.dls.corp.google.com>
 <20150210201648.Horde.QMVdqmJIJnvLkf0U46NdYA1@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matt Korostoff <mkorostoff@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 15:05:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT9vL-0007nV-8i
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 15:05:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757755AbbCDOFL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Mar 2015 09:05:11 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:33115 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756006AbbCDOFK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 4 Mar 2015 09:05:10 -0500
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1YT9v8-0005cs-7G; Wed, 04 Mar 2015 15:05:06 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1YT9up-0000JP-4A; Wed, 04 Mar 2015 15:04:47 +0100
Received: from x590c628a.dyn.telefonica.de (x590c628a.dyn.telefonica.de
 [89.12.98.138]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Wed, 04 Mar 2015 15:04:47 +0100
In-Reply-To: <20150210201648.Horde.QMVdqmJIJnvLkf0U46NdYA1@webmail.informatik.kit.edu>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1425477906.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264758>

Hi,


Quoting SZEDER G=C3=A1bor <szeder@ira.uka.de>:

> Hi,
>
> Quoting Junio C Hamano <gitster@pobox.com>:
>
>> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>>
>>>>> @@ -412,7 +412,7 @@ __git_refs_remotes ()
>>>>> __git_remotes ()
>>>>> {
>>>>> 	local i IFS=3D$'\n' d=3D"$(__gitdir)"
>>>>> -	test -d "$d/remotes" && ls -1 "$d/remotes"
>>>>> +	test -d "$d/remotes" && ls -1 "$d/remotes" 2>/dev/null
>>>>> 	for i in $(git --git-dir=3D"$d" config --get-regexp
>>>>> 'remote\..*\.url' 2>/dev/null); do
>>>>> 		i=3D"${i#remote.}"
>>>>> 		echo "${i/.url*/}"
>>>
>>> Do I smell some bitrotting here?
>>>
>>> This function just lists all the defined remotes, first by listing =
the
>>> directories under refs/remotes to get the "legacy" remotes and then
>>> loops over 'git config's output to get the "modern" ones.  This
>>> predates the arrival of the 'git remote' command in January 2007, s=
o
>>> it was really a long time ago.
>>>
>>> We should just run 'git remote' instead, shouldn't we?
>>
>> Perhaps.  Is it sufficient to just make __git_remotes() a thin
>> wrapper around, i.e.
>>
>> 	__git_remotes ()
>> 	{
>> 		git remotes
>> 	}
>>
>> or do we need to munge its output further (I didn't look)?
>
> Well, just like in other cases where we run git from the completion
> script, we need a '--git-dir=3D"$(__gitdir)"' as well, because the us=
er can
> specify the path to a different repo via $GIT_DIR or on the command
> line.
> Other than that it seems we are OK.  Docs say "With no arguments,
> shows a list of existing remotes." and as far as I can tell, on
> MSysGit, it does so without any funny formatting.

Oh, look what forgotten treasure did I stumble upon in the vaults:

   =20
https://github.com/szeder/git/commit/e4e3760c15b485b9ff4768e13050f4b19b=
5968b8

A two and a half year old commit in my old git repo doing the same...  =
=20
completely forgotten :)

Unfortunately, however, it's not quite that simple, because 'git =20
remote' doesn't list remotes under '$GIT_DIR/remotes'.  Or at least I =20
would have expected the following test to work, but it does not:

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 17c6330..6a4c139 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -734,6 +734,15 @@ Pull: refs/heads/master:refs/heads/origin
  Pull: refs/heads/next:refs/heads/origin2
  EOF

+test_expect_success 'list remote in $GIT_DIR/remotes' '
+	mkdir .git/remotes &&
+	test_when_finished "rm -rf .git/remotes" &&
+	cat remotes_origin >.git/remotes/remote_from_file &&
+	git remote >actual &&
+	echo remote_from_file >expect &&
+	test_cmp expect actual
+'
+
  test_expect_success 'migrate a remote from named file in $GIT_DIR/rem=
otes' '
  	git clone one five &&
  	origin_url=3D$(pwd)/one &&

because listing remotes is implemented by for_each_remote(), which =20
only reads remotes from the config file.

Now, considering how old 'git remote' is, there were plenty of time =20
for someone to miss this functionality and complain about it, but =20
since it's still not implemented is probably a good sign that noone =20
has actually missed it.  And I don't think it's worth implementing it =20
now just to shave off two more lines from the completion script.

Anyway, 'git remote' could still replace that 'git config' query.  I =20
have the patches ready and it seems I got send-email working, so =20
they'll follow in a minute or two.

Best,
G=C3=A1bor
