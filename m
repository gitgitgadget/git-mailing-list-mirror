From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [RFC PATCH 0/3] fast-import: add option command
Date: Sat,  1 Aug 2009 22:06:07 -0700
Message-ID: <1249189570-26576-1-git-send-email-srabbelier@gmail.com>
References: <fabb9a1e0908011829j3843c132ka5081d994aad973f@mail.gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 02 07:07:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXTHu-0001YW-BY
	for gcvg-git-2@gmane.org; Sun, 02 Aug 2009 07:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbZHBFGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2009 01:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbZHBFGb
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Aug 2009 01:06:31 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:52835 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbZHBFGa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2009 01:06:30 -0400
Received: by rv-out-0506.google.com with SMTP id f6so836613rvb.1
        for <git@vger.kernel.org>; Sat, 01 Aug 2009 22:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=AfaPeQybgVoQpLs2CKBLApiSCg7l4Jtypo3w2fCvtKE=;
        b=NOEXNDQvh5h6grcGI9KL2J+/KEdNuvt1JJv0W+Egl4zFkbyaKPvxoJ23UhncowVrMo
         FD0o5O3o96xYNsIH46HQzBX8Z8BfL9vmMC/yO30ueoSpyriv/TbHh7J8jZ7O7xrXud63
         xQLVxj2mfd7oVPWCrGI6Aa/AliRiGuvqT0lLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=e6rG1fG6nFDTXTjom1it3JXSvMmYaI8eddpST6ELKajgbQoqFua5lh0ZqtwxVaTAPi
         0k5xQ9XGbl8mirmr1JT4pEGL0MT8UDhy3YyZ5Rlq66TkufQ9u0gdiWip1Xa2ShhSNOUO
         qda60IbgvTsWi4EowUEirsWTOEttbkLYS1I/k=
Received: by 10.141.34.12 with SMTP id m12mr2892748rvj.48.1249189590915;
        Sat, 01 Aug 2009 22:06:30 -0700 (PDT)
Received: from localhost.localdomain ([173.8.183.73])
        by mx.google.com with ESMTPS id g14sm27870127rvb.40.2009.08.01.22.06.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 01 Aug 2009 22:06:30 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.15.g8b2be
In-Reply-To: <fabb9a1e0908011829j3843c132ka5081d994aad973f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124662>

Because I am too impatient to wait for a reply to my earlier mail,
here is an RFC series that demonstrates how I envision the option
command to work.

>From the second patch:

    This allows the frontend to specify any of the supported options as
    long as no non-option command has been given. This way the
    user does not have to include any frontend-specific options, but
    instead she can rely on the frontend to tell fast-import what it
    needs.

This change of course means that old fast-import clients will break
upon receiving an 'option' command (or with an argument they don't
support), but such clients will break with a clear output stating
the reason for the breakage. Newer frontends therefore should only
output options if the user tells them to (by means of a flag/config
option), or at least allow disabling option output.

The main use case for this is hg-git, which I want to modify so that
it uses 'hg fast-export | git fast-import' for the intial import.
However, to do that I need the fast-import part to write a marks
file, that is, --write-marks=git.marks. To simplify this process for
the user, it would be nice if 'hg fast-export' can instead emit an
'option write-marks git.marks' line (hence the test case).

 Sverre Rabbelier (3):
      fast-import: put option parsing code in seperate functions
      fast-import: add option command
      fast-import: test the new option command

 fast-import.c          |  137 ++++++++++++++++++++++++++++++++++++-----------
 t/t9300-fast-import.sh |   33 ++++++++++++
 2 files changed, 138 insertions(+), 32 deletions(-)
