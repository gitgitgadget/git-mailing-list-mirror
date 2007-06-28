From: Andy Parkins <andyparkins@gmail.com>
Subject: Bug: segfault during git-prune
Date: Thu, 28 Jun 2007 11:34:58 +0100
Message-ID: <200706281134.58453.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 28 12:35:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3rLH-0006v5-M9
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 12:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756254AbXF1KfM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 28 Jun 2007 06:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755237AbXF1KfM
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 06:35:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:51493 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755504AbXF1KfJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jun 2007 06:35:09 -0400
Received: by ug-out-1314.google.com with SMTP id j3so547439ugf
        for <git@vger.kernel.org>; Thu, 28 Jun 2007 03:35:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=U/X7Oexi1LzC+TPV3C0E3UoHEoir0v1ovoIlUVTWVc83ZZlBhxedD0ynMFMxfLg+Fy3PhlWnb11vBPxiwGZ0vcXbCMVIcJpVGEKe1KftuhX1TKM92kVUdBpULY9n504r8FOpZbNWO9qj7Wc37O7T5nzj2bBQO3LUk5r17t3tzsM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=j+jYg9fZ2IPaDu7JdMNraYg6q8Ad7a+N0B82IOx/aXctCRtKNAn6QGQHwr7ci+tBa7kzdWMo0AyNIIz7zoyo9fL8Gt6ieMmrAzhSXGM1BKUcWVP6whJ4l+4e1y/nFa38DuyIjxoyfNhEu2LsS4Oy6mGAFQ+iDN3Y4ekd0z7rKwE=
Received: by 10.82.182.1 with SMTP id e1mr3441251buf.1183026904715;
        Thu, 28 Jun 2007 03:35:04 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id z40sm5878681ikz.2007.06.28.03.35.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Jun 2007 03:35:01 -0700 (PDT)
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51092>

Hello,

I ran git-prune on a repository and got this:

$ git-prune
error: Object 228f8065b930120e35fc0c154c237487ab02d64a is a blob, not a=
 commit
Segmentation fault (core dumped)
$ git-cat-file -t 228f8065b930120e35fc0c154c237487ab02d64a
commit

git-show of the object shows it looks okay.  git-fsck just shows a load
of dangling objects - which isn't a surprise, that's why I was running
git-prune.

Here's the backtrace:

parse_commit_buffer (item=3D0x0, buffer=3D0x81124b8, size=3D421) at com=
mit.c:292
#1  0x0808ad22 in parse_object_buffer (sha1=3D0x8111ac5 "\"\217\200e=C2=
=B90\022\0165=C3=BC\f\025L#t\207=C2=AB\002=C3=96J", type=3DOBJ_COMMIT, =
size=3D421, buffer=3D0x81124b8,
    eaten_p=3D0xafdc6c40) at object.c:152
#2  0x0808adb7 in parse_object (sha1=3D0x8111ac5 "\"\217\200e=C2=B90\02=
2\0165=C3=BC\f\025L#t\207=C2=AB\002=C3=96J") at object.c:187
#3  0x0808d1a2 in add_one_ref (path=3D0x8111aed "refs/remotes/libswscal=
e-svn", sha1=3D0x8111ac5 "\"\217\200e=C2=B90\022\0165=C3=BC\f\025L#t\20=
7=C2=AB\002=C3=96J", flag=3D6,
    cb_data=3D0xafdc6d40) at reachable.c:124
#4  0x0809133e in do_one_ref (base=3D<value optimized out>, fn=3D0x808d=
190 <add_one_ref>, trim=3D0, cb_data=3D0xafdc6d40, entry=3D0x8111ac0) a=
t refs.c:478
#5  0x08092be4 in do_for_each_ref (base=3D0x80c8e76 "refs/", fn=3D0x808=
d190 <add_one_ref>, trim=3D0, cb_data=3D0xafdc6d40) at refs.c:545
#6  0x0808cff4 in mark_reachable_objects (revs=3D0xafdc6d40, mark_reflo=
g=3D1) at reachable.c:188
#7  0x08071c90 in cmd_prune (argc=3D1, argv=3D0xafdc7074, prefix=3D0x0)=
 at builtin-prune.c:93
#8  0x0804aa24 in handle_internal_command (argc=3D1, argv=3D0xafdc7074,=
 envp=3D<value optimized out>) at git.c:348
#9  0x0804b4c9 in main (argc=3D1, argv=3DCannot access memory at addres=
s 0xe

So, I think there are two faults: git-prune is deciding that the object=
 is
a blob, when it's actually a commit; and git-prune's error handling is =
broken
in that case, because it's continuing with the NULL pointer returned by
check_commit() when obj->type !=3D OBJ_COMMIT.



Andy
--=20
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
