From: "Le" <le_wen@distributel.ca>
Subject: Re: Bugs in sub argsfromdir of git-cvsserver
Date: Mon, 22 Dec 2008 16:42:23 -0500
Message-ID: <495009BF.3070306@distributel.ca>
References: <494FF9A9.9060706@distributel.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 22 22:43:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEsYt-0003XX-M0
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 22:43:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754738AbYLVVmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 16:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754657AbYLVVmU
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 16:42:20 -0500
Received: from ottexbe01.corp.distributel.ca ([206.80.252.36]:19244 "EHLO
	ottexbe01.corp.distributel.ca" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754523AbYLVVmU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Dec 2008 16:42:20 -0500
thread-index: Aclkfin/IhMV5CCvQz6Ape3xbs3w1w==
Content-Class: urn:content-classes:message
Importance: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4073
Received: from [192.168.1.46] ([192.168.1.46]) by ottexbe01.corp.distributel.ca with Microsoft SMTPSVC(6.0.3790.3959); Mon, 22 Dec 2008 16:42:18 -0500
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.17) Gecko/20080829 SeaMonkey/1.1.12 (Ubuntu-1.1.12+nobinonly-0ubuntu1)
In-Reply-To: <494FF9A9.9060706@distributel.ca>
X-OriginalArrivalTime: 22 Dec 2008 21:42:18.0974 (UTC) FILETIME=[29FAF7E0:01C9647E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103774>

Le wrote:
> Hi, all,
>
> I found a bug in git-cvsserver.
> sub argsfromdir
> {
>
>    if ( scalar(@{$state->{args}}) == 1 )
>    {
>        my $arg = $state->{args}[0];
>        #$arg .= $state->{prependdir} if ( defined ( 
> $state->{prependdir} ) );
>        $arg = $state->{prependdir} . $arg if ( defined ( 
> $state->{prependdir} ) );
>        $log->info("Only one arg specified, checking for directory 
> expansion on '$arg'");
> ...
>    }
> ...
> }
>
> It makes not sense of the above remarked out code.
>
> But when I use the code followed remarked out, I have problem to use 
> cvs diff or cvs log in a sub directory of the root (may other commands 
> as well). Eg.:
>
> I have a project called test1 and in test1 there is a test2 
> subdirectory and a file test2/test3.txt.
> I have no problem to cvs diff and cvs log in test1 directory. But if I 
> enter test1/test2 to check these commands then they are not working.
>
> I tried to fixed the problem to remarked out the code:
> #$filename = filecleanup($filename);
> in req_log and req_diff, then both cvs diff and cvs log work.
>
> In
> sub filecleanup
> {
> ...
> $filename = $state->{prependdir} . $filename;
> return $filename;
> }
>
> inserts $state->{prependdir} into the $filename.
>
> But I don't know if what I did brings incompatibilities.
>
> Can anybody check this issue?
>
> Thanks!
>
> Le Wen
> -- 
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
It seems that req_up and req_status need to be changed as well. I am not 
which subs need to be changed.

Le Wen
