From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 3/4] fast-import: let importers retrieve blobs
Date: Fri, 3 Dec 2010 11:30:05 +0100
Message-ID: <201012031130.06008.trast@student.ethz.ch>
References: <1287147256-9457-1-git-send-email-david.barr@cordelta.com> <20101128194131.GA19998@burratino> <20101128194501.GD19998@burratino>
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
X-From: git-owner@vger.kernel.org Fri Dec 03 11:30:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POSu9-0004iV-4B
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 11:30:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754898Ab0LCKaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 05:30:09 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:3581 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751709Ab0LCKaI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 05:30:08 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Fri, 3 Dec
 2010 11:29:54 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.218.12; Fri, 3 Dec
 2010 11:30:06 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc3-git6-8-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <20101128194501.GD19998@burratino>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162786>

Jonathan Nieder wrote:
> +test_expect_success PIPE 'R: copy using cat-file' '
[...]
> +	dd if=/dev/stdin of=blob bs=$size count=1 <&3 &&

This breaks my automated tester, though I am not sure exactly why.  It
runs RHEL5, and I have

  $ ls -l /dev/std*
  lrwxrwxrwx 1 root root 15 Sep  1 09:25 /dev/stderr -> /proc/self/fd/2
  lrwxrwxrwx 1 root root 15 Sep  1 09:25 /dev/stdin -> /proc/self/fd/0
  lrwxrwxrwx 1 root root 15 Sep  1 09:25 /dev/stdout -> /proc/self/fd/1

But from the tests I get back

  dd: opening `/dev/stdin': No such file or directory
  error: git-fast-import died of signal 13
  not ok - 110 R: copy using cat-file

In any case I cannot see a reason to use this construct: 'dd' reads
from stdin by default, so you could just leave away the option.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
