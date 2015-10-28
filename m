From: Victor Leschuk <vleschuk@gmail.com>
Subject: Re: Bug: Segfault when doing "git diff"
Date: Wed, 28 Oct 2015 16:54:18 +0300
Message-ID: <5630D38A.7080301@gmail.com>
References: <5630B876.7080407@sociomantic.com> <5630BE79.40708@gmail.com>
 <5630CF1B.9000706@sociomantic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: vleschuk@accesssoftek.com
To: "Mathias L. Baumann" <mathias.baumann@sociomantic.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 15:11:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrRS8-0000aQ-LW
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 15:11:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966268AbbJ1OLF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Oct 2015 10:11:05 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:34804 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966227AbbJ1NyV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 09:54:21 -0400
Received: by lfaz124 with SMTP id z124so4064554lfa.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2015 06:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=lp8YJzOnaIj/Ie+ISM6ailfAn45QAYJAMUJN5DZEOjI=;
        b=AGBlEzl/Io+uUB/q6JJxrHMHefDt8poVwpiOlGHHRY7eAA3tIzSVGk6vfM9dE1vbEY
         vN+EIpHU+VuHNZySx3dcgGw35TtRfTRez5fbNhCzZ5FgMcHrd4wjWXVOUWFQveY5mJ0q
         IGPbbtA5CNZRBm3W3JXqowW1rM7duxwniYP4/P4lZPtgQUUcoJpee54zb5SUgoz/EixX
         vdZJrrKR6jm28W9DeaiJ639PSoRudFTBIxjPd9AZfMjg23m3HO4NH8vH4TJLy57jPWMD
         FdxLilOHiAozd/DBUOk3zwZmnsjNv+3WI5QoQcpP/X348o2zUNybsKr+qmMXVOThsCSq
         J/Wg==
X-Received: by 10.25.149.210 with SMTP id x201mr2598928lfd.53.1446040460057;
        Wed, 28 Oct 2015 06:54:20 -0700 (PDT)
Received: from [192.168.1.101] (93-80-35-11.broadband.corbina.ru. [93.80.35.11])
        by smtp.gmail.com with ESMTPSA id k67sm5109195lfb.49.2015.10.28.06.54.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2015 06:54:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <5630CF1B.9000706@sociomantic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280366>



On 10/28/2015 04:35 PM, Mathias L. Baumann wrote:
> I was using the latest git version 2.6.2 already.
> I suspect it is due to a .gitconfig. This is what is probably require=
d:
>
> =E2=9E=9C  ~  cat .gitconfig
> [diff]
>     submodule =3D log
Yep, that did the trick.

The segfault is from

sha1_file.c:

/* add the alternate entry */
  *alt_odb_tail =3D ent; /* <=3D=3D=3D=3D=3D alt_obd_tail is NULL here =
*/
alt_odb_tail =3D &(ent->next);
ent->next =3D NULL;

Will try to take a closer look at it.

--
Victor
