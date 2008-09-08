From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: fast-import issues with monotone
Date: Tue, 9 Sep 2008 01:30:39 +0300
Message-ID: <94a0d4530809081530p60ff8692qbf9c314516d03869@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "git list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 09 00:32:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcpHJ-0004bw-HQ
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 00:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755343AbYIHWal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 18:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755330AbYIHWal
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 18:30:41 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:30164 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171AbYIHWak (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 18:30:40 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1626163rvb.1
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 15:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=MysnDsKDMQHCd5QDUlUxJB3T+1zZ8Am1cQizawPtxfk=;
        b=x1gohMDmWhDHXO9C0ZOhfqwknkZErQ2MkPh61Ang9UUoNMYzMzW+WCVtCr/Z+KOTX7
         aJLOQPK3+jWXsJy0uci5eKGuCLLzClNb4oo2L/VeWNkAUOCr0exUsfk6BDer14y42cBJ
         nMI4C7MsoDlqe8mGxmAdjw7uooa7BUWFQAuOw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=QCP1bzaLinWRLRSIS6Pac6LC77kdgHgsgq3WnRo5cIMfq0IiPNL1F2rRTTx2bbu+n9
         BwRUNCYcJTGrTBWbJVTeA7uYX94j6G8klzNvnF0vae99tmwVN7vFwk2EkpQ6ewp0Bv2Q
         UtKi68fAuvtwQJiBjmQfXxFYw3ZfKzclE7Qeo=
Received: by 10.140.226.14 with SMTP id y14mr9198587rvg.188.1220913039887;
        Mon, 08 Sep 2008 15:30:39 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Mon, 8 Sep 2008 15:30:39 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95311>

Hi,

I'm stuck with yet another issue while trying to export a mtn
repository, so I thought on sharing the list of issues:

a) directory rename/deletes are indistinguishable from files

This means directories must be tracked by the generator to find out if
the operation is on a file, or a directory. If it's in a directory
then the operation should be executed in all the files that are under
that directory.

It's possible to find out the whole tree of a revision, but it's a
*very* expensive operation (takes about a second).

b) file mode changes are just like any other operation (you don't get
the mode at each revision)

This means the file mode needs to be tracked all the time. Also, it
means the file contents (blob) needs to be tracked because sometimes
the only change in the file is the mode.

Again, retrieving the whole tree is possible, but expensive.


There are other issues, but not so important.

For these two issues the only viable solution is to keep track of the
whole tree of each revision. Does it makes sense to do that? Or would
it make more sense to modify fast-import to allow more delta-oriented
operations?

-- 
Felipe Contreras
