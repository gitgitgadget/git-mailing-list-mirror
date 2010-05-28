From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCH 2/3] git-instaweb: Wait for server to start before running 
	web browser
Date: Sat, 29 May 2010 01:01:42 +0530
Message-ID: <AANLkTilpiwy2NFhOycoMBeYZFZDuVN5yFt8nIiIoYTjL@mail.gmail.com>
References: <1275073885-26537-1-git-send-email-jnareb@gmail.com>
	<1275073885-26537-3-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Petr Baudis <pasky@suse.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 28 21:31:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OI5HZ-0005rE-CI
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 21:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953Ab0E1Tbo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 May 2010 15:31:44 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:44989 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753996Ab0E1Tbn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 May 2010 15:31:43 -0400
Received: by gwaa12 with SMTP id a12so1281913gwa.19
        for <git@vger.kernel.org>; Fri, 28 May 2010 12:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MTWlNJNpadQZtb3DWSFVYwTEbZpflttBiLTBAtiC/R8=;
        b=VLcjaDm2ZJk3dvXnp6Ri1NBvMV2Yl2X8SA2HelFz4z64roT24gd08VgJhWEZ1ksCqT
         PE5umorv1GGNuj/sWDp9zl0csS1ZnKAKwUDSbI6UeVQWscp7o+eOL+e4feA/dacXWxG1
         FueDCiUYpH4ZSn//tHFWAmTOamW25njlU7LfM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HbHLlBQhmWIXghJWCJXXf478LkeapXYXJgzQDtKm794sXMMfTEpCuntMJXiRbnnryd
         sqxziXwbgxegdUXWYUkGgiud7OH3WwgC5zEYwVVq6l8beFPvcmUsgDeVlsjzQDRhqjNc
         BYqH+Dj3rUtMzIONw3ZbKx/DuqKlwMycyaTl0=
Received: by 10.90.2.23 with SMTP id 23mr941044agb.103.1275075102724; Fri, 28 
	May 2010 12:31:42 -0700 (PDT)
Received: by 10.90.84.5 with HTTP; Fri, 28 May 2010 12:31:42 -0700 (PDT)
In-Reply-To: <1275073885-26537-3-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147935>

> It uses IO::Socket::INET module, which is core Perl module since v5.6=
=2E0.

Core module means it will be installed by default in v5.6. But what
happens in case of lower versions of perl ?

> +httpd_is_ready () {
> + =A0 =A0 =A0 "$PERL" -MIO::Socket::INET -e "
> +local \$| =3D 1; # turn on autoflush
> +exit if (IO::Socket::INET->new('127.0.0.1:$port'));
> +print 'Waiting for \'$httpd\' to start ..';
> +do {
> + =A0 =A0 =A0 print '.';
> + =A0 =A0 =A0 sleep(1);
> +} until (IO::Socket::INET->new('127.0.0.1:$port'));
> +print qq! (done)\n!;
> +"
> +}
> +

One of the solution is to add a web server specific branch in httpd_is_=
ready().
So, if the server is plackup it loads the module and checks the port,
if not it will just continue.

Just an Idea for a common usage.

Thanks,
Pavan.
