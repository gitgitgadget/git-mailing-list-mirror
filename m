From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 0/5] wt-status: fix an invalid memory read, clean up
Date: Sat, 31 Oct 2015 18:33:13 +0100
Message-ID: <5634FB59.1000506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 31 18:33:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zsa22-0000MW-0W
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 18:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509AbbJaRd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2015 13:33:26 -0400
Received: from mout.web.de ([212.227.17.11]:59936 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752049AbbJaRdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2015 13:33:25 -0400
Received: from [192.168.178.36] ([79.253.163.201]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0M8zOD-1Zl7FW1ql3-00CNbg; Sat, 31 Oct 2015 18:33:15
 +0100
X-Mozilla-News-Host: news://news.gmane.org:119
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
X-Provags-ID: V03:K0:uf4U3zkA10uBXt/6FBhPj+/oJNvLVXV1zjQRiWgjCx3y6Wh98Jy
 TsGYrWc0krXgQF53SREsoDujzJgmvNTQGe1Mue4Db9w4nU7I9mKFmMjN/VKxg9AnCSWh68m
 lJW75hzRkiJ9wAe5tZ4RxElnskjc1uUDMAwEfER1D746n0FLQyM2akNRgLSwZGy0Lgnd4rK
 +Txz5dMD1ImvJoj5B4yDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OdDs64J9IPs=:ClzZgaNBFfD1+Tlc06HpP9
 t4OZ9EKQAL0/D3OpCCMuJnvXGWJeA6s4LiO8m5zM+4pFtVFeXe6rWHQWaUnKh6bS3RDA1R4cs
 yyg1wBhAVG/5KDVuvqmg1tR/n/VdFfFTAcJiKMFbeuS/Rc4anqyGOZzAFewEiDm786SQx3DY3
 YWGP2Tp5BccGCykw0aK4oTiTHc/BGyAz+O+YeusctCzLtJZ09CVpqbwCP0bbuoN4Tkplkzx8W
 MM4XZHO9JsuP/b/gSLc0WiuaCoK3wWZ/wEuLZNcZkW4Z/M7gKCAn1kHMGBIQ43LePnCMp7MUh
 3l3pkvGP0KZdlnQR2EmAsmgDkk7EYgaKAQXug7uKf7O8HZhv1R9SwhJ5QqP1UvgHfhUcbfmuO
 MHl945SO8YCW1YO97+SxYo7/ktmqGOauaBexV0Jny4Rjl83aCID12ofNcGYUACrJ16ihnATPL
 JR/PFzeQ/zYJYmevn2ESEvKdJn6Q2PvFe7VoN9Q8YbnZnLK0VgW9U7m40SBJ7tzouJN2Ste6W
 epwR6SAfCu151rrAxPFwkTMvxynDnz9pQHUUiqFFzaZSDoKYXCu3uBFEyammaBcpi1XkGEEYc
 ZSLREnCGosr8kNdZ345/NXLSwaj+Cftz9G+WsvqBdYFwl6EqRsVEXjhZE87rWKJ1K1GP5UnoP
 6+RADsPVnl2enPOW8SP2NcqCt1KVW78tBd04AHX+wsfMmLhAZ7QhcqnqXOLFlgc0Hs0bzDG4u
 SQhiVEhgDzSPdLxfU6bLdMC6a772tVLI9ppWLzeEabAhbn1r548xiL5+1pTHSORgP/+V99AQ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280585>

Memory is accessed out-of-bounds when try to show --branch info in a
repo with a detached HEAD.  Add a test in patch 1 and a fix in patch
3, as well as some cleanups.

Rene Scharfe (5):
  t7060: add test for status --branch on a detached HEAD
  wt-status: exit early using goto in wt_shortstatus_print_tracking()
  wt-status: avoid building bogus branch name with detached HEAD
  wt-status: don't skip a magical number of characters blindly
  wt-status: use skip_prefix() to get rid of magic string length constants

 t/t7060-wtstatus.sh | 14 ++++++++++++
 wt-status.c         | 64 ++++++++++++++++++++++++-----------------------------
 2 files changed, 43 insertions(+), 35 deletions(-)

-- 
2.6.2
