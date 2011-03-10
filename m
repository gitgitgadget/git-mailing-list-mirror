From: Adam Monsen <haircut@gmail.com>
Subject: idea: pruning stale tags
Date: Thu, 10 Mar 2011 09:10:48 -0800
Message-ID: <4D790618.9000302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 18:11:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxjOB-0003ZR-4h
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 18:11:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606Ab1CJRK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 12:10:58 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44155 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240Ab1CJRK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 12:10:57 -0500
Received: by qwd7 with SMTP id 7so1393252qwd.19
        for <git@vger.kernel.org>; Thu, 10 Mar 2011 09:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :subject:x-enigmail-version:content-type:content-transfer-encoding;
        bh=iDpap+rz106wiyr0mNgmN+L5iq6joP0AlrtUZSsAZ4g=;
        b=HhSCNAnQyXzEH7o0X77ii0Jw1HPur53bRRPKBMDncajgwP+gN1OMLrAc2Rc0aXStdw
         R+5pudRjKIGpLLZKRsjdZNwn35fyUOoHrbRk4HyjxhAZ6RHAcUXeHwMTVznANxvaCyCW
         XnqWisNMnwRqapzfX/03zZ3p3FyRYNhhFAGns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type:content-transfer-encoding;
        b=urV9dmc1MGHYM1FdyheQis9u/yAj6MH3Y+vHq8xTVJU7igUILN1vmLEoTdxrxy6vK9
         nq5Vw/Z8yQubcPohg1T0AbYFP6Od0OtavBtbbHOwHcSM1qu4MRIKTf4JZkCB2rtwAr1X
         2HoqPallnpPCM3KbOjysNIoLPA86MVUzSdRzU=
Received: by 10.52.94.48 with SMTP id cz16mr8542218vdb.173.1299777056693;
        Thu, 10 Mar 2011 09:10:56 -0800 (PST)
Received: from [192.168.13.8] (c-67-183-136-182.hsd1.wa.comcast.net [67.183.136.182])
        by mx.google.com with ESMTPS id bo7sm653824vdb.23.2011.03.10.09.10.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Mar 2011 09:10:55 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.15) Gecko/20110303 Lightning/1.0b2 Thunderbird/3.1.9
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168833>

My idea is to add functionality to git-remote to prune stale tags
(those which no longer exist on the remote). Add a new ui:

git remote prune --tags [-n | --dry-run] <name> [<remote>]

I think it is not possible to know which remote tags originated
from, yes? That's why I suggested adding the [<remote>] parameter;
one would be required to specify the remote to sync with if more
than one remote is configured.

Potential use cases:

* tags change from time to time
* accidentally push a tag with the wrong name
* accidentally push a tag with secret information
* tag naming convention changes (1.0, 1.1, 2.0 -> v1.0, v1.1, v2.0)

...and someone else pulled these "bad" tags, someone that may need
to do "git push --tags" sometime in the future.

The only workaround I'm aware of in this situation is to try to
alert everyone with clones who may eventually need to run "git push
--tags" to manually delete specific tags from their clones.

I acknowledge that the use cases are probably contrived/uncommon.
Yes, tags are meant to be forever. But mistakes happen, and maybe
not everyone uses tags the way they were anticipated to be used.

Maybe there's already a suitable workaround better than asking
everyone to manually delete tags? If so, please let me know. I'd
rather do that than advocate adding more complexity to git.

Here is a *little* evidence that I'm not the only one with this
silly idea. Here's a thread on stackoverflow covering the first
use case above (tags change from time to time):

http://stackoverflow.com/questions/1841341/git-remove-local-tags-that-are-no-longer-on-the-remote-repository

And these look like custom scripts to "sync" local tags with those
on a remote:

https://github.com/kigster/git_scripts/blob/master/bin/git-sync-local-tags
https://gist.github.com/345031

Thoughts?
