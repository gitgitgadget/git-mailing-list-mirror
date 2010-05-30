From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 6/7] Add SVN revision parser and exporter
Date: Sun, 30 May 2010 17:58:56 +0200
Message-ID: <AANLkTimPkAWa8YEro50gWgeaPSmgPCRXppHZNZuCb_hj@mail.gmail.com>
References: <1274650832-7411-1-git-send-email-artagnon@gmail.com> 
	<1274650832-7411-7-git-send-email-artagnon@gmail.com> <20100529140645.GA8338@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 30 17:59:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIkvL-0003cV-M3
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 17:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438Ab0E3P7R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 May 2010 11:59:17 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44655 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308Ab0E3P7R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 May 2010 11:59:17 -0400
Received: by vws11 with SMTP id 11so1165207vws.19
        for <git@vger.kernel.org>; Sun, 30 May 2010 08:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=3EEnHZ3VGF+bc4NlVQf8y+atJSf4nhhThAeQVxBgw/E=;
        b=QfK6GavJXcQmDJk7rI8vuieZrtsbmtlAA2/04280hWknSCEQCBTy4oEudkXXV+9VM8
         cPLe8ViiAV+RQvsLAgIwHeREFnc3+19RmZdY7wYl7LAHOTfv4g0m3hrdy7XxyzuCI24s
         AzsASzjVJHTyPDlsGVRKJJQoDz0+IOMXtUEt8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=IOguMgBP3/KgwsdsG2noZUV3PSkxfcLlU2k7ptO+f0Ty/q4XrEx/ckcNWluYh5I7be
         ZktQnaRSG2QG8yGMcxfion2QEB68ml8/Eas6MSBmIPGkfM+fcduUs2+ryTi9gnm8usBj
         6c7Ihzdlmlo3oGE+7cWbhXhrlH5nW+ZRCupHU=
Received: by 10.229.182.9 with SMTP id ca9mr469697qcb.118.1275235156069; Sun, 
	30 May 2010 08:59:16 -0700 (PDT)
Received: by 10.229.50.3 with HTTP; Sun, 30 May 2010 08:58:56 -0700 (PDT)
In-Reply-To: <20100529140645.GA8338@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148008>

Hi Jonathan,

Jonathan Nieder wrote:
> Wait, where are SVN revisions being parsed? =C2=A0It seems that the r=
epo
> module maintains the exporter's state and provides a facility to
> to call the fast_export module to write it out.

Right. Sorry about the bad commit message.

> =C2=A0repo_add(path, mode, blob_mark) is used to add a new file to
> =C2=A0the current commit.
>
> =C2=A0repo_modify is used to add a replacement for an existing file;
> =C2=A0it is implemented exactly the same way, but a check could be
> =C2=A0added later to distinguish the two cases.
>
> =C2=A0repo_copy copies a blob from a previous revision to the current
> =C2=A0commit.
>
> =C2=A0repo_replace modifies the content of a file from the current
> =C2=A0commit, if and only if it already exists.
>
> =C2=A0repo_delete removes a file or directory from the current commit=
=2E
>
> =C2=A0repo_commit calls out to fast_export to write the current commi=
t
> =C2=A0to the fast-import stream in stdout.
>
> =C2=A0repo_diff is used by the fast_export module to write the change=
s
> =C2=A0for a commit.
>
> =C2=A0repo_reset erases the exporter's state, so valgrind can be happ=
y.

Thanks for the nice descriptions. Will be useful while preparing
Documentation/technical.

> Mode must be 100644, 100755, 120000, or 160000.

Okay, do we put in an assert() for sanity?

> Style: we don=E2=80=99t tend to use typedef to hide underlying struct=
 definitions
> (see Documentation/CodingStyle from linux-2.6.git, chapter 5, for som=
e
> explanation about why).

=46ixed.

> Maybe some local variables would make this more readable:

=46ixed.

> Is this for adding new entries to an existing directory? =C2=A0It is
> getting late, so I did not look it over carefully.

=46or David.

> If a file "foo" exists and I ask for "foo/bar", this will return
> the entry for foo. =C2=A0Is that appropriate?

=46or David.

> When would it be NULL? =C2=A0Is an empty path allowed?

=46or David.

> Can this overflow the path stack?

Actually, this has already been changed- see the latest commits to see
how path is allocated.

> Might be easier to read the other way around:

=46ixed.

> I did not carefully trace the cases where repo_clone_dir may reuse a
> dir. =C2=A0I would be happier if someone else does.

=46or David.

-- Ram
