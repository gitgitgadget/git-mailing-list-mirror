From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [StGit PATCH] Add an empty line before signed-off-by
Date: Mon, 12 Mar 2007 22:13:20 +0100
Message-ID: <200703122213.21298.robin.rosenberg@dewire.com>
References: <20070309225959.20959.32505.stgit@lathund.dewire.com> <b0943d9e0703120925k17fb9cabt6b43e371433dfc9b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 22:11:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQrnk-0004S2-19
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 22:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbXCLVLZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 12 Mar 2007 17:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752413AbXCLVLZ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 17:11:25 -0400
Received: from [83.140.172.130] ([83.140.172.130]:11082 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752389AbXCLVLY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Mar 2007 17:11:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 92915802841;
	Mon, 12 Mar 2007 22:06:07 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 08852-03; Mon, 12 Mar 2007 22:06:07 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 3CE6B802808;
	Mon, 12 Mar 2007 22:06:05 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <b0943d9e0703120925k17fb9cabt6b43e371433dfc9b@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42082>


    Default to the standard convention of having an empty line
    before the Signed-off line when addign a signature using the
    --sign option.=20

    Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
--

m=E5ndag 12 mars 2007 17:25 skrev Catalin Marinas:
> On 09/03/07, Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> > Default to the standard convention of having an empty line
> > before the Signed-off line when addign a signature using the
> > --sign option.
>=20
> I mainly use this option to counter-sign an existing patch, in which
> case there is no need for a new line. Maybe we need StGIT to be
> smarter and check whether the patch was already signed.

Ok, here's a smarter version

-- robin

diff --git a/stgit/stack.py b/stgit/stack.py
index feb77e3..681da5e 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -734,7 +734,12 @@ class Series(StgitObject):
             committer_email =3D patch.get_commemail()

         if sign_str:
-            descr =3D '%s\n%s: %s <%s>\n' % (descr.rstrip(), sign_str,
+            descr =3D descr.rstrip()
+            if descr.find("\nSigned-off-by") < 0:
+                if descr.find("\nAcked-by") < 0:
+                    descr =3D descr + "\n"
+
+            descr =3D '%s\n%s: %s <%s>\n' % (descr, sign_str,
                                            committer_name, committer_e=
mail)

         bottom =3D patch.get_bottom()
