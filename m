From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: fix 'Use of uninitialized value' error in href()
Date: Fri, 31 Jul 2009 10:37:42 +0200
Message-ID: <cb7bb73a0907310137o6adb57a5tb05b6745b41b0f01@mail.gmail.com>
References: <200907310824.42953.jnareb@gmail.com> <1249022929-21037-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<200907311030.52643.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 10:38:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWncy-0007qe-QX
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 10:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbZGaIiF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Jul 2009 04:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbZGaIiE
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 04:38:04 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:49400 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbZGaIiD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jul 2009 04:38:03 -0400
Received: by fxm17 with SMTP id 17so1235805fxm.37
        for <git@vger.kernel.org>; Fri, 31 Jul 2009 01:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Jtxa2D72RZn777thgp9MLNAk4cbrACZWKNQlUHHDQgc=;
        b=ILgnS04GDRvydaO18AU1zjNL8Awmw6jUSOdiFNqMjRTZ4UKzGlVngQzwwMK2L+sgJh
         cMW+Jsl1JRg3Re0K8GNrCTHkozDkeOcfAAG6zFTxKHdVFcn6Q/pL0SLT3n2TjUOWssoV
         UN/vWPPPL5eg9Qe7YSbDcek2pmOeyLQfO6wvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=SOWjOUo9BnIlErRET/RbLJlGBaviNQeanWr0jfLgewjEmbwmdIJs1JXwXpCACdBrPf
         SyepoqU28BF/MQztdsZ09jXEGqQB0ejxHqzoHvh5o3xzHSKQSbkx0VLQbldEJ2NxB5Eb
         RCT0GulaxbQLE2F0b+up8z/NoW0kkxt0p4UFQ=
Received: by 10.204.59.135 with SMTP id l7mr2536635bkh.13.1249029482224; Fri, 
	31 Jul 2009 01:38:02 -0700 (PDT)
In-Reply-To: <200907311030.52643.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124512>

2009/7/31 Jakub Narebski <jnareb@gmail.com>:
> On Fri, 31 July 2009, Giuseppe Bilotta wrote:
>>
>> The funny thing is that I seem to get the error for something as sim=
ple
>> as a commit view (_any_ commit view, for the matter), but I wasn't a=
ble
>> to reproduce it from the shell, which is why I'm not adding a testca=
se.
>
> Gaaah! A Heisenbug! ;-)

Well, I can reproduce it consistently on the gitweb repository, with
any shortlog or commit view. I also think I understand why it happens
(i.e. in some cases the check for file_parent eq file_name is done
before calling href). The question, of course, is why wouldn't it
happen in the test repository.

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (define=
d $params{'file_parent'}) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 if (defined $params{'file_name'} && $params{'file_parent'} eq $par=
ams{'file_name'}) {
>
> or, to reduce line length even more:
>
> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 if (defined $params{'file_name'} &&
> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 $params{'file_parent'} eq $params{'file_name'}) {

Oh right ... should I resend?

--=20
Giuseppe "Oblomov" Bilotta
