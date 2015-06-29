From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Jun 2015, #06; Wed, 24)
Date: Mon, 29 Jun 2015 22:02:09 +0200
Message-ID: <5591A441.2010400@web.de>
References: <xmqqwpys95bm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 29 22:02:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9fFs-0003mg-Mu
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 22:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbbF2UCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 16:02:09 -0400
Received: from mout.web.de ([212.227.17.12]:49253 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752865AbbF2UCH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 16:02:07 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0Lrruc-1Z4cQ32tTS-013ie3; Mon, 29 Jun 2015 22:02:01
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.0.1
In-Reply-To: <xmqqwpys95bm.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:5TrhM/T7L5JsQYfEMeNb7jEWdqpA6QY2tBYo2Mdd9UV0o9Kmdun
 77cCTW+TgroRs7J3KEfr55Jdl1x8ldx365Eql0Y+K8hsFez8lWMBlT0irArpxDrONHzVBTw
 Ak5b++ygT1Cz8xLBI4iUMTyYVQdnmVZ1Ug0aEUkPRxJ839KItJYYFFtEiguUJGDYD3qivzj
 j79wclbr9v5iIxAOSXqug==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7bERfM4mJYA=:0Y3JenRTPjeRK1P5Qx9HVN
 qQ2u9tDTsoEH3XSP+8tWwXwI2pcXsF2sB4N7W0EnYtSIqfgINag9PeaCSHICmMM7Z0d1r20uY
 wggWoWs/Zt280xmy8wDxuVZ4qo46BchCP9WAdXqeqYWIL3AKi1w8hm3ddc5jRmU0LR0QMDxPE
 8VKiFeYtelt05jGPRhsLe6zZlsNZaPne9dJ4LRwUf6kg5juyvYBbvVto81jLh+jtvDZ370b71
 H5y7bBCx5vDjoIpP2aEvFmY1Ju0Ww5VXdI+vQztgFVMIiTSlf289uqvoYadvAqujxwbJ/Sj4m
 T1F/9RdUSdLAa3nMJ/HoDrvB8KHU43PEfJLNgVK2cLcjsZdbaArfqLNFvVE3/7+li/95VCmN2
 3JoWOe1y3Nzs6lExUmLeB/lW5BNgh7WRw3sb3khkTQ3hqiU6RixEKh6QlZi31SPdXTIroz5VA
 rOUPsFpoCoAcPSJidktLSrcNCbJgNQfYUzygwFw7W/AbRqwuIUmhFHhKj7N5/1uzrFcyBNKQN
 k1X/IXL953ALOkpfVDbKCppv5LpdejPW+e72dqqj0Yn534vsHQSfaqBFzVKGPgUTv2jUCtsj9
 qGc7tsQsUUIEgm8XgIFn1G9adtrcXg/eN/OAiiUxRDGDg5gziWTThrCUwAlR/CjEAmI9o5tlL
 NybbtbcxGAgWJA8cxpTGLX5whtMw5Be1Gz6m4/x2CKCcFLthfO9/41eVZGYdUK56zCIc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272998>

> * js/rebase-i-clean-up-upon-continue-to-skip (2015-06-23) 2 commits
>  - rebase -i: do not leave a CHERRY_PICK_HEAD file behind
>  - t3404: demonstrate CHERRY_PICK_HEAD bug
> 
>  Abandoning an already applied change in "git rebase -i" with
>  "--continue" left CHERRY_PICK_HEAD and confused later steps.
> 
>  Will merge to 'next'.
I need a little tweak here:

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 7fd1330..f236128 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1228,7 +1228,7 @@ test_expect_success 'rebase --continue removes
CHERRY_PICK_HEAD' '
        git checkout -b commit-to-skip &&
        for double in X 3 1
        do
-               seq 5 | sed "s/$double/&&/" >seq &&
+               test_seq 5 | sed "s/$double/&&/" >seq &&
