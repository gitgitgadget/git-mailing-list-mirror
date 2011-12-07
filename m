From: Joshua Redstone <joshua.redstone@fb.com>
Subject: Re: Debugging git-commit slowness on a large repo
Date: Wed, 7 Dec 2011 01:48:46 +0000
Message-ID: <CB04005C.2C669%joshua.redstone@fb.com>
References: <20111203002347.GB2950@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?iso-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Tomas Carnecky <tom@dbservice.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 02:50:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY6e2-00032F-1H
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 02:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754343Ab1LGBt5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Dec 2011 20:49:57 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46892 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751907Ab1LGBt4 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 6 Dec 2011 20:49:56 -0500
Received: from pps.filterd (m0004347 [127.0.0.1])
	by m0004347.ppops.net (8.14.4/8.14.4) with SMTP id pB71ilOY004550;
	Tue, 6 Dec 2011 17:48:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=from : to : cc : subject :
 date : message-id : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=VR9u5RMXDsULnzr907shsR8QoSNiwiSWTALn7NY1OZY=;
 b=XdhaDUwpe3tMhBSYmMhwCPoWBjnk5iZjKNAw8WCS3nWCDFocH8fOiB3zQh+dTbxhjip4
 XJfv2B7/PbnQLVMDYNMnqact+3kK6hplv8CQwcH0laeHJv6MB8u7QJmKAO0i30ZIzaX5
 BvpRDFoJFi5eAqSMd2SvWGSuhMJjWCYVwi4= 
Received: from mail.thefacebook.com (corpout1.snc1.tfbnw.net [66.220.144.38])
	by m0004347.ppops.net with ESMTP id 11hvdng5n9-3
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 06 Dec 2011 17:48:51 -0800
Received: from SC-MBX02-5.TheFacebook.com ([fe80::9dc2:cfe6:2745:44cc]) by
 sc-hub04.TheFacebook.com ([192.168.18.212]) with mapi id 14.01.0289.001; Tue,
 6 Dec 2011 17:48:46 -0800
Thread-Topic: Debugging git-commit slowness on a large repo
Thread-Index: AQHMsUiE0jGAmaiuRkyp0eiAE6mrR5XJxzCAgAXbCAA=
In-Reply-To: <20111203002347.GB2950@centaur.lab.cmartin.tk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.13.0.110805
x-originating-ip: [192.168.18.252]
Content-ID: <1F3187ED2D72364AA56B15AAEA2F28AC@fb.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.5.7110,1.0.211,0.0.0000
 definitions=2011-12-06_06:2011-12-07,2011-12-06,1970-01-01 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186412>

Hi Carlos and Tomas and Junio,

@Tomas, I tried adding the '--no-status' flag to 'git commit' and it sp=
ed
things up by maybe 15%, but commits still take a second.

@Carlos, by "same size", I mean roughly the same number of files and
number of bytes modified in each file.  In all experiments, it's less t=
han
5 files modified per commit with changes totaling fewer than 10 KB, oft=
en
more like 1 KB.  I actually wrote a test script to generate commits,
customized for the stats on the repo I'm using.  It repeatedly generate=
s
some changes, does 'git add [ list of files changed ]' followed by 'git
commit --no-status -m [ msg ]'.   It generates changes by picking fewer
than 5 files at random, modifying two 100-byte regions in each file, an=
d
occasionally creates a new file of about 1 KB.  If it helps, I can
probably post the test script I've been using.

I tried doing a 'git read-tree HEAD' before each 'git add ; git commit'
iteration, and the time for git-commit jumped from about 1 second to ab=
out
8 seconds.  That is a pretty dramatic slowdown.  Any idea why?  I wonde=
r
if that's related to the overall commit slowness.

@Carlos and/or @Junio, can you point me at any docs/code to understand
what a tree-cache is and how it differs from the index?  I did a google
search for [git tree-cache index], but nothing popped out.

Cheers,
Josh


On 12/2/11 4:23 PM, "Carlos Mart=EDn Nieto" <cmn@elego.de> wrote:

>On Fri, Dec 02, 2011 at 11:17:10PM +0000, Joshua Redstone wrote:
>> Hi,
>> I have a git repo with about 300k commits,  150k files totaling mayb=
e
>>7GB.
>>  Locally committing a small change - say touching fewer than 300 byt=
es
>> across 4 files - consistently takes over one second, which seems kin=
da
>> slow.  This is using git 1.7.7.4 on a linux 2.6 box.  The time does =
not
>> improve after doing a git-gc (my .git dir has maybe 250 files after =
a
>>git
>> gc).  The same size commit on a brand new repo takes < 10ms.  Any
>>thoughts
>> on why committing a small change seems to take a long time on larger
>>repos?
>
>By "same size commit" do you mean the same amount of changes, or the
>same amount of files? Committing doesn't depend on the size of the
>repo (by itself), but on the size of the index, which depends on the
>amount of files to be committed (as git is snapshot-based). At one
>point, commit forgot how to write the tree cache to the index (a
>performance optimisation). Do the times improve if you run 'git
>read-tree HEAD' between one commit and another? Note that this will
>reset the index to the last commit, though for the tests I image you
>use some variation of 'git commit -a'.
>
>Thomas Rast wrote a patch to re-teach commit to store the tree cache,
>but there were some issues and never got applied.
>
>>=20
>> Fwiw, I also tried doing the same test using libgit2 (via the pygit2
>> wrapper), and it was ever slower (about 6 seconds to commit the same
>>small
>> change).
>
>I don't know about the python bindings, but on the (somewhat
>unscientific) tests for libgit2's write-tree (the slow part of a
>creating a commit), it performs slightly faster than git's (though I
>think git's write-tree does update the tree cache, which libgit2
>doesn't currently). The speed could just be a side-effect of the small
>test repo. From your domain, I assume the data is not for public
>consumption, but it'd be great if you could post your code to pygit2's
>issue tracker so we can see how much of the slowdown comes from the
>bindings or the library.
>
>   cmn
>
