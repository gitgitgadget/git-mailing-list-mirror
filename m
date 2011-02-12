From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH 2/2] git-p4: Add copy detection support
Date: Sat, 12 Feb 2011 00:29:34 +0000
Message-ID: <AANLkTinF=9ELNMV0TmBzjEPa=7BZF+dnAK7VUrUw4QNK@mail.gmail.com>
References: <1296429563-18390-1-git-send-email-vitor.hda@gmail.com>
 <1296429563-18390-2-git-send-email-vitor.hda@gmail.com> <20110206002547.GB31245@arf.padd.com>
 <AANLkTi=Awi6d77QcbbZ2rDTv6LpP+qjsReJ5=4NyhUBz@mail.gmail.com>
 <20110206220546.GA9024@mew.padd.com> <AANLkTikO4=froHvYN-JCOMZF7zgGHaD4J=nbN1ij_RjW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sat Feb 12 01:30:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Po3NY-0005pd-2Z
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 01:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719Ab1BLAaH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Feb 2011 19:30:07 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38575 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298Ab1BLAaG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Feb 2011 19:30:06 -0500
Received: by vws16 with SMTP id 16so2049913vws.19
        for <git@vger.kernel.org>; Fri, 11 Feb 2011 16:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=UNqRcXos75yLXvGF8ryzMXcxfzd3o6lPhUcQ6NlI+xc=;
        b=FYncknTRZmeq/RqypuK2SEptPXVWJ6wEhDwUYJJ1i8lywXGVPbnV65uk+x6SuGxgmL
         nOoGbC/TKwwwX77IbSgpDuArE8ihXGwwpEM9dRAjnnf0esN6YjLp27Mq+1N2iAIjDrE/
         4IWowvkyj+J6j8ooDJq9kkf7hW/lWWFoJ19Mc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=dfUhcPSJCp2WpZP32F9e4OZp1XB426DUKMLjERjP8LsxQsAqtz4OO9aFd3rC0rVriY
         lzHHBkqBdY62Zj9Z5TEZmddfZvxpo+5aRoQIGzNjp0iywpJq/gQ8guaE4Dgwrp43KZdy
         mkYXtb6w7Bj3LiiLmeGsHDIM86CJepJD17w9o=
Received: by 10.220.175.139 with SMTP id ba11mr1450705vcb.145.1297470605037;
 Fri, 11 Feb 2011 16:30:05 -0800 (PST)
Received: by 10.220.184.75 with HTTP; Fri, 11 Feb 2011 16:29:34 -0800 (PST)
In-Reply-To: <AANLkTikO4=froHvYN-JCOMZF7zgGHaD4J=nbN1ij_RjW@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166580>

Hi Pete,

On Mon, Feb 7, 2011 at 11:11 AM, Vitor Antunes <vitor.hda@gmail.com> wr=
ote:
> Hi Pete,
>
> On Sun, Feb 6, 2011 at 10:05 PM, Pete Wyckoff <pw@padd.com> wrote:
>>> (Copying help text:
>>> =A0 =A0 =A0 The -t flag makes the source file's filetype propagate =
to the target
>>> =A0 =A0 =A0 file. =A0Normally, the target file retains its previous=
 filetype.
>>> =A0 =A0 =A0 Newly branched files always use the source file's filet=
ype. =A0The
>>> =A0 =A0 =A0 filetype can still be changed before 'p4 submit' with '=
p4 reopen'.
>>> )
>>>
>>> Since in git we're only considering newly branched files, I think i=
n
>>> this case "-t" will not add anything. In fact, what is being done h=
ere
>>> is detecting exec bit changes from source to target files - we're n=
ot
>>> trying to force P4 to use the source's exec bit. Do you agree?
>>
>> That sounds fine to me. =A0The code seemed to indicate that
>> sometimes the destination file exists.
>
> I've basically copied the code from the rename detection part and
> adapted it to copying. Nevertheless, even if git detects a copy to a
> already existing file I think that the integrate command should behav=
e
> correctly. I should create a test case for this, though.
>
>>> + =A0 =A0 =A0 =A0 =A0 =A0elif modifier =3D=3D "C":
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0src, dest =3D diff['src'], diff['d=
st']
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p4_system("integrate -Dt \"%s\" \"=
%s\"" % (src, dest))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if diff['src_sha1'] !=3D diff['dst=
_sha1']:
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p4_system("edit \"%s\"" % =
(dest))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if isModeExecChanged(diff['src_mod=
e'], diff['dst_mode']):
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0filesToChangeExecBit[dest]=
 =3D diff['dst_mode']
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0os.unlink(dest)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0editedFiles.add(dest)
>>
>> If you're happy the dest never exists, you may be able to get rid
>> of the edit step and the mode-change check entirely. =A0As long as
>> you've tested this, you're the expert here. =A0The change makes
>> sense overall.
>
> I'm not that happy with this... and I'm no expert! I will really need
> to test this possibility. Just need to understand how I can make git
> detect a copy to an existing file... :)

I've tried to trick git into detecting a copy over an existing file by
replacing a file with the contents of another file. But git is not
detecting this as a copy. How can I make git detect a copy over an
existing file?

After re-reading your answer I got the feeling that this SHA diff code
may have been misinterpreted. So, just in case it was, here is the
full history.
Originally the code always opened the files for editing just in case
there was a patch to be applied late,r. This makes sense, because git
can detect a rename (or copy) even if the files differ. But doing this
would create an "unclean" integration in the revision graph. So, what
I thought was "if we have available the SHA of the origin and
destination files in diff-tree output why not compare them before
opening the file for editing?" And that was the only purpose for this
comparison.

--=20
Vitor Antunes
