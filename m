From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH v2] connect.c: remove a few globals by using git_config 
	callback data
Date: Wed, 11 Mar 2009 14:17:53 +0100
Message-ID: <40aa078e0903110617g60e0d7d0x1e0d94e44ef89f40@mail.gmail.com>
References: <1236739092-8280-1-git-send-email-kusmabite@gmail.com>
	 <alpine.DEB.1.00.0903111251160.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 11 14:19:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhOLH-0003jX-2P
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 14:19:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754247AbZCKNR5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Mar 2009 09:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753646AbZCKNR5
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 09:17:57 -0400
Received: from mail-ew0-f177.google.com ([209.85.219.177]:57729 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288AbZCKNR4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2009 09:17:56 -0400
Received: by ewy25 with SMTP id 25so1654535ewy.37
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 06:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0zAnQT2ecSYxEhbEFGx/3Xf7QD1pdUt77njC/GDdwVA=;
        b=rsToJIV/b7y0kWpX904+l+RKi+eVS/sqQPW9Xu5YJDRQHi3WYudkJL1ppVK50I98W1
         7uXx1FlgbR/c6+Dp2RPywtZfdwGEcS4xXBxX0rGKi45ouS5JwwcDzAux0tPEIx6ymgv9
         dHe6h7H+kGlqD8LpJPYDZuoPcrxHmCH33bEXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eiHcd/oNAno+/7CgYycFVoG+oWgwu/XMt5IlLKc6tOfauO+s/A1epnkD9eYMRV7ZGJ
         8iDdfp6ktxJ347HuwP9eE7WDZdDidu4ih6UlIcEEhM4aC7NDUwOD3JHAXhsfuFIGWESp
         eYwN2VDyBPrxnta4oxIcjqHB/Qz8uoz6HWJbM=
Received: by 10.210.39.8 with SMTP id m8mr1380016ebm.59.1236777473725; Wed, 11 
	Mar 2009 06:17:53 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903111251160.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112926>

Thanks for the feedback.

On Wed, Mar 11, 2009 at 12:52 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> @@ -383,6 +381,8 @@ static int git_proxy_command_options(const char =
*var, const char *value,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *for_pos;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 int matchlen =3D -1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 int hostlen;
>> + =A0 =A0 =A0 =A0 =A0 =A0 const char *rhost_name =3D cb;
>> + =A0 =A0 =A0 =A0 =A0 =A0 int rhost_len =3D strlen(rhost_name);
>
> I see that you still calculate the length everytime
> git_proxy_command_options() is called -- which is for every config
> variable.

Actually, the length-calculation is now moved inside the check for
"core.gitproxy", so it should only trigger for each config variable
that is "core.gitproxy". Hopefully, this should usually be just once
;)

This change was suggested as a compromise by Junio.

>
>> + =A0 =A0 git_config(git_proxy_command_options, (void*)host);
>
> The (void *) should not be needed.

Actually, it is - it casts away the const-ness of the string. Removing
the cast generates a warning on my installation of GCC. Perhaps I
should have made that clearer by casting to "char*" instead of
"void*"?

--=20
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
