Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8025BC433ED
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 07:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50289610C8
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 07:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhDKHQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 03:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhDKHQz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 03:16:55 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B9DC061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 00:16:37 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e7so11246242edu.10
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 00:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=auA/FgtuRFPuoe6NObs9x6bV7O3qUAOMRFT6eRf/oac=;
        b=bOMtvilHUp4VDKDBmQuuw7yJ/XYedrB5b426F++E1rOEH5YrSK+cf+ejpPIvI6OkY1
         s5YhMhLupG114nrqPvQ6MbatdtcteymkqbAuaStjtgMiU9E4OEuAbk3vL0KlU09o4Wpb
         FidNt9p4+FZ8LuhfX5er8wTJU85NtF9YybEqJtwdUHaaMUWvCmQ838b+z4E6al/7xipX
         /DnbX0ygRgpTJM5Kw1m97Kzz0H4g17W+03HEI+5TL4pdw/8UN03iKj2MO2M/tRssWlPa
         8LVOOyiiDDKnj4QagYJ8zKTe6HhNngp9We0ZrsU2nqJ4EAaOz52SQkeib6ea26281QzB
         m/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=auA/FgtuRFPuoe6NObs9x6bV7O3qUAOMRFT6eRf/oac=;
        b=gXHjjZYCsO7Rc45b7JB7bVdV+BTytzXOXpMF1eUmDeDv4T8eh9dhmHor1BOcJ2yQuE
         wOCmkOfxuANX25BrDQ+q9nTnBxlKoI8GYmIKioZh70VjKXtzHAJu0GXplQtDtq6fkthZ
         DfM+7t9VsiaQOl7VSvvHjJAinVTTL8WSv4ghqzYg0uvDuvNGXYQ6JlaaOvUuGZ9GBwPP
         B5Rf2CfPj2y5USSHO4bIfgCAHtscLSS/SEQ82E1SUkMWnIcKvpFphmKvUVdWJXHKJPxk
         9clQv771icS3Wmz10+6rBvHXpbyX82JyvnulyfINRbFysZI9jXpD9FrWB748VLzsiuSZ
         bu6Q==
X-Gm-Message-State: AOAM531UGZeld258BPu+Er5asotDWIwQEJ40WGTOxd7p5cl2azDAvJkP
        1HSIUqRobIS0R56H6KetKF1HE1X7ZkPxxZAl/BU=
X-Google-Smtp-Source: ABdhPJyhD1/U0O8JeJGKj9ElAXyYgTT/puK2wr0s9lGVf2ck4KGSH3AbDPA36Kbg9oHe8JMEw7WYm4oddayxt3RMz4M=
X-Received: by 2002:aa7:d9d7:: with SMTP id v23mr15554465eds.281.1618125396567;
 Sun, 11 Apr 2021 00:16:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAKu1iLXtwuCQTS0s7_LEm0OJF-4s0UhPhDW1r5Zb7=GsSPfpdQ@mail.gmail.com>
 <20210409153815.7joohvmlnh6itczc@tb-raspi4>
In-Reply-To: <20210409153815.7joohvmlnh6itczc@tb-raspi4>
From:   Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Date:   Sun, 11 Apr 2021 00:16:25 -0700
Message-ID: <CAKu1iLX1AyTCSGxDVgiR1cr4=4ODD-gn8jHAinhp7OhDChAf1A@mail.gmail.com>
Subject: Re: git-p4 crashes on non UTF-8 output from p4
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is the pull request:

From 8d234af842223dceae76ce0affd3bbb3f17bb6d9 Mon Sep 17 00:00:00 2001
From: Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Date: Sat, 10 Apr 2021 22:41:39 -0700
Subject: [PATCH] add git-p4.fallbackEncoding config variable, to prevent
 git-p4 from crashing on non UTF-8 changeset descriptions

