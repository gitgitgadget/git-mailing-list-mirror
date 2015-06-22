From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v7 10/19] fsck: Make =?UTF-8?Q?fsck=5Ftag=28=29=20warn-fri?=
 =?UTF-8?Q?endly?=
Date: Mon, 22 Jun 2015 17:26:30 +0200
Organization: gmx
Message-ID: <dd82008f47d4f3b534a5c914c8f72accdbb6fd37.1434986506.git.johannes.schindelin@gmx.de>
References: <cover.1434720655.git.johannes.schindelin@gmx.de>
 <cover.1434986506.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 22 17:26:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z73cR-00074v-0R
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 17:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753791AbbFVP0j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jun 2015 11:26:39 -0400
Received: from mout.gmx.net ([212.227.15.19]:54859 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753661AbbFVP0h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 11:26:37 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Mh9yT-1ZTPrK0aW1-00MKgc; Mon, 22 Jun 2015 17:26:31
 +0200
In-Reply-To: <cover.1434986506.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:1Vi2AeMsj9ZhD7iwa0DNM65qJ2BpHKx2jkhq40mHZEVpx0IHzMh
 tFaaN6yljdyLr4yUKeED+a/UcXAVdKC4IA3YEADWLhQJmG0tsGL5htN+ezYanxtf6wvh3pk
 Hv3K5ctXgAsOsxwfumN7zEQB52amJnIAmDtD6xBWBxBmKNfzCwjA/nXp4hsHyG+sLHvb0nL
 749EzZfq452NRKHiDXorw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aL0YSRtKg4w=:i6sDEtzF5L3PpxSlE/MeiE
 68F8/nxv3i41RWRaYTKrHf8WTfTlRHX50u4c8Np7AadZd8gDfEsqoCwGrAhO7g5C+nKhV0mWa
 KXlm4DpndnuPKSo0EsFqPZIu33/I/WoKmrncEsy66YWVJAjsvUbwhXD+DQvG/6LkP02IOdvFk
 hXJvE5el8w6KdzZMzdAFrFi5S9FQNlnd8bNcItUDUhnU/FOpvKZKTfa1r62Gz/+jquu3u/mXH
 kOV6zVEudEv8UCXkGjey1ANtcDk9IdNyXH2K+dy3vNB8cYVBaNU7M4SwLc556h/6+Gan8FO9k
 oDLocKWVhvEfOXr6W2pczHm/RVG9OAkPF1pC/FLtukOPiNCBZkjvGtQWpOsshKQ1h1MMJeWvL
 qdJGHmLJQPSEInOQxnSnRjtA0lJiHbLBGYYj/qR+r5onF+FQq4MphjuB1U4zUVVB9XG7cJGIX
 7oYJpctehCx6hNImL6vlXmW/2b4lIzHpf+PH6bxPI/CAPobZHBltmVBDze/+9L+3ic26dHy7R
 y5dG37I3K5ulnyi8Q3RxUUDRxzvQXfF/nn+hIcE/53aVahFYOuSUUbcuJY2kLirXlDYO5Gg8R
 +YMAcr7DborYomQCUYI91tuYrAghBAFjJVjaGSaSwkKH0UwhfNEqO7y/7JX5KecoQxT/TfG3T
 bp4diiFS8ce8HqFbwGNbc/eGLw9RTZvp/lkUaJeFzaYb3raCseUWnk5BFuS2AP+2WWi8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272381>

When fsck_tag() identifies a problem with the commit, it should try
to make it possible to continue checking the commit object, in case the
user wants to demote the detected errors to mere warnings.

Just like fsck_commit(), there are certain problems that could hide oth=
er
issues with the same tag object. For example, if the 'type' line is not
encountered in the correct position, the 'tag' line =E2=80=93 if there =
is any =E2=80=93
would not be handled at all.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fsck.c b/fsck.c
index daa07ad..3f76f99 100644
--- a/fsck.c
+++ b/fsck.c
@@ -642,7 +642,8 @@ static int fsck_tag_buffer(struct tag *tag, const c=
har *data,
 	}
 	if (get_sha1_hex(buffer, sha1) || buffer[40] !=3D '\n') {
 		ret =3D report(options, &tag->object, FSCK_MSG_BAD_OBJECT_SHA1, "inv=
alid 'object' line format - bad sha1");
-		goto done;
+		if (ret)
+			goto done;
 	}
 	buffer +=3D 41;
=20
--=20
2.3.1.windows.1.9.g8c01ab4
