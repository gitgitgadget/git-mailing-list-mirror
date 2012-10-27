From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Strange behaviour of git diff branch1 ... branch2
Date: Sat, 27 Oct 2012 10:51:12 +0700
Message-ID: <CACsJy8CX4Wbf3Bqez2kcQ7NGYMkqXC8MK+=hrH4iaev+0ZrQ8Q@mail.gmail.com>
References: <20121026212650.GB2612@pug.qqx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org, Aaron Schrab <aaron@schrab.com>
X-From: git-owner@vger.kernel.org Sat Oct 27 05:51:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRxRF-000494-HE
	for gcvg-git-2@plane.gmane.org; Sat, 27 Oct 2012 05:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934473Ab2J0Dvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 23:51:44 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:39247 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934466Ab2J0Dvn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 23:51:43 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so3199254obb.19
        for <git@vger.kernel.org>; Fri, 26 Oct 2012 20:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=5uP27gfveVQyP4pYvvu3OqkifWIS+iI2+bQwpwxw5Cs=;
        b=SOZyESiOJxVntH6N7DclxBYLX20C36qxMvZAyE66SKDUOFEpOtDjRDIF7bLJpkVL/X
         WIoYnD1fRBDoe/pfP5esEkh7+xSv2/FxlQZtf6iqtpWm5KOw3Y+t2fy3rhS30GD9nz/X
         EZn7PC0ZZ4meBcK2VBY8teBqkAz0V/21psQTdVhDN9q9IDJ+Dq9I5i4m8nq9aWuLZbJ/
         Y+dNQFQyqjCDAOH18g1KQGBw0HBYv2bjCvTKdVU+NsqBDlToW/qvAg5zYndBt/7Mz/zm
         QdOIlB016NGVNjF2BQQ5wVcnxZh2C+3+qDyKz5FRyyiYdlL53NLR5A5zE7Ny7QgvJ142
         Qnpw==
Received: by 10.182.89.103 with SMTP id bn7mr20583961obb.35.1351309902950;
 Fri, 26 Oct 2012 20:51:42 -0700 (PDT)
Received: by 10.182.108.10 with HTTP; Fri, 26 Oct 2012 20:51:12 -0700 (PDT)
In-Reply-To: <20121026212650.GB2612@pug.qqx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208496>

On Sat, Oct 27, 2012 at 4:26 AM, Aaron Schrab <aaron@schrab.com> wrote:
> I came across this odd question on stackoverflow:
>         http://stackoverflow.com/q/13092854/1507392
>
>
> If git diff is run with "..." as a separate argument between two commit-ish
> arguments causes it to produce strange output.  The differences seem to be
> the same as if "..." was left out, but change lines begin with 4 + or -
> characters rather than just 1.
>
> Can anybody explain what is happening here?  I don't have any reason to want
> to use that form myself, but I'm very curious about why it produces this odd
> output.

I'm curious too. It shows this to me

diff --cc .gitignore
index a188a82,a188a82,a188a82,a188a82..d4473d8
--- a/.gitignore
+++ b/.gitignore
@@@@@ -2,9 -2,9 -2,9 -2,9 +2,6 @@@@@
    /GIT-CFLAGS
    /GIT-LDFLAGS
    /GIT-GUI-VARS
----/GIT-PREFIX
----/GIT-SCRIPT-DEFINES
----/GIT-USER-AGENT
    /GIT-VERSION-FILE
    /bin-wrappers/
    /git

Notice the --cc in the first line, which is combined diff. Usually
combined-diff is between two points and one parent. Though somehow git
passes 4 parents down combined-diff.c:show_combined_header, as you can
see in the "index" line. I think we should fix rev parsing code as it
does not make sense to pass 4 identical parents this way.
-- 
Duy
