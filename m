From: Daniel Bonniot <bonniot@gmail.com>
Subject: bisect: "Needed a single revision" message is confusing
Date: Fri, 2 Nov 2012 14:23:15 +0100
Message-ID: <CAO5QaZkZYxvSYoAQGgrrH1ULM8rnwX5=0Ln-_zfh8OwdegNNoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 02 14:24:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUHEA-0002y3-1o
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 14:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757496Ab2KBNXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 09:23:39 -0400
Received: from mail-ea0-f174.google.com ([209.85.215.174]:53393 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475Ab2KBNXi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 09:23:38 -0400
Received: by mail-ea0-f174.google.com with SMTP id c13so1369202eaa.19
        for <git@vger.kernel.org>; Fri, 02 Nov 2012 06:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=hh+BiZh0h6b5Ay0skmCMFlYz9Qe7FbXvyVosdOM9VmM=;
        b=SB0hVFt5eGJdWUOuKIfLHCS/Srbd0J/k3c98j+tjEBPlU1WA7I6/GBo/u0MYArfqz9
         6oZkRC95bultXf23aRoG11gMumWPsJtrx7PmwU62cWoA2sSVii9Bgkau80GZJvw26+Af
         erSBXbTSnWstzW2eqAlxIlgWcC+/L5vtogqAPmLI3Rp8g75bl9UJ/10TW0tT8DPJPEAI
         1gvZye3cAWp4ZkUCajPY4V+lI1SZ/evZzyATVOCItMD+OpeuoiBkbTGVFEZ1V405+KSC
         3q5Qg3fSzAHyeJFIMwW+SOQz0lCmMhJTWza+1YrPtYPAcQSjVHAhhoh8GpkvTICGhjKx
         Vd2w==
Received: by 10.14.223.4 with SMTP id u4mr6634035eep.19.1351862615608; Fri, 02
 Nov 2012 06:23:35 -0700 (PDT)
Received: by 10.223.88.155 with HTTP; Fri, 2 Nov 2012 06:23:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208929>

Hi,

Suppose I'm doing a git bisect, say:

$ git bisect good 8c7a786b6c8eae8eac91083cdc9a6e337bc133b0

That works fine. The sha1 could also be a substring, as long as it's
unambiguous, e.g.:

$ git bisect good 8c7a786b6c

Now if it's ambiguous, I get an error message:

$ git bisect good 8
fatal: Needed a single revision
Bad rev input: 8

All fine and good. But what if I somehow input a non-existing sha1 (in
my case see [1]), e,g:

$ git bisect good 8c7a786b6c8eae8eac91083cdc9a6e337bc133b1
fatal: Needed a single revision
Bad rev input: 8c7a786b6c8eae8eac91083cdc9a6e337bc133b1

I understand that technically both "no revision" and "multiple
revisions" qualify as "not a single revision", but they correspond to
quite different situations. I think it would be more helpful to get
different error messages, something like:

Bad rev input: 8 refers to multiple revisions
Bad rev input: 8c7a786b6c8eae8eac91083cdc9a6e337bc133b1 does not refer
to a valid revision

(and avoid outputing the "fatal: Needed a single revision" message).

Is this a good idea? Anybody can think of better error messages?

I'm not familiar with the code base at all, but I could give a try at
implementing it, unless it's trivial enough that someone does it
earlier. After a quick look, it looks like either git-bisect itself or
rev-parse would need to be touched, any pointers and hints welcome.

Cheers,

Daniel

[1] if you want to know, I got a sha1 from one repository and used it
in another, which probably should work, except that when using git-svn
they don't. And the "single revision" error message lead me on a
tangent.
