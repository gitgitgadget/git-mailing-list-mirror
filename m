From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Does pack v4 do anything to commits?
Date: Sat, 18 Feb 2012 11:44:40 +0700
Message-ID: <CACsJy8CZPG3b3LBF-EFO_kOv6i157jy5414+bHcqiwOKyC+8VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Feb 18 05:45:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RycB9-0002yi-Lh
	for gcvg-git-2@plane.gmane.org; Sat, 18 Feb 2012 05:45:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975Ab2BREpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 23:45:12 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38125 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116Ab2BREpL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 23:45:11 -0500
Received: by wgbdt10 with SMTP id dt10so3260653wgb.1
        for <git@vger.kernel.org>; Fri, 17 Feb 2012 20:45:10 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.216.136.211 as permitted sender) client-ip=10.216.136.211;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.216.136.211 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.216.136.211])
        by 10.216.136.211 with SMTP id w61mr328502wei.18.1329540310340 (num_hops = 1);
        Fri, 17 Feb 2012 20:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=imTYw7+IqvZKEhH1icV8om3qAEZk1E1Xa+Pu2CCY7as=;
        b=QKc4Db2IX3S2ocweQymkmbGmGx27EunNkRotv+dTstOvyqtgyhPU08CHwHzJ7an0FJ
         0hPrNLXiNT6d7Ytxu488A5dFzvUPzER9avE7VgOwZ8TAq0Nve7el/iBPaptaHt32UJ3n
         16GN2lS8u9rbrgdn8LsCsYzkBHkv05lVE2aFI=
Received: by 10.216.136.211 with SMTP id w61mr282686wei.18.1329540310249; Fri,
 17 Feb 2012 20:45:10 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Fri, 17 Feb 2012 20:44:40 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190993>

Hi Nico,

I had an experiment on speeding up "rev-list --all". If I cache sha-1
of tree and parent, and committer date of single-parent commits, in
binary form, rev-list can be sped up significantly. On linux-2.6.git,
it goes from 14s to 4s (2s to 0.8 for git.git). Profiling shows that
commit parsing (get_sha1_hex, parse_commit_date) dominates rev-list
time.

>From what I remember, pack v4 is mainly about changing tree
representation so that we can traverse object DAG as fast as possible.
Do you do anything to commit representation too? Maybe it's worth
storing the above info along with the compressed commit objects in
pack to shave some more seconds.

By the way, is latest packv4 code available somewhere to fetch?
-- 
Duy
