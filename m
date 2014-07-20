From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH 0/3] getcwd without PATH_MAX
Date: Sun, 20 Jul 2014 13:18:52 +0200
Message-ID: <53CBA59C.8050901@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karsten Blees <karsten.blees@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWk=?= =?UTF-8?B?IE5n4buNYyBEdXk=?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 20 13:19:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8p9L-0000YW-GT
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jul 2014 13:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbaGTLTX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jul 2014 07:19:23 -0400
Received: from mout.web.de ([212.227.15.3]:64404 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751079AbaGTLTW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2014 07:19:22 -0400
Received: from [192.168.178.27] ([79.253.172.97]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0LnS3i-1WcGHW2Dxm-00hhPZ; Sun, 20 Jul 2014 13:19:12
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Provags-ID: V03:K0:PF68e1Lgf1+pkmgUBiWf0jxDRfiGwRr0XcUKgkfsvcr4QCpmWpm
 AS5oQNqzdGQjksITV/EcKSi/r2La2orZNNzSsS1BWHLplarfgD7wyPqdUvdKkdwinePinKa
 rwhIe4YvovvIP+LtlePtr343wHlo+66INa/aWBE/TI7f3nrUrVso5Jco3jaCcVWUgmyNn+i
 xW2FAOR57KdFoI4SKvEWw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253915>

Paths longer than PATH_MAX can be created and used on at least on some
file systems.  Currently we use getcwd() generally with a PATH_MAX-
sized buffer.  This short series adds two functions, strbuf_add_cwd()
and xgetcwd(), then uses them to reduce the number of fixed-sized
buffers and to allow us to handle longer working directory paths.

Ren=C3=A9 Scharfe (3):
  strbuf: add strbuf_add_cwd()
  wrapper: add xgetcwd()
  use xgetcwd() get the current directory or die

 Documentation/technical/api-strbuf.txt |  4 ++++
 builtin/init-db.c                      | 17 ++++++++---------
 builtin/rev-parse.c                    |  6 +++---
 dir.c                                  | 12 ++++++++----
 git-compat-util.h                      |  1 +
 strbuf.c                               | 22 ++++++++++++++++++++++
 strbuf.h                               |  1 +
 trace.c                                |  7 ++++---
 wrapper.c                              |  8 ++++++++
 9 files changed, 59 insertions(+), 19 deletions(-)

--=20
2.0.2
