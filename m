Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C80E1448F2
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735402316; cv=none; b=UEtNCaZ41kwO+bkzgndvRanzFMCdxVjuwqYMKBpEFXLCixDBAlC86gMbBIfOFmip80Hcm3gpNmepKqkqvBKQx5lEnpA8juhorDUlKcYdYsndhDrIzoYdu9yUlDQoj4ZVu+HYjundph2wZd6r2u4NTjYNAEhriMLx+a39XE/YLVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735402316; c=relaxed/simple;
	bh=cWcq0pCeckC8tb1eLt8XKSHwF+mrFExywLgDTiHT/pg=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=SvZGMhRM2oRUEuXWr3qjgi18JUhJKPq09kzP3zMa72ShTUv1jwU8YJcFXJJuFfpS1sMjbD6V4k6TtTWk2I/AOpmzZc3T2Tf9NHP0w0vGKKolakjXvpXlgeuJjt/ZmSmI+NJES7H8mqvwqr6D9YbsSL+lVPUzpx289s6vvHqQe1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4BSGBncf3918877
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 28 Dec 2024 16:11:49 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <crstml@libero.it>, <git@vger.kernel.org>
References: <a69c4e2e-cbb0-c242-a34a-8997a84fefb7@libero.it>
In-Reply-To: <a69c4e2e-cbb0-c242-a34a-8997a84fefb7@libero.it>
Subject: RE: connecting the local main branch to the remote origin/main without pushing
Date: Sat, 28 Dec 2024 11:11:45 -0500
Organization: Nexbridge Inc.
Message-ID: <027f01db5943$340b2c70$9c218550$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJOjts6fzJ/non6LHwWNa+ljJww/bIVZlUA
Content-Language: en-ca
X-Antivirus: Norton (VPS 241228-2, 12/28/2024), Outbound message
X-Antivirus-Status: Clean

On December 28, 2024 10:47 AM crstml@libero.it wrote:
>I would like to put a set of files under version control and I have =
some issues with
>the workflow. Let me explain:
>
>First I create the bare repository with the command:
>
>     git init --bare -b main ~/rps/project-x.git
>
>Then I can proceed in one of the following ways:
>
>
>---- Method 1 ----
>
>    By first cloning the remote repository locally and next
>    putting the files under version control. All running the
>    following commands:
>
>    1    cd ~/projects;
>    2    git clone ~/rps/project-x.git project-x
>    3    cp ~/my-existing-project-x-files/* project-x
>    4    cd project-x
>    5    git add .
>    6    git commit -m "fc"
>    7    git push origin
>    8    rm -rf ~/my-existing-project-x-files   # clean your home =
folder
>
>---- Method 2 ----
>
>    By putting the existing files under version control and next
>    adding the remote. Running the following commands:
>
>    1    cd ~/projects/project-x
>    2    git init -b main
>    3    git add .
>    4    git commit -m "fc"
>    5    git remote add origin ~/rps/project-x.git
>    6    git push --set-upstream origin main
>
>
>Let me discuss both these methods:
>
>Method 1:
>
>   Everything works but the cp statement may be problematic. If
>   you have hidden files (starting with .) or if you want to
>   preserve the file permissions and owenership, the invokation
>   of the cp command is trickier.
>
>   After you copy the files all the next statements work well.
>   The main branch in the cloned repository is connected to the
>   upstream origin/main branch and "git push" will work.
>
>   There is one more small problem with this workflow: the
>   statement 8 is ugly.
>
>
>
>Method 2
>
>   Everything is very clean (apparently). We don't have to think
>   to file permissions, hidden files, tricky cp invocations and
>   there is no need to clean your home folder at the end. We are
>   interested to put files under version control, so we focus only
>   the version control system.
>
>
>   The problem  with this workflow (from my point of view) is the
>   statement 6. This statement makes two things which is contrary
>   to the UNIX philosophy: programs that do one thing and do it well.
>
>       1) The command connects the local main branch to the
>          remote origin/main branch.
>
>       2) Pushes the files to the remote.
>
>   From my point of view instead of executing the statement 6 I would
>   like to execute the following two statements that I will number
>   here as 6.1 and 6.2:
>
>    6.1  # To connect the main branch to origin/main
>         #
>         git branch -u origin/main main
>
>    6.2  # To push to the remote.
>         #
>         git push origin
>
>    However, the statement 6.1 does not work. Git prints the following
>    message.
>
>    hint: If you are planning on basing your work on an upstream
>    hint: branch that already exists at the remote, you may need to
>    hint: run "git fetch" to retrieve it.
>    hint:
>    hint: If you are planning to push out a new local branch that
>    hint: will track its remote counterpart, you may want to use
>    hint: "git push -u" to set the upstream config as you push.
>    hint: Disable this message with "git config =
advice.setUpstreamFailure false"
>
>    The end solution it suggests to use with "git push -u" which
>    is the same as the statement on line 6 that I would like to
>    avoid.  I would add that by issuing a "git fecth" before 6.1
>    would not bring the remote branch origin/main in the local
>    repository.
>
>    The core of the problem is that the local branch main is not =
connected
>    to the origin/main branch.
>
>My question is:
>      Is it possible when applying the method 2 to have (without =
pushing)
>      the local main branch connected to the remote origin/main branch =
as
>      in the case of method 1 which by cloning connects these branches.

I think method 2 is failing for you because you do not have origin/main =
in your
local repository. That requires a git fetch. Git fetch will not =
overwrite your
working area, but is needed so that tracking can occur with an existing
remote branch.

The reason git push -u works is that the resolution of your branch =
tracking
can be worked out by git as part of the push, where the remote reference
is known. Without that, the git branch -u does not work (no reference).

So do the git fetch as 5.9 in Method 2, then 6.1 should work, assuming =
origin/main
exists in your remote. This downloads the clone history without =
modifying
your work area, so it should be fine.

--Randall

