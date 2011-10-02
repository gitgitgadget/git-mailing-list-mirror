From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: how to produce an index with smudged entries
Date: Sun, 02 Oct 2011 15:10:24 +0200
Message-ID: <4E8862C0.7010906@dewire.com>
References: <CAENte7h-sbv7VTBdV7A+=TtONTpgOBBfVWz2Nejm1DqJJ9tFiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Christian Halstrick <christian.halstrick@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 02 15:10:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RALoQ-0003cw-67
	for gcvg-git-2@lo.gmane.org; Sun, 02 Oct 2011 15:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532Ab1JBNK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Oct 2011 09:10:29 -0400
Received: from mail.dewire.com ([83.140.172.130]:29618 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752382Ab1JBNK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Oct 2011 09:10:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 21F448003A4;
	Sun,  2 Oct 2011 15:10:25 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bpDZSc5dKJeJ; Sun,  2 Oct 2011 15:10:25 +0200 (CEST)
Received: from Robin-Rosenbergs-MacBook-Pro.local (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 78700800384;
	Sun,  2 Oct 2011 15:10:25 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:7.0) Gecko/20110916 Thunderbird/7.0
In-Reply-To: <CAENte7h-sbv7VTBdV7A+=TtONTpgOBBfVWz2Nejm1DqJJ9tFiQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182599>

Christian Halstrick skrev 2011-09-30 17.33:
> I am trying to find out how native git handles the racy git problem. I
> read https://raw.github.com/git/git/master/Documentation/technical/racy-git.txt.
> But I cannot reproduce the behaviour described in this text.

I guess that code is only likely to work if USE_NSEC is not set or the
file system has only whole second resolution. It might be very hard to 
reproduce the situation since the likehood that a file AND the index has 
the same timestamp at the subsecond level is very small. Nasty thing to 
test :)

Is your file system one that does not have subsecond timestamp 
resolution? The nanosecond part of the timestamp(s) should be 0 (byte 
24-27 for mtime for the first index entry).

Touch can set the timestamp to an explicit value, so you can use that 
instead of waiting for luck. Touch cannot set ctime, but you can make 
git ignore ctime by setting core.trustctime to false.

For testing the issue with nanosecond resolution you have to roll your 
own touch in C, perl or even Java.

-- robin
