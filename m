From: Brian Foster <brian.foster@maxim-ic.com>
Subject: [BUG 1.7.6.1] `git config --bool --get-regexp' omits separating space... sometimes!
Date: Mon, 10 Oct 2011 12:20:21 +0200
Message-ID: <201110101220.21890.brian.foster@maxim-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 10 12:40:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDDHF-0005DX-FP
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 12:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426Ab1JJKkB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Oct 2011 06:40:01 -0400
Received: from antispam01.maxim-ic.com ([205.153.101.182]:49018 "EHLO
	antispam01.maxim-ic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113Ab1JJKkA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Oct 2011 06:40:00 -0400
X-Greylist: delayed 1017 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Oct 2011 06:40:00 EDT
X-ASG-Debug-ID: 1318242182-02ae985dcc1609e0001-QuoKaX
Received: from maxdalex02.maxim-ic.internal (maxdalex02.maxim-ic.internal [10.16.15.104]) by antispam01.maxim-ic.com with ESMTP id RUu6czJG98pMf9Dg for <git@vger.kernel.org>; Mon, 10 Oct 2011 05:23:02 -0500 (CDT)
X-Barracuda-Envelope-From: brian.foster@maxim-ic.com
Received: from maxsvlex02.maxim-ic.internal (10.32.112.18) by
 maxdalex02.maxim-ic.internal (10.16.15.104) with Microsoft SMTP Server (TLS)
 id 8.3.83.0; Mon, 10 Oct 2011 05:21:12 -0500
Received: from bfoster-57.localnet (10.201.0.19) by
 maxsvlex02.maxim-ic.internal (10.32.112.18) with Microsoft SMTP Server (TLS)
 id 8.3.83.0; Mon, 10 Oct 2011 03:21:11 -0700
X-ASG-Orig-Subj: [BUG 1.7.6.1] `git config --bool --get-regexp' omits separating space... sometimes!
User-Agent: KMail/1.12.2 (Linux/2.6.31-23-generic; KDE/4.3.2; x86_64; ; )
X-Barracuda-Connect: maxdalex02.maxim-ic.internal[10.16.15.104]
X-Barracuda-Start-Time: 1318242182
X-Barracuda-URL: http://AntiSpam02.maxim-ic.com:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at maxim-ic.com
X-Barracuda-Spam-Score: 0.12
X-Barracuda-Spam-Status: No, SCORE=0.12 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=5.0 tests=CN_BODY_332
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.76917
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.12 CN_BODY_332            BODY: CN_BODY_332
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183239>

Hello,

# Script to illustrate the problem:
rm -f Config
cat <<\EOF >Config
[Example]
	Boolean
	Other =3D yes
EOF
git_Config() { git config --file Config "$@"; }

git version
git_Config        --get-regexp '.*\.Boolean'	#1. =E2=9C=93 Ok: example.=
boolean
git_Config --bool --get-regexp '.*\.Boolean'	#2. =E2=9C=97 NO: example.=
booleantrue
git_Config        --get-regexp '.*\.Other'	#3. =E2=9C=93 Ok: example.ot=
her yes
git_Config --bool --get-regexp '.*\.Other'	#4. =E2=9C=93 Ok: example.ot=
her true
exit

# Output:
git version 1.7.6.1
example.boolean
example.booleantrue
example.other yes
example.other true

 Case 2 omits the space between the key-name and (generated) value,
 making the output difficult to parse/process.  Without checking,
 I assume --int (and friends) have a similar bug?

cheers!
	-blf-

--=20
Brian FOSTER
Principal MTS, Software
Maxim Integrated Products (Microcontroller BU), formerly Innova Card
Web    : http://www.maxim-ic.com/
