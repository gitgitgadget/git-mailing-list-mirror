From: "Ping Yin" <pkufranky@gmail.com>
Subject: [bug] Working files created in bare repository when pushing to a rewound bare repository
Date: Mon, 31 Dec 2007 14:42:42 +0800
Message-ID: <46dff0320712302242m34b5267dlb3f26488293d5d51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 31 07:43:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9EMj-0004vz-Rz
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 07:43:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbXLaGmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2007 01:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbXLaGmo
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 01:42:44 -0500
Received: from py-out-1112.google.com ([64.233.166.177]:49355 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbXLaGmn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2007 01:42:43 -0500
Received: by py-out-1112.google.com with SMTP id u52so8877279pyb.10
        for <git@vger.kernel.org>; Sun, 30 Dec 2007 22:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=BM3QDcJGDeb1GOr/p+xoCpw1m/j3IY/RUskjO76KVmw=;
        b=aVsfrVq+NMJEPfEFcd4g4dLe+d+LXF7wE5n8RZ6tlja47mCgO1w7QedCOyskznFz/+ZEpL3ANVn73LgVCwaspoL5tm3nHsnxtgaybZjKGoTdRaDZEKh/FPR7881VQsssR5EnC6ij4VxaM+J3KSoBGQgs4U8OMxuahzahRbLs+EU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DixIAKslZu/KGCmKpZXKDS8NzpZde+hrwDI80Tz+my6QH8Z3Fp+IV8SIwC7JnmdGOKuELv4bMyBpq1JnefgxbQpZ0YE1Uhn2x1Q6p44ZJKvNG3bmRxWJwbiXEIEFPxjQwgAKJY8fcj0/H7tbYVbPp6mAPaGH3IAFWV06vCuCa1w=
Received: by 10.35.98.6 with SMTP id a6mr6428412pym.10.1199083362851;
        Sun, 30 Dec 2007 22:42:42 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Sun, 30 Dec 2007 22:42:42 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69386>

Following scripts can reproduce the problem: in the final line,
foo.txt is generated in bare foo.git

# create bare foo.git and its clone foo
mkdir foo
cd foo && echo foo>foo.txt &&
git init && git add . && git commit -m 'create project foo' && cd ..
cd foo && echo foo1>foo.txt && git commit -a -m "update foo.txt" && cd ..
git clone --bare foo foo.git && rm -rf foo
git clone foo.git foo

# reset bare and then push
cd foo.git && git reset --hard HEAD^ && cd ..
cd foo && git push && cd ..
ls foo.git

branches  config  description  *foo.txt*  HEAD  hooks  index  info
objects  ORIG_HEAD  refs

-- 
Ping Yin
