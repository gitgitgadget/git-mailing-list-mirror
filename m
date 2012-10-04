From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: git pull takes ~8 seconds on up-to-date Linux git tree
Date: Thu, 4 Oct 2012 16:14:54 +0200
Message-ID: <20121004141454.GA246@x4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 00:25:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtZJ-0001w8-My
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925Ab2JDOO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 10:14:57 -0400
Received: from ud10.udmedia.de ([194.117.254.50]:42968 "EHLO
	mail.ud10.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964793Ab2JDOO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 10:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=mail.ud10.udmedia.de; h=
	date:from:to:subject:message-id:mime-version:content-type; s=
	beta; bh=/nBUbUz9FzVrtMC0wit4tDrogmJj6CR4XYP84hNdzC0=; b=HGDzpQz
	z8a49K0nSm/Z4tKK4N2e++m4OQzrk/qJOQYxsy2J+ClqiJmjvbb+DqnxIUG+GzGQ
	hpUQGD9n5vNALErsrl59iLcyf2PkG+NaBeZ06FINgdFxD1UZnekkft6yb1FWbx15
	gwsPmn4bfmkR3M31unkUxUQ2681ZUDaSBqsQ=
Received: (qmail 26289 invoked from network); 4 Oct 2012 16:14:54 +0200
Received: from unknown (HELO x4) (ud10?360p3@91.65.91.246)
  by mail.ud10.udmedia.de with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 4 Oct 2012 16:14:54 +0200
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206999>

Hi,

with current trunk I get the following on an up-to-date Linux tree:

markus@x4 linux % time git pull
Already up-to-date.
git pull  7.84s user 0.26s system 92% cpu 8.743 total

git version 1.7.12 is much quicker:

markus@x4 linux % time git pull
Already up-to-date.
git pull  0.10s user 0.02s system 16% cpu 0.740 total

perf shows for trunk:

    22.11%  git-merge  libz.so.1.2.7          [.] 0x00000000000073bc           
    22.03%        git  libz.so.1.2.7          [.] 0x0000000000007338           
    14.18%        git  libz.so.1.2.7          [.] inflate                      
    13.70%  git-merge  libz.so.1.2.7          [.] inflate                      
     9.18%        git  git                    [.] 0x00000000000ea391           
     8.56%  git-merge  git-merge              [.] 0x00000000000f0598           
     1.58%  git-merge  libz.so.1.2.7          [.] adler32                      
     1.52%        git  libz.so.1.2.7          [.] adler32                      
     0.59%        git  [kernel.kallsyms]      [k] clear_page_c

and for 1.7.12:

    39.29%        git  git                    [.] 0x00000000000b9fa8           
    12.16%        git  libz.so.1.2.7          [.] inflate                      
     8.67%        git  libz.so.1.2.7          [.] 0x000000000000a18e           
     8.49%  git-merge  git-merge              [.] 0x00000000000efa15           
     4.96%        git  libc-2.16.90.so        [.] memcpy@@GLIBC_2.14           
     2.63%        git  libc-2.16.90.so        [.] _int_malloc                  
     2.61%  git-merge  [kernel.kallsyms]      [k] clear_page_c                 
     2.32%        git  [kernel.kallsyms]      [k] clear_page_c                 
     2.04%        git  [kernel.kallsyms]      [k] filemap_fault                
     1.87%  git-merge  libc-2.16.90.so        [.] memcpy@@GLIBC_2.14  

-- 
Markus
