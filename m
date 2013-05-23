From: Joel Kaasinen <joel.kaasinen@gmail.com>
Subject: Bug report: git grep seems to use the wrong .gitattributes when
 invoked in a subdirectory
Date: Thu, 23 May 2013 15:44:09 +0300
Message-ID: <CAK=EYX51G57borL_Hy2XzqJVML4wmAgOCBPwFLa+miDDY30O7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 23 14:44:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfUsU-00083k-PJ
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 14:44:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758513Ab3EWMoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 08:44:11 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:34547 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756862Ab3EWMoK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 08:44:10 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so8352080ief.40
        for <git@vger.kernel.org>; Thu, 23 May 2013 05:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=ExOk168Lom8kAnLG6RLPYuCU8OP9QeAnoaLkrEmYnvU=;
        b=VRxGqoZ6gSJ51uHMUv0khfSsA0Als256hqNB0J5w3cygbwvQoRTmHOjPjYoB6TeOYb
         sxYj1p5iVupIqYLCfQMEtr6bgYPbDwzygOESpsG+kR7ymVa8Kxre9ctVUPv6gW8jE9sC
         asMmxo8eleriBmYAZRqjQhFKuk1vYym871WpdBIGvzbMZiDEQoV3tsDT9nAKU2w1dh4/
         +gR4jzMsaoKsIFfQ/Q3cTqXXEoSVqwl2uQzYsYruVWKk31877bhkYQLCAnmi/Z4IBdtZ
         3JhyIwsM3far31LlsoM+w2HzIqgZrAqwpOwtTK++H4G1r3nd0A/rEnYotYIBskKHzgOu
         uphw==
X-Received: by 10.50.32.33 with SMTP id f1mr344761igi.39.1369313049740; Thu,
 23 May 2013 05:44:09 -0700 (PDT)
Received: by 10.64.148.80 with HTTP; Thu, 23 May 2013 05:44:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225244>

Greetings,

I bumped into a problem where git grep thinks files in repo/a/data are
binary files when it is invoked from repo/a and
repo/data/.gitattributes contains "* binary".

I can reproduce this on 1.7.9.5 and 1.7.10.4. Unfortunately I don't
have a newer version at hand.

How to reproduce:

[pseudo:~/tmp]% git --version
git version 1.7.10.4
[pseudo:~/tmp]% git init git-test
Initialized empty Git repository in /home/opqdonut/tmp/git-test/.git/
[pseudo:~/tmp]% cd git-test
[pseudo:~/tmp/git-test:master()]% mkdir -p a/data
[pseudo:~/tmp/git-test:master()]% mkdir data
[pseudo:~/tmp/git-test:master()]% echo '* binary' > data/.gitattributes
[pseudo:~/tmp/git-test:master()]% echo foo > a/data/foo
[pseudo:~/tmp/git-test:master()]% git add -A
[pseudo:~/tmp/git-test:master()]% git commit -m "foo"
[master (root-commit) 20fafbb] foo
 2 files changed, 1 insertion(+)
 create mode 100644 a/data/foo
 create mode 100644 data/.gitattributes
[pseudo:~/tmp/git-test:master()]% git grep foo
a/data/foo:foo
[pseudo:~/tmp/git-test:master()]% cd a
[pseudo:~/tmp/git-test/a:master()]% git grep foo
Binary file data/foo matches

(Please CC me on replies, I'm not subscribed to the list.)

--
Joel Kaasinen
joel.kaasinen@gmail.com
