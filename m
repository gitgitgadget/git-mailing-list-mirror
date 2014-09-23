From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v5 19/35] commit_lock_file(): rollback lock file on failure
 to rename
Date: Tue, 23 Sep 2014 13:57:27 +0200
Message-ID: <54216027.90406@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu> <1410896036-12750-20-git-send-email-mhagger@alum.mit.edu> <20140916222207.GS29050@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 13:59:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWOiu-0005ch-CT
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 13:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754283AbaIWL5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 07:57:32 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:65218 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754054AbaIWL5a (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Sep 2014 07:57:30 -0400
X-AuditID: 1207440c-f79036d000005e77-1c-5421602a7d63
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 15.7B.24183.A2061245; Tue, 23 Sep 2014 07:57:30 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1DCD.dip0.t-ipconnect.de [93.219.29.205])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8NBvRC0017777
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 23 Sep 2014 07:57:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <20140916222207.GS29050@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRmVeSWpSXmKPExsUixO6iqKuVoBhi8GY5h0XXlW4mi4beK8wW
	T+beZbZ4e3MJo8WPlh5mi38Taiw6O74yOrB77Jx1l91jwaZSj4evutg9nvXuYfS4eEnZ4/Mm
	OY/bz7axBLBHcdskJZaUBWem5+nbJXBndPSnF/RyVjx5rtHAuIS9i5GTQ0LAROLTvnVQtpjE
	hXvr2boYuTiEBC4zSsxddoEdwjnPJPFy1gM2kCpeAU2JFzcmMoLYLAKqEndffASLswnoSizq
	aWYCsUUFAiQ+dD5ghKgXlDg58wkLiC0ioCHx/NM3sA3MAh+BNlw/yQqSEBaIljj5vI0FYtsi
	Ronly/8ydzFycHAKGEgsPpsNUsMsoCex4/ovVghbXqJ562zmCYwCs5DsmIWkbBaSsgWMzKsY
	5RJzSnN1cxMzc4pTk3WLkxPz8lKLdA31cjNL9FJTSjcxQuKAZwfjt3UyhxgFOBiVeHg91iiE
	CLEmlhVX5h5ilORgUhLlnRytGCLEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhPddGFCONyWxsiq1
	KB8mJc3BoiTOq7pE3U9IID2xJDU7NbUgtQgmK8PBoSTBuysOqFGwKDU9tSItM6cEIc3EwQky
	nEtKpDg1LyW1KLG0JCMeFKnxxcBYBUnxAO3dFwuyt7ggMRcoCtF6ilGXY13nt34mIZa8/LxU
	KXHeyyA7BECKMkrz4FbAkt4rRnGgj4V5e0GqeIAJE27SK6AlTEBL7h+XB1lSkoiQkmpgTPux
	+MTi4PN7vc5UxyrOef5jXrAka82zK6zTVtyZJBL7Il7liIbGp7TbVnHmV7jlP95Q 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257412>

On 09/17/2014 12:22 AM, Jonathan Nieder wrote:
> Michael Haggerty wrote:
> 
>> If rename() fails, call rollback_lock_file() to delete the lock file
>> (in case it is still present) and reset the filename field to the
>> empty string so that the lockfile object is left in a valid state.
> 
> Can you spell out more what the goal is?  Is the idea to keep the
> .lock file for a shorter period of time, so other processes can lock
> that file before the current process exits?

I doubt that there are situations where releasing the .lock file
immediately vs. holding it until the end of the process makes any
practical difference. Most callers die() right away if the commit fails.

This change is more about cleaning up the API by making the state
diagram for lock_file objects well-defined. commit_lock_file() can fail
in multiple ways that callers cannot easily distinguish. So all of the
failure paths have to leave the lock_file object in the same final
state, otherwise the callers cannot know what state it is in. Since
lock_file objects are reusable, this is an API design bug.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
