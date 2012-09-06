From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: Encrypted repositories
Date: Thu, 06 Sep 2012 04:23:32 +0200 (CEST)
Message-ID: <f6682453-92bc-4f3b-9bf3-1910ca6fb307@zcs>
References: <fcbea7c0-b433-414b-abd3-b0e205a96fc5@zcs>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 04:23:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9Rks-0001Gf-GC
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 04:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952Ab2IFCXf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Sep 2012 22:23:35 -0400
Received: from zcs.vnc.biz ([83.144.240.118]:36539 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752934Ab2IFCXe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Sep 2012 22:23:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id 1D3AC62225B
	for <git@vger.kernel.org>; Thu,  6 Sep 2012 04:23:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9ZvlLtSEQECx for <git@vger.kernel.org>;
	Thu,  6 Sep 2012 04:23:32 +0200 (CEST)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id 1BD6B62203A
	for <git@vger.kernel.org>; Thu,  6 Sep 2012 04:23:32 +0200 (CEST)
In-Reply-To: <fcbea7c0-b433-414b-abd3-b0e205a96fc5@zcs>
X-Originating-IP: [91.43.204.13]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC18 (Linux)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204852>

Hi,

I'm currently planning to implement an strong encryption in git
(not like gitcrypt, but with encrypted blobs, directories, etc,
directly in the core).

The idea goes like this:

* blobs are encrypted with their (original) content hash as
  encryption keys
* directory objects only hold randomized filenames and pointers
  to the encrypted blob (content hash of the encrypted data)
* new ext-directory objects are holding a mapping of the
  randomized file names to the real ones and the encryption keys,
  stored encrypted similar to the blobs
* ext-directory object is referenced by a special filename in
  the directory object.
* commit objects also hold an encrypted section (eg. uuencoded)
  with the ext-directory node's key, additional commit text, etc,
  itself encrypted with the repository key

This way, the lowlevel / bare repository operations (including
remote sync and gc) should continue to work, while only actual
access (eg. checkout or commit) need to be changed and have the
repository key available.


What do you think about this approach ?


cu
--=20
Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards=20

Enrico Weigelt=20
VNC - Virtual Network Consult GmbH=20
Head Of Development=20

Pariser Platz 4a, D-10117 Berlin
Tel.: +49 (30) 3464615-20
=46ax: +49 (30) 3464615-59

enrico.weigelt@vnc.biz; www.vnc.de=20
