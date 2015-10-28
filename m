From: =?UTF-8?Q?Rafael_Esp=C3=ADndola?= <rafael.espindola@gmail.com>
Subject: git fsck failure on OS X with files >= 4 GiB
Date: Wed, 28 Oct 2015 16:10:10 -0700
Message-ID: <CAG3jReJn2Pz6-bXLw6baOZaE1BHYiC+1-zN0eagigfG3umWpJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Filipe Cabecinhas <filcab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 00:10:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrZrF-0000Oe-NZ
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 00:10:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753648AbbJ1XKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 19:10:12 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:33929 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870AbbJ1XKL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 19:10:11 -0400
Received: by obbza9 with SMTP id za9so19815933obb.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2015 16:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=IvH4FP3evvXvXzWb6Y6hXSdoEHhFS5gJ9TqotWM4qYs=;
        b=KPqL6sfb3EudnZ+8qRWcOfqHKnflz5OH9nxgVJk02bWGlbxn3t03L/jTS4qFtHp9MN
         U0aUK85ZF07Z+x6FGOmrMlVTRjK5o2co+hB0jmoY+4camdU4nAEREv8urUKtcONT3EAs
         H0n+h2sRxnHb6snTjlvv2TbeQ9NJyT30uJopD5PfbCUF+TgqWyCA2aSBLz0fZsChnNj4
         fcx/PH/BR09cgIJ56E+8eCumuEDZJJBKRGLOyrXCg7QNedKOh/qbKbYG/iqbHv1qhwfA
         YVdGTdqV6ydrSGMjtPir/xN+SWWCBvAtZXsQ8eujiHKB3qaHvOT2dmOeh6HpKXLcfnDX
         fBiA==
X-Received: by 10.182.65.5 with SMTP id t5mr35665137obs.32.1446073810166; Wed,
 28 Oct 2015 16:10:10 -0700 (PDT)
Received: by 10.202.228.73 with HTTP; Wed, 28 Oct 2015 16:10:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280421>

I first noticed this with "2.4.9 (Apple Git-60)", but it reproduces
with git built from 37023ba381b6d251d7140a997b39b566dbc63c42.

Create two files with just 0s:

-rw-r--r--  1 espindola  staff  4294967296 28 Oct 11:09 exactly-4gib
-rw-r--r--  1 espindola  staff  4294967295 28 Oct 11:09 one-less-than-4gib


and run

git init
git add one-less-than-4gib
git commit -m bar
git fsck
git add exactly-4gib
git commit -m bar
git fsck

The first fsck will run with no problems, but the second one fails:

error: packed cfdaf54c9ccfd8f5e4cee562f7d5f92df13d3106 from
.git/objects/pack/pack-ff08480fd7f767b6bd0aeb559f0f5dea2245b0b3.pack
is corrupt

Using the very same revision on freebsd doesn't cause any errors.

Cheers,
Rafael
