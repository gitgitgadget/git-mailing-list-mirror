From: Mika Fischer <mika.a.fischer@googlemail.com>
Subject: Re: [msysGit] Git unable to access https repositories due to
 curl/OpenSSL 1.0.0 handshake issues
Date: Wed, 26 Jan 2011 16:13:33 +0100
Message-ID: <AANLkTi=Gey75oo-iaELVWg87cP+HgM3RQ60vPgwaEMpS@mail.gmail.com>
References: <0aa77107-bb31-4f74-90e2-02ce5155b0a0@l17g2000yqe.googlegroups.com>
 <AANLkTi=UQR3cEbTj4N0W_4CLG9T1F+rmkLEew+WO4w5f@mail.gmail.com>
 <AANLkTinGLMcRJ9EuZY_k4GoKyg+r7hxcgnq3z0=qOemA@mail.gmail.com>
 <AANLkTimJznExH8N9fcgSC88HOPfaFDF7jFMTZUJauL9+@mail.gmail.com> <alpine.DEB.2.00.1101261422550.20831@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: kusmabite@gmail.com, msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Wed Jan 26 16:13:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pi74J-0006TC-FP
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 16:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394Ab1AZPNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 10:13:54 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44371 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267Ab1AZPNx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 10:13:53 -0500
Received: by iyj18 with SMTP id 18so458666iyj.19
        for <git@vger.kernel.org>; Wed, 26 Jan 2011 07:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Dh7pXKm6Set48O3die81i8Z2oMDmZ2KXVAL3TkZg6s4=;
        b=K34sWU1V+Ygcf8UmXnfftKjPU4tRZrQ3iqSQloO3kjBb59T5ekEdjvN3iRK5E0X495
         t6MPs0p04iBGCE/h+Ty3oIFVogUf5rrZZLXuI1aO0CjcDDlsqIWLNkw2NzyNtEna5TmH
         jzMW1729eUT0yfd59yFgFrayaPHftvKrCs4nM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=JRlJKMekiZnfhUamf06YGcT2/CWO0q4O4xIQ2/iYIwf8UgSRIRsYqtln9V/yJyR33f
         UXkF5VdHmDm8SwVAdeUkKUY5+XymDO9LwS3EAZaNUz92HLoXi8ypJWNc85ioWQ/ytDuD
         Kv9QmH8XUWvmIaLmi4LIkCV+hkEEccEgH0VFs=
Received: by 10.231.208.8 with SMTP id ga8mr8342262ibb.1.1296054833278; Wed,
 26 Jan 2011 07:13:53 -0800 (PST)
Received: by 10.231.8.215 with HTTP; Wed, 26 Jan 2011 07:13:33 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1101261422550.20831@tvnag.unkk.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165521>

On Wed, Jan 26, 2011 at 14:29, Daniel Stenberg <daniel@haxx.se> wrote:
> 3. I tried getting a file through this using curl 7.21.2 and my current dev
> version of 7.21.4-DEV (see below for full details). Both managed to get it
> fine.

Same here. curl can fetch fine from the openssl mini-httpd

> From this, I conclude that there's some additional factors necessary to make
> this problem trigger. Can you figure out what?

So to recap, we have the following situation:

curl/openssl 0.9.8k <-> apache/openssl 0.9.8k -> works
curl/openssl 1.0.0 <-> apache/openssl 0.9.8k -> works
curl/openssl 0.9.8k <-> apache/openssl 1.0.0 -> error
openssl 0.9.8k <-> apache/openssl 1.0.0 -> works
curl/openssl 0.9.8k <-> openssl 1.0.0 -> works
openssl 0.9.8k <-> openssl 1.0.0 -> works

I'm not sure what to take away from this. Maybe it's a problem that is
partly caused by both apache and curl?

Do you know how I could debug this? I won't have much time during the
day but I can test things in the evenings...

Just FYI: To get something running, I downgraded our apache server to
the OpenSuSE 11.2 packages. Now it works again fine, with the same
configuration as before...

The failing curl -V on OpenSuSE 11.2
curl 7.19.6 (x86_64-unknown-linux-gnu) libcurl/7.19.6 OpenSSL/0.9.8k
zlib/1.2.3 libidn/1.10
Protocols: tftp ftp telnet dict ldap http file https ftps
Features: GSS-Negotiate IDN IPv6 Largefile NTLM SSL libz

curl -V on the problematic apache host running OpenSuSE 11.3
curl 7.20.1 (x86_64-unknown-linux-gnu) libcurl/7.20.1 OpenSSL/1.0.0
zlib/1.2.3 libidn/1.15 libssh2/1.2.2_DEV
Protocols: dict file ftp ftps http https imap imaps ldap pop3 pop3s
rtsp scp sftp smtp smtps telnet tftp
Features: GSS-Negotiate IDN IPv6 Largefile NTLM SSL libz

Best,
 Mika
