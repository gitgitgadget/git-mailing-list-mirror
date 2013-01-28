From: Jed Brown <jed@59A2.org>
Subject: Updating shared ref from remote helper, or fetch hook
Date: Sun, 27 Jan 2013 23:19:36 -0600
Message-ID: <87ehh5lw9j.fsf@59A2.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 28 06:20:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzh8U-00070r-Bn
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 06:20:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913Ab3A1FTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 00:19:41 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:64316 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809Ab3A1FTk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 00:19:40 -0500
Received: by mail-ie0-f180.google.com with SMTP id k11so805022iea.11
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 21:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:subject:user-agent:date:message-id
         :mime-version:content-type;
        bh=lhhyoDaTGACTNPKtAbye0BfZOfiSLKK+l4zDNfrZx3I=;
        b=1FfaROUij6bfPlvlss0BQH2i5ubbPlAfr+FtIzhdrlQVyhVmhCUKsXUHMPZgcl44+F
         YXPlOmdmFpW5DJqrKhGcr9UhIuTvZw2QBs/0WK7yNTBVavT6jQvQbLaEJuAXWs2sBZ+W
         28DHCTH+InVRI3oYUM37LGtTlGRdobzbqTMPbrYN0iO59Ka+45d9COZCZyVV//UoV597
         r85/5hcsfAg82kfQzm00HiTu9t2VZjOSn58w4tKttwRdJ4Uiwro+mb5Gl5i/3Wv4DXfP
         +9A3l/aO5ccbj+aWLH4BVpnepEzxqQkXIditEHaPggO7I5uAR8N2wnfkHkwU/bpccAR2
         eLKg==
X-Received: by 10.50.213.73 with SMTP id nq9mr4257957igc.27.1359350379612;
        Sun, 27 Jan 2013 21:19:39 -0800 (PST)
Received: from batura ([38.69.41.115])
        by mx.google.com with ESMTPS id as6sm5409830igc.8.2013.01.27.21.19.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 21:19:38 -0800 (PST)
User-Agent: Notmuch/0.15 (http://notmuchmail.org) Emacs/24.2.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214802>

I'm working on an hg remote helper that uses git notes for the sha1
revision, so that git users can more easily refer to specific commits
when communicating with hg users.  Since there may be multiple
concurrent fast-import streams, I write the notes to a private ref
(refs/notes/hg-REMOTE), to be merged eventually using

  git notes --ref hg merge hg-REMOTE*

There will never be conflicts because each hg commit translates to a
unique git commit, thus even if multiple concurrent remotes process the
same commit, the corresponding note will match.

Unfortunately, I couldn't find a safe way to get this run after a fetch
or clone.  Of course I can ask the user to arrange to have this command
run, but it would be a better interface to have it run automatically
since it is a natural responsibility of the remote helper.  Am I missing
a way to do this or a viable alternative approach?
