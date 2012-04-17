From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH 8/9 v13] difftool: teach difftool to handle directory diffs
Date: Tue, 17 Apr 2012 09:25:26 -0400
Message-ID: <CAFoueth37aeHMorh-r2w_mwSp+uSgeF+PYbUfHNPy9-HVvL01w@mail.gmail.com>
References: <1334335002-30806-1-git-send-email-tim.henigan@gmail.com>
	<CAJDDKr7Uw3Nwg4p7F2zaY8f82j3_tRf3WiiO+YSN+nA6a9wY6w@mail.gmail.com>
	<CAJDDKr78T1HNFXPPnvMUxBoJhAHP8XGdk9ZbpQCS1sZEQJfR8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, ramsay@ramsay1.demon.co.uk
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 15:25:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SK8PY-0003oL-Db
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 15:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280Ab2DQNZ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Apr 2012 09:25:28 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49699 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932175Ab2DQNZ1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2012 09:25:27 -0400
Received: by iagz16 with SMTP id z16so8939714iag.19
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 06:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=NE8iHvIJKE3uobnnxBhqi1BtQeQHnLmmNnSzhTYS/UE=;
        b=KA7NSdmNpC7b9Lj/b9RR5jNdgViOO3LytL56eXqXllvwGlAFtuE3v22gzyrKpSCRmk
         hv1LWcnLLn1anQXjQeB+jBMCoX/dew6CXrhwc0cDklRUqKn3KmNC1lJE8xH42C50CsLP
         MWhhTBOXMoWU9Dfg+NQLnKaFqasYojxQo1MoEzl+7q2pjF5/PS/SAW1E8rgS4DMdtcdu
         hy9eb+RkLIaVKRuSpAVdHiOOIDZ14P2ET7Vr1/ydaVsXcBSDwm4Kl0Yro3YuC3v5lF4a
         iyo6hclj+IxqEZIHwnT/BaDxcD+ivo2c4hItEhQjgYLVIca31YsbkeyH2d37GTB9O4hd
         L1lg==
Received: by 10.42.215.68 with SMTP id hd4mr10084656icb.30.1334669126892; Tue,
 17 Apr 2012 06:25:26 -0700 (PDT)
Received: by 10.42.225.193 with HTTP; Tue, 17 Apr 2012 06:25:26 -0700 (PDT)
In-Reply-To: <CAJDDKr78T1HNFXPPnvMUxBoJhAHP8XGdk9ZbpQCS1sZEQJfR8w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195757>

On Sun, Apr 15, 2012 at 9:01 PM, David Aguilar <davvid@gmail.com> wrote=
:
> On Sun, Apr 15, 2012 at 3:20 PM, David Aguilar <davvid@gmail.com> wro=
te:
>> On Fri, Apr 13, 2012 at 9:36 AM, Tim Henigan <tim.henigan@gmail.com>=
 wrote:
>>
>> I started testing this patch. =C2=A0I started on the commit before w=
hat's
>> in pu and then applied this patch:
>>
>> $ git checkout e9653615fafcbac6109da99fac4fa66b0b432048
>> $ git am difftool.patch
>>
>> The basics work and I know folks will be really happy when this
>> feature lands. =C2=A0Folks have personally asked me for this feature=
 in the
>> past. =C2=A0I dig it. =C2=A0I'd also like to help pursue using symli=
nks sometime
>> in the future if that sounds like a reasonable thing to you, but the
>> stabilizing the existing implementation is more important right now.

I appreciate everyone's patience as this feature continues to develop.
 It has not gone as smoothly as I hoped ;)


>> I ran into some issues when trying it against a few random commits. =
=C2=A0I
>> went pretty far back in git's history to see what would happen.
>>
>> $ git difftool --dir-diff e5b06629de847663aaf0f7daae8de81338da3901 |=
 tail
>> Use of uninitialized value $rmode in string eq at
>> /home/david/src/git/git-difftool line 96.

I ran the same test using both my local branch [1] and the tip of
Junio's th/difftool-diffall branch [2].   In both cases, I see the
"RelNotes: no such file" error (more on that below), but I do not see
uninitialized value errors.

The section of code that reads the mode, SHA1 and path info from the
diff output looks like this:

    my @rawdiff =3D split('\0', $diffrtn);

    for (my $i=3D0; $i<$#rawdiff; $i+=3D2) {
        my ($lmode, $rmode, $lsha1, $rsha1, $status) =3D split(' ',
substr($rawdiff[$i], 1));
        ...

If the "$lmode, ..." variables are not defined, then the output of
'git diff --raw' is malformed in some way (perhaps some error?).  At
the very end of your output, I saw this as well:

>> fatal: malformed index info /t9800-git-p4-basic.sh      :100755 1007=
55
>> a25f18d36a196a4b85f6cac15a6a081744fe8fa1
>> d41470541650590355bf0de1a1b556b3502492b5 M
>> update-index -z --index-info: command returned error: 128

Would it be possible for you to try either Junio's or my branch to
insure something did not go wrong with your locally applied patch?
Also, which platform are you testing on?


> I did some more investigating. =C2=A0I think this happens when the di=
ff
> contains detected renames.
>
> This command made it work:
>
> $ git difftool --dir-diff --no-renames e5b06629de847663aaf0f7daae8de8=
1338da3901
>
> So I think we might need to specify --no-renames when calling git dif=
f --raw.

One of my test repos includes added, removed and renamed files.  They
do not cause any errors.  Just like the output of 'git diff --raw', in
'git difftool --dir-diff' renamed files are shown as the old file name
being deleted and the new file name being added.

I also looked to see if 'git diff --raw' reports a different result
when '--no-renames' is used, but did not see any difference:

    $ git diff --raw e5b0662 > diff_with_renames.txt
    $ git diff --raw --no-renames e5b0662 > diff_without_renames.txt
    $ diff diff_with_renames.txt diff_without_renames.txt


> xxdiff still gives an error message about "$tmp/left/RelNotes: No suc=
h
> file or directory" with --no-renames so we may want to touch some
> dummy files to make the tools happy.

I get the same error.  I looked into it and found that "RelNotes" is a
symbolic link.  If we look at the standard diff of the example you
gave, we see the following:

    $ git diff e5b0662 -- RelNotes
    diff --git a/RelNotes b/RelNotes
    index 7d92769..2c2a169 120000
    --- a/RelNotes
    +++ b/RelNotes
    @@ -1 +1 @@
    -Documentation/RelNotes/1.7.8.txt
    \ No newline at end of file
    +Documentation/RelNotes/1.7.10.txt
    \ No newline at end of file

When 'git-difftool' executes this command, it sees that the "RelNotes"
file changed, but it is not smart enough to copy the link target.  So
the "/tmp/git.diffall.XXXXX/left" directory has "RelNotes" in it, but
not the target of the link "Documentation/RelNotes/1.7.8.txt".

In xxdiff, this manifests as a "file not found" error.  In meld, it is
shown as a "Dangling symlink".

I will look into ways to deal with this, probably adding special logic
to deal with file modes of "120000".

[1]: https://github.com/thenigan/git/tree/th/difftool-phase2
[2]: https://github.com/gitster/git/tree/th/difftool-diffall
