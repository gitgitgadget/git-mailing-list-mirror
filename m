From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH 0/8] Fetch improvements and re-implementation of remote update
Date: Tue, 10 Nov 2009 09:13:04 +0100
Message-ID: <4AF92090.7030102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 09:13:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7lqp-0006te-LU
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 09:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbZKJIND convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Nov 2009 03:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752459AbZKJINC
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 03:13:02 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:38036 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613AbZKJINB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 03:13:01 -0500
Received: by ewy3 with SMTP id 3so3972591ewy.37
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 00:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=FpJWECo8BOpXxlWV5vGKOAl9wEwXsqPyfOudSyevvT8=;
        b=gOEpn+2ybZ9lOWcNa7/SV6OKfbj1fGd7rbMeH5PUvifkNWthZMqY/tWGBtms8XwGuT
         ds9i5tXUxfHIdGmquJBOPAgpEOcj0+JSgRigGYSUN2alHhV4E7RkXPQzlexcGR8eOe+2
         NeQ6ACys8tdPJP792hTnMtZDE8cqlRJ4BY+S8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=dZbDQ+jTuzwp4NOWQG7UZVQa6kRwSRhv9/21XCGUKLDc8fvUdxs0Xljb7zgoRqWBZ/
         qz8YSzfJ3kFcNg7IQ4LCIW2NeJ6tTDrdqv9srPusyy8oyN6wFmmiICQHzC0TWjEOpIzV
         Kq3NlyOezIygGPtv7hAHAWM4PsGEoI54oBKrE=
Received: by 10.213.96.202 with SMTP id i10mr4485534ebn.99.1257840785583;
        Tue, 10 Nov 2009 00:13:05 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 7sm1153341eyb.32.2009.11.10.00.13.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 00:13:05 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132544>

To avoid having a commit where 'git remote update --prune' is broken
(except for cleanliness reasons, it would cause problems if someone
wants to bisect a breakage in that functionality), I have made
a slight change to one of Jay's patches and put my patch that
re-implements 'git remote update' last in the series.

=46ollowing this email, there will be series of patches starting
with number 5 and ending in number 8.

It can be applied directly on top of my fourth patch I sent out
yesterday ("Add missing test for 'git remote update --prune'").
The fifth patch in that series should be discarded.

Bj=C3=B6rn Gustavsson (1):
  Re-implement 'git remote update' using 'git fetch'

Jay Soffian (3):
  teach warn_dangling_symref to take a FILE argument
  builtin-fetch: add --prune option
  builtin-fetch: add --dry-run option

 Documentation/fetch-options.txt |    9 ++++
 builtin-fetch.c                 |   42 ++++++++++++++++--
 builtin-remote.c                |   90 ++++++++++++-------------------=
-------
 refs.c                          |    7 ++-
 refs.h                          |    2 +-
 5 files changed, 81 insertions(+), 69 deletions(-)
