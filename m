From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH 8/9 v13] difftool: teach difftool to handle directory diffs
Date: Wed, 18 Apr 2012 09:13:02 -0400
Message-ID: <CAFouetjbHewYzQXZr33xGKgwk0k7D8R0XfoP7k2qAV6Nq_d+Ow@mail.gmail.com>
References: <1334335002-30806-1-git-send-email-tim.henigan@gmail.com>
	<CAJDDKr7Uw3Nwg4p7F2zaY8f82j3_tRf3WiiO+YSN+nA6a9wY6w@mail.gmail.com>
	<CAJDDKr78T1HNFXPPnvMUxBoJhAHP8XGdk9ZbpQCS1sZEQJfR8w@mail.gmail.com>
	<CAFoueth37aeHMorh-r2w_mwSp+uSgeF+PYbUfHNPy9-HVvL01w@mail.gmail.com>
	<CAJDDKr6djdBvUbV6qZZu75iR2UbFHt8_D0+V+K_C+-Dgx8BfVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, ramsay@ramsay1.demon.co.uk
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 15:13:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKUh3-0007qK-ST
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 15:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752992Ab2DRNNE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Apr 2012 09:13:04 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62322 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459Ab2DRNNC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Apr 2012 09:13:02 -0400
Received: by iagz16 with SMTP id z16so10419822iag.19
        for <git@vger.kernel.org>; Wed, 18 Apr 2012 06:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=NXzHZW/d43RSsgAWqfjhtR1frYhY4ysKIAmz0TMw2rY=;
        b=n1dICamqVr5hTBmEMKsHpzjxEroOyUn4NochlIEINsajLNdWwXWbjCeesSj4JJiTKe
         HFVtWJbwNKODWAwDILbsv4FERp3/O518ucSdD0ojS/STkIqjnV+AcZkNIL2FXTf4Gaem
         uq6Ol9BQiFfSqOTgB1M4xEugvPpBBQDmgC4MxpwVei7eWTk/63am2kAIti4f6Hm0OksE
         SH4WAiVINRRVHdyqmn7l/HsPDfVrB9IhNsoowx7zKtTJkQkETDiYY0cxi74+74nOJJfl
         aQHQVcdMFUczhvUj8jlinYa2VasDeVA/h/hV4E0Hu3cvTe9qweEMzke7rRO3UYaAfO7b
         ynKw==
Received: by 10.42.66.84 with SMTP id o20mr1472875ici.25.1334754782159; Wed,
 18 Apr 2012 06:13:02 -0700 (PDT)
Received: by 10.42.225.193 with HTTP; Wed, 18 Apr 2012 06:13:02 -0700 (PDT)
In-Reply-To: <CAJDDKr6djdBvUbV6qZZu75iR2UbFHt8_D0+V+K_C+-Dgx8BfVA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195865>

On Tue, Apr 17, 2012 at 11:23 PM, David Aguilar <davvid@gmail.com> wrot=
e:
> On Tue, Apr 17, 2012 at 6:25 AM, Tim Henigan <tim.henigan@gmail.com> =
wrote:
>> On Sun, Apr 15, 2012 at 9:01 PM, David Aguilar <davvid@gmail.com> wr=
ote:
>>> On Sun, Apr 15, 2012 at 3:20 PM, David Aguilar <davvid@gmail.com> w=
rote:
>>>> On Fri, Apr 13, 2012 at 9:36 AM, Tim Henigan <tim.henigan@gmail.co=
m> wrote:
>
> I think I narrowed it down. =C2=A0I have this in my ~/.gitconfig
> --
> [diff]
> =C2=A0 =C2=A0renames =3D copy
> --
> That means we should be able to reproduce this by doing:
>
> =C2=A0 =C2=A0$ git difftool --dir-diff -M -C baf5aaa33383af656a34b7ba=
9039e9eb3c9e678c
>
> That ends up calling `git diff --raw -M -C
> baf5aaa33383af656a34b7ba9039e9eb3c9e678c`, whose output contains:
>
> ...[snip]...
> :000000 100755 0000000... 05824fa... A =C2=A0t/lib-gpg.sh
> :100644 100644 83855fa... 83855fa... R100 =C2=A0 =C2=A0 =C2=A0 t/t700=
4/pubring.gpg
> =C2=A0t/lib-gpg/pubring.gpg
> :100644 100644 8fed133... 8fed133... R100 =C2=A0 =C2=A0 =C2=A0 t/t700=
4/random_seed
> =C2=A0t/lib-gpg/random_seed
> :100644 100644 d831cd9... d831cd9... R100 =C2=A0 =C2=A0 =C2=A0 t/t700=
4/secring.gpg
> =C2=A0t/lib-gpg/secring.gpg
> :100644 100644 abace96... abace96... R100 =C2=A0 =C2=A0 =C2=A0 t/t700=
4/trustdb.gpg
> =C2=A0t/lib-gpg/trustdb.gpg
> :100644 100644 3f24384... f7dc078... M =C2=A0t/lib-httpd.sh
> ...[snip]...
>
> I suspect the R100 lines are the ones that are throwing it off.

It is indeed the lines that show the renames/copies that cause the
error.  Adding the '-C' or '-M' option to 'git diff --raw' changes the
diff output for copied/modified files from:

    :<mode> <mode> <SHA1> <SHA1> <status> <file>
to
    :<mode> <mode> <SHA1> <SHA1> <status> <file before> <file after>

The difftool code assumes that the diff output will be of the first
form and fails when given the second form.

So now we must decide how to handle deal with this use case.  It seems
there are two options:

1) Append '--no-renames' to the end of the 'git diff --raw' argument
list.  This will override any '-C' or '-M' settings.  This is a simple
solution, but it loses some information about copies and renames.

2) Add new logic to parse copies and renames.  Your earlier email
advocated this approach, but I am concerned that the implementation
will include some tough choices.

So, I would like to simply amend the current patch to include solution
1.  Solution 2 can be considered in the future.

Does this sound reasonable?
