From: ghazel@gmail.com
Subject: git reset and ctime
Date: Fri, 3 Dec 2010 13:36:37 -0800
Message-ID: <AANLkTimyYTup+PqJFJ+2g-tVwWXA2bxTT3noonEuKBSu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 03 22:37:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POdJR-0000r1-Qz
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 22:37:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362Ab0LCVg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 16:36:59 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:64607 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000Ab0LCVg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 16:36:58 -0500
Received: by qyk12 with SMTP id 12so12178034qyk.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 13:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=PDPw59sGnhl1KOH0ceGaa34QrFpbW4B8Ou39IOSekdk=;
        b=aMesRNJdFAY1v9gDptVjxpmyztamBe3aO1VumNC52K7hT69ve0YJxDOWJQO0VJRYFZ
         vTI7rSjHooi7nENOdLYf3ljijsq4hrN0hmDAp1Hmp5TmrsH84i2eEozQzpgKSpvz05iX
         8RDtkWNihkmmN05Y4ueFQWRdJQfAz9JUQxKwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=T61JKMOrW3Sbu8mYGHI9qClNJRwUHj3JeM8LzeizZyupC+LkF2DlvhU5e2/zVbnsT2
         HFIQtVqvSn7R2RV/oLlcy9L6W5zMydGibFg8Rqj+WNhhGkC2uLT9ZanwsPpdQYMZJwbW
         0OQXR/8YO3AuFVW6TzQ18WS0vxrVW/1xQ5fuo=
Received: by 10.224.64.75 with SMTP id d11mr1644659qai.214.1291412218133; Fri,
 03 Dec 2010 13:36:58 -0800 (PST)
Received: by 10.220.16.68 with HTTP; Fri, 3 Dec 2010 13:36:37 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162860>

Hi,

I've encountered a strange issue where "git reset --hard" insists on
"Checking out files ..." when all that is changed is the ctime on
these files. My deploy process (capistrano) maintains a cached copy of
a git repo, which it fetches, resets, and then hardlinks files from
when a deploy occurs ( https://github.com/37signals/fast_remote_cache
). The hardlinking step is meant to save the time of copying the file.
but hardlinking changes the ctime of the source files. That causes git
reset to re-check out the files when the next deploy occurs, which is
quite time-consuming. Some helpful people on #git showed that "git
update-index --refresh" before the git reset prevents this behavior,
but I wonder why that is needed at all.

Should git reset be performing whatever "git update-index --refresh"
is doing? Certainly in this case it would result in a vast speed
improvement.

-Greg
