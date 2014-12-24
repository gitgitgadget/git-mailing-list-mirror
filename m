From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/7] receive-pack.c: add protocol support to negotiate
 atomic-push
Date: Wed, 24 Dec 2014 08:33:32 +0100
Message-ID: <549A6C4C.8000905@alum.mit.edu>
References: <1419017941-7090-1-git-send-email-sbeller@google.com> <1419017941-7090-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>, ronniesahlberg@gmail.com,
	jrnieder@gmail.com, gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Wed Dec 24 08:34:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3gSj-0002wu-5K
	for gcvg-git-2@plane.gmane.org; Wed, 24 Dec 2014 08:34:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbaLXHeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2014 02:34:22 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:59871 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751427AbaLXHeW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Dec 2014 02:34:22 -0500
X-AuditID: 1207440d-f79976d000005643-f5-549a6c7955ff
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 54.75.22083.97C6A945; Wed, 24 Dec 2014 02:34:17 -0500 (EST)
Received: from [192.168.1.150] ([82.113.121.136])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBO7XhBX006380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 24 Dec 2014 02:34:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <1419017941-7090-2-git-send-email-sbeller@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsUixO6iqFuZMyvEYMtTYYuuK91MFg29V5gt
	3t5cwmjR2/eJ1eLfhBqLzZvbWSzOvGlkdGD32DnrLrvHgk2lHhcvKXssfuDl8XmTXABrFLdN
	UmJJWXBmep6+XQJ3xtFPXYwFG9grPk86yd7A+IO1i5GTQ0LAROLslOlMELaYxIV769m6GLk4
	hAQuM0ps6T3IApIQEtjIJLH6ZCGIzSugLXHq9DM2EJtFQFVi17O97CA2m4CuxKKeZrBBogJB
	EldaNjND1AtKnJz5hAVkqIhAJ6PEm487wBqYBewkuvYvAbtCWCBC4uPyb4wQy8oltq1/D7aA
	U8BJouX4dBaIej2JHdd/sULY8hLNW2czT2AUmIVkxywkZbOQlC1gZF7FKJeYU5qrm5uYmVOc
	mqxbnJyYl5dapGukl5tZopeaUrqJERLyvDsY/6+TOcQowMGoxMMrkTQrRIg1say4MvcQoyQH
	k5Io7zJvoBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3tAsoBxvSmJlVWpRPkxKmoNFSZxXbYm6
	n5BAemJJanZqakFqEUxWhoNDSYK3KRuoUbAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQk
	Ix4Uq/HFwGgFSfEA7RUBaectLkjMBYpCtJ5i1OVY0L5/JpMQS15+XqqUOG83SJEASFFGaR7c
	CliCe8UoDvSxMC8/SBUPMDnCTXoFtIQJaInUrekgS0oSEVJSDYyBBrseF63KXS/mXTz3/Ps0
	uxPPEr8ZFp3+ytEi4+rmpBWitLWkOXHe1bRH15Zusty5+emP3Zp3T4n2e1xOdL41 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261793>

On 12/19/2014 08:38 PM, Stefan Beller wrote:
> From: Ronnie Sahlberg <sahlberg@google.com>
> 
> This adds support to the protocol between send-pack and receive-pack to
> * allow receive-pack to inform the client that it has atomic push capability
> * allow send-pack to request atomic push back.
> 
> There is currently no setting in send-pack to actually request that atomic
> pushes are to be used yet. This only adds protocol capability not ability
> for the user to activate it.

Sorry to jump in so late...

If I understand correctly, after this patch the server advertises the
"atomic" capability even though it doesn't actually have that ability
until a later patch. It seems to me that the order of the patches should
be reversed: don't advertise the capability before it is actually
implemented. Why? Bisection. Between the two patches the server is buggy.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
