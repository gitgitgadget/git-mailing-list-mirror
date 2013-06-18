From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: send-email adds redundant From: lines to message body
Date: Tue, 18 Jun 2013 13:09:04 +0200
Message-ID: <20130618110904.GA20052@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "Michael S. Tsirkin" <mst@redhat.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 18 13:09:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uotmz-00020j-ST
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 13:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754941Ab3FRLJ0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jun 2013 07:09:26 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:65013 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411Ab3FRLJY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 07:09:24 -0400
Received: from localhost6.localdomain6 (g230129165.adsl.alicedsl.de [92.230.129.165])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MJF9e-1Urdbn23ru-002I3H; Tue, 18 Jun 2013 13:09:05 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:f7RDLcM9vOVV04HdB598fWSGksegCpVEkyNdjJO5jDN
 ct+GKPJPSuUYwWxw/gAdwusP2tQTq9UhSYcKxvViLtyO4vZzRN
 +lZdtobw2ZlOnkbWv4b6jBd/IZcYbwHWO09X2TxJmxntiUu/VR
 INJu6461Fm4IAjzc9mY40GTInUG6hRZHfh4zuI9xULM/yxRxwN
 3oKESFS/oEAn7oyw4HC09bJY+rMCEbTbs+HE5JK/pSJZ7rivec
 9C3YAXBo5xgqXuW2HYAHJK706kKn70TcbRxq+1bqfcuLZD1VuE
 CHci01SJWZtnVGuR61SFJsIv373On2JperHD5p6DQIDgAq7E/6
 hu8ogtXxf4raZAcL0pN45Zgpfy/kB4b4jJdFWy2t0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228197>

Hi,

'git send-email' recently started to add redundant From: lines to my
messages, see e.g.

  http://article.gmane.org/gmane.comp.version-control.git/228132

Bisect points to:

commit da18759e86bb1a7ee718c79a0c6cb15fbcbdf3c2
Author: Michael S. Tsirkin <mst@redhat.com>
Date:   2013-06-05 21:11:00 +0300

    send-email: make --suppress-cc=3Dself sanitize input
   =20
    --suppress-cc=3Dself fails to filter sender address in many cases w=
here it
    needs to be sanitized in some way, for example quoted:
    "A U. Thor" <author@example.com>
    To fix, make send-email sanitize both sender and the address it is
    compared against.
   =20
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

The exact commands I run were:

  git format-patch --cover-letter --subject-prefix=3D'PATCH v2' 2847cae=
835fa70f00e6e2286fbfa5595cb2247d0..bash-prompt-speedup
  vim 0000-cover-letter.patch
  git send-email --to=3Dgit@vger.kernel.org 00*

i.e. no '--suppress-cc=3Dself' option at all.  Values of related config
variables are:

  git config --get-regexp '(sendemail|user)\..*'
  sendemail.smtpserver /usr/local/bin/putmail
  sendemail.confirm auto
  user.name SZEDER G=E1bor
  user.email szeder@ira.uka.de

The '=E1' in my first name is apparently significant: creating a commit
and sending it as a patch with that accent removed doesn't trigger a
redundant From: line.


Thanks,
G=E1bor
