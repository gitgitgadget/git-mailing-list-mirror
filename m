From: Stephen Boyd <bebarino@gmail.com>
Subject: bash completion on 4.0 broken?
Date: Mon, 16 Nov 2009 22:46:31 -0800
Message-ID: <4B0246C7.6020401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 17 07:46:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAHq1-0005nO-7c
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 07:46:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755431AbZKQGqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 01:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755341AbZKQGqa
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 01:46:30 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:61579 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442AbZKQGq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 01:46:29 -0500
Received: by ywh40 with SMTP id 40so3845053ywh.33
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 22:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=XkpX60wQfXtuWEj8+R+URUsLWYW8YEGEYFnBF2YZt7I=;
        b=qJqXk9P+v+K7PG3xOC3J1Xqr21+g9m57w8LEWr9xj9qZzAMymHQ5Hk+do6By1gOSZz
         pEUxXzboExVGUH1ViDQLSGUtIUvaILa4fA95/GaQCeOZ7PN1MKlM+KGwKzFr/j8SRLLH
         gw+gBe6hNwytZpim8idRGpANgweSI3aGgxoQw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=awggCNX++oNyGZmHffhygPzvyAqMzrw0QJ+MPbudsk85RlbFmnE2CbThMx9VI6xgtM
         bmFWlswvTHEszsJXY7JKbfKDKXl+Ly7hTr/dH0k/XG6I5QNeAMroGMvffOwBKN3BhM8p
         T/jZd3wDyk/jGSQphJZNuOT0NSAdZ34oiKOfc=
Received: by 10.150.239.1 with SMTP id m1mr15429766ybh.152.1258440394885;
        Mon, 16 Nov 2009 22:46:34 -0800 (PST)
Received: from ?192.168.0.5? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 5sm1643758ywd.8.2009.11.16.22.46.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Nov 2009 22:46:34 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20091026)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133067>

When I try

    git show --pretty=<TAB><TAB>

I get a list of filenames and not the list of pretty formats.

I've debugged a little and see that the cur variable in _git_show () is 
set to '=' when it should be '--pretty='. So it looks like something is 
causing the command line to be split weirdly. Looking at the bash 
NEWS[1] for 4.0 I see

i.  The programmable completion code now uses the same set of characters as
    readline when breaking the command line into a list of words.


which causes me to believe this is why it's broken now. I've tried 
removing '=' from COMP_WORDBREAKS and that shows the list of formats 
correctly, but then causes the entire '--pretty=' to be replaced with 
the selected format.

Anyone else seeing the same problem or is my system just b0rked?

$ bash --version
GNU bash, version 4.0.35(2)-release (x86_64-pc-linux-gnu)

References:
[1] http://tiswww.case.edu/php/chet/bash/NEWS
