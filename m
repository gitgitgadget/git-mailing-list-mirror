From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] abspath.c: use PATH_MAX in real_path_internal()
Date: Sat, 19 Jul 2014 19:51:05 +0700
Message-ID: <CACsJy8Dq9Em8qZtkep+iVE2M9GPM5RN0oyvyt-nWwK50kSmsQQ@mail.gmail.com>
References: <1405601143-31354-1-git-send-email-pclouds@gmail.com>
 <53C80265.5030903@web.de> <53C8562C.4000304@gmail.com> <CACsJy8D5X5svApB9edHK+1EaGi+q2ZRSOvyDYaDieVV2psgZPg@mail.gmail.com>
 <53C9387D.4090504@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sat Jul 19 14:51:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8U77-0001HE-Oh
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 14:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681AbaGSMvh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jul 2014 08:51:37 -0400
Received: from mail-qc0-f178.google.com ([209.85.216.178]:53236 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754627AbaGSMvg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jul 2014 08:51:36 -0400
Received: by mail-qc0-f178.google.com with SMTP id x3so4346789qcv.9
        for <git@vger.kernel.org>; Sat, 19 Jul 2014 05:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=8coa+lgAaYavsb91sJYwr/eYYlwLv9P/hj0UqHFzadU=;
        b=mTy2CSr1I/34/g+GnO4CN48UvjSObw6yTm8Eybza0IPv36D7CG02jOtnxHUhJjxSvz
         S/ry68qOkUvRym5y5+Y4a9OFNwgK0VuXKKJHPBur0kU2jpk3MxXOIfkYoIy2oYapWdQI
         eQlhfFmoAj8sR0lCY1wB2vSuFY24hiSmNrdzOqH8JpVT+uyZTRThDB3tKqBVLN35unev
         FW8W31QTD4Dwd1qHYLbMLMtJUELEvGgs2yM/TSfXdSrX8k8Yn1hjovBjFQRyxg+jcOy9
         LFPJHPizylO1UAVaz8/r7F1qj9HFBLOxRPYfeypHXAplX6AGI6UgBj+VVtWN13+dT1OS
         1l+w==
X-Received: by 10.140.106.74 with SMTP id d68mr17651719qgf.103.1405774295527;
 Sat, 19 Jul 2014 05:51:35 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Sat, 19 Jul 2014 05:51:05 -0700 (PDT)
In-Reply-To: <53C9387D.4090504@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253878>

On Fri, Jul 18, 2014 at 10:08 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrot=
e:
>> We could wrap this "get cwd, cd back" pattern as well. So "save_cwd"
>> returns an opaque pointer, "go_back" takes the pointer, (f)chdir bac=
k
>> and free the pointer if needed. On platforms that support fchdir, it
>> can be used, else we fall back to chdir. I think there are only four
>> places that follow this pattern, here, setup.c (.git discovery), git=
=2Ec
>> (restore_env) and unix-socket.c. Enough call sites to make it worth
>> the effort?
>
> On a cursory look I didn't find any more potential users.  Something
> like this?

I think it looks nice.

> Applying it to setup.c looks difficult to impossible, though.

Yeah, setup.c needs cwd as a string because it does something else to
cwd besides going back. Too bad.
--=20
Duy
