From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 0/8] Fix GIT_CEILING_DIRECTORIES that contain symlinks
Date: Mon, 22 Oct 2012 10:26:38 +0200
Message-ID: <5085033E.2070607@alum.mit.edu>
References: <1350799057-13846-1-git-send-email-mhagger@alum.mit.edu> <7v7gqkgvxe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	David Reiss <dreiss@facebook.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 22 10:26:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQDLb-0000FT-Pr
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 10:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910Ab2JVI0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2012 04:26:44 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:60547 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750793Ab2JVI0n (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Oct 2012 04:26:43 -0400
X-AuditID: 12074411-b7fa36d0000008cc-d7-508503428f71
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 9E.45.02252.24305805; Mon, 22 Oct 2012 04:26:42 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q9M8Qcab004651
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Oct 2012 04:26:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121011 Thunderbird/16.0.1
In-Reply-To: <7v7gqkgvxe.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsUixO6iqOvE3Bpg8PCViMWRN0+YLbqudDNZ
	NPReYbZ4Mvcus8XRUxYW699dZXZg83jT3svosXPWXXaPh6+62D0uXlL2+LxJLoA1itsmKbGk
	LDgzPU/fLoE7Y988g4IHvBWTHlxibWA8z9XFyMkhIWAisXHxbDYIW0ziwr31YLaQwGVGiTXr
	gGwuIPs4k0TfhxPsIAleAW2JF1sbmUBsFgFViVW7NjCD2GwCuhKLeprB4qICYRLLd25mgqgX
	lDg58wkLiC0ioCYxse0QC8hQZoHNjBJPbnUygiSEBXwlrh6fxwSxOU9iybujYEM5Bcwkep/P
	B1vMLKAj8a7vATOELS+x/e0c5gmMArOQ7JiFpGwWkrIFjMyrGOUSc0pzdXMTM3OKU5N1i5MT
	8/JSi3RN9XIzS/RSU0o3MUJCXXAH44yTcocYBTgYlXh4b99sCRBiTSwrrsw9xCjJwaQkynvv
	D1CILyk/pTIjsTgjvqg0J7X4EKMEB7OSCK8rQ2uAEG9KYmVValE+TEqag0VJnJdvibqfkEB6
	YklqdmpqQWoRTFaGg0NJgleSCahRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhSp
	8cXAWAVJ8QDt1Qdp5y0uSMwFikK0nmLU5fjYOO8hoxBLXn5eqpQ4rwZIkQBIUUZpHtwKWGJ7
	xSgO9LEwry5IFQ8wKcJNegW0hAloiTl3I8iSkkSElFQDY9CT52czpj+piHX1uPRIP/pP5IkN
	zvr/bj1WV3c8d1074Pv1qZmlH+dUlV2KOTqhbqrlb6a+42b1Lf/iI59/2b6xtbD5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208177>

On 10/21/2012 08:51 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> This patch series has the side effect that all of the directories
>> listed in GIT_CEILING_DIRECTORIES are accessed *unconditionally* to
>> resolve any symlinks that are present in their paths.  It is
>> admittedly odd that a feature intended to avoid accessing expensive
>> directories would now *intentionally* access directories near the
>> expensive ones.  In the above scenario this shouldn't be a problem,
>> because /home would be the directory listed in
>> GIT_CEILING_DIRECTORIES, and accessing /home itself shouldn't be
>> expensive.
> 
> Interesting observation.  In the last sentence, "accessing /home"
> does not exactly mean accessing /home, but accessing / to learn
> about "home" in it, no?

This is the extra overhead on my system for using
GIT_CEILING_DIRECTORIES=/home:

stat("/home", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
getcwd("/home/mhagger", 1024)           = 14
chdir("/home")                          = 0
getcwd("/home", 4096)                   = 6
lstat("/home", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
chdir("/home/mhagger")                  = 0

If I use GIT_CEILING_DIRECTORIES=/dev/shm, which is a symlink to
/run/shm on my system, the overhead is comparable:

stat("/dev/shm", {st_mode=S_IFDIR|S_ISVTX|0777, st_size=200, ...}) = 0
getcwd("/home/mhagger", 1024)           = 14
chdir("/dev/shm")                       = 0
getcwd("/run/shm", 4096)                = 9
lstat("/run/shm", {st_mode=S_IFDIR|S_ISVTX|0777, st_size=200, ...}) = 0
chdir("/home/mhagger")                  = 0

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
