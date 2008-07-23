From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH v2] git daemon: avoid waking up too often
Date: Wed, 23 Jul 2008 15:26:32 -0400
Message-ID: <32541b130807231226m73fcc874ub72f69adeb5d26c3@mail.gmail.com>
References: <alpine.DEB.1.00.0807222251570.8986@racer>
	 <alpine.DEB.1.00.0807222302440.8986@racer>
	 <4886D503.7030106@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jul 23 21:27:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLjzq-0000ZJ-9f
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 21:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858AbYGWT0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 15:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752768AbYGWT0e
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 15:26:34 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:63618 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbYGWT0e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 15:26:34 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1115011ywe.1
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 12:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Z+DU2JCMoITOl/BaTzVT/6E2igDaNZi3/sffGVhX4kg=;
        b=CtLr8D4euzCF91m5IBzaBOBbb4NsjsTfRzElay3WHuqCwxo0KlXD6jfUSB+rcOIsHw
         32Jb8G5WcImGchDeoJz99Xf9u39E9NkL5HKvSibiOVgHti4XNyETvUn2UsaCgd+wL6x+
         VpdHQt1ipfe5WT/t5YYSvcmFBckD+bDlbzaBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=B1d0BhvLKmGWJggL5n02BRfMk0NCxz7oeYKMft62HRqG5t/7KDJEZiVYmXUhHDaX1i
         EG5zMTiI+HXtl3X9n25cK1bQCBsrrcUMVZPhWv2dpO5HYIzrd06W89RvaSTgHTcLIx9i
         dLi6Lg7de6duJtGRpy75iNKeouNvvdEQPzjS8=
Received: by 10.151.46.17 with SMTP id y17mr47382ybj.120.1216841193058;
        Wed, 23 Jul 2008 12:26:33 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Wed, 23 Jul 2008 12:26:32 -0700 (PDT)
In-Reply-To: <4886D503.7030106@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89752>

On 7/23/08, Johannes Sixt <j.sixt@viscovery.net> wrote:
> This makes porting this beast to Windows practically impossible because we
>  cannot have a poll() implementation that waits both on a listening socket
>  and a pipe. :-(

I have worked around such problems in the past by having a thread
whose job it is to read from the pipe and simply write it to a socket.
 The trick works for "console" objects, too, which in win32 are even
less agreeable than pipes.

(In case your life wasn't disgusting enough already today :))

Alternatively, you could use something like socketpair() instead of a
pipe for this purpose.  Naturally, Win32 helps you out here by somehow
forgetting to include socketpair() in winsock, although it's sort of
easy to emulate.

Have fun,

Avery
