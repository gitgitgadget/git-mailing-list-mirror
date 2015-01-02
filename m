From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: xfuncname problems with C++
Date: Fri, 2 Jan 2015 11:03:34 -0600
Message-ID: <CAHd499C_Z_npG3ibv_gJSU7kqrT6=DRCV8TU9_sjz9zzQ7vC-Q@mail.gmail.com>
References: <CAHd499Cn8C51i_+Dm4h_U4X_Jc-nhNMjoufiZRdn5LGxFqD_HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 02 18:03:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y75dV-0004sU-AK
	for gcvg-git-2@plane.gmane.org; Fri, 02 Jan 2015 18:03:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbbABRDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2015 12:03:37 -0500
Received: from mail-la0-f44.google.com ([209.85.215.44]:56559 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036AbbABRDg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2015 12:03:36 -0500
Received: by mail-la0-f44.google.com with SMTP id gd6so15802036lab.31
        for <git@vger.kernel.org>; Fri, 02 Jan 2015 09:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:content-type;
        bh=enH0vVs7hUcVvLqvc/DRCDcWnFQ+LXFM+lCBu336QqM=;
        b=GUDM5CPhm8T0MIsp4LbD8kb1LdLY7Bf3m12Loo3L5KvvicRIi7I3ciYQ6/vA1xm/hr
         GN/B7FA6ouxCND5AKufH+7SRWlqwPggxEwCY3lpuP+cpp0Oviz6987qPPQ7ae2qTVLUz
         gWV0k2kQqNLEvTMzZ8FnR0FY/V+wI/h/GfnXmB6LeURZEiU+gPdvSEsXFe1PPJzYbyP+
         aJZ5hHlsZw3KNTKmiVRcWX8Ut9lEjBq1D3GaRD4V5HECvB92kBSawLAWxyU4Tu4UgyUN
         xU05EK/ezbsKzJR47V66rogWkie8F69Wm/TTnmxAcoztfbE9dk4GVnb8flhrZOgaUhdo
         pkRA==
X-Received: by 10.112.27.133 with SMTP id t5mr77389776lbg.45.1420218215021;
 Fri, 02 Jan 2015 09:03:35 -0800 (PST)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.114.185.67 with HTTP; Fri, 2 Jan 2015 09:03:34 -0800 (PST)
In-Reply-To: <CAHd499Cn8C51i_+Dm4h_U4X_Jc-nhNMjoufiZRdn5LGxFqD_HA@mail.gmail.com>
X-Google-Sender-Auth: EQ4CG6n9aZxdEiDR3hwFf84-X3s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261978>

On Fri, Jan 2, 2015 at 10:49 AM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> I have a function like so:
>
> void MyClass::SomeFunction(int someParameter)
> {
>     // Stuff changed in here
> }
>
> When I do `git diff` on the file containing this function, I get a
> chunk showing some changed code in this function somewhere in the
> middle of the body. However, the chunk header shows my root namespace
> name in the file instead of the function header:
>
> @@ -144,15 +149,22 @@ namespace Utils
>
> What I expect to see:
>
> @@ -144,15 +149,22 @@ void MyClass::SomeFunction(int someParameter)
>
> I've tried various regular expressions that work in regex testers I
> use against this function signature, however they do not work when I
> apply them to my config:
>
> [diff "cpp"]
>     xfuncname =
> "^\\s*[\\w_][\\w\\d_]*\\s*.*\\s*[\\w_][\\w\\d_]*\\s*\\(.*\\)\\s*$"
>
> File name is "foo.cpp", I even added it to my git attributes file:
>
> *.cpp diff=cpp
>
> Using the regex above, my chunk headers come back blank. Why is it
> showing namespace? How do I make this match the nearest function
> header?

Oopsie, I didn't realize the regex must be POSIX compatible. I've
updated the regex to this:
https://www.regex101.com/r/kP3dM6

The test seems to work; however git gives me an error with the regex
when I do a diff:

$ git diff Core
fatal: Invalid regexp to look for hunk header:
^[[:space:]]*[[:word:]_][[:word:][:digit:]_]*[[:space:]]*.*[[:space:]]*[[:word:]_][[:word:][:digit:]_]*[[:space:]]*\(.*\)[[:space:]]*$

Here is how it is stored in my .gitconfig:

[diff "cpp"]
    xfuncname =
"^[[:space:]]*[[:word:]_][[:word:][:digit:]_]*[[:space:]]*.*[[:space:]]*[[:word:]_][[:word:][:digit:]_]*[[:space:]]*\\(.*\\)[[:space:]]*$"
