From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: making stgit handle being rebased by git rebase
Date: Thu, 11 Nov 2010 10:41:55 +0000
Message-ID: <AANLkTimjO0yMJvf_fF3g7qypAuhPyiHCeF-sUv5toM_S@mail.gmail.com>
References: <AANLkTik3MVNW0svJEo5gWq3+qGo6dKeqAUz9NPcJnYNN@mail.gmail.com>
	<AANLkTik_dFsaiDkugrpBp8T31zNWVMRNC=hQBj0RmV+o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Chris Packham <judge.packham@gmail.com>, GIT <git@vger.kernel.org>
To: Karl Wiberg <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 11:42:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGUbR-0002Fr-Kt
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 11:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861Ab0KKKl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 05:41:56 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36921 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242Ab0KKKlz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 05:41:55 -0500
Received: by iwn10 with SMTP id 10so2004337iwn.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 02:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=69V4bxlmqKwgulH9MHlf4iJOfnG3eVE4A1fDrb5SLPQ=;
        b=sgRdgxIiY5ue/XDKujaNAJLJMlQORxH5Gj4gm35euRNB0v0chUTg23YfWMX8lCvoJ2
         3ZgQLu/mzCSblrpsdhJEADuOTUsxz5mCUNyDMSrnhvCmp06ZFUX0mbO7lxffW7cMaHbI
         A0YReWPIiqfYAmcdjD9u/jrLJByPJuAuwWPsw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=tzimUQ1cSG2o8V+fxRZmZEMGueYBDskcGBtsdBXkm8Sx1xOzALzJBHSV26iAKjSS3X
         k1VTtrh1MJQNBgajJLzfM7uUDFmREy8dAcvGkjZ4D4m2RnqVrpnujSTTHGwbd11IBc3b
         N7qzOWaeuBy3LoDX1mPgEX/ml0IASNXcmt/SI=
Received: by 10.231.17.9 with SMTP id q9mr374544iba.109.1289472115047; Thu, 11
 Nov 2010 02:41:55 -0800 (PST)
Received: by 10.231.35.75 with HTTP; Thu, 11 Nov 2010 02:41:55 -0800 (PST)
In-Reply-To: <AANLkTik_dFsaiDkugrpBp8T31zNWVMRNC=hQBj0RmV+o@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161223>

On 11 November 2010 10:29, Karl Wiberg <kha@treskal.com> wrote:
> On Mon, Nov 8, 2010 at 11:39 PM, Chris Packham <judge.packham@gmail.com> wrote:
>> Has anyone looked at making stgit interact with git-rebase more gracefully?
>
> The problem is that StGit's metadata gets out of date when you do a
> git rebase. A solution would either have to change StGit's metadata
> representation so that it can't get out of date, or be a fancy version
> of repair/uncommit that can actually figure out what git did.
>
> I've thought a bit about this in the past, and the best solution I
> could come up with is of the first kind, and would change the
> representation of applied patches to use just two refs: the branch
> itself, and the stack base ref. I think git rebase wouldn't wreck
> things for that representation.

git rebase would most likely change the base of the stack so stgit can
no longer track its patches. If git rebase just moves the stack base
forward, stgit could generate additional patches that have been
brought in by git, though sometimes this would include merges etc.

Maybe a better option for stgit is to just remember the branch and the
number of patches (probably including the patch names unless we always
generate them automatically, not that bad but you lose the possibility
of renaming patches).

The above would work well if people use git commit on top of an stgit
branch. The patch names maybe be wrongly associated or (if we
automatically generate patch names) we may miss the first patch in the
series because of the number of commits. The latter is not that bad
since we can always use stg uncommit, though a stg rebase could
override the committed patch.

-- 
Catalin
