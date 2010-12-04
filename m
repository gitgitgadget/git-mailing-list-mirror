From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 3/4] fast-import: let importers retrieve blobs
Date: Sat, 4 Dec 2010 14:24:32 +0100
Message-ID: <201012041424.33146.trast@student.ethz.ch>
References: <1287147256-9457-1-git-send-email-david.barr@cordelta.com> <20101128194501.GD19998@burratino> <201012031130.06008.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 04 14:29:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POsBS-00064O-E3
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 14:29:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754998Ab0LDNYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 08:24:37 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:58289 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754944Ab0LDNYg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Dec 2010 08:24:36 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sat, 4 Dec
 2010 14:24:20 +0100
Received: from pctrast.inf.ethz.ch (84.74.105.24) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sat, 4 Dec
 2010 14:24:34 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc3-git6-8-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <201012031130.06008.trast@student.ethz.ch>
X-Originating-IP: [84.74.105.24]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162893>

Thomas Rast wrote:
> Jonathan Nieder wrote:
> > +test_expect_success PIPE 'R: copy using cat-file' '
> [...]
> > +	dd if=/dev/stdin of=blob bs=$size count=1 <&3 &&
> 
> This breaks my automated tester, though I am not sure exactly why.  It
> runs RHEL5, and I have
> 
>   lrwxrwxrwx 1 root root 15 Sep  1 09:25 /dev/stdin -> /proc/self/fd/0

Ah, answering my own question: on my normal box, strace'ing dd[1] in
such an invocation uses

  open("/dev/stdin", O_RDONLY)            = 3
  dup2(3, 0)                              = 0
  close(3)                                = 0

OTOH on RHEL5[2] it tries a different order:

  close(0)                                = 0
  open("/dev/stdin", O_RDONLY)            = -1 ENOENT (No such file or directory)

Oops.


[1] dd --version says: dd (coreutils) 7.1
[2] dd (coreutils) 5.97

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
