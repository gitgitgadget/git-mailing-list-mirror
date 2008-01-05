From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Fix an off by one bug in pretty.c
Date: Sun, 6 Jan 2008 00:18:37 +0100
Message-ID: <e5bfff550801051518u49e9c21ake36584457f4c9488@mail.gmail.com>
References: <e5bfff550801051455i3d589c4q9375aeab0cb6aa47@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"=?UTF-8?Q?Ren=C3=A9_Scharfe?=" <rene.scharfe@lsrfire.ath.cx>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 00:19:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBIIE-0003Ys-0P
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 00:19:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859AbYAEXSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 18:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752857AbYAEXSi
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 18:18:38 -0500
Received: from rv-out-0910.google.com ([209.85.198.189]:63535 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767AbYAEXSh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 18:18:37 -0500
Received: by rv-out-0910.google.com with SMTP id k20so6593948rvb.1
        for <git@vger.kernel.org>; Sat, 05 Jan 2008 15:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=mJedxhIiH7PlSWLt+m07STRO+JDI7RDMxkEVton8bM4=;
        b=RgOg0MbbkEookLvYyLnRdkTZnBSYKYzlvrCB9XT/FOUfo9p8KyGC/sacRMhlb5xJVJTyOV9l/WrlJ3z+PFyHVtelvSwrUHfaFW3AGhds/LE/z+uB/S94nghb7zFKawxljR+wBbQw3a9E9h9nfZj/6pYkGzHaZOmrL6cIi5JuQ3I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=deZIygnHReYy2T80M/jG/HFljQ0+VwDu6cwUDsOOYnL+D6r/uNiFW1I2nLveTUhJ5VHoHlAIRz2IX43KXndgldyOfb/bFFrzEL3Qw9phMNWAdJH4UmWyHtQm5WiAGaKwg84utPCdW1LI5uE8tikV1C4JhsG5RsyFh9hsqK/L7sQ=
Received: by 10.141.87.13 with SMTP id p13mr9737597rvl.55.1199575117365;
        Sat, 05 Jan 2008 15:18:37 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sat, 5 Jan 2008 15:18:37 -0800 (PST)
In-Reply-To: <e5bfff550801051455i3d589c4q9375aeab0cb6aa47@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69693>

On Jan 5, 2008 11:55 PM, Marco Costalba <mcostalba@gmail.com> wrote:
> In case author email is <> then we have the following
> bug in function 'format_person_part'
>

WARNING: Please discard previous patch!

Due to an error I sent the wrong one, the following is the correct one:

------------------- CUT ----------------------------------------------------


In case author email is <> then we have the following
bug in function 'format_person_part'

/* parse name */
for (end = 0; end < len && msg[end] != '<'; end++)
      ; /* do nothing */

start = end + 1; /* now start points to '>' */

-- cut ---

/* parse email */
for (end = start + 1; end < len && msg[end] != '>'; end++)

And here 'end' is initialized with 'start + 1'
instead of 'start'. This turns out in empty commit
date when git log is used with --pretty=format option.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---

feba083ccd11374560e34a755ca03f07e7d45533
 pretty.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/pretty.c b/pretty.c
index 5b1078b..3ce5e6f 100644
--- a/pretty.c
+++ b/pretty.c
@@ -304,7 +304,7 @@ static void format_person_part
 		return;

 	/* parse email */
-	for (end = start + 1; end < len && msg[end] != '>'; end++)
+	for (end = start; end < len && msg[end] != '>'; end++)
 		; /* do nothing */

 	if (end >= len)
