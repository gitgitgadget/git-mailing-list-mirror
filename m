From: Maximilian Mehnert <maximilian.mehnert@googlemail.com>
Subject: suggestion? only pull cleanly applying commits
Date: Wed, 26 Nov 2008 12:48:50 +0100
Message-ID: <492D37A2.4010500@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 26 12:50:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5Iux-0002UE-DC
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 12:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbYKZLtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 06:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbYKZLtf
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 06:49:35 -0500
Received: from mail-ausfall.charite.de ([193.175.70.131]:41937 "EHLO
	mail-ausfall.charite.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914AbYKZLtf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 06:49:35 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail-ausfall.charite.de (Postfix) with ESMTP id 018A33DB74
	for <git@vger.kernel.org>; Wed, 26 Nov 2008 12:49:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at charite.de
Received: from mail-ausfall.charite.de ([127.0.0.1])
	by localhost (mail-ausfall.charite.de [127.0.0.1]) (amavisd-new, port 10025)
	with ESMTP id uDENJVVotHK6 for <git@vger.kernel.org>;
	Wed, 26 Nov 2008 12:49:33 +0100 (CET)
Received: from postamt.charite.de (postamt.charite.de [141.42.4.250])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail-ausfall.charite.de (Postfix) with ESMTPS
	for <git@vger.kernel.org>; Wed, 26 Nov 2008 12:49:33 +0100 (CET)
Received: from [10.129.103.228] (unknown [92.116.103.228])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by postamt.charite.de (Postfix) with ESMTPSA id 59EA7B2C68
	for <git@vger.kernel.org>; Wed, 26 Nov 2008 12:49:29 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1b2pre) Gecko/20081119 Mnenhy/0.7.6.0
X-Enigmail-Version: 0.96a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101726>

Hi!

I've a scenario where I don't really want to do a full merge but rather
to pull all commits from another repository that merge without conflicts.

I've put together the script at the bottom which seems to work ok but is
damn slow.

Is there a smarter and faster way to do this that I missed reading the
documentation?

Any help would be really appreciated! :-)

Regards,
Maximilian


#!/bin/sh

for commit in `git rev-list --reverse HEAD..other-repository/master`; do
        git diff-tree -p $commit|patch --dry-run -p1 -N -f >/dev/null
        if [ $? -eq 0 ]; then
                echo "getting $commit"
                parents=`git rev-list --parents -n1  $commit|wc -w`
                if [ $parents -eq 2 ]; then
                        git cherry-pick $commit
                else
                        git cherry-pick -m1 $commit
                fi
        fi
done
