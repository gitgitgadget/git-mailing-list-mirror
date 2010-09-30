From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH 2/3] grep: prepare grep for submodules
Date: Thu, 30 Sep 2010 11:10:11 +1000
Message-ID: <AANLkTik3bvJneak9gjG8O1A=LZeivPkFc6MF5_T7nbWo@mail.gmail.com>
References: <1285792134-26339-1-git-send-email-judge.packham@gmail.com>
	<1285792134-26339-3-git-send-email-judge.packham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Jens.Lehmann" <Jens.Lehmann@web.de>, git <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 03:11:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P17fx-0004el-Bj
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 03:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903Ab0I3BKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 21:10:50 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:61450 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719Ab0I3BKu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 21:10:50 -0400
Received: by wwi17 with SMTP id 17so69565wwi.1
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 18:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=lhnDwFd6zWxQ7naV5TKFAkB63WnBc+YeMDbHNFN/rYU=;
        b=xGAh0WKzXaC2rVm2gZdqKJBy2nCmBlhqEuzmQV0QpKwfgI76A9qOpLzU9WzEkfT96+
         RuuqTHnwCwrbvr03UhF9Tzdm+T8utwzMqsS9HE3R+lVLZiWG+kcgJVNe9nlR3U7vd0ik
         sEkQmjtoU4D3Rpr96/Iivz00ivziJhHPoblJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=M5SLwconq5o6EcrL5WjMhAl4MEeMKNazqYYdKisRkk7kZd34cwp0rynp7IukQguRg/
         CnF0OEtBtzlUZMqA+tNzKJ99rEJb4PGPB4mRvX4ye1UrYMttccb7PGb94jVMSLnh33if
         RHQLYaXamtAxoSewRR2dBPZ14Y4JxfbKvx4i8=
Received: by 10.216.210.206 with SMTP id u56mr3306360weo.23.1285809011526;
 Wed, 29 Sep 2010 18:10:11 -0700 (PDT)
Received: by 10.216.153.195 with HTTP; Wed, 29 Sep 2010 18:10:11 -0700 (PDT)
In-Reply-To: <1285792134-26339-3-git-send-email-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157625>

On Thu, Sep 30, 2010 at 6:28 AM, Chris Packham <judge.packham@gmail.com> wrote:
> Add --submodule-prefix option to pass to subprocess grep invocations. The
> prefix is then used when outputting the results.

I haven't followed the recursive submodule support in Git lately. But
I think --submodule-prefix is unnecessary. I would imagine you need to
add --submodule-prefix to a lot more commands as they support recusive
submodule search. There is a corner case in Git's prefix setup that we
can utilize to avoid the new option.

If you do this at the superproject repo:

$ GIT_DIR=path/to/submodule/.git GIT_WORK_TREE=path/to/submodule git grep blah

I would expect that it shows the result correctly (i.e. all files
prefixed by "path/to/submodule"), but it does not right now. If you
make that setup work, then you don't need --submodule-prefix, just set
GIT_DIR/GIT_WORK_TREE properly and run "git grep".

You can make setup_explicit_git_dir() realize that situation (current
working directory outside $GIT_WORK_TREE), then calculate and save the
submodule prefix in startup_info struct. Then "git grep" or any
commands can just read startup_info to find out the submodule prefix.
-- 
Duy
