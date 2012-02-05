From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Git performance results on a large repository
Date: Sun, 5 Feb 2012 10:47:27 +0700
Message-ID: <CACsJy8Bf95JMp1qOiruR7+Tdi7JN42KNeMqGLud+z3O26DREnw@mail.gmail.com>
References: <CB5074CF.3AD7A%joshua.redstone@fb.com> <CACsJy8DkLCK0ZUKNz_PJazsxjsRbWVVZwjAU5n2EAjJfCYtpoQ@mail.gmail.com>
 <243C23AF01622E49BEA3F28617DBF0AD5912CA85@SC-MBX02-5.TheFacebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Redstone <joshua.redstone@fb.com>
X-From: git-owner@vger.kernel.org Sun Feb 05 04:48:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rtt5E-0000Py-TL
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 04:48:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685Ab2BEDsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 22:48:00 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:51374 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754648Ab2BEDr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 22:47:59 -0500
Received: by werb13 with SMTP id b13so3561651wer.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 19:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=e8i0MULJZ6YysKDSxR+uvVan+ZkC+W7X9qPNInONSQY=;
        b=qMoVVYFy3cJ9olOeR+2PnwWDw5u9GzKgSwszX0/VtM8TDXLQireEDaIssVNeT8hv/M
         tC2wtDPFDZrHzV51e6spsL+kEZXQ838RXj3irCWLZ31FV3exeZVyz+Ziko6Wleq0lDlZ
         5wCXJgfPI0NsysM1dbPms1PX/4aCl4U7+XFho=
Received: by 10.216.136.17 with SMTP id v17mr5036338wei.26.1328413678238; Sat,
 04 Feb 2012 19:47:58 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Sat, 4 Feb 2012 19:47:27 -0800 (PST)
In-Reply-To: <243C23AF01622E49BEA3F28617DBF0AD5912CA85@SC-MBX02-5.TheFacebook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189928>

On Sun, Feb 5, 2012 at 1:05 AM, Joshua Redstone <joshua.redstone@fb.com> wrote:
> It's also conceivable that, if there were an external interface in git to attach other
> systems to efficiently report which files have changed (e.g., via file-system integration),
> it's possible that we could omit managing the index in many cases.
> I know that would be a big change, but the benefits are intriguing.

The "interface to report which files have changed" is exactly "git
update-index --[no-]assume-unchanged" is for. Have a look at the man
page. Basically you can mark every file "unchanged" in the beginning
and git won't bother lstat() them. What files you change, you have to
explicitly run "git update-index --no-assume-unchanged" to tell git.

Someone on HN suggested making assume-unchanged files read-only to
avoid 90% accidentally changing a file without telling git. When
assume-unchanged bit is cleared, the file is made read-write again.
-- 
Duy
