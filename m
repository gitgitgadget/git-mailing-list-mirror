From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: [BUG] git submodule update is not fail safe
Date: Fri, 04 Jan 2013 21:53:25 +0100
Message-ID: <50E74145.4020701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 04 21:59:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrEMW-0006eJ-NZ
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jan 2013 21:59:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754831Ab3ADU7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2013 15:59:08 -0500
Received: from mail-wg0-f51.google.com ([74.125.82.51]:57517 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754733Ab3ADU7F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2013 15:59:05 -0500
Received: by mail-wg0-f51.google.com with SMTP id gg4so7959970wgb.30
        for <git@vger.kernel.org>; Fri, 04 Jan 2013 12:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=LuM0k6yH77obdWshcXCTF+PYlMcgj1pCl7ZuaNgr24s=;
        b=dzHKWBTSDBIe3zXHSXHreWO3sL4i3eJ5DxOHRoxX31hhJWDxQQs/8Z3nUzJJQhZNSN
         2XF+edVqjX726BK211Xd+Cz+nXkltLoerztCZREIGmBAbUU9m6pzsx8Ib/bKznaTRfia
         /IhkfCf+3qMzq5kL/+nIVKAuIlPtFt6pqXzPr+6J5G/6licO+B6YWesKNWP3bZh5RGS+
         bt0WbNz9xWmLvcHRwoTcFC4+5hqfeFq6FrbNVSGmchKwhGwsx1o2sOdQChr5o3XAvgUz
         TQoddahT62ULQFFt+bLrW1KQTy6PS3IexWJc0xbV3kGfI5hN6zzcP/t3ZAEHX+uQjSgn
         Bf4Q==
X-Received: by 10.194.76.165 with SMTP id l5mr85627634wjw.14.1357332819598;
        Fri, 04 Jan 2013 12:53:39 -0800 (PST)
Received: from [192.168.0.3] ([151.70.204.244])
        by mx.google.com with ESMTPS id i2sm682464wiw.3.2013.01.04.12.53.35
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 04 Jan 2013 12:53:38 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212639>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

My network connection at times is rather unstable, so I can experience
all sort of network problems.

Today I tried to clone the qemu repository, and then to update all
submodules.

I'm using git from a recent master (790c83 - 14 December).

This is what happened:

$ git submodule update --init pixman
Submodule 'pixman' (git://anongit.freedesktop.org/pixman) registered for
path 'pixman'
Cloning into 'pixman'...
fatal: Unable to look up anongit.freedesktop.org (port 9418) (Name or
service not known)
Clone of 'git://anongit.freedesktop.org/pixman' into submodule path
'pixman' failed


$ git submodule update --init
Submodule 'roms/SLOF' (git://git.qemu.org/SLOF.git) registered for path
'roms/SLOF'
Submodule 'roms/ipxe' (git://git.qemu.org/ipxe.git) registered for path
'roms/ipxe'
Submodule 'roms/openbios' (git://git.qemu.org/openbios.git) registered
for path 'roms/openbios'
Submodule 'roms/qemu-palcode' (git://repo.or.cz/qemu-palcode.git)
registered for path 'roms/qemu-palcode'
Submodule 'roms/seabios' (git://git.qemu.org/seabios.git/) registered
for path 'roms/seabios'
Submodule 'roms/sgabios' (git://git.qemu.org/sgabios.git) registered for
path 'roms/sgabios'
Submodule 'roms/vgabios' (git://git.qemu.org/vgabios.git/) registered
for path 'roms/vgabios'
fatal: unable to connect to anongit.freedesktop.org:
anongit.freedesktop.org[0: 131.252.210.161]: errno=Connection timed out

Unable to fetch in submodule path 'pixman'


$ git submodule update --init
fatal: Needed a single revision
Unable to find current revision in submodule path 'pixman'


The problem is easy to solve: manually remove the pixman directory;
however IMHO git submodule update should not fail this way since it may
confuse the user.

I'm sorry for not sending a patch.



Regards   Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDnQUUACgkQscQJ24LbaUSgVACglJjFxB51VINOCe9Z39/XEEUH
6+QAnAwdQerBSjVSS1/3eNXSBfnR0yba
=eOJT
-----END PGP SIGNATURE-----
