From: dclist@gmail.com
Subject: git-svn fails when svn.noMetaData is set
Date: Mon, 06 Dec 2010 21:24:27 -0500
Message-ID: <87bp4ytj50.fsf@invalid.clx>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 07 03:32:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPnM6-0003DR-Dv
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 03:32:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754935Ab0LGCb7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 21:31:59 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:49521 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754771Ab0LGCb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 21:31:58 -0500
Received: by mail-qy0-f174.google.com with SMTP id 11so4401554qyk.19
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 18:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:user-agent:mime-version:content-type;
        bh=sSbj9WoEbw18V2IWGlEzDcrLFVRerXy3QF2fE7Jfzt4=;
        b=La5h325effTyJ/LfxY88jKjRKp0i5G4FMVPk7dvbIaHnZmk2154rhwHp2uwy70zUaF
         M6UNN6lCRHsIZANgMW+ILZIkJqBR0gk3Uzw0IpcbQ+SGgrtrbUtQiuSnzpAs0jKqigA8
         Glt/iqpKaixQf6GPuDD74VyNtWhl/dz9jOBP4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:user-agent:mime-version
         :content-type;
        b=bXg8sceUq49K8L0JZMS9CT9KwQFrYDwb9bY2crP66FLHtn0BbkWuUs+A4lNzDDHogO
         sEU4i4xd1WpOgMNVzEEVZCSlamMM49R7H/IILQ8ED5bgdfoG93fSvHJBxwO9w4VywzE4
         W7eXheGelHbPbpUbmJQmUN0JExN2/uoO8UXdg=
Received: by 10.224.67.72 with SMTP id q8mr5157055qai.385.1291688671582;
        Mon, 06 Dec 2010 18:24:31 -0800 (PST)
Received: from localhost (bas1-montreal46-2925033342.dsl.bell.ca [174.88.119.126])
        by mx.google.com with ESMTPS id l14sm4031678qck.29.2010.12.06.18.24.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 18:24:30 -0800 (PST)
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163066>


Run on git version 1.7.3. Analyzed the source code using commit
0b0cd0e0a2.

Steps to reproduce
------------------
1. Set svn.noMetaData to true globally.
2. Invoke git svn clone on an svn repository

What happens
------------
Fatal error: "Not a SCALAR reference at /usr/lib/git-core/git-svn line 1457"

What I expect to happen
-----------------------
The clone to complete successfully

Analysis
--------
The problem seems to be line 1457, where the variable 'v' is
dereferenced and assigned a value --- $$v = $tmp ---- in combination
with line 118, where the value of the variable 'v' for the option
no-metadata is specified as a subroutine and, therefore, cannot be
assigned a value in the manner defined on line 1457. I believe the same
is true of other options that specify subroutines as their hash values.
