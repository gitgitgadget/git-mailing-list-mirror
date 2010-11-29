From: demerphq <demerphq@gmail.com>
Subject: Re: [PATCHv7.1 3/4] gitweb: File based caching layer (from git.kernel.org)
Date: Tue, 30 Nov 2010 00:26:56 +0100
Message-ID: <AANLkTim5V_50Er8OiNTWDHNzvqJ3J+biOwuqnBdnR4jH@mail.gmail.com>
References: <201010311021.55917.jnareb@gmail.com>
	<1288607092-31458-1-git-send-email-jnareb@gmail.com>
	<201011130035.50229.jnareb@gmail.com>
	<201011130056.24222.jnareb@gmail.com>
	<AANLkTinX9Phu+SuOyEWtAsMz182VkfVkJva1ep==V-zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 30 00:27:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PND7f-0003vR-Hk
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 00:27:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754476Ab0K2X06 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Nov 2010 18:26:58 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61016 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753340Ab0K2X06 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Nov 2010 18:26:58 -0500
Received: by qwb7 with SMTP id 7so5079638qwb.19
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 15:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DHje3vJZNF1W/W7FY56Z3O7hjSd+J25hxZzG4BhA1rc=;
        b=jw6urJGArA+sUpEATwst75pv3vE9kXsNei/lCXDl49sxvheiBEOD2cjH9tTFG6cIex
         yXZvtZbsLr4YTWt2CHzGWu7+ODT9wk+Hnu4rLNLjcwh72mYYqH197iXGsqKr5ki/W/76
         /+CS7gSek7b3K+yz3K1dsKADYUyV83/Nm3/0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qIfXFcVHjoo+z6XAF5bozD0oJS1SpFkwZq398rt9HnVxaiadADBJfm6rmG/BIJ95IP
         TfJ6PQEURw7mUv5UNhezeFZFg25Rb+nZq2yZo8nwi+hun/AKUlTRnn/8iWuZiLIFHucW
         4iWXz3lcwR4HEPo6P/UUFgKRVHstQIUJlNlSA=
Received: by 10.229.251.204 with SMTP id mt12mr5364562qcb.182.1291073216501;
 Mon, 29 Nov 2010 15:26:56 -0800 (PST)
Received: by 10.229.192.193 with HTTP; Mon, 29 Nov 2010 15:26:56 -0800 (PST)
In-Reply-To: <AANLkTinX9Phu+SuOyEWtAsMz182VkfVkJva1ep==V-zQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162451>

On 30 November 2010 00:07, demerphq <demerphq@gmail.com> wrote:
> 2010/11/13 Jakub Narebski <jnareb@gmail.com>:
>> - =A0 =A0 =A0 binmode STDOUT, ':raw';
>> - =A0 =A0 =A0 print <$fd>;
>> - =A0 =A0 =A0 binmode STDOUT, ':utf8'; # as set at the beginning of =
gitweb.cgi
>> + =A0 =A0 =A0 if ($caching_enabled) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 open BINOUT, '>', $fullhashbinpath or =
die_error(500, "Could not open bin dump file");
>> + =A0 =A0 =A0 }else{
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 open BINOUT, '>', \$fullhashbinpath or=
 die_error(500, "Could not open bin dump file");
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 binmode BINOUT, ':raw';
>> + =A0 =A0 =A0 print BINOUT <$fd>;
>> + =A0 =A0 =A0 binmode BINOUT, ':utf8'; # as set at the beginning of =
gitweb.cgi
>> + =A0 =A0 =A0 close BINOUT;
>
> Why do you use dynamically scoped file handles here as opposed to
> lexically scoped ones?
>
> And why do you change the output discipline on BINOUT immediately
> before closing the file, and after you print data to it?
>
> Doing so sortof makes sense when the filedhandle is STDOUT, but not
> when it is BINOUT.

Also in this code:

2010/11/28 Jakub Narebski <jnareb@gmail.com>:
> +#
> +# Includes
> +#
> +if (!exists $INC{'cache.pl'}) {
> +       my $return =3D do 'cache.pl';
> +       die $@ if $@;
> +       die "Couldn't read 'cache.pl': $!" if (!defined $return);
> +}

Why is that preferred to:

   require 'cache.pl';

And why is this thing even a .pl file? Why isnt it called
lib/GitWeb/Cache.pm or something like that?


--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
