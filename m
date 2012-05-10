From: Subho Banerjee <subs.zero@gmail.com>
Subject: Re: Git.pm
Date: Thu, 10 May 2012 21:48:28 +0530
Message-ID: <CAB3zAY0NAQaN-nNeJdJy80omrXqUZ-vCWsFhbx_iHF5RPBYUQQ@mail.gmail.com>
References: <CAB3zAY3-Bn86bCr7Rxqi4vxbYFxUesLwm8gddxyMSexov2tOhw@mail.gmail.com>
 <CAFouetgwRpB1GFJOC8PTVryVY-94S3xa5ZiSaWQWoz070qQ-6g@mail.gmail.com>
 <CAB3zAY0NeXuH-wXyYkbim5U74eANY4hq5D6SsVLu3KeUqHFqzQ@mail.gmail.com>
 <20120426203136.GA15432@burratino> <CAB3zAY3VHtUobJfJ7=nSKb_6uJOXLGVHzR18qV6txPkzf54cDw@mail.gmail.com>
 <CANgJU+W-FJZRtu_4si7nr96KfNe2rzaiUaDC0GiK_WixudvcxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Tim Henigan <tim.henigan@gmail.com>, git <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 18:18:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSW4t-0001dU-Df
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 18:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754449Ab2EJQSv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 May 2012 12:18:51 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:50452 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023Ab2EJQSt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 May 2012 12:18:49 -0400
Received: by vbbff1 with SMTP id ff1so1695344vbb.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 09:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=E1sMQc4y2bDg7UPKyP6cO/yJJCXJ1AHQC775JAnk/AU=;
        b=WPn8pev9iOIeRgR9IQy6VhwRBViLxvxLXQkvFXvAUAI0t1KxNZW8KfX0nv/XziQXVh
         IyIup070gTawsC8dp8E6vRskcMNVQMNEyQF2BGSzdw4Q/XQ91u/QoogmlqtM40ymsEWt
         C6u1OYxDhXA0wBCqJitChgymX8xBG4VVooD50utu26IHWfo7I8XzjFO1olQ/1yk31p5H
         mO7FLqQ4P7+qhEBhwsuVKp6ljC1WW+9UYkzgmmX/p22xvyCH4n72l+b43yLBPQV1ucqa
         SxQdsZ/jcXHisjuyeG8HNcpTTTIESOUissocbMxS5K/6QgEw1lXukZjIae9qZAJNe4qV
         q1NA==
Received: by 10.52.96.35 with SMTP id dp3mr2332230vdb.97.1336666729034; Thu,
 10 May 2012 09:18:49 -0700 (PDT)
Received: by 10.220.189.137 with HTTP; Thu, 10 May 2012 09:18:28 -0700 (PDT)
In-Reply-To: <CANgJU+W-FJZRtu_4si7nr96KfNe2rzaiUaDC0GiK_WixudvcxA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197590>

Hello Yves,
I am aware of that. But you see the problem is that using eval/warn/do
is that the $@ has to be localized every time eval is called. From my
understanding of how the Try::Tiny package works, this is exactly what
happens. So we are just calling a simple eval statement but in a block
where the $@ is handled properly, which is eventually what we would
have to do if we wrote it ourselves(Though I am not sure about how DBI
does it, I will have a look into that). And that is why I arrived in
favor of the Try::Tiny module in the first place. Well, that and the
ability to throw exception objects if required.

Cheers,
Subho.

On Thu, May 10, 2012 at 9:24 PM, demerphq <demerphq@gmail.com> wrote:
> On 10 May 2012 15:19, Subho Banerjee <subs.zero@gmail.com> wrote:
>> Hello,
>> I have started looking into how the error catching mechanism
>> implemented right now. I have looked into the more modern error
>> catching/throwing mechanisms in use in perl, and I am of the opinion
>> that Try::Simple would probably be the best candidate for being the
>> new error catching mechanism. I also wanted to discuss some aspects =
of
>> the changes to be made -
>> ------- Replacing the Error::Simple stuff should be relatively
>> straightforward. It can be achieved with simple changes to the synta=
x
>> of the perl module itself.
>>
>> ------- What I feel will be more complicated, and will require some
>> discussion before it is implemented is the Git::Error module. This h=
as
>> modified some of the code in the original Error module and is used
>> only when there are calls made to the git system command. Using the
>> Try::Tiny will mean that this can be simplfied to a very large exten=
t.
>> As a mater of fact I am in favor of getting rid of this completely a=
nd
>> implementing whatever is required in the Git.pm as required. Because
>> the Try::Tiny module no longer requires exception objects to be
>> thrown. Its just simply passing strings around.
>>
>> This I believe is a big decision, and I would like to hear what you
>> guys have to say before I actually get along changing and playing
>> around with stuff inside the code.
>
> Personally I would prefer it just does error handling like any other
> standard Perl code does: either return false, or dies with a useful
> error message. One of the things I find annoying about Git.pm is it
> forces its authors non-standard preferences for exception handling
> onto its users.
>
> Any other approach forces people to use the exception framework you
> have chosen. Which is just a pain in the ass.
>
> Similar logic for Try::Tiny. Why bother with it? It is pretty close t=
o
> a fancy way to write eval { ...; 1 } or do { .... }; =A0It is just on=
e
> more module for people to misunderstand, and then make bugs with.
>
> Why require people coding on your module to learn a new way to eval c=
ode?
>
> Yes I know in some circles these are probably controversial points,
> but in all the core, heavily used Perl code I know of none of it uses
> either exception objects nor Try::Tiny. I think there is a reason why=
=2E
>
> So think carefully. Look at DBI.pm for guidance. That module is
> probably the single most stable, well maintained and widely used
> module in Perl. And it does none of the tricks you discuss here.
>
> Yves
>
>
>
>
> --
> perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
