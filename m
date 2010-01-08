From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 2/2] Pass the --in-reply-to and --no-thread options 
	to git send-email
Date: Fri, 8 Jan 2010 12:33:32 +0000
Message-ID: <b0943d9e1001080433o553ffef7jd7d797c4f77da142@mail.gmail.com>
References: <20100107160932.3226.95737.stgit@pc1117.cambridge.arm.com>
	 <20100107160937.3226.14811.stgit@pc1117.cambridge.arm.com>
	 <b8197bcb1001072243h24e6248er79ac5a8afb6e3782@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl Wiberg <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 13:33:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTE2B-0007FS-7l
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 13:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856Ab0AHMdf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jan 2010 07:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752323Ab0AHMde
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 07:33:34 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:63285 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890Ab0AHMde convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jan 2010 07:33:34 -0500
Received: by fxm25 with SMTP id 25so12571075fxm.21
        for <git@vger.kernel.org>; Fri, 08 Jan 2010 04:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DSZ+Q8PgsDwgXeAwECLr7Me/Dxpdva5Q2AJWIEyXZcg=;
        b=XUBE59x6DPTeQJT0SLn9PbvP80PyWCEl41KImlt6uIOMjsPYMJCEAv38j+l38lwE0W
         CdN7i52BiUPR4fcWjY2TpmMIncF77Dv+y8V9DWBXanu/HTL6zjCgsQj6swyR8oN6Uqb/
         Wjg0B4IOW38zIquZbJe0oJrGiPevkT2Cw+1ak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=W5d0qW3/cWuDT3lYqRoVw7wAnsXBh0ISeyZ2cQbJK+2dxKzritZLPSQYePZITdtqz2
         bXvluCVqNO3eTGXhxtF1DYAxoZJQn70T1ee+ZLzlvjSLqAUFFKLqjYjc6yhyyTAa/Jy8
         DSiE8x5AjpQ9j86dqbj2oEaa7wvmO6/bSuXC8=
Received: by 10.223.27.79 with SMTP id h15mr4091863fac.23.1262954012848; Fri, 
	08 Jan 2010 04:33:32 -0800 (PST)
In-Reply-To: <b8197bcb1001072243h24e6248er79ac5a8afb6e3782@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136426>

2010/1/8 Karl Wiberg <kha@treskal.com>:
> On Thu, Jan 7, 2010 at 5:09 PM, Catalin Marinas <catalin.marinas@arm.=
com> wrote:
>
>> + =A0 =A0if options.in_reply_to:
>> + =A0 =A0 =A0 =A0cmd.append("--in-reply-to %s" % options.in_reply_to=
)
>
> Have you tested this? I'm pretty sure you need "--in-reply-to=3D%s", =
or
> to add the two strings separately---since as far as I can see, this
> command is never shell-expanded.

I now tested it. I initially had an "=3D" before "%s" but dropped it
because git help wasn't clear whether it's needed. See below for an
updated patch:


Pass the --in-reply-to and --no-thread options to git send-email

=46rom: Catalin Marinas <catalin.marinas@gmail.com>

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/commands/mail.py |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index a78c9d2..287b6a4 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -241,6 +241,10 @@ def __send_message_git(msg, options):
     cmd.append("--suppress-cc=3Dself")
     if not options.auto:
         cmd.append("--suppress-cc=3Dbody")
+    if options.in_reply_to:
+        cmd.extend(["--in-reply-to", options.in_reply_to])
+    if options.no_thread:
+        cmd.append("--no-thread")

     # We only support To/Cc/Bcc in git send-email for now.
     for x in ['to', 'cc', 'bcc']:
