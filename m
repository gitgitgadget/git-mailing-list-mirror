From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Q: ".git/HEAD" and ".git/refs/heads"
Date: Wed, 02 Apr 2014 19:54:00 +0200
Message-ID: <vpqob0jwrbb.fsf@anie.imag.fr>
References: <533C404F020000A1000151CE@gwsmtp1.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Thu Apr 03 12:29:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeTV-0000xS-EF
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 12:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932725AbaDBRyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 13:54:09 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51746 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932541AbaDBRyG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 13:54:06 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s32HrwQT006389
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 2 Apr 2014 19:53:58 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s32Hs07R012736;
	Wed, 2 Apr 2014 19:54:00 +0200
In-Reply-To: <533C404F020000A1000151CE@gwsmtp1.uni-regensburg.de> (Ulrich
	Windl's message of "Wed, 02 Apr 2014 16:52:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 02 Apr 2014 19:53:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s32HrwQT006389
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1397066040.76286@1hptKM/F4A10zVBhxTawag
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245678>

"Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de> writes:

> Hi!
>
> I have a small question: After a "git gc" with last commit being "[shared 2679648]" I found this:
>> cat .git/HEAD
> ref: refs/heads/shared
>> cat .git/refs/heads/shared
> cat: .git/refs/heads/shared: No such file or directory
>
> Is this intentional?

Yes.

> commit in these files: .git/logs/HEAD .git/logs/refs/heads/shared
> .git/info/refs .git/packed-refs

Yes, they are where the refs are stored. If you have many refs in your
repository, having one file per ref is inefficient. It's more efficient
for Git to have one big read-only file. When one ref is modified, the
.git/refs/heads/$branch file is re-created, and the packed entry is
ignored.

>             if [ -d .git ]; then
>                 GIT_HEAD="$(<.git/HEAD)"
>                 GIT_BRANCH="${GIT_HEAD##*/}"
>                 GIT_HEAD="Git:$GIT_BRANCH-$(cut -c1-7 .git/${GIT_HEAD##*: })"
>             fi

Don't access the filesystem. Ask Git.

GIT_FULL_BRANCH=$(git rev-parse --symbolic-full-name HEAD)
GIT_BRANCH="${GIT_FULL_BRANCH##*/}"
GIT_HEAD="Git:$GIT_BRANCH-$(git rev-parse --short HEAD)"

(Perhaps there's a simpler way without $GIT_FULL_BRANCH)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
