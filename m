From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git difftool does does not respect current working directory
Date: Thu, 19 May 2011 21:31:54 -0700
Message-ID: <7vwrhm3scl.fsf@alter.siamese.dyndns.org>
References: <loom.20110514T160931-46@post.gmane.org>
 <7v1uzznr09.fsf@alter.siamese.dyndns.org> <20110520035856.GA13582@gmail.com>
 <20110520041045.GB13582@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?RnLDqWTDqXJpYw==?= Heitzmann 
	<frederic.heitzmann@gmail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 20 06:32:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNHNt-00067t-8C
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 06:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935166Ab1ETEcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 00:32:16 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50897 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934971Ab1ETEcN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 00:32:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5F39E59A4;
	Fri, 20 May 2011 00:34:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aIyQ2vcvsb2SfMGsdz4/Qq9EBV8=; b=UM9LXf
	hdGaGdt/VHhUzc4rti+WOyPO4ZL4PW9Kl9hGVMBMBcaNefjdtSUVr/lcPBGD1VXu
	JCDYNZo0ifwvnBtNrEeJEYFy6G91TC6Fko170Dx2A7n3hbvsEFDMTQqNQhgLZTe8
	GN6TTG6H06KzDEqb6LAOAJQMU4Xv5yYY4w/XU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NZI/taEYfOaUBSSdDbcS/pgA1GuChym+
	jbHR2svwfQ281rIrix+odaqkneSqJDoOpl7rzfDBDFfxkCG3UI5bbVtOoRVIjqmZ
	sdl1oGrHRKefFAc0NOuLNzABVnnjdWMWcZR/TlP2x+NvuvrcfoqCaQgYUlipjsrV
	3rh98hokxwo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 29CA759A2;
	Fri, 20 May 2011 00:34:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D0AC859A0; Fri, 20 May 2011
 00:34:03 -0400 (EDT)
In-Reply-To: <20110520041045.GB13582@gmail.com> (David Aguilar's message of
 "Thu, 19 May 2011 21:10:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 66B53D02-829A-11E0-BA00-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174039>

David Aguilar <davvid@gmail.com> writes:

> We would have to change the way $GIT_EXTERNAL_DIFF works so
> that it preserves the current directory and constructs
> paths relative to it.  Patches welcome :-)

I am afraild that would break a lot more than difftool.

If we really wanted to change the behaviour, the external diff interface
needs to export the value of prefix (i.e. what the original subdirectory
was), and the script that is spawned as $GIT_EXTERNAL_DIFF (optionally
optionally) take it into account, perhaps by cd'ing back to that
subdirectory and possibly moving or renaming the temporary files to suit
its needs (I think recently we also saw a request to rename the temporary
files).

Or something like that.
