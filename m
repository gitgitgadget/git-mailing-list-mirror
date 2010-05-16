From: =?ISO-8859-1?Q?D=E9vai_Tam=E1s?= <devait@vnet.hu>
Subject: Re: [PATCH GSoC 2/3] git-instaweb: Configure it to work with a	global
 server root and projects list
Date: Sun, 16 May 2010 02:16:58 +0200
Message-ID: <1273969019.1169.16.camel@localhost.localdomain>
References: <1273953520-25990-1-git-send-email-pavan.sss1991@gmail.com>
 <1273953520-25990-2-git-send-email-pavan.sss1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 16 02:32:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODRmh-0003Gj-1H
	for gcvg-git-2@lo.gmane.org; Sun, 16 May 2010 02:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176Ab0EPA1M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 May 2010 20:27:12 -0400
Received: from a.relay.invitel.net ([62.77.203.3]:34033 "EHLO
	a.relay.invitel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767Ab0EPA1L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 May 2010 20:27:11 -0400
X-Greylist: delayed 607 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 May 2010 20:27:11 EDT
Received: from mail.invitel.hu (mail.invitel.hu [213.163.59.4])
	by a.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id 80FB811B26E;
	Sun, 16 May 2010 02:17:02 +0200 (CEST)
Received: from [192.168.0.2] ([87.97.121.122])
 by mail.invitel.hu (Invitel Messaging Server)
 with ESMTPA id <0L2H005T0KSCGM70@invitel.hu>; Sun,
 16 May 2010 02:17:01 +0200 (CEST)
In-reply-to: <1273953520-25990-2-git-send-email-pavan.sss1991@gmail.com>
X-Mailer: Evolution 2.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147170>

> +# Default is /usr/share/gitweb
> +test -z "$root" && root=3D'/usr/share/gitweb'

Just one question: what happens, when one installs to /usr/local (or an=
y
other directory) instead of /usr? I'd use the $(gitwebdir) variable fro=
m
the Makefile as default, such as

  # if installed, it doesn't need further configuration (module_path)
  test -z "$httpd" && httpd=3D'lighttpd -f'
 =20
-+# Default is /usr/share/gitweb
-+test -z "$root" && root=3D'/usr/share/gitweb'
++# Default is @@gitwebdir@@
++test -z "$root" && root=3D'@@gitwebdir@@'
 +
  # any untaken local port will do...
  test -z "$port" && port=3D1234

and in the Makefile

         sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
             -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
             -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
++           -e 's|@@gitwebdir@@|$(gitwebdir)|g' \
 -           -e '/@@GITWEB_CGI@@/r gitweb/gitweb.cgi' \
 -           -e '/@@GITWEB_CGI@@/d' \
 -           -e '/@@GITWEB_CSS@@/r $(GITWEB_CSS)' \

Hope that you find it reasonable.
--
D=C3=A9vai Tam=C3=A1s
