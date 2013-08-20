From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Document smart http
Date: Tue, 20 Aug 2013 12:08:08 +0700
Message-ID: <1376975288-17079-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 20 07:08:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBeB6-0007fh-7j
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 07:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037Ab3HTFIU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Aug 2013 01:08:20 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:48397 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925Ab3HTFIT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 01:08:19 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so5855092pbc.29
        for <git@vger.kernel.org>; Mon, 19 Aug 2013 22:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=ApTMbqCksPZgvErY2Eoxef+KrfavW1XRru0+whZNWyg=;
        b=EUZGy/2pEuqnx4HISVCtKM49eARVS1VHReQWkrFpCjRG83y3kXxUZntqyW56Oh8hsr
         28+8knfVAYB53evHHlQwAQx3NgkVo0y1kvwG8wKM5UxuaN7nApoX6xuJbb2ZaGtewsTI
         CD2wO+isJZnHP+ie4EfG4e4nblv4ZHS+iztiMSREeLcrCSonqUx84Nm1yiKOV8W2PQ/c
         5MbcMYlIuP+Ve+26qZJnpDziGUrKY/rHDvkkZI06HkAvWhLoarXjIpGefpBJ+bP4ujbt
         DRhl+z9jAHxT8RRz02YAoTDpSP68lGZ6FTtu4PQ64pbn2EWITgT8HKaVdRNkEExrHSvc
         yyhg==
X-Received: by 10.68.5.228 with SMTP id v4mr16975028pbv.117.1376975298883;
        Mon, 19 Aug 2013 22:08:18 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id ts6sm18750448pbc.12.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 19 Aug 2013 22:08:17 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 20 Aug 2013 12:08:12 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232582>

This may provide some clues for those who want to modify smart http
code as smart http is pretty much undocumented. Smart http "document"
so far is a few commit messages and the source code.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-fetch-pack.txt          | 11 +++--
 Documentation/git-receive-pack.txt        | 12 +++++-
 Documentation/git-send-pack.txt           |  9 +++-
 Documentation/git-upload-pack.txt         |  9 +++-
 Documentation/technical/pack-protocol.txt | 69 +++++++++++++++++++++++=
++++++++
 5 files changed, 103 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch=
-pack.txt
index 1e71754..85a9437 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -9,10 +9,7 @@ git-fetch-pack - Receive missing objects from another =
repository
 SYNOPSIS
 --------
 [verse]
-'git fetch-pack' [--all] [--quiet|-q] [--keep|-k] [--thin] [--include-=
tag]
-	[--upload-pack=3D<git-upload-pack>]
-	[--depth=3D<n>] [--no-progress]
-	[-v] [<host>:]<directory> [<refs>...]
+'git fetch-pack' [options] [<host>:]<directory> [<refs>...]
=20
 DESCRIPTION
 -----------
@@ -90,6 +87,12 @@ be in a separate packet, and the list must end with =
a flush packet.
 --no-progress::
 	Do not show the progress.
=20
+--stateless-rpc::
+	Smart HTTP mode.
+
+--lock-pack::
+	Issue "lock" command to the remote helper via stdout.
+
 -v::
 	Run verbosely.
=20
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-rec=
eive-pack.txt
index b1f7dc6..0b2029c 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -9,7 +9,7 @@ git-receive-pack - Receive what is pushed into the repo=
sitory
 SYNOPSIS
 --------
 [verse]
-'git-receive-pack' <directory>
+'git-receive-pack' [options] <directory>
=20
 DESCRIPTION
 -----------
@@ -35,6 +35,16 @@ are not fast-forwards.
=20
 OPTIONS
 -------
+--stateless-rpc::
+	Smart HTTP mode.
+
+--advertise-refs::
+	Only the initial ref advertisement is output then exits
+	immediately.
+
+--quiet::
+	Make unpack-objects at the receive-pack end quiet.
+
 <directory>::
 	The repository to sync into.
=20
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-p=
ack.txt
index dc3a568..6cee3d4 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -9,7 +9,7 @@ git-send-pack - Push objects over Git protocol to anoth=
er repository
 SYNOPSIS
 --------
 [verse]
-'git send-pack' [--all] [--dry-run] [--force] [--receive-pack=3D<git-r=
eceive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]
+'git send-pack' [options] [<host>:]<directory> [<ref>...]
=20
 DESCRIPTION
 -----------
@@ -52,6 +52,13 @@ OPTIONS
 	Send a "thin" pack, which records objects in deltified form based
 	on objects not included in the pack to reduce network traffic.
=20
+--stateless-rpc::
+	Smart HTTP mode.
+
+--helper-status:
+	Issue status commands (e.g. "ok" or "error") to the remote
+	helper via stdout.
+
 <host>::
 	A remote host to house the repository.  When this
 	part is specified, 'git-receive-pack' is invoked via
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-uplo=
ad-pack.txt
index 0abc806..ce9a455 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -9,7 +9,7 @@ git-upload-pack - Send objects packed back to git-fetch=
-pack
 SYNOPSIS
 --------
 [verse]
-'git-upload-pack' [--strict] [--timeout=3D<n>] <directory>
+'git-upload-pack' [options] <directory>
=20
 DESCRIPTION
 -----------
@@ -31,6 +31,13 @@ OPTIONS
 --timeout=3D<n>::
 	Interrupt transfer after <n> seconds of inactivity.
=20
+--stateless-rpc::
+	Smart HTTP mode.
+
+--advertise-refs::
+	Only the initial ref advertisement is output then exits
+	immediately.
+
 <directory>::
 	The repository to sync from.
=20
diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/=
technical/pack-protocol.txt
index b898e97..7590394 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -546,3 +546,72 @@ An example client/server communication might look =
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
+request, write a response and must exit. Any negotiation is broken
+down into many separate GET or POST requests. The server is
+stateless. The client must send enough information so that the server
+can recreate the previous state.
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
1.8.2.82.gc24b958
