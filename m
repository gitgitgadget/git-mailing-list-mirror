From: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
Subject: How to add custom metadata to Git commit object
Date: Mon, 30 May 2016 20:58:08 +0300
Message-ID: <959E96F7-0FF3-4336-B098-58836136DB08@jetbrains.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 19:58:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7RSE-0003cO-Hf
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 19:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161681AbcE3R6O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2016 13:58:14 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:36741 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161249AbcE3R6N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2016 13:58:13 -0400
Received: by mail-lf0-f50.google.com with SMTP id b73so53576012lfb.3
        for <git@vger.kernel.org>; Mon, 30 May 2016 10:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jetbrains.com; s=googleapps;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=Gc0m2TYxxw39QMvN2lCAB3O+Dzhd/hncyPEcxJlgN3Q=;
        b=TRauL90/3seSVjsqpcsSQzju+Aoau3qx5l1LvCh0ii3rVknhc4L4q49jsi2TfTBjBU
         NXP5UlmfLRmj/A4IzgbN7ygNjgZ81eOyc3IdTy5vA6vj8BaU6BISUdQ16sGYqlsDWxqE
         Nrn/AJU4lIdNl7aglcPObEHvYsqCiIJ9nXPD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=Gc0m2TYxxw39QMvN2lCAB3O+Dzhd/hncyPEcxJlgN3Q=;
        b=OPltlOtAWA9U4JwB9n3MQDdrbxghIQ/Nup8tgs6ei9WbDWM90eCVVUssQ3jxZkYk3e
         wupO4IT17l9Ni9OZ+QepP4McK1SI90CO6IrZ/nTKduW3tdaDSIMcOb4QmREqDWoOt3sR
         /mLFvmecu2kIGTVchSJ0YVwZmIHdxFNzhHqAs58SBg6pxmOkxSXg0aWpNGpDZ/OxAJ9u
         G9WqZ14h57suYjiNeUlN+XgCYPrf9NOAMH+noyMkhSIWQtmO4k1JO32VhWc+uk+1VcYP
         Lm2u3zre5cHy5nfYWM6O88/S+DHftRIl1PPxbnplMo9/hgjKb9lMXpuV9RSQ37q9WjRM
         bg0g==
X-Gm-Message-State: ALyK8tIlm4lbxNC1suNZYXBy0T3kUU7aU33iGI0rj0VFYuyvjw5Wyn2aJdt0TJ6Qf+EVHj7x
X-Received: by 10.25.16.104 with SMTP id f101mr9043119lfi.34.1464631091032;
        Mon, 30 May 2016 10:58:11 -0700 (PDT)
Received: from loki.times.labs.intellij.net ([217.148.215.18])
        by smtp.gmail.com with ESMTPSA id wc3sm4531137lbb.27.2016.05.30.10.58.09
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 30 May 2016 10:58:09 -0700 (PDT)
X-Google-Original-From: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295913>

Is it possible to add custom metadata to Git commit object?=20
Such metadata should be ignored by Git commands, but could be used by a=
 3-party tool which knows the format and knows where to look.=20

I assume that this should be possible, given that Git objects are actua=
lly patches, and patches can contain additional details. But can this b=
e done with the help of Git commands?=20

----

The reason why I am asking this - is to create a tool which could overc=
ome false rename detection.=20

As all of you know, if I make significant changes to the code together =
with rename, Git won=E2=80=99t detect this rename and will treat this c=
hange as added + deleted. And sometimes there are false rename detectio=
ns as well. It would be useful to record the fact of rename and use it =
afterwards.

If a user is developing with our IDE (IntelliJ IDEA), we could remember=
 the fact that he renamed a file, then write this information to the co=
mmit object, and when the commit information is requested (e.g. from th=
e git log graphical view), the IDE could read the additional informatio=
n of the commit and display the file as renamed, not as added + deleted=
=2E The IDE could also use this information to follow rename through th=
e file history.

As a real example, in our project we are converting a lot of files from=
 Java to Kotlin, and such conversion always looses history unless the d=
eveloper remembers to prepare a separate rename-commit first, which is =
tedious.=20

There are git-notes, which could be used for the purpose, but they are =
visible to the user via standard Git command, and could be used by the =
user for other purposes, so they are not very suitable for the task.

Thanks a lot!
-- Kirill