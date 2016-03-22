From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: git-apply does not work in a sub-directory of a Git repository
Date: Tue, 22 Mar 2016 17:40:17 +0530
Message-ID: <CA+DCAeQQQH59Lb43Y4Bi1xktPNoODV11KkUBbKNG1OZ7mDb-UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 22 13:12:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiL8i-0001bU-Mu
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 13:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783AbcCVMKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 08:10:20 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:33227 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085AbcCVMKS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 08:10:18 -0400
Received: by mail-qg0-f53.google.com with SMTP id 51so10592646qgy.0
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 05:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=iVBpRmQPUxTAV9uEpl+XIGc1NiT2fNmF4hk41UMnngk=;
        b=KQQngKB0rYCS2FCu4LbjgfW2MuzXzCW7TryY2eSNTbg+B3fv4JXCdg+eaDVx6Co2qx
         MwwYZduQ3U244NqvPA3g71OVJVcxlGDELxntAuVCBX1dIHDFpQoCQAsCI20qMR2yAyy8
         2Dcn1yD4XUlmSgIh0a5GLEWXflYzlx6tIiGR30JTo1FJF51VnI4G2OA2qZ4i78ShUzpk
         +IsJf5r6g4+qHqVlQB6rDQyAgJs7tMo6koj0L1oVertwsv9CTQJGl/UQ1TEDPOYTO+x9
         dmV2ZkZG3sLT6pwox4hDupuhGJIicP0/z6kfKIaWLTsHgAT+29pNUgsYhfJ+FrLbOiZ3
         eYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=iVBpRmQPUxTAV9uEpl+XIGc1NiT2fNmF4hk41UMnngk=;
        b=lutVQyAC51q5aoh9Kh7JbwzNMHD/FCkK9Yvix3fsmjjtkje4E9ExApKvE/y9v05p2L
         Ln4I/wK9klcV254PUptbpVgbNXn7ANdyLoL6VDYGcR5DavYJ6wezenl2x7y0Tt/OqAFv
         tX/0b9VChFyyoXDc66DER3fxOBS2GtI5zye1Q1F4oJIZm595Z9OLlaepiTaY3Jnt1FjK
         kfZBQU2ioaL7K8wLYjpOG/FnTjxs+5UF0+CRfE1nD8mT2LqfQ8ZjL1h/zDuOQXI+knTQ
         4oxx2vWwGQfUql69V85CaqugTqzp6Zmjss33+1jX4xr49JC365rPFULJ/bN7CxG9mXms
         ccnw==
X-Gm-Message-State: AD7BkJJAGB69SlkqyQTt7ISL8+trrQ0NLvFPKflIxDIy+sQt7uLnsfHWbwauSdSN0sH7ofVsRVeeHolKnVNCEg==
X-Received: by 10.140.20.197 with SMTP id 63mr45974538qgj.18.1458648617115;
 Tue, 22 Mar 2016 05:10:17 -0700 (PDT)
Received: by 10.55.188.7 with HTTP; Tue, 22 Mar 2016 05:10:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289504>

Hello everyone,

Recently while using git-apply, I observed that if git-apply is used in a
sub-directory of a Git repository then it silently dies without doing
anything.

Here's what I did

~ $mkdir example
~ $cd example
example $git init
Initialized empty Git repository in /home/mj/example/.git/
example $echo main >main
example $git add main
example $git commit -m 'main'
[master (root-commit) 97aeda3] main
 1 file changed, 1 insertion(+)
 create mode 100644 main
example $git checkout -b feature
Switched to a new branch 'feature'
example $echo modified >main
example $git add main
example $git commit -m 'modified'
[feature 2551fa2] modified
 1 file changed, 1 insertion(+), 1 deletion(-)
example $mkdir outgoing
example $git diff master >outgoing/feature.patch
example $git checkout master
Switched to branch 'master'
example $cd outgoing/
outgoing $git apply feature.patch
outgoing $cd ..
example $cat main
main

As you observed, patch wasn't applied. Is it intended behaviour of
git-apply? Usually to apply the patch I have to copy it to top directory
and then use git-apply.

I tried out git-am to apply the patch ("git format-patch" was used to
make patch) while being in the "outgoing" sub-directory and it worked
fine. So why does git-apply show this kind of behaviour?

Thanks,
Mehul
