From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: inotify daemon speedup for git [POC/HACK]
Date: Wed, 28 Jul 2010 07:08:37 -0400
Message-ID: <5C87954A-5BB2-468D-8C4E-79A97685ED0D@mit.edu>
References: <20100727122018.GA26780@pvv.org> <AANLkTinuU6b1vmRFuBrA4Tc5H6gmC5cMP3Pa8EYz-8JE@mail.gmail.com> <9E67A084-4EDB-4CCB-A771-11B97107F4EF@gmail.com> <AANLkTi=oA33M4DmS5FyDx7Wn1DFrUGcmhSYkvcSYMc2r@mail.gmail.com> <20100728000009.GE25268@spearce.org> <AANLkTimkLrTwavErFkyaUTSVU-2s3me5f+cyqNFp7n+D@mail.gmail.com> <52EDBD9A-2961-4F66-88B3-07BF873FA994@gmail.com> <AANLkTi=TQnyATgJ0LSdR3qeeCVAgu+wOFcHmHUBguPiV@mail.gmail.com> <AANLkTinabaO3csi3TBRJKPTZ1zVGgK8-ijs6h1YUkT-n@mail.gmail.com> <20100728060646.GA16400@dert.cs.uchicago.edu> <AANLkTinuq9Q_RADtQwvVTn-kDCw7cg7JcdkhbQnek9Tw@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Joshua Juran <jjuran@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 13:13:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe4a8-0006UE-JZ
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 13:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001Ab0G1LNo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 07:13:44 -0400
Received: from DMZ-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.35]:53667 "EHLO
	dmz-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751136Ab0G1LNn convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 07:13:43 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Jul 2010 07:13:43 EDT
X-AuditID: 12074423-b7cb4ae000000a9b-8b-4c500fbb9aa7
Received: from mailhub-auth-1.mit.edu (MAILHUB-AUTH-1.MIT.EDU [18.9.21.35])
	by dmz-mailsec-scanner-6.mit.edu (Symantec Brightmail Gateway) with SMTP id 05.88.02715.BBF005C4; Wed, 28 Jul 2010 07:08:43 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id o6SB8eF3024277;
	Wed, 28 Jul 2010 07:08:40 -0400
Received: from [10.0.42.101] (c-98-216-98-217.hsd1.ma.comcast.net [98.216.98.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6SB8bZ0010740
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 28 Jul 2010 07:08:38 -0400 (EDT)
In-Reply-To: <AANLkTinuq9Q_RADtQwvVTn-kDCw7cg7JcdkhbQnek9Tw@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152077>


On Jul 28, 2010, at 3:44 AM, =C6var Arnfj=F6r=F0 Bjarmason wrote:

> SQLite has an option to turn that off [1], but I don't know if it has
> an equivalent feature to manually call fsync when you need that.

The right way to use SQLite is to have a memory-packed database which y=
ou check first, and where you do al of your work.  Then once you hit a =
stable stopping point, you commit those changes to your on-disk SQLite =
database, which can have proper transaction support.   That way you don=
't lose your database when your crappy binary-only video driver crashes=
 on you, but you don't trash your disk performance because of the fsync=
() calls....

It only took a few years for firefox developers to figure this out, but=
 the next version is supposed to finally get this right....  it'll be n=
ice to have it NOT chewing up a third of a megabyte of SSD write endura=
nce on every URL click....

-- Ted
