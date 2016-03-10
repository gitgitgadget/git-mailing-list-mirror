From: Nicola Paolucci <npaolucci@atlassian.com>
Subject: [PATCH 0/3] subtree: add 'git-subtree-repo' and list command
Date: Thu, 10 Mar 2016 10:44:09 +0100
Message-ID: <1457603052-53963-1-git-send-email-npaolucci@atlassian.com>
Cc: Dave <davidw@realtimegenomics.com>,
	"David A . Greene" <greened@obbligato.org>,
	Mathias Nyman <mathias.nyman@iki.fi>,
	Nicola Paolucci <npaolucci@atlassian.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 10:45:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adx9f-0001oY-3c
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 10:45:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681AbcCJJpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 04:45:06 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37634 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754555AbcCJJpB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 04:45:01 -0500
Received: by mail-wm0-f50.google.com with SMTP id p65so20662544wmp.0
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 01:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=rekh7De1+f1H2kQp+dlT7VqwYbtx12MyqREz6G3Ziec=;
        b=0Iy6VCsIsCNiQ2N9CPTIfv2NGoYWP5Kx0RVQkYVyTpqXbUqecg+LauwBZLjqs6Sw7H
         Ryjw5pMk4tT+SYeuGZl+TwsjzrmWrDDhf1vHT5dyLJu0QcO3hWn9Tz5qtLAgnB/PiN2X
         MOiMSNiA6ASBb4Ru+byD8C3AQMP0vYLeUakjgP8zKDUXcV6f6gXjsBmqY3TouU5J4nVz
         J4uS0xR5K1kuR77D19hNz6Du3xbq2pri+2nAO7j878dFhPcK2f/ulEkr8k0yZEJthNmP
         o3vkzxWmr3EfOP6Nnia5JORvsPCsHMtblF1DUqfvcg6nwVIab0Ck0+mAHtT8gr4vy4Bh
         Criw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rekh7De1+f1H2kQp+dlT7VqwYbtx12MyqREz6G3Ziec=;
        b=dOTqn9v8yMs6RR32d1jhWD2R/ztaOua8L9pwAwp8eV5KhpNDksiwMQqy+ptvaOo52b
         iRnCqBHl0ZywkMQXffYIvqOM++gxw6gb1jO/D8hm+ttxS8ByogH457t0IruQvaN7hc19
         2fvRj+llEPuT63lLsIviQfBhTSdN4YI/wYg+6KVZ/CGQqfD7LXFLlkoVhP9AmLvbPnTB
         Y7AeI+QFIZhEEbZqnkMGQB7N+EtjMXsHHzQA77oY1MTtWSK/eAfyViElyAjBU6IUk3PN
         FjXiS1bPY8sFEh7Nyn4NbsWiYi2HdXetr5XS6bTerbE7iHa+BrOLMsBUbptAvkoMgtfj
         VdwA==
X-Gm-Message-State: AD7BkJKbv0UC7akcJfHjXeP8pgnRiSHkPDZ0amUIMQhXJm5rKLtqV4z5bbxc3fbM35+Ely0c
X-Received: by 10.194.114.166 with SMTP id jh6mr2624810wjb.39.1457603100357;
        Thu, 10 Mar 2016 01:45:00 -0800 (PST)
Received: from reborn.ams.atlassian.com ([46.243.25.78])
        by smtp.gmail.com with ESMTPSA id q139sm2684747wmd.2.2016.03.10.01.44.59
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 10 Mar 2016 01:44:59 -0800 (PST)
X-Mailer: git-send-email 2.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288606>

To my knowledge 'git subtree' currently lacks a way to
track where injected repositories come from originally.
Adding this information allows for useful extensions to 
the command and makes it easier to use subtrees to track
external dependencies.

In this patch series I propose to add a 'git-subtree-repo'
line to the meta-data stored when injecting a tree
in a repository with 'git subtree add'. The result looks 
like this:

    git-subtree-dir: .vim/bundle/fireplace
    git-subtree-split: b999b09cd9d69f359fa5668e81b09dcfde455cca
    git-subtree-repo: https://repo/user/vim-fireplace.git

Thanks a lot to Mathias Nyman who has cleaned up my idea to
add 'git-subtree-repo' and already submitted it for review.
I added a test and a tiny fix to his patch and I resend it 
here (hence the v3 in the first patch).

Using this extra value a simple 'git subtree list' command can 
be implemented which scans the checked out branch for subtrees
injected:

    $ git subtree list
    .vim/bundle/fireplace https://github.com/tpope/vim-fireplace.git b999b0

I also added an optional '--resolve' flag to retrieve symbolic
remote refs associated with the commit ids of the remote repository:

    $ git-subtree.sh list --resolve
    
    vim-airline  https://repo/bling/vim-airline.git 4fa37e5e[...]
    vim-airline  https://repo/bling/vim-airline.git HEAD
    vim-airline  https://repo/bling/vim-airline.git refs/heads/master


Nicola Paolucci (3):
  contrib/subtree: 'add' stores 'git-subtree-repo'
  contrib/subtree: new list command to list subtrees
  contrib/subtree: list --resolve gets symbolic refs

 contrib/subtree/git-subtree.sh     | 140 +++++++++++++++++++++++++++++--------
 contrib/subtree/git-subtree.txt    |  31 ++++++++
 contrib/subtree/t/t7900-subtree.sh |  63 +++++++++++++++++
 3 files changed, 205 insertions(+), 29 deletions(-)

-- 
2.7.1
