From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] git svn: handle errors and concurrent commits in
 dcommit
Date: Thu, 09 Aug 2012 10:44:30 -0700
Message-ID: <7v1ujgot8h.fsf@alter.siamese.dyndns.org>
References: <1343856397-6536-1-git-send-email-robert@debian.org>
 <20120802104421.GA13271@dcvr.yhbt.net> <5021F9D4.1010700@debian.org>
 <20120808230754.GB24956@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Luberda <robert@debian.org>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Aug 09 19:44:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzWmk-0002oj-WA
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 19:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758045Ab2HIRoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 13:44:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59131 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757539Ab2HIRod (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 13:44:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDCDC7F2A;
	Thu,  9 Aug 2012 13:44:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AU+b40it5Syh3aUIz/iUoG+a9Jw=; b=Xgh9Km
	Lq9jPi7tzyRCcRLxchV3uV27mpKYzoiz2o6nDPoNu4JCnirl1yXrFgyqVik5ID4a
	ddKbVjyUDHdlPchROhdaqnyg/5g6Y0TJDaY/tlTDL8eZhAlR1Y/8DyhBFXUw7L+2
	2U84MgD+rYgL1Xfx87n7NtcaJbcSWu1wRdvEg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=or6jPq4c+AnK5l0ovwtA33o6hAuzGEVI
	tMBnebjxIBdpbLKh2kjkMxK+PwAW6uHr8Bv4+vAkr8QcR6EY5iG8L2Tnn6IndV2y
	ISssJts+ZUCeo2ap23XJ2PZDekeX26ibJ8RIZtdMNMkMiLbrtb835nEMZsEUs1GS
	/CIRMTovm1w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA9CA7F29;
	Thu,  9 Aug 2012 13:44:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3AB5F7F28; Thu,  9 Aug 2012
 13:44:32 -0400 (EDT)
In-Reply-To: <20120808230754.GB24956@dcvr.yhbt.net> (Eric Wong's message of
 "Wed, 8 Aug 2012 23:07:54 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E05CB1DE-E249-11E1-BE2B-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203171>

Eric Wong <normalperson@yhbt.net> writes:

> Robert Luberda <robert@debian.org> wrote:
>> Eric Wong wrote:
>> >> +		echo "PATH=\"$PATH\"; export PATH" >> $hook
>> >> +		echo "svnconf=\"$svnconf\"" >> $hook
>> >> +		cat >> "$hook" <<- 'EOF2'
>> >> +			cd work-auto-commits.svn
>> >> +			svn up --config-dir "$svnconf"
>> > 
>> > That doesn't seem to interact well with users who depend on
>> > svn_cmd pointing to something non-standard.  Not sure
>> > what to do about it, though....
>
>> I have no idea how to change it either. I've tried to source the
>> lib-git-svn.sh file inside the hook, but it sources test-lib.sh, and the
>> latter script doesn't work well if it is sourced by non-test script.
>> Anyway I the part of my original patch unchanged.
>
> Ah, so svn_cmd only cares about --config-dir and you already handled
> that :)   I misremembered it also allowed for non-standard SVN
> installations :x
>
> I've pushed your updated patch to my "maint" branch on
> git://bogomips.org/git-svn since "master" has larger pending changes.

I should have asked this yesterday, but do you mean you want to have
your "maint" in the upcoming 1.7.12?  This does look like a useful
thing to do, but does not seem like a regression fix to me.
