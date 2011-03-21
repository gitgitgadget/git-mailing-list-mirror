From: Trevor Harmon <trevor@vocaro.com>
Subject: remote.origin.*pack settings are not honored when repository is specified
Date: Mon, 21 Mar 2011 11:31:06 -0700
Message-ID: <982706A6-A00E-43B3-9002-41C8DC084EC9@vocaro.com>
Mime-Version: 1.0 (Apple Message framework v1082.1)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 19:31:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1jtE-0003hu-Tk
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 19:31:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866Ab1CUSbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 14:31:36 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:42179 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab1CUSbf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 14:31:35 -0400
Received: from homiemail-a21.g.dreamhost.com (caiajhbdcaib.dreamhost.com [208.97.132.81])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 7AF1017CA2D
	for <git@vger.kernel.org>; Mon, 21 Mar 2011 11:31:34 -0700 (PDT)
Received: from homiemail-a21.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a21.g.dreamhost.com (Postfix) with ESMTP id 3F4EA300079
	for <git@vger.kernel.org>; Mon, 21 Mar 2011 11:30:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; c=nofws; d=vocaro.com; h=from:content-type
	:content-transfer-encoding:subject:date:message-id:to:
	mime-version; q=dns; s=vocaro.com; b=LGVN108yeT5zss55xyaMaVd7gDm
	qYLfZE3662sTePzBMRc00NC2Fq1ArixhSAy5Ia8AbkEgvCa9oBKaxXBuw9o3A51T
	/CJgwgS5UWUcGbi2hQ0K5EMLgkwC5SKPttBY2P/ahWHzlRs9kE2C07km0U79X1Fk
	SosEIl1bdjGQut84=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=vocaro.com; h=from
	:content-type:content-transfer-encoding:subject:date:message-id
	:to:mime-version; s=vocaro.com; bh=yWYXqkkxuQXbPvZHHTMlgUbe5VU=;
	 b=eeVb22ynaBdMgAa/WUomAy8CtLCh2cQIyoO3eWbdMPsWbM53/1mUK6XS6Kw+o
	1h+oDWFxWpuwHtqhH1NHDs/UtmATO7WR+pWbxkrdb1NFiQt3U9mUQ/+e0qkWysjd
	U+Jt3kYcWtVUilZTpbeH/QhMnIxMyUTDjbER9CRkXiU77Y=
Received: from [10.244.200.81] (outbound4.ebay.com [216.113.168.128])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: trevor@vocaro.com)
	by homiemail-a21.g.dreamhost.com (Postfix) with ESMTPSA id 23E4F300061
	for <git@vger.kernel.org>; Mon, 21 Mar 2011 11:30:51 -0700 (PDT)
X-Mailer: Apple Mail (2.1082.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169636>

Hi,

I'm trying to set up a remote repository on a shared hosting provider. The provider doesn't have Git on their system, so I installed it to a custom location: ~/opt. That should be sufficient to allow external clients to use the repository, but there's a snag: The provider prevents users from modifying the PATH variable for non-interactive shells, which means I can't add ~/opt/bin to the server's PATH for SSH sessions. As a result, users who attempt to clone the repository get an error:

  bash: git-upload-pack: command not found

Luckily, users can work around this issue by providing Git with the command's location:

  git clone -u /home/[user]/opt/bin/git-upload-pack [repository]

but a subsequent "git pull" on the working copy also fails for the same reason, though that's also easily remedied:

  git config remote.origin.uploadpack '/home/[user]/opt/bin/git-upload-pack'

However, there's one last problem I can't find a workaround for... Specifying the repository explicitly when doing a "git pull", such as:

  git pull someguy@somewhere.com:git/some-repository.git

still gives a "git-upload-pack: command not found" error. It seems that Git isn't honoring the remote.origin.uploadpack value here. This is a problem because I'm using a third-party automated tool for handling pushes, and it's hard-coded to always specify the repository in the command (as opposed to the default from the remotes list).

Is this a bug in Git? Thanks,

Trevor
