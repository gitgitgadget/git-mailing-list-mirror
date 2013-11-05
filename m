From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH V4] git clone: is an URL local or ssh
Date: Tue, 05 Nov 2013 08:14:45 +0100
Message-ID: <52789AE5.2010702@viscovery.net>
References: <201311042220.50178.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 05 08:14:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vdaqk-0007Oh-JD
	for gcvg-git-2@plane.gmane.org; Tue, 05 Nov 2013 08:14:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497Ab3KEHOu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Nov 2013 02:14:50 -0500
Received: from so.liwest.at ([212.33.55.16]:57759 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911Ab3KEHOt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Nov 2013 02:14:49 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Vdaqb-0001l6-He; Tue, 05 Nov 2013 08:14:45 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 45B2816613;
	Tue,  5 Nov 2013 08:14:45 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <201311042220.50178.tboegi@web.de>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237323>

Am 11/4/2013 22:20, schrieb Torsten B=C3=B6gershausen:
> Bug fix for msygit in t5601 : use $PWD insted of $(pwd)

Not really. $PWD is /c/foo/bar style, but $(pwd) is c:/foo/bar, which i=
s
equally good.

>  test_expect_success 'clone with excess parameters (2)' '
> =20
>  	rm -fr dst &&
> -	test_must_fail git clone -n "file://$(pwd)/src" dst junk
> +	test_must_fail git clone -n "file://$PWD/src" dst junk

That the code change necessitates this change in the test suite is a si=
gn
that there is something wrong with the new code.

And indeed, the original works:

C:\Temp\gittest>git clone -n file://c:/Temp/gittest/foo good
Cloning into 'good'...
remote: Counting objects: 2, done.
remote: Total 2 (delta 0), reused 0 (delta 0)
Receiving objects: 100% (2/2), done.
Checking connectivity... done.

but the changed code does not:

C:\Temp\gittest>D:\src\mingw-git\git clone -n file://c:/Temp/gittest/fo=
o bad
Cloning into 'bad'...
fatal: 'D:/Src/MsysGit/Temp/gittest/foo' does not appear to be a git re=
pository
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.


Can you please make this into a series of small patches so that we can
more easily see the good and the bad parts? One of the patches could be=
 a
clean-up of the current protocol determination and URL dissection, whic=
h
is indigestible spaghetti right now.

-- Hannes
