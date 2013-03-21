From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: merging a tag is a special case
Date: Thu, 21 Mar 2013 12:50:25 -0700
Message-ID: <7vmwtwa5xa.fsf@alter.siamese.dyndns.org>
References: <1363704914.6289.39.camel@test.quest-ce.net>
 <7vfvzrjrad.fsf@alter.siamese.dyndns.org>
 <1363802033-26868-1-git-send-email-ydroneaud@opteya.com>
 <7vboadevpk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: Yann Droneaud <ydroneaud@opteya.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 20:51:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIlVr-0006X6-Tv
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 20:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491Ab3CUTua (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 15:50:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56187 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950Ab3CUTu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 15:50:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A53B9B3F7;
	Thu, 21 Mar 2013 15:50:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n5KtCrpTcmC0VWom2a/6zJKbzDY=; b=PfWUNS
	2qjvfmWyH/SbWhWhhnO/YbE0vWZMFVwx8zmwgPn8mjJvy2Nvqw3HSc5QHhURmHOV
	hzB73vFMWnmHEmeTCDmggjBrBbHpggR2rVWd8dptCAMMZgwdYCFkYnW2LUdIEKm2
	tuXKkXonPQleVpd/gvPfC9d81Lv32OD2ERF2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ohXHt0X/nH/P5ofCHwVjH04Agyt71M7z
	JKiCc10l+EZja2j5mIuG602qyLdeutgqkf54YjOCgmXETTG6ZD2Gz9ME6+zs3+H/
	uo7ht3KQs0DO+ybDj2DPpINgcuGO30j/TIYmuyx1saJmvk+mPh7VZwEFGpWfxOqO
	GRT/buoyPwA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 993D6B3F6;
	Thu, 21 Mar 2013 15:50:27 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CEFDBB3F3; Thu, 21 Mar 2013
 15:50:26 -0400 (EDT)
In-Reply-To: <7vboadevpk.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 20 Mar 2013 12:07:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 93CA3E5A-9260-11E2-B1EA-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218749>

Junio C Hamano <gitster@pobox.com> writes:

>> +MERGING TAG
>> +-----------
>> +
>> +When merging a tag (annotated or signed), Git will create a merge commit
>> +...
>> +if the tag was signed. See also linkgit:git-tag[1].
>> +
>
> It would make it more helpful to readers to describe how _not_ to
> create such a merge commit if it is unwanted, and how the request to
> merge a tag interacts with --ff-only option.
>
>> @@ -26,7 +26,7 @@ set to `no` at the beginning of them.
>>  --ff::
>>  	When the merge resolves as a fast-forward, only update the branch
>>  	pointer, without creating a merge commit.  This is the default
>> -	behavior.
>> +	behavior (except when merging a tag).
>
> With this update, the reader will be left wondering what would be
> the default when she asks Git to merge a tag, no?

Taking Jonathan's input and the above into account, perhaps we can
do something like this on top of the posted patch?

 Documentation/git-merge.txt     | 26 +++++++++++++++++++++-----
 Documentation/merge-options.txt |  5 +++--
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index f7e68e1..75b5ee7 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -173,11 +173,27 @@ want to start over, you can recover with `git merge --abort`.
 MERGING TAG
 -----------
 
-When merging a tag (annotated or signed), Git will create a merge commit
-even if a fast-forward merge is possible (see above).
-The commit message template will be created from the tag message.
-Additionally, the signature check will be reported as a comment
-if the tag was signed. See also linkgit:git-tag[1].
+When merging an annotated (and possibly signed) tag, Git always
+creates a merge commit even if a fast-forward merge is possible, and
+the commit message template is prepared with the tag message.  
+Additionally, the signature check is reported as a comment
+if the tag is signed.  See also linkgit:git-tag[1].
+
+Consequently a request `git merge --ff-only v1.2.3` to merge such a
+tag would fail.
+
+When you want to just integrate with the work leading to the commit
+that happens to be tagged, e.g. synchronizing with an upstream
+release point, you may not want to make an unnecessary merge commit
+especially when you do not have any work on your own.  In such a
+case, you can "unwrap" the tag yourself before feeding it to `git
+merge`, e.g.
+
+---
+git fetch origin
+git merge [--ff-only] v1.2.3^0
+---
+
 
 HOW CONFLICTS ARE PRESENTED
 ---------------------------
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 70d1ec0..34a8445 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -26,11 +26,12 @@ set to `no` at the beginning of them.
 --ff::
 	When the merge resolves as a fast-forward, only update the branch
 	pointer, without creating a merge commit.  This is the default
-	behavior (except when merging a tag).
+	behavior.
 
 --no-ff::
 	Create a merge commit even when the merge resolves as a
-	fast-forward.
+	fast-forward.  This is the default behaviour when merging an
+	annotated (and possibly signed) tag.
 
 --ff-only::
 	Refuse to merge and exit with a non-zero status unless the
