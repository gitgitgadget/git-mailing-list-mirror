From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH] rev-parse: fix potential bus error with --parseopt option spec handling
Date: Tue, 26 Feb 2008 09:45:29 -0500
Message-ID: <76718490802260645i8bd74b0mf643820f5cfb1aa0@mail.gmail.com>
References: <1203998859-86344-1-git-send-email-jaysoffian@gmail.com>
	 <alpine.LSU.1.00.0802261126130.17164@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 26 15:47:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU14M-0003yR-7g
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 15:46:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbYBZOpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 09:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbYBZOpd
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 09:45:33 -0500
Received: from el-out-1112.google.com ([209.85.162.182]:18406 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbYBZOpc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 09:45:32 -0500
Received: by el-out-1112.google.com with SMTP id v27so1869285ele.23
        for <git@vger.kernel.org>; Tue, 26 Feb 2008 06:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=y8GacEBOHrisDX7CasWgr6DI29CiZmq8IkZjG0jck88=;
        b=sql0dx3hvQIQsuixd/4BRmR+kmvfEbMlO+RypB2zvgB/itHC0UiQrwR/IqM5CODuwOAuQKKQOSRvdd0mCPgrXMX6GrF9eLtzCQYETV6GlgGmoSgAJssG/qVOy1Il2drjZKQLYtf97HigrlvTSeNdMSobesAZd7XEjiDfRznkRLI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=x4yOSZBBLv+cltayARkOsFv9t2AJ1ZcZmPOaXLOEeocUm7vhgGC/zsYNFOULne3q+jPTwi1/wzEWfoi9EGi4Ii4rpV1CBnmbTHiayiJr645+uVDzjxfS1lZ2PRQxw7NkajtXr6lKlurKcbROEbx3/+5sBXkgXZG+08Fr8cUeWFw=
Received: by 10.114.124.1 with SMTP id w1mr5527000wac.114.1204037129728;
        Tue, 26 Feb 2008 06:45:29 -0800 (PST)
Received: by 10.114.13.5 with HTTP; Tue, 26 Feb 2008 06:45:29 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802261126130.17164@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75141>

On Tue, Feb 26, 2008 at 6:26 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>  Looks obviously correct, but I would have expected a SIGSEGV, not a
>  SIGBUS.

For your entertainment only, the OS X crash log. [Please don't make
fun of me for using tcsh, I'm been meaning to switch to bash for about
10 years now. :-) ]

Process:         git [86324]
Path:            /opt/git/bin/git
Identifier:      git
Version:         ??? (???)
Code Type:       X86 (Native)
Parent Process:  tcsh [80929]

Date/Time:       2008-02-25 23:05:42.717 -0500
OS Version:      Mac OS X 10.5.2 (9C31)
Report Version:  6

Exception Type:  EXC_BAD_ACCESS (SIGBUS)
Exception Codes: KERN_PROTECTION_FAILURE at 0x0000000000000000
Crashed Thread:  0

Thread 0 Crashed:
0   git                           	0x000497f6 skipspaces + 6
1   git                           	0x00049b83 cmd_parseopt + 867
2   git                           	0x0004a355 cmd_rev_parse + 709
3   git                           	0x00001df0 handle_internal_command + 240
4   git                           	0x00001fff main + 191
5   git                           	0x00001876 start + 54

Thread 0 crashed with X86 Thread State (32-bit):
  eax: 0x00000000  ebx: 0x0004982d  ecx: 0x00805a00  edx: 0x00000000
  edi: 0x00000000  esi: 0x002006e0  ebp: 0xbffff308  esp: 0xbffff304
   ss: 0x0000001f  efl: 0x00010246  eip: 0x000497f6   cs: 0x00000017
   ds: 0x0000001f   es: 0x0000001f   fs: 0x00000000   gs: 0x00000037
  cr2: 0x00000000

Binary Images:
    0x1000 -    0xcaffb +git ??? (???) /opt/git/bin/git
  0x100000 -   0x12bffb  libcurl.4.dylib ??? (???)
<54ada27deb3b4ff7043d8836264eca0d> /usr/lib/libcurl.4.dylib
0x8fe00000 - 0x8fe2da53  dyld 96.2 (???)
<7af47d3b00b2268947563c7fa8c59a07> /usr/lib/dyld
0x9001b000 - 0x9001ffff  libmathCommon.A.dylib ??? (???)
/usr/lib/system/libmathCommon.A.dylib
0x90f51000 - 0x910b0ff3  libSystem.B.dylib ??? (???)
<4899376234e55593b22fc370935f8cdf> /usr/lib/libSystem.B.dylib
0x910fe000 - 0x9111cfff  libresolv.9.dylib ??? (???)
<0629b6dcd71f4aac6a891cbe26253e85> /usr/lib/libresolv.9.dylib
0x92898000 - 0x928a6ffd  libz.1.dylib ??? (???)
<5ddd8539ae2ebfd8e7cc1c57525385c7> /usr/lib/libz.1.dylib
0x92beb000 - 0x92bf2fe9  libgcc_s.1.dylib ??? (???)
<f53c808e87d1184c0f9df63aef53ce0b> /usr/lib/libgcc_s.1.dylib
0x93b48000 - 0x93bf8fff  edu.mit.Kerberos 6.0.12 (6.0.12)
<9e98dfb4cde8b0510fdd972dc9fa1dc9>
/System/Library/Frameworks/Kerberos.framework/Versions/A/Kerberos
0x93c2c000 - 0x93d64ff7  libicucore.A.dylib ??? (???)
<afcea652ff2ec36885b2c81c57d06d4c> /usr/lib/libicucore.A.dylib
0x93d66000 - 0x93e98fef  com.apple.CoreFoundation 6.5.1 (476.10)
<d5bed2688a5eea11a6dc3a3c5c17030e>
/System/Library/Frameworks/CoreFoundation.framework/Versions/A/CoreFoundation
0x93ea9000 - 0x93f06ffb  libstdc++.6.dylib ??? (???)
<04b812dcec670daa8b7d2852ab14be60> /usr/lib/libstdc++.6.dylib
0x93f07000 - 0x93fe6fff  libobjc.A.dylib ??? (???)
<a53206274b6c2d42691f677863f379ae> /usr/lib/libobjc.A.dylib
0x95207000 - 0x95232fe7  libauto.dylib ??? (???)
<42d8422dc23a18071869fdf7b5d8fab5> /usr/lib/libauto.dylib
0x95773000 - 0x95825ffb  libcrypto.0.9.7.dylib ??? (???)
<330b0e48e67faffc8c22dfc069ca7a47> /usr/lib/libcrypto.0.9.7.dylib
0x95f15000 - 0x960e0ff7  com.apple.security 5.0.2 (33001)
<0788969ffe7961153219be10786da436>
/System/Library/Frameworks/Security.framework/Versions/A/Security
0x961f4000 - 0x96218feb  libssl.0.9.7.dylib ??? (???)
<acee7fc534674498dcac211318aa23e8> /usr/lib/libssl.0.9.7.dylib
0x96790000 - 0x96884ff4  libiconv.2.dylib ??? (???)
<c508c60fafca17824c0017b2e4369802> /usr/lib/libiconv.2.dylib
0xfffe8000 - 0xfffebfff  libobjc.A.dylib ??? (???) /usr/lib/libobjc.A.dylib
0xffff0000 - 0xffff1780  libSystem.B.dylib ??? (???) /usr/lib/libSystem.B.dylib
