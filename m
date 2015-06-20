From: Richard Weinberger <richard@nod.at>
Subject: broken repo after power cut
Date: Sat, 20 Jun 2015 21:40:38 +0200
Message-ID: <5585C1B6.50407@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: David Gstir <david@sigma-star.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 20 21:40:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6OdE-0002UN-BJ
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jun 2015 21:40:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbbFTTkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2015 15:40:42 -0400
Received: from a.ns.miles-group.at ([95.130.255.143]:65275 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932135AbbFTTkm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2015 15:40:42 -0400
Received: (qmail 23105 invoked by uid 89); 20 Jun 2015 19:40:39 -0000
Received: by simscan 1.3.1 ppid: 23100, pid: 23103, t: 0.0479s
         scanners: attach: 1.3.1
Received: from unknown (HELO ?192.168.0.11?) (richard@nod.at@213.47.235.169)
  by radon.swed.at with ESMTPA; 20 Jun 2015 19:40:39 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272239>

Hi!

Yesterday our git server faced a power cut and a git repository broke.
The server is running a ext4 filesystem on top of Linux 3.16 (stable from openSUSE) and git 2.1.4.
We had a backup, so no data was lost but I really would like to figure out
what happened.

This is the output of git fsck:
Checking object directories: 100% (256/256), done.
error: object file objects/ce/f7627fc160ad7294b1f728db0c1ddb65a38b1d is empty
error: object file objects/ce/f7627fc160ad7294b1f728db0c1ddb65a38b1d is empty
fatal: loose object cef7627fc160ad7294b1f728db0c1ddb65a38b1d (stored in objects/ce/f7627fc160ad7294b1f728db0c1ddb65a38b1d) is corrupt

To me it seems like git was creating a new object and got interrupted before fsync/fdatasync'ing it.
As the object was referenced before syncing the data to disk the repo broke.
Could this have happened?
Also, is git designed to survive power cuts? Then referencing an object before synching it do disk would make no sense.

Thanks,
//richard
