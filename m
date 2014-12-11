From: Florian Hassanen <florian.hassanen@gmail.com>
Subject: Re: [PATCH] git-check-ignore.txt: Clarify exit codes
Date: Fri, 12 Dec 2014 00:16:32 +0100
Message-ID: <CAMAJHBYVMy-tc_aCjyeN7=VMG=k7gjWh9evL6bcJLzYfQcf6yg@mail.gmail.com>
References: <1418323355-23935-1-git-send-email-florian.hassanen@gmail.com> <xmqqiohhdc5j.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 00:17:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzCz8-00007U-Ne
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 00:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934536AbaLKXQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2014 18:16:55 -0500
Received: from mail-lb0-f170.google.com ([209.85.217.170]:36072 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934114AbaLKXQy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2014 18:16:54 -0500
Received: by mail-lb0-f170.google.com with SMTP id 10so5072528lbg.15
        for <git@vger.kernel.org>; Thu, 11 Dec 2014 15:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6iGy/pHktmBj8rNqkzfozgg0UZTkIiA17H8sU88q6xI=;
        b=AM49SS+4KHDWN+ruKc29+z7Tbrn+uNKC80KnjUwaCAnQEwkQpTVDrfu2nXE/mcVz52
         ws8lWRRVJOQb6ZDj9jkTy7dh6vuN6Cg2kiWgiQugPpvzOkjDlJeXLJN1KYBwYn0oxZoq
         Zu3Wk2XErorYaPusio+mLN0FVa7WRdRtVzhLIBU6S6B5bY1+dbUDFF1ZipJ6e9lA4rkI
         pINPa0POLFCjTjaUbbHhJdQHlFBhe+hM5Gvm8dlvd3AKE/R8+OT5m97/FlXFP5z4hB3L
         w/MrzGx+rxieH29SEXetX2c57qqsHxFrm10XFRHiGlaO7254cYNnzdEHDcMbRC/vsGuI
         VTiQ==
X-Received: by 10.112.158.40 with SMTP id wr8mr12401980lbb.51.1418339813048;
 Thu, 11 Dec 2014 15:16:53 -0800 (PST)
Received: by 10.152.26.101 with HTTP; Thu, 11 Dec 2014 15:16:32 -0800 (PST)
In-Reply-To: <xmqqiohhdc5j.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261304>

>> check-ignore disregards whether a path is matched by a
>> positive or negative pattern. Thus for a file that is _not_
>> ignored, but is captured by negative pattern in .gitignore,
>> the exit code is 0. The docs suggested otherwise.
>
> I am not sure that is the actual behaviour of the command.  Given
> this .gitignore file:
>
>     $ cat .gitignore; echo END
>     !vendor.o
>     *.o
>     END
>
> which is designed to allow binary-only blob "vendor.o" supplied by
> the vendor to be tracked, but to ignore all the other usual build
> artifacts, you see this:
>
>     $ for o in a.o vendor.o; do git check-ignore $o >/dev/null; echo $?; done
>     0
>     1
>
> Puzzled...

Maybe your global ignore file gets in the way?

on both of my machines (cygwin + git 2.1.1, linux + git @master) I have:

  $ cat > .gitignore << EOF
  !vendor.o
  *.o
  EOF

  for o in a.o vendor.o; do git check-ignore $o >/dev/null; echo $?; done
  0
  0

which corresponds to how I understand the command so far :)

is one of a.o and vendor.o already in your index?
there is a --no-index as well (which enables yet another different behavior)
