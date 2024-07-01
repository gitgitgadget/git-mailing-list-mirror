Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038681366
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 20:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719867149; cv=none; b=EVJ64mfJwokYPK7AvUX/R2M8SBK6lVTurYi83/nYnzK+oaqNBJBMgH8BrjeA6uKQ7Zg0J+uU6NrvQOspXeqaog/Kfq/DYvHN15DMf18WOzzlN+Q9454USx4H1Fd0vvjEEVKBJEnLMT1rBiQscQlJIHY83Bm256QN1fxPRTXI/Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719867149; c=relaxed/simple;
	bh=oUXE8rzFk5FV19KGE0nEZl3iMNav8YUvWu5Dhfu8r+w=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=CsxgS61F19E2JuTcO5fUy6VZyPpo7Px1Nzak6Ae5NI7jOSPpjrxaZoprsP/c5kzo+cg1pGbHaB94R1kPEEq1phvief7/uj4OC8amMg6AFfKrfdhSrzQx5MJJLKxtGVCDweK6DjQHaVHkG6bRNEMEdDTaU/Xx+ZxdwG2wxFWJu2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 461Kgo3R1862414
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Jul 2024 20:42:51 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Alec Sanders'" <aws022@bucknell.edu>
Cc: <git@vger.kernel.org>
References: <CA+Gods=0N9yYZ2tMSiV2GRO2uwpQTvvWB=Gcv9CfS4XrMYWN=A@mail.gmail.com> <ZoMOLz--NK_U6sst@tapette.crustytoothpaste.net>
In-Reply-To: <ZoMOLz--NK_U6sst@tapette.crustytoothpaste.net>
Subject: RE: Trouble with Gaia binary files
Date: Mon, 1 Jul 2024 16:42:44 -0400
Organization: Nexbridge Inc.
Message-ID: <073501dacbf7$3d4825b0$b7d87110$@nexbridge.com>
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
Thread-Index: AQE12DISOZyGV7goV5i0+caV3/nbDgKA/yXjsxg1PVA=
Content-Language: en-ca

On Monday, July 1, 2024 4:15 PM, brian m. carlson wrote:
>On 2024-07-01 at 15:34:04, Alec Sanders wrote:
>> Hello,
>>
>> I am running into an issue with Git and Gaia files This error =
persists
>> when I perform a git checkout or git merge.
>> The error is as follows
>>
>> error: Your local changes to the following files would be overwritten
>> by checkout:
>>
>> *Insert filepath here*
>> Filepath directs the user to the project folder and within it, =
Assets,
>> Gaia User Data, Sessions, ... , Terrain data, etc
>>
>> Please commit your changes or stash them before you switch branches.
>> aborting
>
>This message isn't particular to any given type of file.  What it means =
is that your
>files are modified in the working tree and the operation you want to =
perform (a
>checkout or a merge) will modify the working tree.  Because doing that =
operation
>would destroy data, Git asks you to do something specific to make your =
working
>tree clean before you can do that operation.
>
>I'm not familiar with Gaia, but in the case that you're using Git LFS, =
this could be
>caused by using Git LFS incorrectly, whether by you or someone else, =
that can lead
>to files being perpetually marked modified.
>If a file is tracked as a Git LFS file (that is, the file type is =
listed as `filter=3Dlfs` in
>`.gitattributes`), but someone has checked in the file without =
installing or enabling
>Git LFS (that is, as a regular file), then the file will end up always =
modified.

I have seen this situation resulting from security attribute mismatches =
under Windows. If the Gaia generated files are executable and =
core.filemode=3Dtrue and/or the files are not added with --chmod=3D+x, =
this can be persistent. This sometimes gets past git status in a Cygwin =
shell but shows up as a difference in ECLIPSE.

>That happens because if the file is updated in the working tree, Git =
tries to run the
>clean filter to turn it into a pointer file, and since that differs =
from what's in the
>repository (which is the full file), Git marks it as modified.  =
Attempting to check out
>or reset the file causes the same thing to occur, resulting in the same =
situation.
>
>In any event, if you _do_ want to keep the changes, you should run `git =
stash` to
>stash the changes, and then checkout or merge.  If you _don't_ want the =
changes
>and you are really certain you want to destroy all of them, you can run =
`git reset --
>hard` (this really does destroy them, so be careful).
>
>If you have the Git LFS problem I mentioned above, `git reset --hard` =
will not fix the
>problem.  In such a case, you will need to do `git add --renormalize .` =
and then `git
>commit` to fix the state of the branch.
>You'll need to do this to every affected branch.  You can also run `git =
lfs fsck --
>pointers BASE..HEAD` (substituting `BASE` and `HEAD`) in your CI =
system, which will
>exit nonzero and print an error if someone does this again.

--Randall

