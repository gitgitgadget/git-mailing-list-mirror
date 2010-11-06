From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 8/8] Remove pack file handling dependency from wrapper.o
Date: Sat, 6 Nov 2010 13:42:51 -0500
Message-ID: <20101106184251.GA14288@burratino>
References: <20101106113905.GA27405@burratino>
 <20101106115237.GH27641@burratino>
 <4CD5996F.6010809@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Nov 06 19:43:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEnjL-0007Za-88
	for gcvg-git-2@lo.gmane.org; Sat, 06 Nov 2010 19:43:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026Ab0KFSnE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Nov 2010 14:43:04 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:54079 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674Ab0KFSnC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Nov 2010 14:43:02 -0400
Received: by gwj21 with SMTP id 21so2737151gwj.19
        for <git@vger.kernel.org>; Sat, 06 Nov 2010 11:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=eZ/QrWWcc9ylKyfpGl+eXDB66p/4QNnXbzYjnhOmca4=;
        b=L7yrY/yUmY6SJgj3DWXeoYGjP1QJ+rJ6JQzBW5w/JYxw4PRu+AMSMCFaH56VKiYuRw
         X3gQWe9XPYDsnEbh6uPaxhQplMKmmF0e9EvzWNDhcgc1t2pm64A7EJvUT0oWuas7joYW
         aBrOdeEBAFnxY2+jfZf4cNTsahl1vJU/SJCqc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=MTlzj8Bhaqe6Fm3yezh5xkHcCQ2eP4AemOLq+GmxDU1Oe2p3fh1xFd0xNzFPJAjNDu
         pUOgaWCxgg1R0mcgsiHnvtb+HCU7cGNtw/ZK9sP1McaHBNkd90djD8Dujoo8IyxGlpy/
         HYzaUxceL5HO+5l8lLpL3UTF0GkKUG5DK4s/8=
Received: by 10.150.144.10 with SMTP id r10mr5696615ybd.120.1289068981464;
        Sat, 06 Nov 2010 11:43:01 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id r18sm2082786yba.15.2010.11.06.11.42.59
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 06 Nov 2010 11:43:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4CD5996F.6010809@lsrfire.ath.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160854>

Ren=C3=A9 Scharfe wrote:

> Ugh.  Having to remember setting this handler is tedious.
>=20
> Can it be set automatically once the first pack is loaded?  A quick l=
ook
> suggests that use_pack() would be the right place to do it.

Maybe add_packed_git()?

use_pack() is called by:

 pack-objects::check_pack_inflate
 pack-objects::copy_pack_data
 pack-objects::check_object
 check_pack_crc
 verify_pack
 get_size_from_delta
 sha1_file::get_delta_base
 sha1_file::unpack_object_header
 packed_object_info_detail
 sha1_file::unpack_compressed_entry

some of which would make me worry about thread-safety.
