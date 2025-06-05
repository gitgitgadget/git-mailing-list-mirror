Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D7F1A5B8A
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 20:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749155280; cv=none; b=iY2HLKn/Mc+TgQaf1sGM/8tXN1WhNB/DlxNKNTYLYdBSUqhUB+SoXBfaYNjkcK9u/Wfg6uqLmhpkap01ltP8HWOHcJf0sFYu4Ouc4hwBnlOke5pvjK8Jq9HWYiNuskimqTX02WFfJu8/zbb3ZyRJ9lXMwY02y/DtX2+tslEyuo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749155280; c=relaxed/simple;
	bh=MRP16/yCJtp2FTXCjTDllc28/03y27MXFMN2dAxbI5w=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=R3F0LGp+fLMELdKf7Bq1wEm3Zq8dmVfhe8kYTFINVc4MxvblN6PKJAPgKG5jTcWT3ElkhJEGVm2I3v71exbmFpOMkPfvb08sP98CnBnCSppSVZZw4oAfvQCu8Ob+AOvVhXgP6GamN1magnMt6igluXISsxtJq0CVwxa2O0ybzLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen ([185.122.133.20])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 555KRmlW758832
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Jun 2025 20:27:49 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Patrick Steinhardt'" <ps@pks.im>
Cc: "'Johannes Sixt'" <j6t@kdbg.org>, "'Junio C Hamano'" <gitster@pobox.com>,
        <git@vger.kernel.org>, "'Todd Zullinger'" <tmz@pobox.com>
References: <xmqqsekgn4gk.fsf@gitster.g> <007a01dbd4d7$89ebf100$9dc3d300$@nexbridge.com> <007d01dbd4d9$356ded70$a049c850$@nexbridge.com> <aEBPdFXpIca7lMls@teonanacatl.net> <xmqqjz5rcz90.fsf@gitster.g> <44fe8627-5680-443d-bf02-a6e85afd46b4@kdbg.org> <010b01dbd5f1$3c26ec20$b474c460$@nexbridge.com> <aEFb0Sjj0Xuu-t7l@pks.im>
In-Reply-To: <aEFb0Sjj0Xuu-t7l@pks.im>
Subject: RE: [ANNOUNCE] Git v2.50.0-rc1 - Test Failed
Date: Thu, 5 Jun 2025 16:27:41 -0400
Organization: Nexbridge Inc.
Message-ID: <014201dbd658$4da75680$e8f60380$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE/8OENAHtdeNmfXNuu5L7gSMXaAQGPhlBYAT32OawCDCTCZQHcPefDAfT2uzQCU1eiuwIb33kTtMP5zuA=
Content-Language: en-ca
X-Antivirus: Norton (VPS 250605-8, 6/5/2025), Outbound message
X-Antivirus-Status: Clean

