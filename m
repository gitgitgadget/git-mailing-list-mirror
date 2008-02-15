From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: diff --check line number bug
Date: Fri, 15 Feb 2008 15:18:45 -0500
Message-ID: <76718490802151218s62c4f884u39353b66540b347a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 15 21:19:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ71x-0005TB-9N
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 21:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760636AbYBOUSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 15:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759796AbYBOUSu
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 15:18:50 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:44906 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763278AbYBOUSs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 15:18:48 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1337435wah.23
        for <git@vger.kernel.org>; Fri, 15 Feb 2008 12:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=d2SJiJee0ljRDJjdcybDuo4CwlM9+2ccO/WUamXU9E4=;
        b=cn2pMZlNjJJaUvN+6G6fe4+LXWAhbKKsI4twPG/9HG4Nu2ZLei7mU3xIc9bGn5REoZiF7AL3EjVO+G9KA8LiUoEJmZGpkWg7xUuYFEuKNkmTFXuHEa1cJJbDjCAsN6Dyz/g/msGqrWUKZtqNqqptKsLD5UimwDs85k6Seswn97Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eQmQfZlDCDXtgB+BH9es/O/2b/z+sDHbKNFtLiTs9iJLXuD52hUlVD3qSK0rosDjHgd/LNkYVQ/DW9XOYtA/7jL7c5TWNaq+hxHMKTPU92BYIhw5oJkkH71O/TAi+NVlxIjRN3HF7FA1x5TTb0BJYnyXwcS9X7aQObGOvi3i2NM=
Received: by 10.114.61.1 with SMTP id j1mr3411619waa.62.1203106725821;
        Fri, 15 Feb 2008 12:18:45 -0800 (PST)
Received: by 10.114.255.11 with HTTP; Fri, 15 Feb 2008 12:18:45 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73980>

% mkdir git-ws
% cd git-ws
% git init
% touch foo
% git add foo
% printf '\n\nline 3 \n\nline 5 \nline 6\n' > foo
% cat -n foo
     1	
     2	
     3	line 3
     4	
     5	line 5
     6	line 6
% sed -ne l foo
$
$
line 3 $
$
line 5 $
line 6$
% git diff --check foo
foo:1: trailing whitespace.
+line 3
foo:2: trailing whitespace.
+line 5
% git version
git version 1.5.4.1.1281.g75df

Apparently somewhere in the bowels of the "Crazy xdl interfaces", empty
lines are skipped over, thus the line number counting in
checkdiff_consume() is off? I dunno, I briefly looked into fixing it but
it didn't seem like a quick fix.

j.
