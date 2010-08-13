From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 jn/svn-fe 0/5] vcs-svn: Port to Windows
Date: Fri, 13 Aug 2010 18:47:23 -0500
Message-ID: <20100813234723.GC2153@burratino>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
 <4C63BD9B.6000608@viscovery.net>
 <20100813000848.GA8076@burratino>
 <4C65BA46.9010604@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Aug 14 01:50:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok40c-0006HM-Ul
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 01:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756290Ab0HMXty convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 19:49:54 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39960 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756093Ab0HMXtx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 19:49:53 -0400
Received: by vws3 with SMTP id 3so1665334vws.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 16:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=EpwhNxQ9af1c4a97YnN6zfRX+ZTG/lzfJeY2Um4e7aE=;
        b=S2pwC0DDXVvT57k8Yb8b1yaWLUbs59+sVlmyd7jCqVhOUs4BUG0jCH+9u6yeyitVbL
         cr5vBrM4M5tcXzGlxi8Fza63xfwmBgOFsa5NVlMkWTBww2Pg1y8EWsIoOXRZ7B9Vi78a
         3PMECVY5c7T/53UKCS4cfHwaASBA9NojwDdQU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Vu6eUVaNWkklwQ7KtsfvarhI9NBmfTVU1kdM5t4xQQB0lBb0gTN1Vfr+g4kGEWb6+r
         dtlLzz/8tKwVGcGrk2l9sft5iNUx+SQWYICnYOPFFpTDRYzizqAf1N3NN6ewN8un1Mku
         QqD4qhrpMnOmdLs97jmHh8ASY02+VR0kfPWaU=
Received: by 10.220.158.9 with SMTP id d9mr1214593vcx.245.1281743392949;
        Fri, 13 Aug 2010 16:49:52 -0700 (PDT)
Received: from burratino ([64.134.175.141])
        by mx.google.com with ESMTPS id m6sm1225665vcx.24.2010.08.13.16.49.32
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 16:49:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C65BA46.9010604@kdbg.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153527>

Johannes Sixt wrote:
> Am 13.08.2010 02:08, schrieb Jonathan Nieder:

>> Subject: vcs-svn: Port to Windows
>>
>> MSys #define-s dirent away.  Avoid trouble by avoiding that
>> identifier.
>>
>> Windows does not have strtok_r (and while does have an identical
>> strtok_s, but it is not obvious how to use it).  Grab an
>> implementation from glibc.
>>
>> The svn-fe test fails in the =E2=80=9Csvn export=E2=80=9D step becau=
se of the
>> lack of symlink support.  With a less ambitious dump, it passes.
>>
>> Cc: Johannes Sixt <j6t@kdbg.org>
>> Cc: Ramkumar Ramachandra <artagnon@gmail.com>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Thanks, it compiles with this patch and passes the test suite.
>
> Acked-by: Johannes Sixt <j6t@kdbg.org>
>
> The license, LGPL 2.1 or later is OK, I assume?

xdiff uses it, so I think that should be fine.  If not, it shouldn=E2=80=
=99t
be hard to rewrite based on the man page; I only took the glibc
version because it was easy to do.

Here=E2=80=99s a split-up patch.  Patch 1 adds an autoconf test (thanks=
,
Jakub!).  Patch 2 is a little (though not much) shorter than the blind
search-and-replace I sent before.  This uses uint32_t instead of int
in patch 3 because the vcs-svn lib uses 32-bit lengths elsewhere.

Not tested on Windows but it is not so different from v1 which was.

Thanks again for the help.

Jonathan Nieder (5):
  compat: add strtok_r()
  vcs-svn: Rename dirent pool to build on Windows
  vcs-svn: Avoid %z in format string
  t9010 (svn-fe): use Unix-style path in URI
  t9010 (svn-fe): avoid symlinks in test

 Makefile              |    8 +++
 compat/strtok_r.c     |   61 ++++++++++++++++++++
 config.mak.in         |    1 +
 configure.ac          |    6 ++
 git-compat-util.h     |    5 ++
 t/t9010-svn-fe.sh     |    4 +-
 vcs-svn/fast_export.c |    5 +-
 vcs-svn/repo_tree.c   |  146 ++++++++++++++++++++++++-----------------=
-------
 8 files changed, 159 insertions(+), 77 deletions(-)
 create mode 100644 compat/strtok_r.c

--=20
1.7.2.1.544.ga752d.dirty