On June 5, 2025 4:57 AM, Patrick Steinhardt wrote:
>On Thu, Jun 05, 2025 at 04:09:54AM -0400, rsbecker@nexbridge.com wrote:
>> On June 4, 2025 3:25 PM, Johannes Sixt wrote:
>> >Am 04.06.25 um 17:17 schrieb Junio C Hamano:
>> >> So the build procedure for git-gui (but not gitk) has changed
>> >> rather extensively after we tagged the preview before -rc1?
>> >> Honestly, I would have preferred to see a change with this impact
>> >> go through the regular 'seen' to 'next' to 'master' way before
>> >> -rc0, but that is water under the bridge.
>> >
>> >I don't think we ever had such a cycle for gitk and git-gui. I carry
>> >inofficial branches 'j6t-testing' in my repositories that interested
parties could
>track instead of 'master'.
>> >I would be happy to hear that people actually do use them.
>> >
>> >> I do not spot anything obviously wrong (and it is not expected that
>> >> I would---we wouldn't have this code sent to me in the first place
>> >> if this is something I can immediately notice).  git-gui/Makefile
>> >> sets ALL_LIBFILES to $(wildcard lib/*.tcl) and then does
>> >>
>> >>     $(SHELL_PATH) generate-tclindex.sh . ./GIT-GUI-BUILD-OPTIONS
>> >> $(ALL_LIBFILES)
>> >>
>> >> So the error message in Becker's message, i.e.
>> >>
>> >>> /usr/coreutils/bin/bash generate-tclindex.sh .
>> >>> ./GIT-GUI-BUILD-OPTIONS
>> >>> usage: generate-tclindex.sh <BUILD_DIR> <BUILD_OPTIONS> <LIBFILE>
>> >>> [<LIBFILE>...]
>> >>> Makefile:200: recipe for target 'lib/tclIndex' failed
>> >>
>> >> suggests that $(wildcard lib/*tcl) expanded to *nothing*, which
>> >> sounds horribly wrong.  They are source material and should exist
>> >> in an unmodified checkout or a tarball extract.
>> >
>> >I don't see anything wrong, either. I can easily verify your theory
>> >that the
>> >$(wildcard) produces an empty list by modifying the pattern.
>> >
>> >Randall, would it be possible for you to find out why $(wildcard
>> >lib/*tcl) produces an empty list in your case?
>>
>> I can verify that $(wildcard lib/*tcl) is correctly reporting an empty
list.
>>
>> There are three directories name lib in the 2.50.0-rc1 commit:
>> ./git-gui/lib
>> ./gitweb/static/js/lib
>> ./perl/build/lib
>> None have any files ending in tcl:
>> $ ls git-gui/lib
>> git-gui.ico  meson.build  tclIndex  win32_shortcut.js $ ls
>> gitweb/static/js/lib common-lib.js  cookies.js  datetime.js $ ls
>> perl/build/lib FromCPAN  Git  Git.pm
>>
>> If it possible that your workspace has extra stuff that does not exist
>> at the time make is run. Note that I am using gnu Make 4.2.1 with bash to
perform
>the built/test cycle.
>
>Your "git-gui/lib" directory is missing a bunch of files:
>
>    $ git ls-tree v2.50.0-rc1:git-gui/lib
>    100644 blob cfa50fca87827f09b2fc93509e0f249cc03ca6cd	about.tcl
>    100644 blob 8441e109be32822df003d3ab3a221d742a74a8b7	blame.tcl
>    100644 blob 8b0c4858890f11cf0e3f31536b584e0596f3aba0	branch.tcl
>    100644 blob d06037decc1a44ad0f0c153cd461a22a138f35ea
>	branch_checkout.tcl
>    100644 blob ba367d551d217f12cfae3c2f99cd19da58f1226f
>	branch_create.tcl
>    100644 blob a5051637bbc2388c4aab14479ded14d2c41df314
>	branch_delete.tcl
>    100644 blob 3a2d79a9cc3a1ade90db21721f75266d797c26f0
>	branch_rename.tcl
>    100644 blob a98298366763d841d3f88e4478f0afdc6e9a5653	browser.tcl
>    100644 blob 21ea768d8036c0ae2ba6bd430c6c667b5ac30c4f
>	checkout_op.tcl
>    100644 blob ebe50bd7d07e8a430096dc8f5813c781839bd0f6
>	choose_font.tcl
>    100644 blob d23abedcb36fd93ab3f12694d607bf354d6cf208
>	choose_repository.tcl
>    100644 blob 6dae7937d589c174132e9f8b9bd77133e189590f
>	choose_rev.tcl
>    100644 blob e21e7d3d0b7924f85c29dad248492e22de0bf39b	chord.tcl
>    100644 blob f08506f3834a1ec821390190b920146d83078997	class.tcl
>    100644 blob a570f9cdc6a406ef9482802e16c4489cc9873c2c	commit.tcl
>    100644 blob fafafb81f1269c1a1a130f66c335f7d4a6f27bb9	console.tcl
>    100644 blob 85783081e0d887a7c7857f07670847ef1bc0629d
>	database.tcl
>    100644 blob abe82992b6529cf49983029d85348df5d27ceaf5	date.tcl
>    100644 blob d657bfec05b49865627f321ab260633f250f71c6	diff.tcl
>    100644 blob d2e0fa60c3ba3f770f525a8d01c66f17826aea75
>	encoding.tcl
>    100644 blob 8968a57f33e37584e3589f03918db2cb89db24e9	error.tcl
>    100644 blob 334cfa5a1a59c320e86789ccf4ed3320584a0215	git-gui.ico
>    100644 blob d2ec24bd80e12af37ca0099b8aca0bc471cb180f	index.tcl
>    100644 blob a026de954c3d9cbfd03d4dec9a73a74647bf74ba	line.tcl
>    100644 blob 5ff76692f5eeeb51bcca0905385f51963d1e6531	logo.tcl
>    100644 blob 664803cf3fd14c496bbf4b87ca4f7e8e87503ba1	merge.tcl
>    100644 blob 8b8c16b1d616b62e5141b4228f1152921bcb86f1
>	mergetool.tcl
>    100644 blob 4b9efab774dc97546f41158ba56b19d20291acfb
>	meson.build
>    100644 blob e43971bfa3e0084e1a306fc82111895a301f905e	option.tcl
>    100644 blob ef77ed7399c5b0cc1bdd06f1471d275ffd0ab3ad	remote.tcl
>    100644 blob 480a6b30d0a9c9aa4f667a618b0e852d637432dd
>	remote_add.tcl
>    100644 blob 5ba9fcadd17f315a4a47220f91f81ba964d64b08
>	remote_branch_delete.tcl
>    100644 blob ef1e55521d7cea10e280f720ad700a4cd4b71d65	search.tcl
>    100644 blob 674a41f5e0c868b70d84202381fec8b5919f962f	shortcut.tcl
>    100644 blob 538d61c792defa7a8e19736039fa5a9af630125c
>	spellcheck.tcl
>    100644 blob 589ff8f78aba8273651b33005c6f6abd1db2fa27	sshkey.tcl
>    100644 blob d32b14142ff8383bcdfddecd1d435fbea3260a51
>	status_bar.tcl
>    100644 blob f43d84e54fba18b5e2ebf5f9dbf28f3f8db8593d	themed.tcl
>    100644 blob 413f1a170079e0cec78ecdbd1adb7baeb83406f2	tools.tcl
>    100644 blob c05413ce432d2d37cc2461f1f1a739001c2220f4
>	tools_dlg.tcl
>    100644 blob a1a424aab540663957c96a37cd277ae666287051
>	transport.tcl
>    100644 blob db91ab84a56d79be6a5497f885a9181f368b9cf2	win32.tcl
>    100644 blob 117923f8860bb8f0f04c1664d8cbe38804a59831
>	win32_shortcut.js
>
>It seems like your working tree is somehow broken?

The actual problem is the prior stage, running make test fails on GIT_GUI,
so
make install fails. The lib/*.tcl are removed. The build command I using is:

Bring back the missing files from the commit

$ git restore . 

Run the actual build.

$ /usr/coreutils/bin/make V=1 prefix=/usr/local-ssl3.5 CFLAGS="-g -O2
-D_LARGEFILE64_SOURCE=1 -D_FILE_OFFSET_BITS=64 -Winline
-I/usr/local-ssl3.5/include -I/usr/coreutils/include
-I/usr/tandem/xml/T0625L01_AAE/include" LDFLAGS="-D_LARGEFILE64_SOURCE=1
-D_FILE_OFFSET_BITS=64 /usr/coreutils/lib/libz.a -L/usr/local-ssl3.5/lib
-L/usr/coreutils/lib -L/usr/tandem/xml/T0625L01_AAE/lib"
SHELL=/usr/coreutils/bin/bash

The *.tcl files in git-gui/lib are gone after the above command. I noticed a
few things run by the above - this did not happen in 2.49.

/usr/coreutils/bin/make -C git-gui
gitexecdir='/usr/local-ssl3.5/libexec/git-core' all
make[1]: Entering directory
'/home/jenkinsbuild/.jenkins/workspace/Git_Pipeline/git-gui'
GITGUI_VERSION=0.21.GITGUI
/usr/coreutils/bin/bash generate-git-gui.sh "git-gui.sh" "git-gui"
./GIT-GUI-BUILD-OPTIONS ./GIT-VERSION-FILE
/usr/coreutils/bin/bash generate-tclindex.sh . ./GIT-GUI-BUILD-OPTIONS
lib/merge.tcl lib/error.tcl lib/chord.tcl lib/date.tcl lib/encoding.tcl
lib/remote_branch_delete.tcl lib/branch_delete.tcl lib/line.tcl
lib/choose_rev.tcl lib/console.tcl lib/checkout_op.tcl lib/blame.tcl
lib/class.tcl lib/about.tcl lib/choose_repository.tcl lib/diff.tcl
lib/transport.tcl lib/branch_rename.tcl lib/shortcut.tcl lib/search.tcl
lib/win32.tcl lib/status_bar.tcl lib/tools_dlg.tcl lib/tools.tcl
lib/mergetool.tcl lib/option.tcl lib/database.tcl lib/choose_font.tcl
lib/logo.tcl lib/remote.tcl lib/branch.tcl lib/branch_checkout.tcl
lib/index.tcl lib/sshkey.tcl lib/commit.tcl lib/browser.tcl
lib/remote_add.tcl lib/branch_create.tcl lib/spellcheck.tcl lib/themed.tcl
generate-tclindex.sh: line 21: tclsh: command not found
    * tclsh failed; using unoptimized loading

It appears the above removes the *.tcl files. That causes the subsequent
failure.

--Randall

