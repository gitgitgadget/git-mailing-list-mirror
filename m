From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v7 6/9] submodule: fix detection of invalid submodule URL
Date: Sun, 3 Jun 2012 19:51:00 +1000
Message-ID: <CAH3Anrp_aUR2O_iEwxHu4bRs83U58X6QsY6+SJ56NXKEC7LA5Q@mail.gmail.com>
References: <1338132851-23497-1-git-send-email-jon.seymour@gmail.com>
	<1338132851-23497-7-git-send-email-jon.seymour@gmail.com>
	<4FC3CB7E.6000501@kdbg.org>
	<CAH3Anrrg4Fc5GXB_VwOXRfwP=hx5Xn5bqimP56oDB0USn7c4Cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, gitster@pobox.com,
	phil.hord@gmail.com, ramsay@ramsay1.demon.co.uk
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Jun 03 11:51:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sb7Sl-0004bZ-F0
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 11:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757175Ab2FCJvD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Jun 2012 05:51:03 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:52007 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624Ab2FCJvB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jun 2012 05:51:01 -0400
Received: by wgbdr13 with SMTP id dr13so3166653wgb.1
        for <git@vger.kernel.org>; Sun, 03 Jun 2012 02:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=y/0939YDj3wW0Fjbfxho9VBvVFa7B4/XVRMdDU8tMQs=;
        b=zbo9KEFCHfosK/QV0Fwx9MBmnPpC20id8UXC+BfWfpe/SZI+kx6vIUoQQvayI2kOKn
         ihKt08rm3q/DYR1+M0QSsLGNNI8Ubk2Rv8ya2v2kIN5jL97Z4dVCra3yKXK/eup1ORMm
         lW+u6LJbCJgly1mlej2SfHP8R72s4tghwbvM4KXg7K7je+k2ZWqoQNO3dXIRAwsP8Nzg
         Jlo8X4prHnh8ngOJJ7m62dI8LobeslEh6x2lQeM/6UX1bw5lomYxxE7U5O7KbuI8hkJR
         sumdbw8UQxjXQfDN2TUu4QKRLYefsrV4KaEGB/gHJpQtc2WVgsi77FjYWtYJIyju/VTU
         b8AA==
Received: by 10.216.228.135 with SMTP id f7mr8106514weq.129.1338717060355;
 Sun, 03 Jun 2012 02:51:00 -0700 (PDT)
Received: by 10.180.146.166 with HTTP; Sun, 3 Jun 2012 02:51:00 -0700 (PDT)
In-Reply-To: <CAH3Anrrg4Fc5GXB_VwOXRfwP=hx5Xn5bqimP56oDB0USn7c4Cg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199079>

On Tue, May 29, 2012 at 7:39 AM, Jon Seymour <jon.seymour@gmail.com> wr=
ote:
> On Tue, May 29, 2012 at 5:01 AM, Johannes Sixt <j6t@kdbg.org> wrote:
>> Am 27.05.2012 17:34, schrieb Jon Seymour:
>>
>> Without understanding in detail what this series is about, I would g=
uess
>> that the previous two case arms are not very Windows friendly. Does =
the
>> right thing happen when $remoteurl is "c:/path/to/remote"? Would it =
help
>> to use is_absolute_path?
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if is_absolute_path "$remoteurl"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0then
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0variant=3D"${=
remoteurl#*/}"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case "$remote=
url" in
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...other case=
s go here...
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0esac
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
>>
>> -- Hannes
>
> Thanks, I will investigate this as an alternative.
>

I did investigate is_absolute_path for the v8 roll of this series, but
I found it wasn't suitable because it doesn't classify URLs of the
form user@host:repo as absolute. You can find the alternative I did
use in v8 3/4.

Regards,

jon.
