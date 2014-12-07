From: Olivier Croquette <ocroquette@free.fr>
Subject: Re: Fetching a specific commit by commit ID
Date: Sun, 7 Dec 2014 11:15:10 +0100
Message-ID: <F6468265-A6B4-4065-A3F0-3F198421C08F@free.fr>
References: <0EA82B66-7DDD-40A9-BB9C-94D3B1B43DBB@free.fr> <20141206155210.GA22146@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sun Dec 07 11:15:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxYs9-0007ve-Ek
	for gcvg-git-2@plane.gmane.org; Sun, 07 Dec 2014 11:15:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001AbaLGKPW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Dec 2014 05:15:22 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:65337 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752916AbaLGKPV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Dec 2014 05:15:21 -0500
Received: from [192.168.1.101] ([178.26.97.1]) by mrelayeu.kundenserver.de
 (mreue001) with ESMTPSA (Nemesis) id 0M0Y1e-1Xhofm0ho6-00upN9; Sun, 07 Dec
 2014 11:15:12 +0100
In-Reply-To: <20141206155210.GA22146@vauxhall.crustytoothpaste.net>
X-Mailer: Apple Mail (2.1878.6)
X-Provags-ID: V03:K0:SRRwZwUS4hSpmr6rRpSp/FgI3TXqr2R0tn2gvEFu7SzGfEJmNhu
 fb9kY664v+72cXwE61PBHxKepZqubpyihrdEtyeU5FykmTI/QzslRziPDViY/uBuTG9u6I0
 jxeejdNFkgOCKZdTziXFPcs4nMJ6ujCI9IE4Zea85RP5U/jg2BZxSSHZWzM+KZr9rcAXCHo
 QfrIcmif/QgzBHR/N4X1A==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260984>

On 06 Dec 2014, at 16:52, brian m. carlson <sandals@crustytoothpaste.ne=
t> wrote:

>> - more interestingly: is there any reason why git fetch should not
>>  support fetching by commit id? There are real world use cases where
>>  this can be very useful, for instance when references on the remote
>>  have been overwritten or deleted.
>=20
> The reason this isn't supported in the general case is because one mi=
ght
> want to restrict access to certain branches.  For example, an open
> source project might want to embargo some security fixes that are in =
the
> repository.  Allowing a user to specify an arbitrary ID would permit
> someone to circumvent those access controls.

Shouldn=92t these checks be implemented in the layers above, eg. in git=
olite, gitosis, gerrit=85 ? Having it in git itself makes it impossible=
 in all cases, even for projects/repositories with no ref-specific read=
 restrictions (the vast majority of projects, I would guess).

It seems pretty straightforward to support access control in these laye=
rs. If a commit id is provided, go through all references of the reposi=
tory, if one is found that is a child of the given commit, and the user=
 has access to the ref, then it=92s ok to fetch the commit. Of course i=
t=92s an expensive operation, but it=92s is rarely required.
