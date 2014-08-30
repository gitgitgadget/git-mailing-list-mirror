From: dev <dev@cor0.com>
Subject: Re: problem with def of inet_ntop() in git-compat-util.h as well as
 other places
Date: Sat, 30 Aug 2014 11:25:51 -0400 (EDT)
Message-ID: <1333134044.25621.1409412351761.JavaMail.vpopmail@webmail2.networksolutionsemail.com>
References: <1024776344.30870.1409166905539.JavaMail.vpopmail@webmail2.networksolutionsemail.com> <20140827192848.GC7561@peff.net> <805178325.32077.1409168920760.JavaMail.vpopmail@webmail2.networksolutionsemail.com> <20140827200612.GA10469@peff.net> <597210348.36175.1409173228026.JavaMail.vpopmail@webmail2.networksolutionsemail.com> <20140827222803.GZ20185@google.com> <1506847499.57192.1409201670955.JavaMail.vpopmail@webmail2.networksolutionsemail.com> <20140829000502.GC53982@vauxhall.crustytoothpaste.net>
Reply-To: dev <dev@cor0.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sat Aug 30 17:26:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNkXm-00027L-CP
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 17:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbaH3P0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2014 11:26:07 -0400
Received: from atl4mhob19.myregisteredsite.com ([209.17.115.112]:53825 "EHLO
	atl4mhob19.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751640AbaH3P0G (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Aug 2014 11:26:06 -0400
Received: from atl4oxapp02pod2.mgt.hosting.qts.netsol.com ([10.30.77.38])
	by atl4mhob19.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id s7UFPpHV008137;
	Sat, 30 Aug 2014 11:25:51 -0400
In-Reply-To: <20140829000502.GC53982@vauxhall.crustytoothpaste.net>
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v6.20.7-Rev18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256253>



On August 28, 2014 at 8:05 PM "brian m. carlson"
<sandals@crustytoothpaste.net> wrote:
> On Thu, Aug 28, 2014 at 12:54:30AM -0400, dev wrote:
> > Funny I don't see libcurl anywhere. Thought that was needed? Also
> > the
> > RUNPATH
> > and RPATH look duplicated and slightly borked but the initial data
> > there
> > is correct enough to locate all the libs except for some strange
> > libz
> > issue.
>
> The main git binary is not linked with libcurl, only the HTTP and FTP
> programs.  You'd want to check git-remote-http, for instance.


wow ... you're right.  I had to go check to verify :

$ elfdump -d /usr/local/bin/git

Dynamic Section:  .dynamic
     index  tag                value
       [0]  NEEDED            0x11ef7             libpcre.so.1
       [1]  NEEDED            0x11f04             libz.so.1
       [2]  NEEDED            0x11f0e             libintl.so.8
       [3]  NEEDED            0x11f1b             libiconv.so.2
       [4]  NEEDED            0x11e67             libsocket.so.1
       [5]  NEEDED            0x11e91             libnsl.so.1
       [6]  NEEDED            0x11f29             libresolv.so.2
       [7]  NEEDED            0x11f38             libcrypto.so.1.0.0
       [8]  NEEDED            0x11ead             libpthread.so.1
       [9]  NEEDED            0x11ecf             libc.so.1
      [10]  INIT              0x1003e2f28
      [11]  FINI              0x1003e2f38
      [12]  RUNPATH           0x11f4b
            /usr/local/lib:/usr/local/ssl/lib
      [13]  RPATH             0x11f4b
            /usr/local/lib:/usr/local/ssl/lib
      [14]  HASH              0x100000178
      [15]  STRTAB            0x100018b08
      [16]  STRSZ             0x1216d
      [17]  SYMTAB            0x100006418
      [18]  SYMENT            0x18
      [19]  CHECKSUM          0x2dce
      [20]  VERNEED           0x10002ac78
      [21]  VERNEEDNUM        0x4
      [22]  PLTRELSZ          0x1338
      [23]  PLTREL            0x7
      [24]  JMPREL            0x10002c6c0
      [25]  RELA              0x10002c630
      [26]  RELASZ            0x13c8
      [27]  RELAENT           0x18
      [28]  DEBUG             0
      [29]  FLAGS             0                   0
      [30]  FLAGS_1           0                   0
      [31]  SUNW_STRPAD       0x200
      [32]  SUNW_LDMACH       0x2b                EM_SPARCV9
      [33]  PLTGOT            0x10053dc00
   [34-44]  NULL              0


cool.
