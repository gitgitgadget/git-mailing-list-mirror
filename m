From: Peter Weseloh <peter.weseloh@googlemail.com>
Subject: Can 'git push' reset refs of the 'from' repo?
Date: Sat, 18 Sep 2010 17:46:27 +0200
Message-ID: <AANLkTi=H=1Ako5pbfmxU-s7XvgrzSc37gPJMzxi283de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 18 17:46:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Owzcl-0003hM-Ln
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 17:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008Ab0IRPq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 11:46:29 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46986 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421Ab0IRPq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 11:46:29 -0400
Received: by eyb6 with SMTP id 6so1275803eyb.19
        for <git@vger.kernel.org>; Sat, 18 Sep 2010 08:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=RC63MH7ce0FOyd0eAa/4kpbC4vGh4RJ+qvnbKynmXLw=;
        b=qLJWViV9H6dS8qGmyTI0aqsbwVEI5uQ7zmlDUchXaSb2f6dbkv/o0CzK72q5BsZJ91
         3Rgxe2irt1Ksa76K8NcKh3F/7vheFLtW3ufTWixJ9d3OnzX9YQq0y4gHszOQPg+tB0Pz
         IuUIH01znnjMqUNrcr2ev7BTvk/JaLNxVof6s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Gwmp+h8j4sLFsaPrv+3c6+Pm83Ui/5L7H+Fu8oUJgp6LTpAQgpCN/FRFgNq+waAvni
         F1lKk8HEYnk0w23f7ZRogqLh1mlXVONX71lcw4vGC0h20raBKC8SyusUt6/SzuU+tsuj
         GpGJi7+GxrmxA9wH08uGzBPwjPR9rtb8vgpiM=
Received: by 10.213.10.198 with SMTP id q6mr5209430ebq.8.1284824787487; Sat,
 18 Sep 2010 08:46:27 -0700 (PDT)
Received: by 10.14.121.142 with HTTP; Sat, 18 Sep 2010 08:46:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156462>

Hi,

Since a few days we have a very strange problem with our (bare)
central git repo.
Every night some refs in refs/heads get reset to older CSs.
It is not clear why that happens. The repo has the config
'receive.denyNonFastForwards = true' so it cannot be due to a push to
the central repo, right?
I also don't think that someone does a 'git reset' or something
directly on the central repo.

Today it happened again and luckily no new changes were pushed to the
central repo after the event so I inspected the files in refs/heads.

The modification time and owner of the "tampered" refs seam to
indicate that it was a cron job that changed them.
The cron job does a 'git --git-dir=<path_to_central_repo> push foo' to
update a remote repo 'foo' which was added to the central repo with
'git remote add --mirror foo ssh://<host>/<path_to_foo>'.
This setup was working well for quite a while.

Is it possible that the 'git push' changes refs in the central repo,
i.e. the 'from' repo?

Another interesting information might be that I now also get an email
from the cron job every night:
yp_all: clnt_call: RPC: Unable to receive; errno = Connection reset by peer

That started at the same night I first saw the reset of the refs.
I now replaced that cron job with another one running on the remote
host that does a ''git remote update --prune" on the remote repo.
Hopefully that resolves the problem.

Any feedback on what might be going on is highly appreciated.

Oh, the OS is Linux (RHEL4.8) and the git version is 1.7.0

Thanks in advance,
Peter
