From: Paul Smith <paul@mad-scientist.net>
Subject: Building Git with HTTPS support: avoiding libcurl?
Date: Tue, 22 Dec 2015 10:39:40 -0500
Organization: I may be mad, but I am a professional!
Message-ID: <1450798780.11255.22.camel@mad-scientist.net>
Reply-To: paul@mad-scientist.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 22 16:46:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBP93-00057p-Db
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 16:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621AbbLVPqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 10:46:32 -0500
Received: from gproxy9-pub.mail.unifiedlayer.com ([69.89.20.122]:58417 "HELO
	gproxy9-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751726AbbLVPq3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Dec 2015 10:46:29 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Dec 2015 10:46:29 EST
Received: (qmail 14186 invoked by uid 0); 22 Dec 2015 15:39:49 -0000
Received: from unknown (HELO CMOut01) (10.0.90.82)
  by gproxy9.mail.unifiedlayer.com with SMTP; 22 Dec 2015 15:39:49 -0000
Received: from box531.bluehost.com ([74.220.219.131])
	by CMOut01 with 
	id wffl1r00M2qhmhE01ffoJa; Tue, 22 Dec 2015 08:39:48 -0700
X-Authority-Analysis: v=2.1 cv=Zc6OaKlA c=1 sm=1 tr=0
 a=GcR8MKwCKDX7fzHfRD/fNg==:117 a=GcR8MKwCKDX7fzHfRD/fNg==:17 a=cNaOj0WVAAAA:8
 a=f5113yIGAAAA:8 a=pBbsfl06AAAA:8 a=IkcTkHD0fZMA:10 a=cdVwids0oJMA:10
 a=O5GnRg5U9jgA:10 a=wUQvQvOEmiQA:10 a=ztIK0ruuaPtuWua6FMMA:9
 a=GRKuZyVBmsutu15l:21 a=FnaGvjvTtDRSD0jB:21 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mad-scientist.net; s=default;
	h=Content-Transfer-Encoding:Mime-Version:Content-Type:Date:To:Reply-To:From:Subject:Message-ID; bh=CXCjpqQl7tMse57m8qJoXb0ApI7rnQHwsCEF0utB7g0=;
	b=dFYICXcG/tcpiL50J64qw5sKLo5ZPDvVfauEOeFgZHLX00k436CrR6pTa5hYzoeaq2N3hm3TeV396JbB90TWFrEABEwKVCJyXncv3EMQwKAG3VNTbj4dImEHUQdZBgie;
Received: from [96.237.233.6] (port=43692 helo=homebase)
	by box531.bluehost.com with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.84)
	(envelope-from <paul@mad-scientist.net>)
	id 1aBP2Q-0000Nr-90
	for git@vger.kernel.org; Tue, 22 Dec 2015 08:39:46 -0700
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
X-Identified-User: {678:box531.bluehost.com:madscie1:mad-scientist.us} {sentby:smtp auth 96.237.233.6 authed with paul+mad-scientist.us}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282879>

I'm trying to build Git (2.6.4) on GNU/Linux, but without any
requirements (other than basic libc etc.) on the local system.  This
works fine except for one thing: git-remote-https.

In order to build this I need to have libcurl, but libcurl is a MONSTER
library with an enormous number of prerequisites (see below).

Just wondering if anyone has considered an alternative to libcurl; maybe
I'm wrong but it seems to me that HTTPS support for Git would require
only a tiny fraction of the libcurl features and maybe there's an
alternative available which would be more targeted?

I realize this is not a short-term thing in that there won't be an API
compatible library that can just be dropped in.  This is more a forward
-looking question.  For now I'm looking to see if I can rebuild libcurl
myself without most of these dependencies such as Kerberos, LDAP, etc.


