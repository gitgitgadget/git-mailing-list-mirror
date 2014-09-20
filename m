From: "James H. Fisher" <jhf@trifork.com>
Subject: Bug/request: the empty string should be a valid git note
Date: Sat, 20 Sep 2014 21:47:42 +0200
Message-ID: <F9750CC0-3FAC-4B50-AB6A-BFD6A7D0BE97@trifork.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 20 21:57:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVQmq-0005xY-6K
	for gcvg-git-2@plane.gmane.org; Sat, 20 Sep 2014 21:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757526AbaITT5f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Sep 2014 15:57:35 -0400
Received: from mxout02.netic.dk ([77.243.50.218]:21191 "EHLO mxout02.netic.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754691AbaITT5e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Sep 2014 15:57:34 -0400
X-Greylist: delayed 590 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Sep 2014 15:57:34 EDT
X-IronPort-AV: E=Sophos;i="5.04,561,1406584800"; 
   d="scan'208";a="11122252"
Received: from mail91.interprise.dk ([77.66.16.98])
  by mxout02.netic.dk with ESMTP/TLS/AES128-SHA; 20 Sep 2014 21:47:43 +0200
Received: from MAIL01.interprise.dk (172.22.110.50) by MAIL91.interprise.dk
 (172.22.200.10) with Microsoft SMTP Server (TLS) id 8.3.348.2; Sat, 20 Sep
 2014 21:47:42 +0200
Received: from MAIL01.interprise.dk ([fe80::79b6:f1f5:a21d:550b]) by
 MAIL01.interprise.dk ([fe80::79b6:f1f5:a21d:550b%11]) with mapi; Sat, 20 Sep
 2014 21:47:39 +0200
Thread-Topic: Bug/request: the empty string should be a valid git note
Thread-Index: Ac/VC7xBM4oD8ktNQTasgtrx0mizVQ==
Accept-Language: en-US, da-DK
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, da-DK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257330>

In the documentation for git notes [1] I read:

    In principle, a note is a regular Git blob, and any kind of (non-)f=
ormat is accepted.

Then, since the empty string is a valid regular Git blob, the empty str=
ing is also a valid git note.

Therefore this behavior was unexpected for me:

    > git notes --ref=3Dfoo add -m ''
    Removing note for object 97b8860c071898d9e162678ea1035a8ced2f8b1f

I was surprised to see that this behavior was deliberately introduced:

    > git log -1 a0b4dfa
    commit a0b4dfa9b35a2ebac578ea5547b041bb78557238
    Author: Johan Herland <johan@herland.net>
    Date:   Sat Feb 13 22:28:24 2010 +0100

        Teach builtin-notes to remove empty notes

        When the result of editing a note is an empty string, the assoc=
iated note
        entry should be deleted from the notes tree.

        This allows deleting notes by invoking either "git notes -m ''"=
 or
        "git notes -F /dev/null".

        Signed-off-by: Johan Herland <johan@herland.net>
        Signed-off-by: Junio C Hamano <gitster@pobox.com>

I don=92t understand what the motivation for this change was. Yes, it "=
allows deleting notes" by providing the empty string, but there is a sp=
ecific subcommand for removal of a note, `git notes remove`, which make=
s this intention much clearer.

I have specific motivation for wanting to store the empty string as a g=
it note, as distinct from the non-existence of a note for the object. (=
Specifically I have a tool to annotate a commit with a list of files th=
at satisfy a certain condition. The empty string represents the empty l=
ist, a valid value which asserts that no files satisfied the condition.=
 I can imagine many other use cases for which the empty string is a use=
ful git note.)

Does anyone know why we have the existing behavior? Is it for "technica=
l reasons=94 or was it actually considered desirable?

James Fisher=20

[1]: https://www.kernel.org/pub/software/scm/git/docs/git-notes.html