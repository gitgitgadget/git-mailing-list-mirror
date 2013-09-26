From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH v2 0/5] New hash table implementation
Date: Thu, 26 Sep 2013 12:16:48 +0200
Message-ID: <20130926101648.GD6615@paksenarrion.iveqy.com>
References: <522FAAC4.2080601@gmail.com>
 <52416058.90008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 26 12:09:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VP8VV-00023C-Fs
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 12:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755764Ab3IZKJI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Sep 2013 06:09:08 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:43987 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755Ab3IZKJH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 06:09:07 -0400
Received: by mail-la0-f54.google.com with SMTP id ea20so739020lab.13
        for <git@vger.kernel.org>; Thu, 26 Sep 2013 03:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=D9GsxJAMteCvpnteOu++a20J22n3VUzhja5LfzvwBkM=;
        b=p2qLYyAh2g7rlp2ylFVBTq2ZptCmRmhAD44/fBMxgO93hkLuqxjxldyS34PnFWEzUn
         oK16k1bWseOHJIVcXC/zTSBPgdw6gQ2OMaNiPUPJ8QnmJZEoWj0e0BXy5xYBTdxOtOHD
         EAbf34pRU6CYYWDDeSm6KlAk3Ie0++ZHz2ZwdmAHOhx5WncctlrA4Juje1BjG20v1gLO
         N4+VjT8DMHcxNvhXqZxhi3J/Z2PALqcCTKP57L+PS2CExQ3eOrvNmTWuxhfutIcjfZFM
         Rlfp05pqqgIjMPasIWjKZMGxojqriX8IFLUIGnQBNjuvaHGfl0/L7vy3YwExhKCDe0A7
         YuTA==
X-Received: by 10.152.19.97 with SMTP id d1mr103822lae.34.1380190145335;
        Thu, 26 Sep 2013 03:09:05 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-237-167.bredband.comhem.se. [83.250.237.167])
        by mx.google.com with ESMTPSA id ap7sm740427lac.10.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 26 Sep 2013 03:09:04 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1VP8cq-0000Xm-QN; Thu, 26 Sep 2013 12:16:48 +0200
Content-Disposition: inline
In-Reply-To: <52416058.90008@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235412>

On Tue, Sep 24, 2013 at 11:50:16AM +0200, Karsten Blees wrote:
> Tests can be reproduced with 'time echo "perfhash[map] <method> 1000"=
 | ./test-hashmap', see test-hashmap.c for definition of method flags.

So I'm still curious about the actual performance improvements for git.
I runned git describe on the linux kernel with both the old hashmap and
this new one:

With old hashmap
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
iveqy@minilla:/srv/slask/linux$ time ../git/git describe
v3.12-rc2-83-g4b97280

real    0m0.236s
user    0m0.216s
sys     0m0.020s
iveqy@minilla:/srv/slask/linux$ time ../git/git describe
v3.12-rc2-83-g4b97280

real    0m0.236s
user    0m0.220s
sys     0m0.016s
iveqy@minilla:/srv/slask/linux$ time ../git/git describe
v3.12-rc2-83-g4b97280

real    0m0.236s
user    0m0.212s
sys     0m0.024s

With new hashmap
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
iveqy@minilla:/srv/slask/linux$ time ../git/git describe
v3.12-rc2-83-g4b97280

real    0m0.236s
user    0m0.216s
sys     0m0.020s
iveqy@minilla:/srv/slask/linux$ time ../git/git describe
v3.12-rc2-83-g4b97280

real    0m0.235s
user    0m0.216s
sys     0m0.020s
iveqy@minilla:/srv/slask/linux$ time ../git/git describe
v3.12-rc2-83-g4b97280

real    0m0.235s
user    0m0.208s
sys     0m0.028s


I can't see any improvements at all here. What do I miss? Am I running
git describe in the wrong way? Does linux.git have too few tags to be
important?

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
