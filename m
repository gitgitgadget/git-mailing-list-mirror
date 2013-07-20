From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 09/16] pack-protocol.txt: a bit about smart http
Date: Sat, 20 Jul 2013 16:58:03 +0700
Message-ID: <1374314290-5976-10-git-send-email-pclouds@gmail.com>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
 <1374314290-5976-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 20 11:59:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0TwI-0001Vw-T7
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 11:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456Ab3GTJ6z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Jul 2013 05:58:55 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:65235 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823Ab3GTJ6y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jul 2013 05:58:54 -0400
Received: by mail-ie0-f175.google.com with SMTP id a11so11332984iee.20
        for <git@vger.kernel.org>; Sat, 20 Jul 2013 02:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=jVHHPxMAxDwzxtYNp5CsOkc41u33cm/l26uVVLPXVZo=;
        b=wcImaW8ICo7yDctpefk2El8bR4S2v/WaZtlbwHz21RySyA8eBi7N46Y3T8SDycvjW9
         Qcey+2t9hhzMe0ud9lK2+DwUjlEPNc+RzuFefUEqzdKvBLSsBzGJXKnJt7yAWvhPVBxz
         ve4hAJJV+8MDF4OERDApAYqH2qKn4ZzZtqtvBj+vkC7jXwcSBW1E55CPO683pt4oLtaO
         J6W6pidyYA5FyZ6vL0yjguYQ0NOwi6iQE5A/RM81Xnt7iocFk3m0A9ITp0nXCIkVrtQu
         yqQf3PVlEl0MzEDpBZ/gQnuenNWl0ZyygaJ4HZvibdOqeQQNb500Dr4wIXDaDyieWqRS
         O5Ww==
X-Received: by 10.43.143.4 with SMTP id jk4mr13464243icc.81.1374314333833;
        Sat, 20 Jul 2013 02:58:53 -0700 (PDT)
Received: from lanh ([115.73.248.127])
        by mx.google.com with ESMTPSA id n5sm21091906igv.5.2013.07.20.02.58.50
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Jul 2013 02:58:53 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 20 Jul 2013 16:59:12 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1374314290-5976-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230887>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/technical/pack-protocol.txt | 66 +++++++++++++++++++++++=
++++++++
 1 file changed, 66 insertions(+)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/=
technical/pack-protocol.txt
index c73b62f..a1672bc 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -551,3 +551,69 @@ An example client/server communication might look =
like this:
    S: 0018ok refs/heads/debug\n
    S: 002ang refs/heads/master non-fast-forward\n
 ----
+
+Smart HTTP Transport
+--------------------
+
+Smart HTTP protocol is basically "git protocol on top of http". The
+base protocol is modified slightly to fit HTTP processing model: no
+bidirectional full-duplex connections, the program may read the
+request, write a response and must exit.
+
+Reference Discovery
+-------------------
+
+The server end always sends the list of references in both push and
+fetch cases. This ref list is retrieved by the client's sending HTTP
+GET request to a smart http url ending with
+"/info/refs?service=3D<service>" where <service> could be either
+git-upload-pack or git-receive-pack for fetching or pushing
+respectively. The output is in pkt-line format.
+
+----
+  advertised-refs  =3D  service
+		      flush-pkt
+		      (no-refs / list-of-refs)
+		      flush-pkt
+
+  service          =3D  PKT-LINE("# service=3D" service-name)
+  service-name     =3D  ("git-upload-pack" / "git-receive-pack")
+
+  no-refs          =3D  PKT-LINE(zero-id SP "capabilities^{}"
+		      NUL capability-list LF)
+
+  list-of-refs     =3D  first-ref *other-ref
+  first-ref        =3D  PKT-LINE(obj-id SP refname
+		      NUL capability-list LF)
+
+  other-ref        =3D  PKT-LINE(other-tip / other-peeled)
+  other-tip        =3D  obj-id SP refname LF
+  other-peeled     =3D  obj-id SP refname "^{}" LF
+
+  capability-list  =3D  capability *(SP capability)
+  capability       =3D  1*(LC_ALPHA / DIGIT / "-" / "_")
+  LC_ALPHA         =3D  %x61-7A
+----
+
+Packfile Negotiation
+--------------------
+
+For fetching, packet negotiation is via a series of HTTP POST requests
+to an url ending with "/git-upload-pack" with the content in pkt-line
+format. git-upload-pack's response consists of a "service" line like
+in Reference Discovery followed by normal git-upload-pack packet
+lines. Capability multi_ack_detailed is required by Smart HTTP.
+
+Common objects that are discovered are appended onto the request as
+have lines and are sent again on the next request. This allows the
+remote side to reinitialize its in-memory list of common objects
+during the next request and the remote does not need to maintain the
+negotiation state.
+
+Reference Update Request
+------------------------
+
+For pushing, a HTTP POST request is sent to an url ending with
+"/git-receive-pack" with the content in pkt-line format.
+git-receive-pack's response consists of a "service" line like in
+Reference Discovery followed by normal git-receive-pack packet lines.
--=20
1.8.2.83.gc99314b
