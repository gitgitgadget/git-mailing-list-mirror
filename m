From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] contrib: add a pair of credential helpers for Mac OS X's keychain
Date: Tue, 4 Oct 2011 16:09:26 -0400
Message-ID: <CAG+J_DxQg_0YB8X6LMXhus817qRLLQkbCp939Ux4rzO36tj4Sg@mail.gmail.com>
References: <1316055113-2353-1-git-send-email-jaysoffian@gmail.com>
	<20110929075627.GB14022@sigill.intra.peff.net>
	<CAG+J_DwntGc+j3duCVqsnoJGV18FqnwXJ99C1XqKope_zbGHAA@mail.gmail.com>
	<20110930221111.GB9384@sigill.intra.peff.net>
	<CAG+J_Dww1yOeq1LHQYMiObPKqrWbk4t8Hn=G9WpYWXFBbHiuhQ@mail.gmail.com>
	<20111003105908.GF16078@sigill.intra.peff.net>
	<CAG+J_DxAaw=vVENFUP5Mq9+inuDEpn_3Le_b7sO97wRUW6aFSA@mail.gmail.com>
	<20111004101610.GA11236@sigill.intra.peff.net>
	<7v39f8d6iq.fsf@alter.siamese.dyndns.org>
	<20111004174840.GA31558@sigill.intra.peff.net>
	<7vy5x0bmjk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	John Szakmeister <john@szakmeister.net>,
	Kyle Neath <kneath@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 22:09:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBBIy-0007r4-06
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 22:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933615Ab1JDUJ1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Oct 2011 16:09:27 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46034 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933403Ab1JDUJ1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2011 16:09:27 -0400
Received: by yxl31 with SMTP id 31so867339yxl.19
        for <git@vger.kernel.org>; Tue, 04 Oct 2011 13:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=hI5vLAjDq9TxDO7T0BpCfXkNzJmiTgA4Eii1fri6CAo=;
        b=jxsb/XO1kcqBDnsixVcIQ8V9NYTHaxexcPlWptyK9tthBs0Cg3ggG6xPmjKqElAt1m
         +8eIOpiasy/WFNhEAezYhb5enPW4P+eHuidvYShwAQQzRYMqUgzosW+SRkEhUs7VankE
         3z11/rW/s/HEK+DEnWqo08ne7kXbkALL+T0Yo=
Received: by 10.236.155.1 with SMTP id i1mr9640866yhk.8.1317758966587; Tue, 04
 Oct 2011 13:09:26 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Tue, 4 Oct 2011 13:09:26 -0700 (PDT)
In-Reply-To: <7vy5x0bmjk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182795>

On Tue, Oct 4, 2011 at 3:10 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>
> Hmm, don't we first want to enumerate contexts where we might want to=
 get
> the access information from the user? E.g.
>
> =C2=A0* "transport" aka "git fetch/push"; I think you meant this by -=
-type=3Dnetwork,
> =C2=A0 but there probably are other kinds of accesses over "network".
> =C2=A0* "imap-send".
> =C2=A0* "send-email".
> =C2=A0* "tag -s" and perhaps upcoming "push --signed" or "commit --gp=
g-sign"?
>
> Anything else?

Perhaps it would be illustrative to look at the OS X keychain API call
for adding a password to the store:

OSStatus SecKeychainAddInternetPassword (
   SecKeychainRef keychain,
   UInt32 serverNameLength,
   const char *serverName,
   UInt32 securityDomainLength,
   const char *securityDomain,
   UInt32 accountNameLength,
   const char *accountName,
   UInt32 pathLength,
   const char *path,
   UInt16 port,
   SecProtocolType protocol,
   SecAuthenticationType authenticationType,
   UInt32 passwordLength,
   const void *passwordData,
   SecKeychainItemRef *itemRef
);

SecProtocolType is an enum of 4-char values such as 'ftp ', 'http',
etc. Similarly for SecAuthenticationType which uses values such as
'form' (web form), 'http' (basic auth), etc.

http://developer.apple.com/library/mac/#documentation/Security/Referenc=
e/keychainservices/Reference/reference.html#//apple_ref/doc/c_ref/SecKe=
ychainAddInternetPassword
http://developer.apple.com/library/mac/#documentation/Security/Referenc=
e/keychainservices/Reference/reference.html#//apple_ref/doc/c_ref/SecPr=
otocolType
http://developer.apple.com/library/mac/#documentation/Security/Referenc=
e/keychainservices/Reference/reference.html#//apple_ref/doc/c_ref/SecAu=
thenticationType

j.
