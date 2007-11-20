From: "Medve Emilian" <Emilian.Medve@freescale.com>
Subject: RE: git-daemon
Date: Tue, 20 Nov 2007 09:54:13 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E27017BCD50@az33exm24.fsl.freescale.net>
References: <598D5675D34BE349929AF5EDE9B03E27017BCC42@az33exm24.fsl.freescale.net> <7vbq9pnac2.fsf@gitster.siamese.dyndns.org> <598D5675D34BE349929AF5EDE9B03E27017BCC8D@az33exm24.fsl.freescale.net> <20071120050756.GA29502@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 20 17:54:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuWMu-0004qZ-H3
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 17:54:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756549AbXKTQyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 11:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755198AbXKTQyT
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 11:54:19 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:37184 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754728AbXKTQyS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Nov 2007 11:54:18 -0500
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id lAKGsElP008074
	for <git@vger.kernel.org>; Tue, 20 Nov 2007 09:54:15 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net [10.64.32.14])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id lAKGsEh1013587
	for <git@vger.kernel.org>; Tue, 20 Nov 2007 10:54:14 -0600 (CST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <20071120050756.GA29502@sigill.intra.peff.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git-daemon
thread-index: AcgrM1i9xj6yLffSQLq3SuDtPw1/ewAWJ+JA
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65550>

Hi Jeff,


I just built and installed the latest master (and next) and then I tried
to clone (as I usualy do) one of my repositories. I run git-daemon only
with the upload-pack service enabled.

On the client side this is the symptom:

client:~> git-clone git://server/srv/scm/linux-2.6.git
Initialized empty Git repository in /home/user/linux-2.6/.git/
fatal: The remote end hung up unexpectedly
fetch-pack from 'git://server/srv/scm/linux-2.6.git' failed.

On the server side I get this message:

xined.log:

07/11/20@10:17:04: START: git from=10.82.124.104
07/11/20@10:17:04: EXIT: git status=255 duration=0(sec)

messages:

Nov 20 10:17:04 emmedve1-12 git-daemon: [3921] Connection from
10.82.124.104:2978
Nov 20 10:17:04 emmedve1-12 git-daemon: [3921] Extended attributes (18
bytes) exist <host=server>
Nov 20 10:17:04 emmedve1-12 git-daemon: [3921] Request upload-pack for
'/srv/scm/linux-2.6.git'

And here is a small tcpdump snippet:

10:25:09.817726 IP client.msfrs > server.git: S 1311107296:1311107296(0)
win 65535 <mss 1260,nop,nop,sackOK>
10:25:09.817820 IP server.git > client.msfrs: S 3324794408:3324794408(0)
ack 1311107297 win 5840 <mss 1460,nop,nop,sackOK>
10:25:09.818028 IP client.msfrs > server.git: . ack 1 win 65535
10:25:09.817726 IP (tos 0x0, ttl 128, id 16243, offset 0, flags [DF],
proto: TCP (6), length: 48) client.msfrs > server.git: S, cksum 0x093b
(correct), 1311107296:1311107296(0) win 65535 <mss 1260,nop,nop,sackOK>
10:25:09.817820 IP (tos 0x0, ttl  64, id 0, offset 0, flags [DF], proto:
TCP (6), length: 48) server.git > client.msfrs: S, cksum 0xd53c
(correct), 33247944
08:3324794408(0) ack 1311107297 win 5840 <mss 1460,nop,nop,sackOK>
10:25:09.818028 IP (tos 0x0, ttl 128, id 16244, offset 0, flags [DF],
proto: TCP (6), length: 40) client.msfrs > server.git: ., cksum 0x18d1
(correct), 1:1(0) ack 1 win 65535
10:25:09.819114 IP (tos 0x0, ttl 128, id 16246, offset 0, flags [DF],
proto: TCP (6), length: 102) client.msfrs > server.git: P 1:63(62) ack 1
win 65535
10:25:09.819159 IP (tos 0x0, ttl  64, id 14907, offset 0, flags [DF],
proto: TCP (6), length: 40) server.git > client.msfrs: ., cksum 0x01c3
(correct), 1:1(0) ack 63 win 5840
10:25:09.819114 IP client.msfrs > server.git: P 1:63(62) ack 1 win 65535
10:25:09.819159 IP server.git > client.msfrs: . ack 63 win 5840
10:25:09.821531 IP server.git > client.msfrs: F 1:1(0) ack 63 win 5840
10:25:09.821531 IP (tos 0x0, ttl  64, id 14908, offset 0, flags [DF],
proto: TCP (6), length: 40) server.git > client.msfrs: F, cksum 0x01c2
(correct), 1:1(0) ack 63 win 5840
10:25:09.821769 IP (tos 0x0, ttl 128, id 16248, offset 0, flags [DF],
proto: TCP (6), length: 40) client.msfrs > server.git: ., cksum 0x1892
(correct), 63:63(0) ack 2 win 65535
10:25:09.821769 IP client.msfrs > server.git: . ack 2 win 65535
10:25:09.826015 IP client.msfrs > server.git: F 63:63(0) ack 2 win 65535
10:25:09.826040 IP server.git > client.msfrs: . ack 64 win 5840
10:25:09.826015 IP (tos 0x0, ttl 128, id 16249, offset 0, flags [DF],
proto: TCP (6), length: 40) client.msfrs > server.git: F, cksum 0x1891
(correct), 63:63(0) ack 2 win 65535
10:25:09.826040 IP (tos 0x0, ttl  64, id 0, offset 0, flags [DF], proto:
TCP (6), length: 40) server.git > client.msfrs: ., cksum 0x01c1
(correct), 2:2(0) ack 64 win 5840

I'm not sure what other details would be relevant: tools versions,
kernel version?

Did you try this and is working for you?


Cheers,
Emil.


> -----Original Message-----
> From: git-owner@vger.kernel.org 
> [mailto:git-owner@vger.kernel.org] On Behalf Of Jeff King
> Sent: Monday, November 19, 2007 11:08 PM
> To: Medve Emilian
> Cc: git@vger.kernel.org
> Subject: Re: git-daemon
> 
> On Mon, Nov 19, 2007 at 03:49:36PM -0700, Medve Emilian wrote:
> 
> > v1.5.3.6 works but the HEAD of master and next don't. I 
> considered the
> > patches below but they seemed harmless. I think the problem 
> comes form
> > upload-pack (and below it). Weirdly enough running 
> git-daemon standalone
> > seems to work fine. Cloning over ssh or on the same file 
> system seems to
> > work fine too.
> > 
> > I was hoping somebody can repeat the experiment (build the 
> latest master
> > or maint) and invalidate my experience.
> 
> I can't find any breakage on the current master (ea559605). Can you be
> more specific about what you are trying, how it is breaking, other
> details of your setup, etc?
> 
> -Peff
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
