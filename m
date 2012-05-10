From: demerphq <demerphq@gmail.com>
Subject: Re: Git.pm
Date: Thu, 10 May 2012 19:38:29 +0200
Message-ID: <CANgJU+WR9zWbwrHK-PT0jKKNQ6ZXv=9oGxOuQh6iLZaORohGBQ@mail.gmail.com>
References: <CAB3zAY3-Bn86bCr7Rxqi4vxbYFxUesLwm8gddxyMSexov2tOhw@mail.gmail.com>
	<CAFouetgwRpB1GFJOC8PTVryVY-94S3xa5ZiSaWQWoz070qQ-6g@mail.gmail.com>
	<CAB3zAY0NeXuH-wXyYkbim5U74eANY4hq5D6SsVLu3KeUqHFqzQ@mail.gmail.com>
	<20120426203136.GA15432@burratino>
	<CAB3zAY3VHtUobJfJ7=nSKb_6uJOXLGVHzR18qV6txPkzf54cDw@mail.gmail.com>
	<CANgJU+W-FJZRtu_4si7nr96KfNe2rzaiUaDC0GiK_WixudvcxA@mail.gmail.com>
	<7vr4usnh2q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Subho Banerjee <subs.zero@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Tim Henigan <tim.henigan@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 10 19:38:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSXK9-0005Yi-Eu
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 19:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760820Ab2EJRie convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 May 2012 13:38:34 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:34496 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760808Ab2EJRia convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 May 2012 13:38:30 -0400
Received: by mail-gg0-f174.google.com with SMTP id u4so1105415ggl.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 10:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=f+t6cLkksW8Wlw2u8unwTHEYFlZrqwsCaNVhySbwVyY=;
        b=mXePeH+TjcOPaGKdGlQpGISZI7JNNbC3XAP6/bm1R28JWYqGp88XpP49V5vb95ptbk
         TsNg1oW8ZtFF5Qwf/nEFq2+frd/v1SqG7bdVxKAz70h3R7yPHRsESXLWX0sbU46oXVZl
         RnvjW8PnaLITXYRb1RKtasjsdGVC0hm/MR4SEdJV9Z0Z38nO9XmBUbj385JpD+LTuvqJ
         1BWnZ3B07zTnk67caUwh5qmwiDyI4MrG5N0Tq3isvir/arJQJbKHkjZa7DFds5RmoQg5
         76QkdL+iCUiKV9Wcw5kaleWvRM1A8tDPrXnTpBTClCO6RGIeoOwGjYyA8QRLua0OzALJ
         KFaQ==
Received: by 10.236.145.104 with SMTP id o68mr6299029yhj.74.1336671509730;
 Thu, 10 May 2012 10:38:29 -0700 (PDT)
Received: by 10.236.152.35 with HTTP; Thu, 10 May 2012 10:38:29 -0700 (PDT)
In-Reply-To: <7vr4usnh2q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197607>

On 10 May 2012 18:20, Junio C Hamano <gitster@pobox.com> wrote:
> demerphq <demerphq@gmail.com> writes:
>
>> Similar logic for Try::Tiny. Why bother with it? It is pretty close =
to
>> a fancy way to write eval { ...; 1 } or do { .... }; =A0It is just o=
ne
>> more module for people to misunderstand, and then make bugs with.
>
> I personally like the approach to stick to bare "eval {}; if ($@) { .=
=2E. }"
> sequence, as it is much more explicit and easier to understand what i=
s
> happening underneath. =A0IOW, I like what I read in demerphq's messag=
e.

Basically that is the idiom that Try::Tiny encourages people not to
use. Unfortunately the idiom documented in the Perl docs has been
subtly wrong for pretty much ever due to a subtle bug in perl (which
took years to come to light). :-(

Anyway, anything written like this:

eval {
       whatever();
       1;
} or do {
    my $error=3D $@ || "Zombie Error";
    do_something_with_error($error);
};

is fine. See my other post to the list for details.

> But it could be that these many people who wrote these different
> catch/throw things did so for a reason that I am missing, and if that=
 is
> the case, I am interested to hear what benefit we will get from using
> them.
>
> "It looks more familiar to people with (your favorite language)" coul=
d be
> it, but then I would not regret missing such a reason ;-)

A few might justify things based on the bug in Perl, but I suspect the
real motivation people have to use it is to emulate other languages
constructs.

The author of Try::Tiny might be an exception, I am reasonably
convinced he was trying to provide a service to the community, but IMO
on the balance of things the module muddies the water more than it
improves things.

cheers,
Yves


--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
