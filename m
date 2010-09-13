From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Is there an updated version of git-vcs-p4?
Date: Mon, 13 Sep 2010 11:04:29 +0200
Message-ID: <AANLkTi=okJRFeBhbURB8Ez4Vb65fNdacKeko+4sx9ihy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Sep 13 11:04:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ov4xo-0002ko-1g
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 11:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754389Ab0IMJEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 05:04:30 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46436 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906Ab0IMJEa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 05:04:30 -0400
Received: by gxk23 with SMTP id 23so1951096gxk.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 02:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=5i8skOaprJH6QXF1LjGRbMeEtukfMrzjHdDuFfCwYOc=;
        b=g2yH8MNa/t32/nTp80C8AuCfCj0qjK669DoX0LW3d9zv2GHwyreDmlzmAfKCQks3tS
         rC7JIg66kuDhE7oDxs/pL1KVXay7eH7xU3Awf22zhwb1DkW5dhAQkqprbRvOFGOYtnuk
         c62/Zw+bGk5Mm773Kt/8auFir2edaZmOxnKcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=DQYiC6gjdujp3BDQjXQXX1b94Btg8k4uNIw74hlP+jl4yE8W6YhmKXcdA8hFxswMcf
         I2OMyYxNauPkuCuYYL3U4i9uDVLoYX+vblypkDprpg+YUmDd7hLWHMwHc7UPrtcoCXD7
         vMptgxccU39rsLeq92GFfbgkOc1MQjDtwnrbU=
Received: by 10.150.217.17 with SMTP id p17mr6100ybg.256.1284368669296; Mon,
 13 Sep 2010 02:04:29 -0700 (PDT)
Received: by 10.231.178.139 with HTTP; Mon, 13 Sep 2010 02:04:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156082>

Hello, Daniel (and list). I wonder if I might ask you if you have an
"updated" version of git-vcs-p4? Or otherwise, if anyone can hold my
hand while I try to implement what I need... :)

I'm having trouble getting exporting to work. Looking at the C code, I
quickly realize that there's _much_ I don't know anything about, but
it seems to me that vcs-p4.c needs to support the "refspec "
capability. Am I on the right track?

My reasoning so far: the version of vcs-p4.c that I have, contained a
prefixcmp for "export ". This made "git push" barf with the current
version of transport-helper.c, so I did something like this:

diff --git a/vcs-p4/vcs-p4.c b/vcs-p4/vcs-p4.c
index a4613a6..29d761b 100644
--- a/vcs-p4/vcs-p4.c
+++ b/vcs-p4/vcs-p4.c
@@ -1213,7 +1213,18 @@ int main(int argc, const char **argv)
                        }
                        printf("\n");
                        fflush(stdout);
-               } else if (!prefixcmp(buf.buf, "export ")) {
+               } else if (!strcmp(buf.buf, "export")) {
+                       printf("\n"); // no export-marks file
+                       printf("\n"); // no import-marks file either
+                       fflush(stdout);


This got me one step further, but it now produces an empty argument
list to fast-export (in the transport-helper function
push_refs_with_export), because the data->refspecs is NULL. It seems
to get set in get_helper when it encounters the "refspec " cap (which
vcs-p4 does not support).

So - is this "refspec " thingy what needs to be implemented, or am I
lost in space here? :)

-Tor Arvid-
