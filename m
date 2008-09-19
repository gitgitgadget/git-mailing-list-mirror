From: "Elijah Newren" <newren@gmail.com>
Subject: [BUG?]: unpack-file behavior for blobs corresponding to symlinks
Date: Fri, 19 Sep 2008 08:31:39 -0600
Message-ID: <51419b2c0809190731j5a77b8ccmba2feecb9c44cc1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 19 16:32:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kgh2R-00069H-AO
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 16:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258AbYISObl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 10:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbYISObl
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 10:31:41 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:58833 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbYISObk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 10:31:40 -0400
Received: by wf-out-1314.google.com with SMTP id 27so495876wfd.4
        for <git@vger.kernel.org>; Fri, 19 Sep 2008 07:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=KyQMzJiiPacjMgsTTXKUk8d1NyKDNMjOshx59xNDxCY=;
        b=fT93qzvZuHZX7oZ3T92NnzUXwZt5rKAo3Br4ditXqYMzNKfa7vEY8rlUphrSi1pb97
         W/T7lf0942d1CXaEc1M2ptQuCKZKEy5nzS3QYKZ70SCTJ7204vT2JjDXO/UhgM2NP/M+
         C/LKfX1Lx4miO7NIAorsNDShI5UkWzGYDF1XM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=RCNyX+c9I8ZRGJyh9nFCd5/CLov2h+NW2Bfm8gIpyPOFhIH9/K3ILdhd2zRdHw3jOO
         o2kc2bTLVkQtQM0py5pB22TBdntFnc+TLJfsVJib6fOLJO1wW2CHJQ0E5w22qxqDrMSq
         biI13UC0ODRz3ERus5SFSR4KiAANYOExUqCfE=
Received: by 10.140.126.14 with SMTP id y14mr80468rvc.160.1221834700026;
        Fri, 19 Sep 2008 07:31:40 -0700 (PDT)
Received: by 10.141.163.16 with HTTP; Fri, 19 Sep 2008 07:31:39 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96291>

Hi,

unpack-file doesn't create symlinks as I'd expect.  I'm not sure if
this is a bug in unpack-file, or in my expectations.

To reproduce:

$ git init
Initialized empty Git repository in /home/newren/testing/.git/
$ echo bla > bar
$ ln -s bar foo
$ git add bar foo
$ git ls-files -s foo
120000 ba0e162e1c47469e3fe4b393a8bf8c569f302116 0       foo
$ git unpack-file ba0e162e1c47469e3fe4b393a8bf8c569f302116
.merge_file_J1hTaV
$ ls -l foo .merge_file_J1hTaV
lrwxrwxrwx  1 enewren enewren 3 Sep 19 08:22 foo -> bar
-rw-------  1 enewren enewren 3 Sep 19 08:23 .merge_file_J1hTaV
$ echo $(cat .merge_file_J1hTaV)
bar

Why is .merge_file_J1hTaV a regular file instead of a symlink?  Is
there an alternative command I can use that would create a symlink to
bar given the information I have from the git ls-files command (and
which also works for creating normal files and other special file
types)?

Thanks,
Elijah
