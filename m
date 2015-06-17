From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/2] rebase -i: Fix left-behind =?UTF-8?Q?CHERRY=5FPICK=5F?=
 =?UTF-8?Q?HEAD?=
Date: Wed, 17 Jun 2015 10:15:27 +0200
Organization: gmx
Message-ID: <cover.1434528725.git.johannes.schindelin@gmx.de>
References: <20150616140612.Horde.a1irZQmh2o42SqDfxAytHg1@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, szeder@ira.uka.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 17 10:16:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z58Vr-0004AD-7T
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 10:15:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757495AbbFQIPu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jun 2015 04:15:50 -0400
Received: from mout.gmx.net ([212.227.17.21]:51153 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757764AbbFQIPq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 04:15:46 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Lxgnf-1Z3OX40Fqd-017HgX; Wed, 17 Jun 2015 10:15:29
 +0200
In-Reply-To: <20150616140612.Horde.a1irZQmh2o42SqDfxAytHg1@webmail.informatik.kit.edu>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:xppN8D3IktDNbh/FpYeLLKU8vYnBT2jTAh9u+ilHbxcc0VG4Wde
 J9/WQh6tZQjuJUH70S++d4L5EaaNJ66PQnvYTlPqOsKaP3u254Eyw5lmNpEsIHbGCUAEhc2
 0nE4EgU2/AIGVKWxp3O2vFPMzjy3HKf11ZCxNbj8p5QOsyqOSHFZ9mz4S6v4P2AMLHOw3t7
 xozXoDMi/IJ1aFJ9sC5qg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:p6H+5KdGciI=:3ihY07yFs2bOEjZowQAkQu
 RbElbH3ZJ79W38KfD5rB9X/lbdGkbaAfJrp8ew5RcKL3zpyqGcQNco0uPDgWXcR4fBMlJuzgE
 ZDi5fhy0Xry9bVpiX9ty7s4J9/lQ7J8P6/e4yVu8Wdpf5r39DNSmvyPkj12tKUy0jt/Dk/844
 Zr68lWtC8aAtT5XpcbqC100Inwi9tVLJPGT9kZ1nc0pJnEkxaROhOHcA6zkBbyH/8wg+iEr/s
 Tn8QzHcWo3zYZHV/Luj00+dExRb3z6PRx4YmmU46oj+99ScR6YXstw58lUdEW9aRkNGknK5gZ
 4qUYHDerzimyg/ks0xKVGkEKIr/4y85nytNB/AiYH3cPuWJWHEnw1dSY2q53vr6f988NY7zzj
 sI3NGYWfAiFwteX+zXXxTZqE6wS7qjB3rWeuKL/cxix548eKVKy7CU/bFYgdYs6v2fDvb6Kt0
 7nYtk99hslOluZnh3ol41rG6c/XUoZ+5Gt5oDwKzP6HxFoETM9SFGK0QNLleQJazQupM3UpT1
 nctz+FMdRZS7t8MKKzEIvM3vQYpmXbC0jtoJ/L5AzN1tTg6F5uu7tecRGNKU+mg4FFj/sQ/Gk
 yG5u4Zy3wcIAyt3211EZ+8d7Ec5LGfBkKwDprPKzXjTpnAQ9sN7lfA10n6smh1o0/AGeUk3uO
 ZwoE3iRYsJ/1qwMt4nwyFKNETE4mUOwENq7CALc9vuCAuKGaRermImCfvAZVb4wNn2M0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271814>

G=C3=A1bor's mail reminded me that this bug bites me often enough when =
rebasing Git for Windows.

The symptom is that .git/CHERRY_PICK_HEAD is left behind after skipping=
 an already-merged patch with `git rebase --continue` instead of `git r=
ebase --skip`. I always prefer the former invocation because the latter=
 would also skip legitimate patches if there were merge conflicts, whil=
e the former would not allow that.

Johannes Schindelin (2):
  t3404: demonstrate CHERRY_PICK_HEAD bug
  rebase -i: do not leave a CHERRY_PICK_HEAD file behind

 git-rebase--interactive.sh    |  6 +++++-
 t/t3404-rebase-interactive.sh | 20 ++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

--=20
2.3.1.windows.1.9.g8c01ab4
