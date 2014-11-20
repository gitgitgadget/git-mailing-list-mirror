From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/2] Breaking the ref-transactions-reflog series in smaller
 parts
Date: Thu, 20 Nov 2014 12:03:33 +0100
Message-ID: <546DCA85.8060806@alum.mit.edu>
References: <1416433224-29763-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: Stefan Beller <sbeller@google.com>, gitster@pobox.com,
	sahlberg@google.com, git@vger.kernel.org, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Thu Nov 20 12:03:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrPWW-0006k8-E1
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 12:03:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbaKTLDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 06:03:36 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:50825 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750813AbaKTLDg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Nov 2014 06:03:36 -0500
X-AuditID: 12074411-f79fa6d000006b8a-52-546dca87a1db
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id C6.0D.27530.78ACD645; Thu, 20 Nov 2014 06:03:35 -0500 (EST)
Received: from [192.168.69.130] (p5DDB3256.dip0.t-ipconnect.de [93.219.50.86])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAKB3Xk4029160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 20 Nov 2014 06:03:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <1416433224-29763-1-git-send-email-sbeller@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsUixO6iqNt+KjfE4PoFEYuuK91MFg29V5gt
	3t5cwmjxb0KNxebN7SwOrB47Z91l91iwqdTj4iVlj8+b5AJYorhtkhJLyoIz0/P07RK4MxoO
	T2MquMdZsfj6BdYGxhfsXYycHBICJhKHl7VC2WISF+6tZ+ti5OIQErjMKPFq7j9mkISQwDkm
	ibVza0FsXgFtiUW334A1sAioSkz5uIoFxGYT0JVY1NPMBGKLCgRJnNxznR2iXlDi5MwnLCBD
	RQQaGCVW9B9nBEkIC4RLbDi8jgVigZPE8++PWEFsTgFnidsHJoMtZhbQk9hx/RcrhC0v0bx1
	NvMERv5ZSObOQlI2C0nZAkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW6pnq5mSV6qSmlmxgh
	4Su4g3HGSblDjAIcjEo8vAkWuSFCrIllxZW5hxglOZiURHnvLQcK8SXlp1RmJBZnxBeV5qQW
	H2KU4GBWEuHV2AmU401JrKxKLcqHSUlzsCiJ8/ItUfcTEkhPLEnNTk0tSC2CycpwcChJ8Nqc
	BGoULEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB8VkfDEwKkFSPEB7158A2VtckJgL
	FIVoPcWoKCXO+x4kIQCSyCjNgxsLS0qvGMWBvhTmDQHZzgNMaHDdr4AGMwEN/rsUbHBJIkJK
	qoGR6Wqb9tv5vh6nO9M8Lt99z2Z+SkREP892ja7LlffqF36GP5f8fbZ4RZCj7O+N/7kmbNpa
	N1u0w2KFr9rqP39vXFSzeFZS5Cl6vf6DUofRy+e7f6RO1Ra9+vJ+1f3Dd+YzKov4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/19/2014 10:40 PM, Stefan Beller wrote:
> so I think the patch series ref-transactions-reflog[1] sent previously to the list
> is still too large for easy review and I want to break it up more.
> So in this series we'll digest only 2 small patches, which do not seem to be 
> controversial (yet;) and seem to be useful no matter how the discussion on
> the other series continues.
> 
> ref_transaction_create as well as ref_transaction_delete are just special cases
> of ref_transaction_update, so let's reduce some redundant code. While this doesn't
> change code in pathes, which are supposed to be run, we do have slight changes 
> in error messages starting with "BUG: ". So in the best case, the user will never
> see these messages at all.

Users should *never* see error messages starting with "BUG: ". These are
basically what the Git project uses instead of assert(). As long as we
Git developers would understand a bug report submitted by a user who
sees such an error message, their text can be changed without worries.

Both patches are

Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>

And I love that you are proceeding in smaller pieces.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
