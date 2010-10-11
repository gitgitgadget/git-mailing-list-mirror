From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 01/15] mingw: add network-wrappers for daemon
Date: Mon, 11 Oct 2010 17:07:42 -0500
Message-ID: <20101011220742.GA6277@burratino>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
 <1286833829-5116-2-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	avarab@gmail.com, sunshine@sunshineco.com,
	Mike Pape <dotzenlabs@gmail.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 00:11:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5QaP-0000XN-CS
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 00:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756670Ab0JKWLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 18:11:06 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:42894 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756660Ab0JKWLE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 18:11:04 -0400
Received: by qyk10 with SMTP id 10so4850392qyk.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 15:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=JYbFxzMd7PEQ9U78D6q8OO9X9c2QlR4WErEQvWgw8Ow=;
        b=VceN398Sy5HB8Slwzpf8V1rIjozdS9xoO2SZTz1tpxGnGe5JIhOcPlBGGaDSEFGlc/
         4kI21m1EuSNKdLeqMHgoEVChUly+m9oyIshMlwbfJE/Ct5fdCj71dx/wM9UOpXWDhvRA
         2u6hklpsm6Nwp39TWvehdPoQRrCyiw3tLUz0I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=NpeK4xlJSvJE4YGocGL/SSTreB73EDcJ+KchtUKWLPWzSV9WFIPPTBMhaoW6CDGxWX
         0aMVAGgkAnYc23jEPcE6PBJIpU2BkM8HNDzwATdg+W0rzSvyMiitLu1z+8cIFN9QiE7p
         Xxkk0w6Rn0K66Dsl3pRM/aUiPD7UiR5nxMmVI=
Received: by 10.229.97.3 with SMTP id j3mr5491649qcn.233.1286835063655;
        Mon, 11 Oct 2010 15:11:03 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id t35sm2659424qco.18.2010.10.11.15.11.01
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 11 Oct 2010 15:11:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286833829-5116-2-git-send-email-kusmabite@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158808>

Erik Faye-Lund wrote:

> From: Mike Pape <dotzenlabs@gmail.com>
> 
> git-daemon requires some socket-functionality that is not yet
> supported in the Windows-port. This patch adds said functionality,
> and makes sure WSAStartup gets called by socket(), since it is the
> first network-call in git-daemon.

For the curious: gethostbyname(), getaddrinfo(), and getnameinfo()
already call WSAStartup if it hasn't already been called.  So
imap-send and the libgit transport code do not suffer from the same
problem.  Similarly for git daemon in the !NO_IPV6 case.

In the NO_IPV6 case, git daemon does not call getaddrinfo() and
--listen=<hostname> does not work (why?), so we have to hook into
socket(), too.

Looks good to my winsock-ignorant eyes.
