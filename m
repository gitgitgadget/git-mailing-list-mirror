From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 8/9 v13] difftool: teach difftool to handle directory diffs
Date: Tue, 17 Apr 2012 20:23:33 -0700
Message-ID: <CAJDDKr6djdBvUbV6qZZu75iR2UbFHt8_D0+V+K_C+-Dgx8BfVA@mail.gmail.com>
References: <1334335002-30806-1-git-send-email-tim.henigan@gmail.com>
	<CAJDDKr7Uw3Nwg4p7F2zaY8f82j3_tRf3WiiO+YSN+nA6a9wY6w@mail.gmail.com>
	<CAJDDKr78T1HNFXPPnvMUxBoJhAHP8XGdk9ZbpQCS1sZEQJfR8w@mail.gmail.com>
	<CAFoueth37aeHMorh-r2w_mwSp+uSgeF+PYbUfHNPy9-HVvL01w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, ramsay@ramsay1.demon.co.uk
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 05:23:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKLUa-0006Lg-EB
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 05:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795Ab2DRDXf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Apr 2012 23:23:35 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49798 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510Ab2DRDXe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2012 23:23:34 -0400
Received: by gghe5 with SMTP id e5so3477631ggh.19
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 20:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=mqjMu7Ll3YeQBKKZqWU4RCqHwn1htmOiDnhigYwU0oo=;
        b=NPI6cbFcJMsFkQNBa4PHFKkKy3T9ehpsUWs6VwRwxsXFaGbf5iqLvlGOIhJuMONUxk
         ucbfqF8DkHbxjWX+Ix3kJMpXADVTgVGsPOU5uuT1ISefGflv+gn/ErOCp/qNC4LCyi57
         mfc9QkeDKxvuKTbTD8AiERpSPsthEoNC1z1bBGf8ZiODC28A3F1ZxhHQitHeuCiHkgvQ
         DHZzRQ9+V1fTH0Wmw9Fcm3JXb9aeWjZ4gom4BllR56LvI6cEbePHvMgkhvQxNMvQBG9V
         CZz57chsP4Y2iTPy3Kfk/LOIL9C1OgxJAr/e8B9GSr9ifD7G3DkL1Ir7qDUkeZJTxfnz
         7k+Q==
Received: by 10.236.155.226 with SMTP id j62mr598646yhk.30.1334719413871; Tue,
 17 Apr 2012 20:23:33 -0700 (PDT)
Received: by 10.147.128.8 with HTTP; Tue, 17 Apr 2012 20:23:33 -0700 (PDT)
In-Reply-To: <CAFoueth37aeHMorh-r2w_mwSp+uSgeF+PYbUfHNPy9-HVvL01w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195837>

On Tue, Apr 17, 2012 at 6:25 AM, Tim Henigan <tim.henigan@gmail.com> wr=
ote:
> On Sun, Apr 15, 2012 at 9:01 PM, David Aguilar <davvid@gmail.com> wro=
te:
>> On Sun, Apr 15, 2012 at 3:20 PM, David Aguilar <davvid@gmail.com> wr=
ote:
>>> On Fri, Apr 13, 2012 at 9:36 AM, Tim Henigan <tim.henigan@gmail.com=
> wrote:
>>>
>>> I started testing this patch. =C2=A0I started on the commit before =
what's
>>> in pu and then applied this patch:
>>>
>>> $ git checkout e9653615fafcbac6109da99fac4fa66b0b432048
>>> $ git am difftool.patch
>>>
>>> The basics work and I know folks will be really happy when this
>>> feature lands. =C2=A0Folks have personally asked me for this featur=
e in the
>>> past. =C2=A0I dig it. =C2=A0I'd also like to help pursue using syml=
inks sometime
>>> in the future if that sounds like a reasonable thing to you, but th=
e
>>> stabilizing the existing implementation is more important right now=
=2E
>
> I appreciate everyone's patience as this feature continues to develop=
=2E
> =C2=A0It has not gone as smoothly as I hoped ;)
>
>
>>> I ran into some issues when trying it against a few random commits.=
 =C2=A0I
