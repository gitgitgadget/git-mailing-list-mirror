From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rename tracking and file-name swapping
Date: Sun, 13 Sep 2009 11:14:12 -0700
Message-ID: <7viqfmsoej.fsf@alter.siamese.dyndns.org>
References: <wavexx-2ECE7F.13171313092009@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yuri D'Elia <wavexx@users.sf.net>
X-From: git-owner@vger.kernel.org Sun Sep 13 20:15:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmtbr-0004Y3-HB
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 20:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752941AbZIMSOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 14:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752609AbZIMSOS
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 14:14:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40311 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbZIMSOR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 14:14:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3E92F4FE32;
	Sun, 13 Sep 2009 14:14:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OmIqoR3n/+D1RUVSXF5AEEUhyHM=; b=uprOwq
	87+R65LGoJmxabdZjlBBewmZT0B120BA0jHqO5deOMO0MhVkQv1mcOdjoiKv/tJX
	jz5XCcHMCUVjInuugdEyyxSjmkiI9jELJpjXjJSM1/SDGLIwODuzv88RB303BFEV
	mvplW3lrdT5O6tc4KPXYoZRibxCGYSu6G7Uf8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bv3uxmeIGJ6EKNJmkaDvUw9tDjJ6CORw
	evyLBXMxxVbIEWnB3noMMAo5gN9fOJyxA2XSiMG0Lt05JCcDppbGCNfHMAgW9JYT
	QG8hTTpvw0sa0CrRUgqexZTcYoC4V3wB8tWTB8yvo3G5iSrEADIjjdFROCWk+v4l
	ayJyXscVQkI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 22B3B4FE31;
	Sun, 13 Sep 2009 14:14:17 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DD23D4FE2C; Sun, 13 Sep 2009
 14:14:13 -0400 (EDT)
In-Reply-To: <wavexx-2ECE7F.13171313092009@ger.gmane.org> (Yuri D'Elia's
 message of "Sun\, 13 Sep 2009 13\:17\:13 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3FD639EE-A091-11DE-BEE6-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128379>

Yuri D'Elia <wavexx@users.sf.net> writes:

> Hi everyone. Does rename tracking recognize two file names being swapped?
>
> % ls -l
> total 24
> -rw-rw-r--   1 wavexx  wavexx  5952 Sep 13 13:09 file1.txt
> -rw-rw-r--   1 wavexx  wavexx  3330 Sep 13 13:09 file2.txt
> % mv file1.txt file3.txt 
> % mv file2.txt file1.txt
> % mv file3.txt file2.txt
> % git add file1.txt file2.txt 
> % git diff -M --stat --cached
>  file1.txt |  150 +++++++++++++++++++++++-------------------------------------
>  file2.txt |  150 +++++++++++++++++++++++++++++++++++++-----------------------
>  2 files changed, 150 insertions(+), 150 deletions(-)

By default, if the pathname that was present in the old version still
appears in the new version, that path is not considered as a candiate
for rename detection.  Only "X used to be there but is gone" and "Y did
not exist but appeared" are paired up and checked if they are similar.

Give the command -B option, too, to break the filepair that does not
disappear.
