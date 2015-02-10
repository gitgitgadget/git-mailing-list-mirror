From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH] contrib/completion: suppress stderror in bash
Date: Tue, 10 Feb 2015 03:10:08 +0100
Message-ID: <20150210031008.Horde.1WYJ_81O2E96Rgv2xrVmqw1@webmail.informatik.kit.edu>
References: <1423515508-40109-1-git-send-email-MKorostoff@gmail.com>
 <xmqqy4o6aj1w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matt Korostoff <mkorostoff@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 03:10:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YL0HO-0003x0-Ey
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 03:10:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761479AbbBJCKP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Feb 2015 21:10:15 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:50590 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756365AbbBJCKO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 9 Feb 2015 21:10:14 -0500
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1YL0H8-0004Ik-Sq; Tue, 10 Feb 2015 03:10:06 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1YL0HA-00070I-RG; Tue, 10 Feb 2015 03:10:08 +0100
Received: from x590e6356.dyn.telefonica.de (x590e6356.dyn.telefonica.de
 [89.14.99.86]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Tue, 10 Feb 2015 03:10:08 +0100
In-Reply-To: <xmqqy4o6aj1w.fsf@gitster.dls.corp.google.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1423534206.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263623>


Hi,


Quoting Junio C Hamano <gitster@pobox.com>:

> Matt Korostoff <mkorostoff@gmail.com> writes:

>> diff --git a/contrib/completion/git-completion.bash
>> b/contrib/completion/git-completion.bash
>> index 2fece98..72251cc 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -412,7 +412,7 @@ __git_refs_remotes ()
>>  __git_remotes ()
>>  {
>>  	local i IFS=3D$'\n' d=3D"$(__gitdir)"
>> -	test -d "$d/remotes" && ls -1 "$d/remotes"
>> +	test -d "$d/remotes" && ls -1 "$d/remotes" 2>/dev/null
>>  	for i in $(git --git-dir=3D"$d" config --get-regexp
>> 'remote\..*\.url' 2>/dev/null); do
>>  		i=3D"${i#remote.}"
>>  		echo "${i/.url*/}"

Do I smell some bitrotting here?

This function just lists all the defined remotes, first by listing the =
=20
directories under refs/remotes to get the "legacy" remotes and then =20
loops over 'git config's output to get the "modern" ones.  This =20
predates the arrival of the 'git remote' command in January 2007, so =20
it was really a long time ago.

We should just run 'git remote' instead, shouldn't we?


Cheers,
G=C3=A1bor
