From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: libz and RHEL 5.9 compile of Git
Date: Wed, 22 Jan 2014 20:59:12 +0100
Message-ID: <52E02310.9090609@web.de>
References: <1390406392415-7602374.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: salmansheikh <salmanisheikh@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 22 20:59:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W63xO-0007vq-Rs
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 20:59:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755991AbaAVT7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 14:59:22 -0500
Received: from mout.web.de ([212.227.15.14]:50506 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755897AbaAVT7U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 14:59:20 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MZDki-1VrqUU1jdk-00KwBI for <git@vger.kernel.org>;
 Wed, 22 Jan 2014 20:59:18 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <1390406392415-7602374.post@n2.nabble.com>
X-Provags-ID: V03:K0:2HCXdLLWfm1pYRBsl1fZ48iD6ZVkgi/ORVq6QjBh+8vamt1D4tD
 vSmRNuw+WU8icUs8GJxcVIB/dY1nFyxmuz3UtRYzbLLJMgm2XavDsJP1IrzQvjntkooySs6
 Ob65dYdnerf2ZBm7f9ksxsWVfLZYVqgUGezbl8pldV7TS3jqMnSdflOkSCrToVakryM22zt
 ESau5RDpVDrb/E7OZQlIg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240849>

On 2014-01-22 16.59, salmansheikh wrote:
> Hello,
> 
> I have a RHEL system that I am not the admin of. I needed to install git and
> got the source. Everything is okay until I got to this point below. I
> downloaded and installed the latest libz (1.2.8) but i installed it under a
> local directory under my user name (i.e. /home/ssheikh/local). The problem
> is that git only looks in the locations below. I even have that directory in
> my $LD_LIBRARY_PATH. So, how can I force make to use that version of libz
> and not the old one that came with this RHEL 5.9 distro?
> 
> [ssheikh@gs-560g3080090e git-1.8.3.4]$ make
>     LINK git-credential-store
> /usr/bin/ld: skipping incompatible /lib/libz.so when searching for -lz
> /usr/bin/ld: skipping incompatible /usr/lib/libz.so when searching for -lz
> /usr/bin/ld: skipping incompatible /usr/lib/libz.a when searching for -lz
> /usr/bin/ld: cannot find -lz
> collect2: ld returned 1 exit status
> make: *** [git-credential-store] Error 1
> 
You need to tell the linker where to search for the library.
Please have a look at the Makefile:

ifdef ZLIB_PATH
	BASIC_CFLAGS += -I$(ZLIB_PATH)/include
	EXTLIBS += -L$(ZLIB_PATH)/$(lib) $(CC_LD_DYNPATH)$(ZLIB_PATH)/$(lib)
endif
