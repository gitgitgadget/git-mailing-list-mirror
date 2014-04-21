From: Greg M <morenzg@gmail.com>
Subject: error: git-remote-https died of signal 13
Date: Sun, 20 Apr 2014 20:42:15 -0400
Message-ID: <CAEHyFQLmu4GWHcd+Xd6MOikf_LJgK0dGM7VXk6h6OLsud+-Wgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 02:42:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wc2Jf-0000W1-Jc
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 02:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbaDUAmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 20:42:18 -0400
Received: from mail-we0-f171.google.com ([74.125.82.171]:47094 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbaDUAmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 20:42:16 -0400
Received: by mail-we0-f171.google.com with SMTP id t61so3201524wes.2
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 17:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=X4SouhfYaokN4ej7Moqr4FNq+dgNDUOM6+dRF9ipz6A=;
        b=gO4NhjfEzlhVONUzBZM7bW8wyq/73b7qWVXLy/opzur/gm/bPoCHj8pC5lIUKvgDRp
         roJep+UJHA2rMciZYjkyHkwHr0e+xexGwt3VR5dyYvqXIUgeH4b8FFZE/+9JYS53Chgi
         7HS42mXZkMZcAL4TTDQwgHSLLNUxVDynISBCHCp3qt3PAcv8EsJkvLhYF6K98lomeALy
         lYYkqXwu6lPBkQW/yUKVhNqtTM9a7NezPmixa7XFfmccB2hJM82VcEAe0GcE5WRlH63m
         i3tKAHVbiwPx67t3T+gczoSbbBwUQEOWEdPGZQrUVi6zgQ/y6McaY1pqUcGJ4Pk8xCF2
         cwBw==
X-Received: by 10.180.95.4 with SMTP id dg4mr11672671wib.9.1398040935596; Sun,
 20 Apr 2014 17:42:15 -0700 (PDT)
Received: by 10.227.107.70 with HTTP; Sun, 20 Apr 2014 17:42:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246604>

Hi,

Using git version 1.9.2 I am getting this error:

[normal@laptop tmp]$ git clone https://github.com/mozilla/rust.git
Cloning into 'rust'...
remote: Reusing existing pack: 296648, done.
remote: Counting objects: 80, done.
remote: Compressing objects: 100% (77/77), done.
remote: Total 296728 (delta 22), reused 9 (delta 3)
Receiving objects: 100% (296728/296728), 110.68 MiB | 190.00 KiB/s, done.
Resolving deltas: 100% (238828/238828), done.
Checking connectivity... done.
error: git-remote-https died of signal 13

The repository appears to be cloned fine, I can clone other repositories
without error.

I appear to have the exact same symptoms as Stefan in November 2013 as
archived here:
http://thread.gmane.org/gmane.comp.version-control.git/238242/focus=238311.
In this case the cause was a curl error that was fixed in version curl
version 7.34...

I have curl version 7.36 though, in case some of the other output matters:

[normal@laptop tmp]$ curl --version
curl 7.36.0 (x86_64-unknown-linux-gnu) libcurl/7.36.0 OpenSSL/1.0.1g
zlib/1.2.8 libssh2/1.4.3
Protocols: dict file ftp ftps gopher http https imap imaps pop3 pop3s rtsp
scp sftp smtp smtps telnet tftp
Features: AsynchDNS GSS-Negotiate IPv6 Largefile NTLM NTLM_WB SSL libz
TLS-SRP

The curl command to reproduce the since fixed bug (curl --limit-rate 250k
-L http://github.com/raspberrypi/firmware/archive/4ade27942e.tar.gz >
/dev/null) runs without error and exits with a value of 0.

The first response to Stefan's bug report requested the output of the
command with GIT_TRANSPORT_HELPER_DEBUG=1 and strace -f, so I've included
that:

GIT_TRANSPORT...:
https://drive.google.com/file/d/0BxdiDTQp3MYXQWJJaVdydUstbWs/edit?usp=sharing
strace (33M download, 330M uncompressed):
https://drive.google.com/file/d/0BxdiDTQp3MYXb1VKWWtFUDdvbjQ/edit?usp=sharing

Thanks,
Greg
