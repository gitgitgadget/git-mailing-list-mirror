From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: [BUG?] blame: Odd -L 1,+0 behavior
Date: Fri, 16 Jul 2010 15:50:52 +0000
Message-ID: <AANLkTin-6nck9aVKPTwOy_PmrGUs1iS8ruqzIORbf8jb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 16 17:51:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZnBl-00034u-2M
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 17:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965927Ab0GPPuy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jul 2010 11:50:54 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36164 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965842Ab0GPPux convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jul 2010 11:50:53 -0400
Received: by iwn7 with SMTP id 7so2265941iwn.19
        for <git@vger.kernel.org>; Fri, 16 Jul 2010 08:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=bN7P6pzbFQ5OVYdP7YLFcTFl6UTC7z1V5EsSJTKkaM8=;
        b=IegJb2T6Yy7iOAFHMJkAByO7qJq1nJxeZqtmWcfB9WsT4sFZcEiXwUJV9+p5yQSudQ
         ebLXJoM35w42ws/9ZQqopQRKfrgD76iRqU+OOMsbZMV8nG3xD/1eACISuPDVVM3yEbVw
         g6VMXEQgznZphGfEuP7XeXDXX6RK9ds02gTq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=RxKeWXCWlJl8X9tS4A1DZ6DsFpw6rJzCLSIT7HobWJhirIK32m8yUgJqOxu1G+E3M2
         JpEsTCIA4Ck0KkFsbNmjo/eR8PaE63IkZTM5G+R64guaAvRtQ18WZ9pGt81yxZ63W2PQ
         UCRTBec3voGm3sqO5bvTWp+K1V1y0lZRLL6OU=
Received: by 10.231.14.201 with SMTP id h9mr1090933iba.129.1279295452365; Fri, 
	16 Jul 2010 08:50:52 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Fri, 16 Jul 2010 08:50:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151158>

On Fri, Jul 16, 2010 at 15:35, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> git-pickaxe (later git-blame) gained support for the -L/start/,/end/
> form in 2006 (931233bc66 by Junio C Hamano), but nothing was added to
> test this functionality. Change that by adding more -L tests to
> t8003-blame.sh.

I was also going to patch t8003-blame.sh to test for the functionality
introduced in 7bd9641df5, but I'm not sure what it's supposed to do:

ok:

    $ git blame cow
    5b22ca36 (Fourth 2005-04-07 15:16:13 -0700 1) ABC
    5b22ca36 (Fourth 2005-04-07 15:16:13 -0700 2) DEF
    018e3134 (Fifth  2005-04-07 15:17:13 -0700 3) XXXX
    5b22ca36 (Fourth 2005-04-07 15:16:13 -0700 4) GHIJK

ok:

    $ git blame -L 1,2 cow
    5b22ca36 (Fourth 2005-04-07 15:16:13 -0700 1) ABC
    5b22ca36 (Fourth 2005-04-07 15:16:13 -0700 2) DEF

ok, +/- are zero-indexed:

    $ git blame -L 1,+2 cow
    5b22ca36 (Fourth 2005-04-07 15:16:13 -0700 1) ABC
    5b22ca36 (Fourth 2005-04-07 15:16:13 -0700 2) DEF

Shouldn't this either print nothing, er be an error:

    $ git blame -L 1,+0 cow
    5b22ca36 (Fourth 2005-04-07 15:16:13 -0700 1) ABC
    5b22ca36 (Fourth 2005-04-07 15:16:13 -0700 2) DEF

same here, line 0-0 prints the whole file:

    $ git blame -L 0,0 cow
    5b22ca36 (Fourth 2005-04-07 15:16:13 -0700 1) ABC
    5b22ca36 (Fourth 2005-04-07 15:16:13 -0700 2) DEF
    018e3134 (Fifth  2005-04-07 15:17:13 -0700 3) XXXX
    5b22ca36 (Fourth 2005-04-07 15:16:13 -0700 4) GHIJK

And these need a better error message:

    $ git blame -L 0,0a cow
    usage: git blame [options] [rev-opts] [rev] [--] file

Is there any use for +/- 0, or should it always be an error?
