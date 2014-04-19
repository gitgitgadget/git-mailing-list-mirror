From: Schittli Thomas <Thomas.Schittli@akros.ch>
Subject: Git: Please allow to use gpgsm to support X.509 certificates
Date: Sat, 19 Apr 2014 11:03:07 +0000
Message-ID: <87FCFF58480C9949AF1110DED8AC48E4E9A0D636@BASMX001.akros.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 19 13:13:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbTCt-0007nP-HW
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 13:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbaDSLNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 07:13:10 -0400
Received: from mail.akros.ch ([91.198.79.97]:50487 "EHLO mail.akros.li"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077AbaDSLNH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Apr 2014 07:13:07 -0400
X-Greylist: delayed 553 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Apr 2014 07:13:07 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.akros.li (Postfix) with ESMTP id A50C82039B
	for <git@vger.kernel.org>; Sat, 19 Apr 2014 13:03:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at basns01.akros.ch
Received: from mail.akros.li ([127.0.0.1])
	by localhost (basns01.akros.ch [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VbXMkJyED2M5 for <git@vger.kernel.org>;
	Sat, 19 Apr 2014 13:03:49 +0200 (CEST)
Received: from BASMX001.akros.ch (exch.akros.ch [10.7.0.44])
	by mail.akros.li (Postfix) with ESMTP id 19BE120206
	for <git@vger.kernel.org>; Sat, 19 Apr 2014 13:03:49 +0200 (CEST)
Received: from BASMX001.akros.ch ([fe80::ac47:db94:ad74:89e]) by
 BASMX001.akros.ch ([::1]) with mapi id 14.03.0174.001; Sat, 19 Apr 2014
 13:03:09 +0200
Thread-Topic: Please allow to use gpgsm to support X.509 certificates
Thread-Index: AQHPW71ZcUnsLXRrMEet3My08U++Wg==
Accept-Language: de-CH, en-US
Content-Language: de-CH
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [46.126.169.144]
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246512>

Dear Git community

last night, brian m. Carlson explained, that "Git wants a key that can be used by GnuPG" and therefore X.509 certificates are not supported.

As you probably know, since 3 years gpg supports X.509 - unfortunately, gpg does not automatically detect X.509 certificates and we have to use gpgsm instead of gpg.
The good thing: for identical functions, the command line arguments are identical :-)

Therefore: please allow to configure git, so that it can use gpg or gpgsm.
Or even better: if gpg fails, then please automatically try gpgsm :-)


It works perfectly, I just replaced gpg.exe by gpgsm.exe:

1. Copied all missing *.dll and *.exe from c:\Program Files (x86)\GNU\GnuPG\ to c:\Program Files (x86)\Git\bin\
2. renamed c:\Program Files (x86)\Git\bin\gpg.exe to c:\Program Files (x86)\Git\bin\gpg_.exe
3. renamed c:\Program Files (x86)\Git\bin\gpgsm.exe to c:\Program Files (x86)\Git\bin\gpg.exe
4. Imported the X.509 Certificate
5. signed a commit:
    $ git commit -S -m 'Test commit of foo'
    gpgsm: DBG: adding certificates at level -2
    gpgsm: signature created
    [master dd5145a] Test commit of foo
     1 file changed, 0 insertions(+), 0 deletions(-)
     create mode 100644 test
6. Tested the signature
    $ git log --show-signature
    commit dd5145aabac18f6a2fb2cd0d4a30b5064ef4c04a
    gpgsm: Signature made 2014-04-19 10:34:53 using certificate ID 0x12345678^M
    gpgsm: Good signature from "/CN=xxx/O=xxx/L=xxxl/ST=xxx/C=xx/EMail=xxx@xxx.xx"^M
    Author: tom xxx@xxx.xx
    Date:   Sat Apr 19 12:34:53 2014 +0200
        Test commit of foo
    commit b89934b6e3a86343be740f7a5a1fe446e572b5dd
    Author: tom xxx@xxx.xx
    Date:   Fri Apr 18 23:09:47 2014 +0200
        Init


Thanks a lot for this really great tool!!

Kind regards,
Tom



On Fri, Apr 18, 2014 at 10:04:50PM +0200, Thomas Schittli wrote:
> We already have trusted Certificates from a CA. Can we use them
> instead of an additional PGP key?

Git wants a key that can be used by GnuPG, and X.509 certificates can't
be.  It invokes the gpg binary that's in your path, so X.509 integration
isn't possible unless gpg learns about it.

> We already have:
> - s/mime certificate
> - web server ssl/tls certificate
> - XMPP Jabber ssl/tls certificate
> - Object Code Signing certificate
>  
> Or if we have to use a new pgp key: can we sign it using any of our
> certificates?

Only in the sense that you can sign any arbitrary piece of text or data
with your certificates.

-- 
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187