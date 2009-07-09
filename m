From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] quickfetch(): Prevent overflow of the rev-list command 
	line
Date: Thu, 9 Jul 2009 10:49:07 +0200
Message-ID: <81b0412b0907090149l34450255ka77a2341e7ee966b@mail.gmail.com>
References: <alpine.DEB.2.00.0906181310400.23400@ds9.cixit.se>
	 <200907081801.36901.johan@herland.net>
	 <7vws6j6qed.fsf@alter.siamese.dyndns.org>
	 <200907091043.03263.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Peter Krefting <peter@softwolves.pp.se>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jul 09 10:49:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOpJt-0004Te-46
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 10:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756942AbZGIItM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 04:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756703AbZGIItK
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 04:49:10 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:51362 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbZGIItJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 04:49:09 -0400
Received: by bwz25 with SMTP id 25so1782bwz.37
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 01:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=G4RbAr5jFyypHt+DN6vfNkC6F9QSW2JL7LFsvUAfTZ8=;
        b=qiqdrDohz8y97XXy9Qtx41dnvQymtJEzYxC/LHRNNTlxM9cxjDY+OdizDDA/UYXpLT
         TxiY8BQ3UapH2aaL+SnJQJoiqPkck5I5HgsxVJ3+eT9Px/MUOiQ0OS3LxS/ACTosuIY2
         +h6m13VFaOZ/3v63XKeq+Zwo1XaU54vbrwfg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GXKk2yA3WRGRqbmf9FTY/H7rx/0vhVdN8IIiMVefJe6rC81UBHCLdpTF7RjvREVbg3
         Bg40LEtmNjBtSklkBk/vB0ISZxcyeb6SiUAko7/3fiaXxSx5oVq7ZjOa1hKlJbukH+zU
         gXjKobiv0w6jggXPdU90J7EDOKgqGdUZ7GuBc=
Received: by 10.204.72.15 with SMTP id k15mr513173bkj.14.1247129347806; Thu, 
	09 Jul 2009 01:49:07 -0700 (PDT)
In-Reply-To: <200907091043.03263.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122949>

On Thu, Jul 9, 2009 at 10:43, Johan Herland<johan@herland.net> wrote:
> On Wednesday 08 July 2009, Junio C Hamano wrote:
>> Johan Herland <johan@herland.net> writes:
>> > Maybe I need to do something to the close() call as well? What happens
>> > on close() after EPIPE?
>
> Does anybody with Windows/MSYS experience know how this scenario (write() to
> a terminated process, followed by close()) would play out in msysGit?
>

It fails with ERROR_BROKEN_PIPE. See MSDN for WriteFile:

 http://msdn.microsoft.com/en-us/library/aa365747%28VS.85%29.aspx

(look for the error above).

Well, sometimes it just fails, so you can hardly use the error code to detect
if the other process is truly gone or something broke in Windows.
