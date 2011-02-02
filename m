From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 1/3] vcs-svn: Introduce svnload, a dumpfile producer
Date: Wed, 2 Feb 2011 13:43:06 +0100
Message-ID: <AANLkTi=sQtaWc0C5tqjgmAqCoLupKg0fPhEd+-Y5kx=x@mail.gmail.com>
References: <1296570403-9082-1-git-send-email-artagnon@gmail.com>
 <1296570403-9082-2-git-send-email-artagnon@gmail.com> <AANLkTikUUojgj_H0r0L=XBi7H714xUvAS=vPsgMRNNjr@mail.gmail.com>
 <20110202025320.GB11339@kytes>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 02 13:43:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pkc3Z-0002yj-5p
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 13:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909Ab1BBMn2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Feb 2011 07:43:28 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64962 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113Ab1BBMn1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Feb 2011 07:43:27 -0500
Received: by fxm20 with SMTP id 20so7978263fxm.19
        for <git@vger.kernel.org>; Wed, 02 Feb 2011 04:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=AonY5OqV1nXaRqVR1f2TBkn5b8tVC+Lz6l1tusLhlI8=;
        b=WeCtJ0FLhYLTnZ1Q6750WwJNkMbmEtgfc3v7bsIqJrDg7btHtpYMMfmWiIJfpUoQyE
         7JD61kWEJpA3aTSEARK7ONp9wOG0wPwa1Eu99GKydKQTBRmVMbqdaxNZ9ttnsO7XLuxC
         cVHCbFTKyNblNblCW9+Qypi91fVbuM7HqCMns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=dAlmosXbZ0d2S3p0U5LEQEfAt4RqujYsBBoCC73+A8wwBkUIuFmv0Lg0XhkwuROhLy
         yGYeKX1Y/w/uFJz/jW4bOYkRr+lPT5XxwmAv/3Zl3Rf7xPoTwOkHsh6CVifw8rG8bulI
         3I0Qx7CiXfQiPZ3eiPpURhlLK0ifzbhd0c/WM=
Received: by 10.223.73.198 with SMTP id r6mr108748faj.14.1296650606295; Wed,
 02 Feb 2011 04:43:26 -0800 (PST)
Received: by 10.223.116.210 with HTTP; Wed, 2 Feb 2011 04:43:06 -0800 (PST)
In-Reply-To: <20110202025320.GB11339@kytes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165906>

On Wed, Feb 2, 2011 at 3:53 AM, Ramkumar Ramachandra <artagnon@gmail.co=
m> wrote:
> Hi Erik,
>
> Erik Faye-Lund writes:
>> A very superficial review, because I don't have much time, and don't
>> know the surrounding code well. Sorry about that.
>
> Thanks. I have to often switch back and fourth between GNU-style (for
> Subversion) and Linux-style (for Git), so please bear with my silly
> style errors.
>

That's completely fair :)

>> On Tue, Feb 1, 2011 at 3:26 PM, Ramkumar Ramachandra <artagnon@gmail=
=2Ecom> wrote:
>> > + =A0 =A0 =A0 if (!val) die("Malformed author line");
>> > + =A0 =A0 =A0 if (!(tz_off =3D strrchr(val, ' '))) goto error;
>> > + =A0 =A0 =A0 *tz_off++ =3D '\0';
>> > + =A0 =A0 =A0 if (!(t =3D strrchr(val, ' '))) goto error;
>>
>> style: use
>> "if (x)
>> =A0 =A0 =A0 do_stuff();"
>> instead of
>> "if (x) do_stuff();"
>
> This was intentional -- I'm only using it when do_stuff() is 'goto
> error'. I thought it looked nicer that way.
>

This is still not the style we use in git:

$ git grep "if (" | grep goto | wc -l
      0
$ git grep -B1 "if (" | grep goto | wc -l
     33
