From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: git-am and CRLF
Date: Wed, 13 Mar 2013 17:54:14 +0100
Message-ID: <CABPQNSb9euNgCY9g617opThHC8OUpZQvJ+peor8Yk39LZ+y+TQ@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 13 17:55:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFoxV-00076G-HL
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 17:55:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933151Ab3CMQyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 12:54:55 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:46148 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755591Ab3CMQyy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 12:54:54 -0400
Received: by mail-ie0-f181.google.com with SMTP id 17so1764927iea.12
        for <git@vger.kernel.org>; Wed, 13 Mar 2013 09:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:from:date:message-id:subject:to
         :content-type;
        bh=6ZHF7M4S0k0OpCC2vxMIUJxazJjwyyvWneU8BSVopV8=;
        b=VbW65MJUYr1Cl1NgBpuLtMsTEoy/hGZ67XYILW5jgscbmmSzXHsffkgAOt8ihEfpI9
         M1Qw8uGOA39PxPAGregQnR9CvePVfBBe7x+LW/3TciOYg7qbYZnunKrQkM/8yozvYMXs
         pMcpfScvypBe/nDE/7vn2bnJ39GzNo1gNa2qx8H9JUU23AMQ8ATSOIW6w7In5O8CbomQ
         /i9/sprN11+XiNNgLZdY5tTSqjaptXK3AUNfyyfUH9nvws3Ahppp3Tzmi4ENs406XSzi
         SSBP/e/gzPZhalIhyYJJIzW9fSesKTzloukIv7cZkqDhuhue2YukwjhHd3nzjannL1p/
         cVWA==
X-Received: by 10.50.7.242 with SMTP id m18mr17036705iga.53.1363193694217;
 Wed, 13 Mar 2013 09:54:54 -0700 (PDT)
Received: by 10.64.44.47 with HTTP; Wed, 13 Mar 2013 09:54:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218070>

I recently tried to apply a patch-series to a repo that is
unfortunately full of CRLF files, and was a bit surprised that it
didn't work at all.

So I made a small repro-case, and it seems CRLF new-lines is indeed
the problem. Any clue how to fix it? The way I see it, we should
simply be able top treat the CR as any other character, and succeed.
But that doesn't seem to happen...

git init test &&
(
        cd test/ &&
        git config core.autocrlf false &&
        printf "%s\r\n%s\r\n" "foo" "bar" > test.txt &&
        git add test.txt &&
        git commit -m. &&
        printf "%s\r\n%s\r\n%s\r\n" "foo" "baz" "bar" > test.txt &&
        git commit -am. &&
        git format-patch -1 &&
        git reset --hard HEAD^ &&
        git am 0001-.patch
)
