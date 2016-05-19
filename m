From: tboegi@web.de
Subject: [PATCH v5 0/2] CRLF: ce_compare_data() checks for a sha1 of a path
Date: Thu, 19 May 2016 16:21:15 +0200
Message-ID: <1463667675-25930-1-git-send-email-tboegi@web.de>
References: <573A993F.8020205@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 16:16:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3Ok3-0005hb-VG
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 16:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755185AbcESOPx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2016 10:15:53 -0400
Received: from mout.web.de ([212.227.17.11]:61484 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754604AbcESOPt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 10:15:49 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MOArg-1axv5z42oG-005VGy; Thu, 19 May 2016 16:15:40
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <573A993F.8020205@web.de>
X-Provags-ID: V03:K0:3TT7Nbx2+ihCgRMwphcFOCl1+vbAeP02Ckm5qNL+KiRYN1hpgeN
 AEkO3t96k6urS7jkdXwE3BsDFkMC+JIyaiRvMtOtS5RR0DTIfnzjsE5u0LLBlpgVFXNgO/O
 2YB51DjJLA+pfLen6MvZcjkiypC8qENrq1KC1TEKyiqnT9WvnUkxSd5AAo8yLjytbslJSh/
 JltUyhVE3IT4A8IpI8hPg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3ShzXfG5His=:k8I3WYut7nFYbG+4+Yg6Xj
 vZ8qorok2ZLHgpfOVOXqqRtkFBmNNVNCbaPIF2wzQIVrRYZKFV5eJniBeBB295VhyP/nnYhKz
 zSkeBYYE/BJc5XfI4hOV3sjOA4rjzI7M62RmTXAV9Nw3DlGnYvmvYryYRkDXYE2QyB4v7Dsrc
 uM4qu0+5XZz9ScePk6yqEl/cazWwjurZFufxwl3Hv2nTQP5cjSE7/rbZ/w8yaBQEvcg6K2vVA
 wtaRSqm+3331ZsSR+uHKLC7GJs6ANQPK6V2o5H8xl1Hf7+kMrShA+LH8bI0q8yM9S0WZWq5yM
 8RbdwWQ7xmbUSmqth3KBtxoCGijf+aMs5l090NEQS9USxk78Qa+XsvF02ie+IcRukHizXlmx8
 5hkjbokpmMRRoI6HpozZ9XnZnhNo9xWNXt47ndtPA17KVeRJ7FAaczcW5opIA772qqPnjZFdy
 lSrzErM53hYf1f4kUlwoJqqnzLKGZsFu7ujnrubW/pHkwX+DE8diRW49whoKMg2WBcztJJS3f
 xAOrrHycHQW59hBSbiVzYBIoDBxDCC+qXTwTBvw3fZcq9gl445kbcPB8WxQz3oNBFzBUXg5PO
 AcV4ZCZCQGHG1JDf0B7tSmLqCsh1I59q88nRJgVPtW1lBUOjxtpVSgnyxPthnB/1KeuQS7E3d
 PE/Ahs4ySAq91sO43Dt2/P8iCsBqOjPebBShW0ActoQki8hlXmKmpYj9NMhkJNGm5El68zTMb
 DPC5Ni2/35a0P6u+5NlnqlODxsV5r8X59RZQOOZeGsXVS4ERBs3FOHfalr1D05QJM1Uv0IS1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295061>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

Break up the old 10/10 series about CLRF handling into smaller
series. This is a small bugfix, when merge.renormalize is used
with core.autocrlf (and no attributes are set).
Prepare the refactoring to use the streaming interface.
Changes since v4:
 - Rename #define in cache.h into HASH_USE_SHA_NOT_PATH
 - convert.c: Rename has_cr_in_index into blob_has_cr()
   Better logic when sha1 !=3D NULL,
   Adjusted the commit message

Torsten B=C3=B6gershausen (2):
  read-cache: factor out get_sha1_from_index() helper
  convert: ce_compare_data() checks for a sha1 of a path

 cache.h      |  4 ++++
 convert.c    | 34 ++++++++++++++++++++++------------
 convert.h    | 23 +++++++++++++++++++----
 read-cache.c | 33 +++++++++++++++++++++------------
 sha1_file.c  | 17 +++++++++++++----
 5 files changed, 79 insertions(+), 32 deletions(-)

--=20
2.0.0.rc1.6318.g0c2c796
