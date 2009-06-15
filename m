From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] daemon: send stderr of service programs to the syslog
Date: Mon, 15 Jun 2009 14:43:34 -0700
Message-ID: <4A36C086.5010306@zytor.com>
References: <200906142238.51725.j6t@kdbg.org> <200906152339.43607.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Jun 15 23:44:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGJyX-0007eb-8C
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 23:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934512AbZFOVnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 17:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755216AbZFOVnj
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 17:43:39 -0400
Received: from terminus.zytor.com ([198.137.202.10]:50864 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667AbZFOVni (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 17:43:38 -0400
Received: from anacreon.sc.intel.com (hpa@localhost [127.0.0.1])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.3/8.14.1) with ESMTP id n5FLhYGX028256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 15 Jun 2009 14:43:34 -0700
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <200906152339.43607.j6t@kdbg.org>
X-Virus-Scanned: ClamAV 0.94.2/9467/Mon Jun 15 01:11:58 2009 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121632>

Johannes Sixt wrote:
> On Sonntag, 14. Juni 2009, Johannes Sixt wrote:
>>  I don't know whether service programs like upload-archive or upload-pack
>>  write progress report to stderr or not, for example, if a client does not
>>  support side-bands. In this case this patch is probably not enough since
>>  this would fill the log with unneeded progress information. Any hints
>>  are appreciated.
> 
> The progress indicator can be helped . But there is now another anoyance: If 
> the client terminates the connection early, this is now logged as:
> 
> fatal: unable to run 'git-upload-pack'
> 
> The reason for this is that upload-pack is run as 'git upload-pack', which 
> itself spawns the external 'git-upload-pack'. The latter dies from a SIGPIPE, 
> and the former, in execv_dashed_external(), dutyfully writes this down.
> 
> The easiest solution is perhaps to make upload-pack a builtin.
> 
> BUT... The motivation, of which this patch is actually a fall-out, is to clean 
> up the messy error behavor of the start,finish,run_command family. To take 
> care of this error message is just one more (hopefully small) point on my 
> agenda.
> 

We probably do want to log that the client has disconnected.

	-hpa
