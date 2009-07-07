From: Troy Telford <ttelford.groups@gmail.com>
Subject: Git fast-import file format question
Date: Tue, 7 Jul 2009 13:06:08 -0600
Message-ID: <1e30a6d10907071206u21ecd9d8wb53441a3bf7b64c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 21:06:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOFzf-0001c7-KO
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 21:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606AbZGGTGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 15:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754268AbZGGTGM
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 15:06:12 -0400
Received: from mail-gx0-f226.google.com ([209.85.217.226]:49892 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbZGGTGL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 15:06:11 -0400
Received: by gxk26 with SMTP id 26so2241831gxk.13
        for <git@vger.kernel.org>; Tue, 07 Jul 2009 12:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=tQOPoJKrZu7aTx1r9cX0IsGnecXlQzmNNIbgMVURKCo=;
        b=HGuvzNiO9k/HuYdGFKYAjx4Q5T0ylV0wrElz8Rtl0uY0U9NGwHu7yTKgfHWEhOqy++
         qvDdiGMhGxSNpVEQGQHKdK4jfWexlX3k/pZ5AorZV+/ULXPQDSNVYcij4Bab/MSYb5Du
         dP8N9/iDvkmgtqjjvHBEKI7VA7bZv+0HUuBIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=WcH6PP0876nQQfnI0P6IPNhF38DZp9cw/iIXZ/nN1+NEVdlWwxIzbrHOxWxI5iLEOZ
         TuWid27Ohh31kEXDNsCBVJeutixQUswibBMU2j0TGwjgZEZa+RCRCygKeVPke+yAOD6c
         3O4OpVF66mikUfFwIfMW964aZC4b9/Me9DQeI=
Received: by 10.100.107.17 with SMTP id f17mr11012574anc.82.1246993568512; 
	Tue, 07 Jul 2009 12:06:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122858>

I've been writing an importer for a one-off version control system, so
I can import from that version control into git.

So far, I'm pretty pleased with the results, but I'm running into
problems with incremental updates.  I have to be able to continually
pull updates (as the one-off system is still in use), so being able to
grab only the "new" commits is important.

My importer is able to grab just the "new" commit information, and
write it to a file that 'git fast-import' can read.  However, I'm
running into the following problem:

warning: Not updating refs/heads/foo (new tip
aae6a85831127a2b5bef957af81f2b127d98ee6c does not contain
486cb1a4f683da43a72932b3e40c3999bcf3728b)stout6

Which I took to mean that as my commit didn't have the previous
commit, it was failing.  So I modified my importer so that it would
include the "last" known commit (to git), and then had everything new.
 I received the same error (with different SHA1s, as I recall...)

When I was looking at the man page for git-fast-import (and looking at
the output of git-fast-export for a valid git repo), I noted the
"from" directive.  There's a clip there that tells me that "Omitting
the from command on existing branches is usually desired, as the
current commit on that branch is automatically assumed to be the first
ancestor of the new commit."

I double-checked, and the first commit in the files I'm generating
(for incremental updates, at least) does not have the 'from'
directive.

So what do I need to do in order to get git to attach the incremental
update I have to the existing repository?
