From: Jonathan del Strother <maillist@steelskies.com>
Subject: git-status segmentation fault in master / OS X
Date: Tue, 19 Jan 2010 17:59:51 +0000
Message-ID: <57518fd11001190959n355a0f22p7caa7251b705efaf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 19 20:02:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXJLn-0001HY-CV
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 20:02:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755293Ab0ASTCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 14:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755284Ab0ASTCt
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 14:02:49 -0500
Received: from juliet.asmallorange.com ([207.210.105.70]:53076 "EHLO
	juliet.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932099Ab0ASTCq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 14:02:46 -0500
X-Greylist: delayed 3750 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jan 2010 14:02:46 EST
Received: from ey-out-2122.google.com ([74.125.78.26]:26769)
	by juliet.asmallorange.com with esmtpsa (TLSv1:RC4-MD5:128)
	(Exim 4.69)
	(envelope-from <maillist@steelskies.com>)
	id 1NXINE-0004Bo-3Q
	for git@vger.kernel.org; Tue, 19 Jan 2010 13:00:16 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1038447eyd.19
        for <git@vger.kernel.org>; Tue, 19 Jan 2010 10:00:11 -0800 (PST)
Received: by 10.216.85.137 with SMTP id u9mr2776556wee.214.1263924011130; Tue, 
	19 Jan 2010 10:00:11 -0800 (PST)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - juliet.asmallorange.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - steelskies.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137485>

Heya,
I've been running into a segmentation fault on running git status in
my repository while there are staged changes.  Bisecting suggests it
was introduced in:

commit 73d66323ac78c750ba42fef23b1cb8fd2110e023
Merge: 054d2fa 8740773
Author: Junio C Hamano <gitster@pobox.com>
Date:   Wed Jan 13 11:58:34 2010 -0800

    Merge branch 'nd/sparse'


The last commit from nd/sparse (8740773) is fine, so I guess it's a
bad merge...?


Here's the crash I get on 73d6632 :

Process:         git [93736]
Path:            /Users/jon/bin/git
Identifier:      git
Version:         ??? (???)
Code Type:       X86-64 (Native)
Parent Process:  zsh [26194]

Date/Time:       2010-01-19 17:58:01.306 +0000
OS Version:      Mac OS X 10.6.2 (10C540)
Report Version:  6

Interval Since Last Report:          349902 sec
Crashes Since Last Report:           15
Per-App Crashes Since Last Report:   11
Anonymous UUID:                      2563166D-332E-42BE-9D2D-0E741A6DB38A

Exception Type:  EXC_BAD_ACCESS (SIGSEGV)
Exception Codes: KERN_INVALID_ADDRESS at 0x0000000000000000
Crashed Thread:  0  Dispatch queue: com.apple.main-thread

Thread 0 Crashed:  Dispatch queue: com.apple.main-thread
0   libSystem.B.dylib             	0x00007fff81260a56 fnmatch1 + 442
1   libSystem.B.dylib             	0x00007fff8126088a fnmatch + 124
2   git                           	0x0000000100076cde excluded_from_list + 526
3   git                           	0x0000000100077877 excluded + 519
4   git                           	0x0000000100077ab5
read_directory_recursive + 453
5   git                           	0x0000000100077ff9 read_directory + 249
6   git                           	0x000000010007812b fill_directory + 219
7   git                           	0x00000001000b91a7 wt_status_collect + 599
8   git                           	0x0000000100017380 cmd_status + 288
(builtin-commit.c:1032)
9   git                           	0x0000000100001d1c
handle_internal_command + 188 (git.c:257)
10  git                           	0x0000000100001f5c main + 236 (git.c:446)
11  git                           	0x0000000100001814 start + 52

Thread 0 crashed with X86 Thread State (64-bit):
  rax: 0x0000000000000003  rbx: 0x0000000000000000  rcx:
0x00007fff5fbfe260  rdx: 0x0000000000000006
  rdi: 0x000000000000002a  rsi: 0x00007fff5fbfe480  rbp:
0x00007fff5fbfe1d0  rsp: 0x00007fff5fbfe010
   r8: 0x00007fff70276980   r9: 0x0000000100528720  r10:
0x0000000100528ae0  r11: 0x00007fff8120b860
  r12: 0x00007fff5fbfe480  r13: 0x0000000000000001  r14:
0x00007fff70276980  r15: 0x00007fff5fbfe260
  rip: 0x00007fff81260a56  rfl: 0x0000000000010246  cr2: 0x0000000000000000

Binary Images:
       0x100000000 -        0x1000f9fef +git ??? (???)
<FFFFCD11-3352-4216-B27D-2700D1A69326> /Users/jon/bin/git
       0x100179000 -        0x10018bfe7 +libz.1.dylib ??? (???)
<F450102F-273C-872E-0729-BD338777CA02> /opt/local/lib/libz.1.dylib
       0x10018f000 -        0x10028bff7 +libiconv.2.dylib ??? (???)
<A27D1D71-44A7-76A7-41EB-CC4BAC91E740> /opt/local/lib/libiconv.2.dylib
       0x100298000 -        0x1003acfe7 +libcrypto.0.9.8.dylib ???
(???) <D4E1B9E7-BE64-5054-F80A-B63296AFEAD4>
/opt/local/lib/libcrypto.0.9.8.dylib
       0x100410000 -        0x10044ffff +libssl.0.9.8.dylib ??? (???)
<4E8F5D81-1DFF-5CBD-361A-C37609B799A8>
/opt/local/lib/libssl.0.9.8.dylib
    0x7fff5fc00000 -     0x7fff5fc3bdef  dyld 132.1 (???)
<B633F790-4DDB-53CD-7ACF-2A3682BCEA9F> /usr/lib/dyld
    0x7fff811d2000 -     0x7fff81390ff7  libSystem.B.dylib ??? (???)
<526DD3E5-2A8B-4512-ED97-01B832369959> /usr/lib/libSystem.B.dylib
    0x7fff871c3000 -     0x7fff871c7ff7  libmathCommon.A.dylib ???
(???) <95718673-FEEE-B6ED-B127-BCDBDB60D4E5>
/usr/lib/system/libmathCommon.A.dylib
    0x7fffffe00000 -     0x7fffffe01fff  libSystem.B.dylib ??? (???)
<526DD3E5-2A8B-4512-ED97-01B832369959> /usr/lib/libSystem.B.dylib

Model: MacPro1,1, BootROM MP11.005C.B08, 4 processors, Dual-Core Intel
Xeon, 2 GHz, 3 GB, SMC 1.7f10
Graphics: ATI Radeon X1900 XT, ATY,RadeonX1900, PCIe, 512 MB
Memory Module: global_name
AirPort: spairport_wireless_card_type_airport_extreme (0x14E4, 0x87),
Broadcom BCM43xx 1.0 (5.10.91.26)
Bluetooth: Version 2.2.4f3, 2 service, 1 devices, 1 incoming serial ports
Network Service: Ethernet 1, Ethernet, en0
PCI Card: ATY,RadeonX1900, Display, Slot-1
Serial ATA Device: WDC WD2500KS-00MJB0, 232.89 GB
Serial ATA Device: WDC WD2500JS-41SGB0, 232.89 GB
Parallel ATA Device: SONY    DVD RW DW-D150A
USB Device: Hub, 0x05ac  (Apple Inc.), 0x9130, 0xfd400000
USB Device: Keyboard Hub, 0x05ac  (Apple Inc.), 0x1006, 0xfd410000
USB Device: USB-PS/2 Optical Mouse, 0x046d  (Logitech Inc.), 0xc01e, 0xfd411000
USB Device: Apple Keyboard, 0x05ac  (Apple Inc.), 0x0221, 0xfd412000
USB Device: C-Media USB Headphone Set, 0x0d8c  (C-MEDIA ELECTRONICS
INC.), 0x000c, 0xfd430000
USB Device: Apple Cinema Display, 0x05ac  (Apple Inc.), 0x9222, 0xfd420000
USB Device: Hub, 0x05ac  (Apple Inc.), 0x9131, 0xfd300000
USB Device: Apple Cinema HD Display, 0x05ac  (Apple Inc.), 0x9223, 0xfd320000
USB Device: Bluetooth USB Host Controller, 0x05ac  (Apple Inc.),
0x8206, 0x5d200000
FireWire Device: built-in_hub, Up to 800 Mb/sec
FireWire Device: unknown_device, Unknown



Want me to do any more digging?

-Jonathan
