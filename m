From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/5] en/object-list-with-pathspec (v3?)
Date: Wed, 8 Sep 2010 19:58:00 +1000
Message-ID: <AANLkTi=xHCXZKjuGrjYmFS_yH4RaSPtgA1QFzVrGgVuZ@mail.gmail.com>
References: <1283874483-32017-1-git-send-email-pclouds@gmail.com> <AANLkTimFRUfK2+yNGkgJX8K-0N5QYOp4ud2O7afH_iNz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 12:03:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtHUb-00049R-NF
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 12:03:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757532Ab0IHKC4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 06:02:56 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41662 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754598Ab0IHKCz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Sep 2010 06:02:55 -0400
Received: by eyb6 with SMTP id 6so2869330eyb.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 03:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=wuWiI3LfpH2s5+xA9Wsy4kDWBJ4jK1N8NoDuEjr7cno=;
        b=SxUG2M/Z/RienlVluQhbmWAK98qWTv/H7plHzu0kHCZz1y4ct1W8U4Z6jSoMjI0VNv
         7WbiEpcI31OMjpClvknj6KXiK7h0ymbeube8aqx4hbhJsTpCDWVP9QUIbxzyIgypXRUH
         fXL0/ebh/O59L4uoVCnZXNXPgSX6L6isYTF8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Im0Vmau9QOVMGVSxnRZuJinjl7FsWa91HGeIxQQ0vbbUb1ygxOfYALSllkZqLSxGxX
         Ey5P5ipkTXFYnEdGqbUm2rYYJyTxvISwPC5M2sgHgKfwkKmvUgvn1n24kcQJXTFtEds2
         BwaRWD1Ru3GQ3FBRZvo8ZE/PmYQF0axoxh6CU=
Received: by 10.216.145.198 with SMTP id p48mr1046495wej.18.1283940173680;
 Wed, 08 Sep 2010 03:02:53 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Wed, 8 Sep 2010 02:58:00 -0700 (PDT)
In-Reply-To: <AANLkTimFRUfK2+yNGkgJX8K-0N5QYOp4ud2O7afH_iNz@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155778>

2010/9/8 Elijah Newren <newren@gmail.com>:
> 2010/9/7 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>:
>> Changes from last time is tree_entry_interesting() now takes
>> struct exclude * as the pathspecs.
>>
>> I think there'll be a bit of performance loss because diff_options.e=
l
>> is not initialized from the beginning. But that requires more change=
s
>> outside tree-diff.c (makes sure that diff_options.el is copied prope=
rly,
>> makes sure that diff_tree_setup_* is called ...) So one step at a ti=
me.
>> I'm working on it.
>
> Looks reasonable to me so far. =C2=A0I believe your series already ma=
kes
> nr_paths, paths, and pathlens fields from diff_options unused (other
> than via exclude_list) -- yes? =C2=A0If so, that suggests that we cou=
ld
> just modify diff_tree_setup_paths() to do the work that your new
> diff_tree_setup_exclude_lists() is doing (and to take an exclude_list=
*
> instead of a diff_options*). =C2=A0Then you wouldn't need to worry ab=
out
> doing the setup "on-the-fly" and the performance differences should g=
o
> away.

They are used elsewhere, passed around as prune data, even fed to
read_cache_preload().. so they won't go away soon.

> Am I understanding correctly, and is that the route you're going?

Yes. Except that both nr_paths, paths and pathlens will stay along with
exclude_list. Getting rid of "paths" takes time (the other two fields a=
re
easier to deal with).
--=20
Duy
