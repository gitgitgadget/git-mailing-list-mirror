From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/4] Fix file locking with retry and timeout on Windows
Date: Fri, 05 Jun 2015 22:14:39 +0200
Message-ID: <5572032F.1020606@alum.mit.edu>
References: <55700F10.8030806@kdbg.org> <cover.1433532967.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 22:15:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0y1C-0004sb-0V
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 22:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbbFEUO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 16:14:56 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:56216 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751327AbbFEUO4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2015 16:14:56 -0400
X-AuditID: 1207440d-f79026d000000bad-cb-55720331b2b8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 37.E6.02989.13302755; Fri,  5 Jun 2015 16:14:42 -0400 (EDT)
Received: from [192.168.69.130] (p4FC9741B.dip0.t-ipconnect.de [79.201.116.27])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t55KEdWY025271
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 5 Jun 2015 16:14:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <cover.1433532967.git.j6t@kdbg.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42IRYndR1DViLgo1aL3OZNF1pZvJoqH3CrPF
	k7l3mR2YPR6+6mL3uHhJ2ePzJrkA5ihum6TEkrLgzPQ8fbsE7oxX650LZnNUNN1bwdTAuJ2t
	i5GTQ0LAROL10+NQtpjEhXvrgWwuDiGBy4wSR67eZIVwzjFJvLw9gRGkildAW2J1yw9mEJtF
	QFXi/5lesG42AV2JRT3NTF2MHByiAkESr1/mQpQLSpyc+YQFJCwi4CEx61A2SJhZQE3i0JJH
	YBOFBbwlrr+cwAJiCwHZu1YcZAWxOQUMJM6t72eBqNeT2HH9FyuELS+x/e0c5gmMArOQbJiF
	pGwWkrIFjMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3SN9HIzS/RSU0o3MULClncH4/91MocY
	BTgYlXh4GwwLQ4VYE8uKK3MPMUpyMCmJ8vL+BwrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4d3z
	GyjHm5JYWZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgSTleHgUJLgPcVYFCokWJSanlqR
	lplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4rS+GJgnIKkeID2sjEBtfMWFyTmAkUhWk8xKkqJ
	81qAJARAEhmleXBjYcnoFaM40JfCvEYgVTzARAbX/QpoMBPQ4OusBSCDSxIRUlINjAvsln9z
	vfpvk6TjFwZhY/6nGjeX2/5fN/fEsfM3L18SywvYbcQ7Xfd6rKb9KmlNp+PtItqT5n1zdNi5
	e3bJr03HlkbveeCRVHHui3dybxGz27ZtNwTcUq8/+HRF3XSPo/Wd1t+c0dyXyqoP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270888>

On 06/05/2015 09:45 PM, Johannes Sixt wrote:
> The first patch is the same that I posted earlier. It fixes a build
> failure on Windows on master due to missing random/srandom.
> 
> The remaining 3 patches replace the select() invocation that waits
> for a short time period by the version with poll() that we already
> use in help.c. This is necessary because a select() call where all
> three sets of file descriptors are empty is not supported on Windows.
> 
> Johannes Sixt (4):
>   lockfile: replace random() by rand()
>   help.c: wrap wait-only poll() invocation in sleep_millisec()
>   lockfile: convert retry timeout computations to millisecond
>   lockfile: wait using sleep_millisec() instead of select()
> 
>  cache.h    |  1 +
>  help.c     |  2 +-
>  lockfile.c | 31 +++++++++----------------------
>  wrapper.c  |  5 +++++
>  4 files changed, 16 insertions(+), 23 deletions(-)

The whole series looks good to me. Johannes, thanks for taking care of this.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