$ ldd /usr/lib/x86_64-linux-gnu/libcurl.so.4
        linux-vdso.so.1 =>  (0x00007fff37d81000)
        libidn.so.11 => /usr/lib/x86_64-linux-gnu/libidn.so.11 (0x00007f682b921000)
        librtmp.so.1 => /usr/lib/x86_64-linux-gnu/librtmp.so.1 (0x00007f682b704000)
        libssl.so.1.0.0 => /lib/x86_64-linux-gnu/libssl.so.1.0.0 (0x00007f682b49a000)
        libcrypto.so.1.0.0 => /lib/x86_64-linux-gnu/libcrypto.so.1.0.0 (0x00007f682b058000)
        libgssapi_krb5.so.2 => /usr/lib/x86_64-linux-gnu/libgssapi_krb5.so.2 (0x00007f682ae0e000)
        liblber-2.4.so.2 => /usr/lib/x86_64-linux-gnu/liblber-2.4.so.2 (0x00007f682abfe000)
        libldap_r-2.4.so.2 => /usr/lib/x86_64-linux-gnu/libldap_r-2.4.so.2 (0x00007f682a9ac000)
        libz.so.1 => /lib/x86_64-linux-gnu/libz.so.1 (0x00007f682a792000)
        libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f682a573000)
        libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f682a1a9000)
        libgnutls-deb0.so.28 => /usr/lib/x86_64-linux-gnu/libgnutls-deb0.so.28 (0x00007f6829e8d000)
        libhogweed.so.4 => /usr/lib/x86_64-linux-gnu/libhogweed.so.4 (0x00007f6829c59000)
        libnettle.so.6 => /usr/lib/x86_64-linux-gnu/libnettle.so.6 (0x00007f6829a23000)
        libgmp.so.10 => /usr/lib/x86_64-linux-gnu/libgmp.so.10 (0x00007f68297a3000)
        libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f682959e000)
        libkrb5.so.3 => /usr/lib/x86_64-linux-gnu/libkrb5.so.3 (0x00007f68292cc000)
        libk5crypto.so.3 => /usr/lib/x86_64-linux-gnu/libk5crypto.so.3 (0x00007f682909d000)
        libcom_err.so.2 => /lib/x86_64-linux-gnu/libcom_err.so.2 (0x00007f6828e98000)
        libkrb5support.so.0 => /usr/lib/x86_64-linux-gnu/libkrb5support.so.0 (0x00007f6828c8d000)
        libresolv.so.2 => /lib/x86_64-linux-gnu/libresolv.so.2 (0x00007f6828a71000)
        libsasl2.so.2 => /usr/lib/x86_64-linux-gnu/libsasl2.so.2 (0x00007f6828855000)
        libgssapi.so.3 => /usr/lib/x86_64-linux-gnu/libgssapi.so.3 (0x00007f6828615000)
        /lib64/ld-linux-x86-64.so.2 (0x0000559b03259000)
        libp11-kit.so.0 => /usr/lib/x86_64-linux-gnu/libp11-kit.so.0 (0x00007f68283b0000)
        libtasn1.so.6 => /usr/lib/x86_64-linux-gnu/libtasn1.so.6 (0x00007f682819c000)
        libkeyutils.so.1 => /lib/x86_64-linux-gnu/libkeyutils.so.1 (0x00007f6827f98000)
        libheimntlm.so.0 => /usr/lib/x86_64-linux-gnu/libheimntlm.so.0 (0x00007f6827d8e000)
        libkrb5.so.26 => /usr/lib/x86_64-linux-gnu/libkrb5.so.26 (0x00007f6827b04000)
        libasn1.so.8 => /usr/lib/x86_64-linux-gnu/libasn1.so.8 (0x00007f6827861000)
        libhcrypto.so.4 => /usr/lib/x86_64-linux-gnu/libhcrypto.so.4 (0x00007f682762d000)
        libroken.so.18 => /usr/lib/x86_64-linux-gnu/libroken.so.18 (0x00007f6827418000)
        libffi.so.6 => /usr/lib/x86_64-linux-gnu/libffi.so.6 (0x00007f6827210000)
        libwind.so.0 => /usr/lib/x86_64-linux-gnu/libwind.so.0 (0x00007f6826fe6000)
        libheimbase.so.1 => /usr/lib/x86_64-linux-gnu/libheimbase.so.1 (0x00007f6826dd7000)
        libhx509.so.5 => /usr/lib/x86_64-linux-gnu/libhx509.so.5 (0x00007f6826b8c000)
        libsqlite3.so.0 => /usr/lib/x86_64-linux-gnu/libsqlite3.so.0 (0x00007f68268be000)
        libcrypt.so.1 => /lib/x86_64-linux-gnu/libcrypt.so.1 (0x00007f6826686000)
