From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] quiltimport: Skip non-existent patches
Date: Thu, 27 Sep 2007 13:50:01 -0700
Message-ID: <7v1wcju93a.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.62.0709271154440.10467@pademelon.sonytel.be>
	<1190925059-5233-1-git-send-email-dbn.lists@gmail.com>
	<loom.20070927T203413-499@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan Nicholson <dbn.lists@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 22:50:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib0JK-0006iV-6h
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 22:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755262AbXI0UuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 16:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755290AbXI0UuH
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 16:50:07 -0400
Received: from rune.pobox.com ([208.210.124.79]:58790 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753188AbXI0UuG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 16:50:06 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id AD1EB13D2AA;
	Thu, 27 Sep 2007 16:50:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 1466713D394;
	Thu, 27 Sep 2007 16:50:24 -0400 (EDT)
In-Reply-To: <loom.20070927T203413-499@post.gmane.org> (Dan Nicholson's
	message of "Thu, 27 Sep 2007 20:39:54 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59333>

Dan Nicholson <dbn.lists@gmail.com> writes:

> Dan Nicholson <dbn.lists <at> gmail.com> writes:
>> 
>> When quiltimport encounters a non-existent patch in the series file,
>> just skip to the next patch. This matches the behavior of quilt.
>> 
>> Signed-off-by: Dan Nicholson <dbn.lists <at> gmail.com>
>> ---
>>  git-quiltimport.sh |    4 ++++
>>  1 files changed, 4 insertions(+), 0 deletions(-)
>> 
>> diff --git a/git-quiltimport.sh b/git-quiltimport.sh
>> index 74a54d5..880c81d 100755
>> --- a/git-quiltimport.sh
>> +++ b/git-quiltimport.sh
>> @@ -71,6 +71,10 @@ commit=$(git rev-parse HEAD)
>> 
>>  mkdir $tmp_dir || exit 2
>>  for patch_name in $(grep -v '^#' < "$QUILT_PATCHES/series" ); do
>> +	if ! [ -f "$QUILT_PATCHES/$patch_name" ] ; then
>> +		echo "$patch_name doesn't exist. Skipping."
>> +		continue
>> +	fi
>>  	echo $patch_name
>>  	git mailinfo "$tmp_msg" "$tmp_patch" \
>>  		<"$QUILT_PATCHES/$patch_name" >"$tmp_info" || exit 3
>
>
> I forgot to mention the rationale for this patch vs. what Junio sent. The issue
> with Junio's patch is that the failure will occur before $tmp_patch is created
> because the script tries to feed git-mailinfo a non-existent patch
> ($patch_name). You'll only get past the mailinfo if $patch_name exists.
>
> The marker setting may still be useful in this context, though, to suppress the
> "doesn't exist" message.

Thanks.  I did not know what "marker" meant by the original
context and assumed there is a file referred to by the series
file but there is no patch in that file.  Instead it seems that
a series file can contain something that is _not_ a file and
that is called the marker, right?
