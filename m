From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Why do dates in refspecs require the reflog?
Date: Tue, 30 Dec 2014 14:12:15 -0600
Message-ID: <CAHd499Cvy=zi=9utoZ2bEgdSUTjkveHMP2OvVFPBHq7W2MuoZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 30 21:12:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y639V-0000nC-HR
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 21:12:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbaL3UMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 15:12:18 -0500
Received: from mail-lb0-f176.google.com ([209.85.217.176]:34690 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbaL3UMR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 15:12:17 -0500
Received: by mail-lb0-f176.google.com with SMTP id p9so12492300lbv.21
        for <git@vger.kernel.org>; Tue, 30 Dec 2014 12:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=3BPfDPzK+myiyW3h9uB6s143uAN1GBTJMf0W2Hd+Uyg=;
        b=hXqZ/C2xrrF1IuMDDAJ5wk5Q9c9P0oPghr45w5YSAItHGDpPWxvRHViXJUc+JJ7+v0
         ttj8uuWVOnBL3MlSqVdR38p12jcJgHcV2F57ThUGhuMAXF353TCBzKJu5iOFAZe0Crff
         H0tWRokyHywgVbjzrmf/6M5ZQkrx4COCrTk9eB/Pe9E3Hu/2OimJGVmAmiopPSRnluOF
         2dhBLkQW9ljhiIDkDqH66vLWk13HKqtblL+gz0ZpqPv4pVrQ3t58Qp9xDIcX669z5O0A
         6NadQrMKpj4BrdrJ+WEIwgxRhsFpjAgKfWJepct6mEBfcZjHDqQxc3StDTwXHot5k5r0
         fJKA==
X-Received: by 10.112.14.6 with SMTP id l6mr64143116lbc.91.1419970335331; Tue,
 30 Dec 2014 12:12:15 -0800 (PST)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.114.185.67 with HTTP; Tue, 30 Dec 2014 12:12:15 -0800 (PST)
X-Google-Sender-Auth: RnK7u36BLZgV6EjWTe-HH-_8488
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261938>

I was surprised to find today that the following didn't work as expected:

$ git show master@{"1 year ago"}:Path/To/File.h

It gave me the following warning which did not make the problem obvious at all:
warning: Log for 'master' only goes back to Mon, 8 Sep 2014 12:08:44 -0500.

What it is trying to tell me (and I only found this out after a lot of
poking and prodding around Google) is that I can't refer to a commit
by date if it extends beyond the range of the reflog.

I don't understand why this requirement is in place. Each commit has a
time stamp, so in theory it should be possible to calculate an
absolute date from the duration specified in the refspec and grab the
commit from `git log` from that.

I can only assume I'm oversimplifying things and that there is a good
reason for this. If I can't get this to work, how can I view the
contents of a file at a specified relative time frame as I have done
above?
