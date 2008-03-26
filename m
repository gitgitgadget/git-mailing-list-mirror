From: Tommy Thorn <tommy-git@thorn.ws>
Subject: Re: Bug in .gitignore handling
Date: Wed, 26 Mar 2008 13:26:47 -0700
Message-ID: <47EAB187.4070009@thorn.ws>
References: <47EAABB6.30803@thorn.ws> <7vhcetck5m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 21:27:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JecDe-0001vy-HW
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 21:27:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756570AbYCZU0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 16:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756517AbYCZU0v
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 16:26:51 -0400
Received: from server204.webhostingpad.com ([69.65.0.218]:54222 "EHLO
	server204.webhostingpad.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756488AbYCZU0v (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Mar 2008 16:26:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=thorn.ws;
	h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Source:X-Source-Args:X-Source-Dir;
	b=uj61DSMm2p4N7+/9CC55lzZfO/hjIUsvhHqsAMqH34qgLbjZDG+K9FtPFzR/qGa/ig47E/05BOe/TzDp8BTSW0RZ1ofmBbJPL9LU1FUcbL4eXKG0DXieSeLC11Sm1LdW;
Received: from [216.228.112.21] (helo=dhcp-172-16-169-183.nvidia.com)
	by server204.webhostingpad.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <tommy-git@thorn.ws>)
	id 1JecCk-0004ic-Vb; Wed, 26 Mar 2008 15:26:39 -0500
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <7vhcetck5m.fsf@gitster.siamese.dyndns.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server204.webhostingpad.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - thorn.ws
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78306>

Junio C Hamano wrote:
> Are you talking about d6b8fc3 (gitignore(5): Allow "foo/" in ignore list
> to match directory "foo", 2008-01-31), specifically this part of the
> manual?
>   

Yes, thanks.

> "git clean" has always been an ugly and unreliable stepchild, and I would
> not be surprised at all if it is ridden with corner case bugs, especially
> around the area to skip untracked directories; but in this case you are
> not dealing with a directory but a symlink, and it should not get confused
> by the fact that the symlink happens to point at a directory.
>   


Thanks, but first step is in ensuring that my understanding is correct. 
Here's the gist of the test case:

mkdir mydir
cd mydir
git init
mkdir mousetrap
touch mousetrap/nonempty
git add mousetrap/nonempty
git commit -m "initial"
ln -s ../otherdir/foo .
echo "foo/" > .gitignore
echo ".gitignore" >> .gitignore
git clean -n -f -d

I expect the last command to report "Would remove mousetrap/foo/", but
I currently get "Would remove foo".

Thanks,
Tommy