>>> went pretty far back in git's history to see what would happen.
>>>
>>> $ git difftool --dir-diff e5b06629de847663aaf0f7daae8de81338da3901 =
| tail
>>> Use of uninitialized value $rmode in string eq at
>>> /home/david/src/git/git-difftool line 96.
>
> I ran the same test using both my local branch [1] and the tip of
> Junio's th/difftool-diffall branch [2]. =C2=A0 In both cases, I see t=
he
> "RelNotes: no such file" error (more on that below), but I do not see
> uninitialized value errors.
>
> The section of code that reads the mode, SHA1 and path info from the
> diff output looks like this:
>
> =C2=A0 =C2=A0my @rawdiff =3D split('\0', $diffrtn);
>
> =C2=A0 =C2=A0for (my $i=3D0; $i<$#rawdiff; $i+=3D2) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0my ($lmode, $rmode, $lsha1, $rsha1, $statu=
s) =3D split(' ',
> substr($rawdiff[$i], 1));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0...
>
> If the "$lmode, ..." variables are not defined, then the output of
> 'git diff --raw' is malformed in some way (perhaps some error?). =C2=A0=
At
> the very end of your output, I saw this as well:
>
>>> fatal: malformed index info /t9800-git-p4-basic.sh =C2=A0 =C2=A0 =C2=
=A0:100755 100755
>>> a25f18d36a196a4b85f6cac15a6a081744fe8fa1
>>> d41470541650590355bf0de1a1b556b3502492b5 M
>>> update-index -z --index-info: command returned error: 128
>
> Would it be possible for you to try either Junio's or my branch to
> insure something did not go wrong with your locally applied patch?
> Also, which platform are you testing on?

Linux.  I also test on OS X occasionally, but it's not my primary platf=
orm.

I think I narrowed it down.  I have this in my ~/.gitconfig
--
[diff]
    renames =3D copy
--
That means we should be able to reproduce this by doing:

    $ git difftool --dir-diff -M -C baf5aaa33383af656a34b7ba9039e9eb3c9=
e678c

That ends up calling `git diff --raw -M -C
baf5aaa33383af656a34b7ba9039e9eb3c9e678c`, whose output contains:

=2E..[snip]...
:000000 100755 0000000... 05824fa... A  t/lib-gpg.sh
:100644 100644 83855fa... 83855fa... R100       t/t7004/pubring.gpg
 t/lib-gpg/pubring.gpg
:100644 100644 8fed133... 8fed133... R100       t/t7004/random_seed
 t/lib-gpg/random_seed
:100644 100644 d831cd9... d831cd9... R100       t/t7004/secring.gpg
 t/lib-gpg/secring.gpg
:100644 100644 abace96... abace96... R100       t/t7004/trustdb.gpg
 t/lib-gpg/trustdb.gpg
:100644 100644 3f24384... f7dc078... M  t/lib-httpd.sh
=2E..[snip]...

I suspect the R100 lines are the ones that are throwing it off.


>> xxdiff still gives an error message about "$tmp/left/RelNotes: No su=
ch
>> file or directory" with --no-renames so we may want to touch some
>> dummy files to make the tools happy.
>
> I get the same error. =C2=A0I looked into it and found that "RelNotes=
" is a
> symbolic link. =C2=A0If we look at the standard diff of the example y=
ou
> gave, we see the following:
>
> =C2=A0 =C2=A0$ git diff e5b0662 -- RelNotes
> =C2=A0 =C2=A0diff --git a/RelNotes b/RelNotes
> =C2=A0 =C2=A0index 7d92769..2c2a169 120000
> =C2=A0 =C2=A0--- a/RelNotes
> =C2=A0 =C2=A0+++ b/RelNotes
> =C2=A0 =C2=A0@@ -1 +1 @@
> =C2=A0 =C2=A0-Documentation/RelNotes/1.7.8.txt
> =C2=A0 =C2=A0\ No newline at end of file
> =C2=A0 =C2=A0+Documentation/RelNotes/1.7.10.txt
> =C2=A0 =C2=A0\ No newline at end of file
>
> When 'git-difftool' executes this command, it sees that the "RelNotes=
"
> file changed, but it is not smart enough to copy the link target. =C2=
=A0So
> the "/tmp/git.diffall.XXXXX/left" directory has "RelNotes" in it, but
> not the target of the link "Documentation/RelNotes/1.7.8.txt".
>
> In xxdiff, this manifests as a "file not found" error. =C2=A0In meld,=
 it is
> shown as a "Dangling symlink".
>
> I will look into ways to deal with this, probably adding special logi=
c
> to deal with file modes of "120000".

Sounds reasonable.

Thanks Tim,
--=20
David