---
 Documentation/git-p4.txt | 10 ++++++++++
 git-p4.py                | 11 ++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index f89e68b..71f3487 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -638,6 +638,16 @@ git-p4.pathEncoding::
  to transcode the paths to UTF-8. As an example, Perforce on Windows
  often uses "cp1252" to encode path names.

+git-p4.fallbackEncoding::
+    Perforce changeset descriptions can be in a mixture of encodings. Git-=
p4
+    first tries to interpret each description as UTF-8. If that fails, thi=
s
+    config allows another encoding to be tried.  The default is "cp1252". =
 You
+    can set it to another encoding, for example, "iso-8859-5". If instead =
of
+    an encoding, you specify "replace", UTF-8 will be used, with invalid U=
TF-8
+    characters replaced by the Unicode replacement character. If you speci=
fy
+    "none", there is no fallback, and any non UTF-8 character will cause
+    git-p4 to immediately fail.
+
 git-p4.largeFileSystem::
  Specify the system that is used for large (binary) files. Please note
  that large file systems do not support the 'git p4 submit' command.
diff --git a/git-p4.py b/git-p4.py
index 09c9e93..18d02b4 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -771,7 +771,16 @@ def p4CmdList(cmd, stdin=3DNone, stdin_mode=3D'w+b',
cb=3DNone, skip_info=3DFalse,
                 for key, value in entry.items():
                     key =3D key.decode()
                     if isinstance(value, bytes) and not (key in
('data', 'path', 'clientFile') or key.startswith('depotFile')):
-                        value =3D value.decode()
+                        try:
+                            value =3D value.decode()
+                        except:
+                            fallbackEncoding =3D
gitConfig("git-p4.fallbackEncoding").lower() or 'cp1252'
+                            if fallbackEncoding =3D=3D 'none':
+                                raise
+                            elif fallbackEncoding =3D=3D 'replace':
+                                value =3D value.decode(errors=3D'replace')
+                            else:
+                                value =3D value.decode(encoding=3Dfallback=
Encoding)
                     decoded_entry[key] =3D value
                 # Parse out data if it's an error response
                 if decoded_entry.get('code') =3D=3D 'error' and 'data' in
decoded_entry:
--=20
2.31.1.windows.1

On Fri, Apr 9, 2021 at 8:38 AM Torsten B=C3=B6gershausen <tboegi@web.de> wr=
ote:
>
> On Thu, Apr 08, 2021 at 12:28:25PM -0700, Tzadik Vanderhoof wrote:
> > When git-p4 reads the output from a p4 command, it assumes it will be
> > 100% UTF-8. If even one character in the output of one p4 command is
> > not UTF-8, git-p4 crashes with:
> >
> > File "C:/Program Files/Git/bin/git-p4.py", line 774, in p4CmdList
> >     value =3D value.decode() UnicodeDecodeError: 'utf-8' codec can't
> > decode byte Ox93 in position 42: invalid start byte
> >
> > I'd like to make a pull request to have it try another encoding (eg
> > cp1252) and/or use the Unicode replacement character, to prevent the
> > whole program from crashing on such a minor problem.
> >
> > This is especially a problem on the "git p4 clone" command with @all,
> > where git-p4 needs to read thousands of changeset descriptions, one of
> > which may have a stray smart quote, causing the whole clone operation
> > to fail.
> >
> > Sound ok?
>
> Welcome to the Git community.
> To start with: I am not a git-p4 expert as such, but seeing that a progra=
m is crashing
> is never a good thing.
> All efforts to prevent the crash are a step forward.
>
> As you mention cp1252 (which is more used under Windows), there are proba=
bly lots of
> system out there which use ISO-8859-15 (or ISO-8859-1) we may have the fi=
rst whish:
>
> Make the encoding/fallback configurable.
> Let people choose if they want a crash (if things are broken),
> fallback to cp1252 or one of the other ISO-ISO-8859-x encodings.
>
> In that sense: we look forward to a pull-request.



--=20
Tzadik
