From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/14] msvc: Fix compilation errors in
 compat/win32/sys/poll.c
Date: Sat, 4 Dec 2010 14:45:41 -0600
Message-ID: <20101204204541.GA3170@burratino>
References: <4CFA8E64.6070402@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	kusmabite@gmail.com, GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Dec 04 21:46:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POz0P-0003YJ-1O
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 21:46:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755805Ab0LDUqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 15:46:05 -0500
Received: from mail-gx0-f180.google.com ([209.85.161.180]:47112 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755729Ab0LDUqE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Dec 2010 15:46:04 -0500
Received: by gxk19 with SMTP id 19so5793977gxk.11
        for <git@vger.kernel.org>; Sat, 04 Dec 2010 12:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=do79uItAi2e2g6Pdj9ibSI+tT51nXFaUDpDypPWe0WE=;
        b=waOjUpMDrzAhy5K4zwcpsDLH5tjTZSfFOnJLs2WweLsLWaBSxXRIhBcwcbNZIY/OpY
         7bbCGn2kiPTXpw7g6LkjcLqqVDxAeD+tc5divTZzf5Ngk7XUeNJxiEH7KiUB8e2UPpQM
         KJ/H9RZ7/r6jMdMtcxTt+eDjFU91GKXCLdKMw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PB0nPSaPRiFmgVvvVf04TcxYMm0nDNRaQ9IBMHZobfn3mQYOU1JRdHX7DF0yoEUyeb
         akP7rndl3cpbfTDfRetCBscpv/hbg88nM/9AnjBLs/P6O5lcI0tYZ9ebCtE4Bq8oipr8
         CAlG8v+VUCityudn4PiYO+8KfRyWds3IjDC/E=
Received: by 10.151.102.10 with SMTP id e10mr6225373ybm.364.1291495563171;
        Sat, 04 Dec 2010 12:46:03 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id q8sm510604ybk.0.2010.12.04.12.46.01
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Dec 2010 12:46:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CFA8E64.6070402@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162906>

Ramsay Jones wrote:

> The msvc winsock2.h header file conditionally defines or declares
> poll() related symbols which cause many macro redefinition errors,
> a struct type redefinition error and syntax errors. These symbols
> are defined in support of the WSAPoll() API, new in Windows Vista,
> when the symbol _WIN32_WINNT is defined and _WIN32_WINNT >= 0x0600.

Could it make sense to define this at the same time as _GNU_SOURCE et
al?

	#define _ALL_SOURCE 1
	#define _GNU_SOURCE 1
	#define _BSD_SOURCE 1
	#define _NETBSD_SOURCE 1
	#define _SGI_SOURCE 1
	#define _WIN32_WINNT 0x0502

Haven't thought carefully about the consequences, though; your patch
is probably safer.
