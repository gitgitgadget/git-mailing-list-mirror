From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH 2/2] git-p4: Add copy detection support
Date: Mon, 7 Feb 2011 11:11:24 +0000
Message-ID: <AANLkTikO4=froHvYN-JCOMZF7zgGHaD4J=nbN1ij_RjW@mail.gmail.com>
References: <1296429563-18390-1-git-send-email-vitor.hda@gmail.com>
 <1296429563-18390-2-git-send-email-vitor.hda@gmail.com> <20110206002547.GB31245@arf.padd.com>
 <AANLkTi=Awi6d77QcbbZ2rDTv6LpP+qjsReJ5=4NyhUBz@mail.gmail.com> <20110206220546.GA9024@mew.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 12:12:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmP0j-0003sg-Ts
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 12:12:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514Ab1BGLL4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Feb 2011 06:11:56 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:37489 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127Ab1BGLLz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Feb 2011 06:11:55 -0500
Received: by vxb37 with SMTP id 37so1501879vxb.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 03:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=Hzt8TdxHD0M6nyjjT8nh9aJJUYHCXh1GaOPsHdhAYWo=;
        b=NTeIwOX0l969gtsYks+yXb72o2L1lKCP/yMnH2iH81/sBccr6UxfKnyyd3sfQUQLI7
         GySRB5OlmEfEoG9vlQAFkIbZJujJPusK9celRsghi2F+uIZk9PAyL0A/4h9LLWaZZUHh
         EcNJqQGifdztNA3Ic/ZoxEpxOGpZo3RLR2FYE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=HACsTbQi+hp91qHTTV3MKUC+9yTT71461l9xS2RyDmhBc4fL5uZSXeyLdn6hTf9Mzd
         xhQE2+y7VDkh3AJMzbBX8NoXekDg3NKiCpICfb62xD/BPjN3OwVbAtU5IUFPWpDPCnbN
         Mcuo9vdA3t5R4nHTXaLEiBYJB4N61jX5x39TU=
Received: by 10.220.195.138 with SMTP id ec10mr2951164vcb.40.1297077114837;
 Mon, 07 Feb 2011 03:11:54 -0800 (PST)
Received: by 10.220.184.75 with HTTP; Mon, 7 Feb 2011 03:11:24 -0800 (PST)
In-Reply-To: <20110206220546.GA9024@mew.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166252>

Hi Pete,

On Sun, Feb 6, 2011 at 10:05 PM, Pete Wyckoff <pw@padd.com> wrote:
>> (Copying help text:
>> =A0 =A0 =A0 The -t flag makes the source file's filetype propagate t=
o the target
>> =A0 =A0 =A0 file. =A0Normally, the target file retains its previous =
filetype.
>> =A0 =A0 =A0 Newly branched files always use the source file's filety=
pe. =A0The
>> =A0 =A0 =A0 filetype can still be changed before 'p4 submit' with 'p=
4 reopen'.
>> )
>>
>> Since in git we're only considering newly branched files, I think in
>> this case "-t" will not add anything. In fact, what is being done he=
re
>> is detecting exec bit changes from source to target files - we're no=
t
>> trying to force P4 to use the source's exec bit. Do you agree?
>
> That sounds fine to me. =A0The code seemed to indicate that
> sometimes the destination file exists.

I've basically copied the code from the rename detection part and
adapted it to copying. Nevertheless, even if git detects a copy to a
already existing file I think that the integrate command should behave
correctly. I should create a test case for this, though.

>> + =A0 =A0 =A0 =A0 =A0 =A0elif modifier =3D=3D "C":
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0src, dest =3D diff['src'], diff['ds=
t']
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p4_system("integrate -Dt \"%s\" \"%=
s\"" % (src, dest))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if diff['src_sha1'] !=3D diff['dst_=
sha1']:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p4_system("edit \"%s\"" % (=
dest))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if isModeExecChanged(diff['src_mode=
'], diff['dst_mode']):
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0filesToChangeExecBit[dest] =
=3D diff['dst_mode']
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0os.unlink(dest)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0editedFiles.add(dest)
>
> If you're happy the dest never exists, you may be able to get rid
> of the edit step and the mode-change check entirely. =A0As long as
> you've tested this, you're the expert here. =A0The change makes
> sense overall.

I'm not that happy with this... and I'm no expert! I will really need
to test this possibility. Just need to understand how I can make git
detect a copy to an existing file... :)

Thanks for your feedback,
--=20
Vitor Antunes
