From: John Szakmeister <john@szakmeister.net>
Subject: [PATCH] git-web--browse: recognize iTerm as a GUI terminal on OS X
Date: Mon, 25 Mar 2013 06:13:18 -0400
Message-ID: <20130325101318.GA31409@yoda.local>
References: <CAMxBVSs6dJFnK78E2Da7t4V9ndJFRVDZEd1fR5QuCFz=u2Bnpw@mail.gmail.com>
 <CAMxBVStw-b3J_Fm9x=h3==9ebdLUkpjBSQ9-W4+zJ9N20ojfxg@mail.gmail.com>
 <CAP8UFD2oR5tnYuw7Nbe-CzGx7fw-OpAFW+reN+1Nroh1jXjfsQ@mail.gmail.com>
 <CAMxBVStVXZGGrjHzN7kukVP6_ZGo0miyJaE2FVYPVV4Jb5U82w@mail.gmail.com>
 <CAEBDL5VNodcTGBOvQjyL30qiXhshxhnUH-Vd9xy9=RxZQgH-Yw@mail.gmail.com>
 <CAP8UFD2m8n5RHN-CgyDP1ir_AorpJGnWwNhXuRxDa=DbHfsdiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Timo Sand <timo.j.sand@gmail.com>, git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 11:13:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UK4Pc-000883-Se
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 11:13:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755549Ab3CYKN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 06:13:26 -0400
Received: from mail-vb0-f47.google.com ([209.85.212.47]:62364 "EHLO
	mail-vb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580Ab3CYKNW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 06:13:22 -0400
Received: by mail-vb0-f47.google.com with SMTP id e21so3761074vbm.6
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 03:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=SERtiaCgsZaqdIh2LWTqnl3i1O5g1JfEwUDdHMtAsvc=;
        b=XNrWOsAvQmnZzwXJM4928CAMqf93i4CWl3tg61LLq+ftzaVtv0pkomrVswLrT2Ly6x
         dspKPSk3ltXSXSWvPkuvQKX1UDT/1h2N5dr3ZKWgtRADGB/77tThs81jwdAC28b4atCM
         7HINUhvxFWeH9bX5r5/ZdVtbTTyM2KKntMG4ct5jTtlLDLY3tsItgLmas6G26FcqoS5V
         4fHjZ/hwYc1uPVkOTcN8/L9uLFDi7QxQqDeKsn1AKicKft/vJcMeRDff2rEs7GuxV4Vf
         XNnJqeueqFHYVCGEjBsTcGXy+ajyT27bm8ZWVE3QHGBmXt6K80/voUSYXAynFB2CN8W6
         3MNg==
X-Received: by 10.58.224.101 with SMTP id rb5mr14856804vec.17.1364206401921;
        Mon, 25 Mar 2013 03:13:21 -0700 (PDT)
Received: from yoda.local (pool-74-103-61-56.bltmmd.fios.verizon.net. [74.103.61.56])
        by mx.google.com with ESMTPS id d13sm19561239vdj.8.2013.03.25.03.13.20
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 25 Mar 2013 03:13:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAP8UFD2m8n5RHN-CgyDP1ir_AorpJGnWwNhXuRxDa=DbHfsdiw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219023>

It turns out that the presence of SECURITYSESSIONID is not sufficient
for detecting the presence of a GUI under Mac OS X.  SECURITYSESSIONID
appears to only be set when the user has Screen Sharing enabled.
Disabling Screen Sharing and relaunching the shell showed that the
variable was missing, at least under Mac OS X 10.6.8.  As a result,
let's check for iTerm directly via TERM_PROGRAM.

Signed-off-by: John Szakmeister <john@szakmeister.net>
---

On Sun, Mar 24, 2013 at 10:05:53PM +0100, Christian Couder wrote:
[snip]
> Your patch looks good to me, and I cannot really test it as I don't have a Mac.
> Could you just had some of the explanations you gave above to the
> commit message?

Here's an updated patch.  I also noticed that git-bisect.sh is
also trying to determine if a GUI is present by looking for
SECURITYSESSIONID as well.  I wonder if it would be better to
create a shell function in git-sh-setup.sh that the two scripts
could use?

-John

git-web--browse.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-web--browse.sh b/git-web--browse.sh
index 1e82726..1ff5379 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -120,6 +120,7 @@ if test -z "$browser" ; then
 	fi
 	# SECURITYSESSIONID indicates an OS X GUI login session
 	if test -n "$SECURITYSESSIONID" \
+		-o "$TERM_PROGRAM" = "iTerm.app" \
 		-o "$TERM_PROGRAM" = "Apple_Terminal" ; then
 		browser_candidates="open $browser_candidates"
 	fi
-- 
1.8.2
