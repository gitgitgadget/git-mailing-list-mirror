From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: git .lock file error
Date: Thu, 30 Sep 2010 19:13:02 +0000
Message-ID: <AANLkTik364t7WEHOsZcB7FE4Y2gJQNxkXsRvW5guUWCi@mail.gmail.com>
References: <AANLkTikjwW8jJ3qGCAM=8F_GBxsz9_KoSW0KDGPKhXGQ@mail.gmail.com>
	<AANLkTin+MRkYv7vL7eY+mdWG1vTg-E9pVpU4_QujoxdZ@mail.gmail.com>
	<AANLkTim2sFCx8qZ-6o4tiugX3a-EBN9T8wuCSWXb5L12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nate Parsons <parsons.nate@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 21:13:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1OZ4-0001aW-GX
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 21:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650Ab0I3TNF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 15:13:05 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40872 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018Ab0I3TND convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Sep 2010 15:13:03 -0400
Received: by iwn5 with SMTP id 5so2786729iwn.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 12:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=f5RS9aqH21FV2NE3Ro3tzTMH5RBShGCiT9Z0yE3rrrk=;
        b=Vav+wHNZoqVpSwYN/WKTXpnKE/sT07iM5ld7HQey2RQaQYK3i5MzDH64sISujbYJee
         OLWbUJAvU7Zzy/RSehEsuAvE8FIB8ycmrmYUJNoW/dNMZldeF8WESFbU6v2ow7J0IGlg
         RNiagqAdizj+5cO+V/RLQIYk1zbKRRTHq6Z0o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wlxc1hT4Cxg15Z3ZvgweSiNKxRTsePxKzx+BW7IYTsXR0722Vi61a2a8AXwtiXiV0K
         TCBr0uDMARx5wqhi0F2eGdeV9m++09eLu7GgyfxHyWaWMxsvybBw4YKm2+/H3aMBIu51
         8x2Svcqsn+dabj+bT9rrITMHuaEUvvh/AyyI0=
Received: by 10.231.167.130 with SMTP id q2mr4247797iby.163.1285873982651;
 Thu, 30 Sep 2010 12:13:02 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Thu, 30 Sep 2010 12:13:02 -0700 (PDT)
In-Reply-To: <AANLkTim2sFCx8qZ-6o4tiugX3a-EBN9T8wuCSWXb5L12@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157704>

On Thu, Sep 30, 2010 at 18:00, Nate Parsons <parsons.nate@gmail.com> wr=
ote:
> OK, so this is definitely a win32 issue. I believe that the perl
> script is simply creating .lock files too fast for Windows to keep up=
=2E
> Simply trying again fixes the problem for me.

Sounds like something that might do with a non-hacky solution, but I
don't know what that would be.

> - =C2=A0 =C2=A0 =C2=A0 sysopen(my $fh, $db_lock, O_RDWR | O_CREAT)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0or croak "Couldn't open $d=
b_lock: $!\n";
> + =C2=A0 my $fh;
> + =C2=A0 my $tries=3D10;
> + =C2=A0 for(; !sysopen($fh, $db_lock, O_RDWR | O_CREAT) && $tries>=3D=
0; $tries--) { }
> + =C2=A0 if($tries <=3D 0) { croak "Couldn't open $db_lock: $!\n"; }
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$update_ref eq 'reset' ? _rev_map_reset($f=
h, $rev, $commit) :
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _rev_map_set($fh, $rev, $com=
mit);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if ($sync) {

=46WIW I think this is more readable, but maybe we want to retry on all
platforms:

    my $fh;
    if ($^O eq 'MSWin32' or $^O eq 'cygwin') {
        # Try 10 times to open our lock file, in case Windows is laggin=
g
        for my $try (1..10) {
            sysopen($fh, $db_lock, O_RDWR | O_CREAT);
            last if $fh;
        }
    } else {
        sysopen($fh, $db_lock, O_RDWR | O_CREAT);
    }

    warn "Couldnt open $db_lock: $!\n" unless $fh;'
