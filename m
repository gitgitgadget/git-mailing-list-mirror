From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 40/43] refs: allow ref backend to be set for clone
Date: Mon, 05 Oct 2015 11:32:14 +0200
Message-ID: <5612439E.4080200@alum.mit.edu>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com> <1443477738-32023-41-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Jeff King <peff@peff.net>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 05 11:32:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zj286-0007X8-3W
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 11:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471AbbJEJcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 05:32:17 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:61401 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752236AbbJEJcR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Oct 2015 05:32:17 -0400
X-AuditID: 12074414-f794f6d000007852-60-561243a08506
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 8C.29.30802.0A342165; Mon,  5 Oct 2015 05:32:16 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96E0C.dip0.t-ipconnect.de [79.201.110.12])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t959WE4f002917
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 5 Oct 2015 05:32:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1443477738-32023-41-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42IRYndR1F3gLBRmcOO6qsX8TScYLbqudDNZ
	/GjpYXZg9njWu4fRY8Hz++wenzfJBTBHcdskJZaUBWem5+nbJXBnrFykU7CKt6JzfVAD4z2u
	LkZODgkBE4n3C1qYIGwxiQv31rN1MXJwCAlcZpRo5O5i5AIyzzFJfFiyhh2khldAW2LL29fs
	IDUsAqoSz5aCtbIJ6Eos6mkGs0UFgiRWLH/BCFEuKHFy5hMWEFtEwEHi8q6jzCA2s4CsxP1f
	P8DiwgKeEtcermeC2NXGKNFwah4bSIJTwEti6erpjBANehI7rv9ihbDlJZq3zmaewCgwC8mO
	WUjKZiEpW8DIvIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI10IvN7NELzWldBMjJGxFdjAeOSl3
	iFGAg1GJh/dAvGCYEGtiWXFl7iFGSQ4mJVHem3ZCYUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVE
	eF+ZAeV4UxIrq1KL8mFS0hwsSuK83xar+wkJpCeWpGanphakFsFkZTg4lCR4fZ2AGgWLUtNT
	K9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBMRpfDIxSkBQP0N5FIO28xQWJuUBRiNZTjIpS
	4rwnQRICIImM0jy4sbBk9IpRHOhLYV5xkCoeYCKD634FNJgJaHC/PNjgkkSElFQDo/TslXVf
	1+sckj/ecnjm9n2nNtvIXN3PWqDYt+Cu+dmmmxPy9nkv5CvzqrFRd7DPrHMVq1149qZG6Iav
	T/m381cL1Rd8UshQnGmqs/bZsRunWOXyFptxiv4TsPXz6p7cWnMx/drGJWmMxT+Y 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279053>

On 09/29/2015 12:02 AM, David Turner wrote:
> Add a new option, --refs-backend-type, to allow the ref backend type to
> be set on new clones.
> 
> Submodules must use the same ref backend as the parent repository, so
> we also pass the --refs-backend-type option option when cloning
> submodules.

If I'm reading this correctly, you propose to add a new configuration
setting,

    core.refs-backend-type

to record which reference backend the repository is using.

(By the way, please document any new config settings in
Documentation/config.txt.)

This does not provide adequate backwards compatibility. Suppose I create
a repository with a DB backend, then later try to access the repository
using an older version of Git (or JGit or libgit2 or ...) that doesn't
know about this configuration setting. It will think it is a normal
repository that only has a couple of references (HEAD, stash, etc). If I
run `git gc` using the older version of git, *poof* all of the objects
referred to by other branches will be garbage-collected.

Therefore, I don't think this can be merged without a bump to
core.repositoryformatversion. Such a bump will tell well-behaved older
Git clients keep their hands off the repository. (Of course repositories
that use the files backend can continue using
core.repositoryformatversion 0.)

I thought Peff proposed a way to do such a bump, including a way to
extend repositories one by one with new features. But that was something
that we were chatting about off-list.

I haven't reviewed the actual code in this patch yet but I wanted to get
the above comment on your radar.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
