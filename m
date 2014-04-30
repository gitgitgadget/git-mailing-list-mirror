From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH 00/32] Split index mode for very large indexes
Date: Wed, 30 Apr 2014 16:48:05 -0400
Message-ID: <53616185.9000208@bbn.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 22:48:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfbQM-0001Ol-3c
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 22:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759394AbaD3UsI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Apr 2014 16:48:08 -0400
Received: from smtp.bbn.com ([128.33.1.81]:26016 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758905AbaD3UsH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Apr 2014 16:48:07 -0400
Received: from socket.bbn.com ([192.1.120.102]:42889)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WfbQO-000LTU-0j; Wed, 30 Apr 2014 16:48:16 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id C419440822
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247779>

On 2014-04-28 06:55, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> From the user point of view, this reduces the writable size of index
> down to the number of updated files. For example my webkit index v4 i=
s
> 14MB. With a fresh split, I only have to update an index of 200KB.
> Every file I touch will add about 80 bytes to that. As long as I don'=
t
> touch every single tracked file in my worktree, I should not pay
> penalty for writing 14MB index file on every operation.

I played around with these changes a bit and have some questions:

  * These changes should only affect performance when the index is
    updated, right?  In other words, if I do "git status; git status"
    the second "git status" shouldn't update the index and therefore
    shouldn't have a noticeable performance improvement relative to Git
    without these patches.  Right?

  * Do you have any before/after benchmark results you can share?

  * Are there any benchmark scripts I can use to test it out in my own
    repositories?

  * Is there a debug utility I can use to examine the contents of the
    index and sharedindex.* files in a more human-readable way?

I'm asking because in my (very basic) tests I noticed that with the
following command:

    git status; time git status

the second "git status" had an unexpected ~20% performance improvement
in my repo relative to a build without your patches.  The second "git
status" in the following command also had about a ~20% performance
improvement:

    git status; touch file-in-index; time git status

So it seems like the patches did improve performance somewhat, but in
ways I wasn't expecting.  (I'm not entirely certain my benchmark method
is sound.)

Thanks,
Richard
