From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use wc instead of awk to count subtrees in t0090-cache-tree
Date: Mon, 22 Dec 2014 13:45:42 -0800
Message-ID: <xmqqk31j8ik9.fsf@gitster.dls.corp.google.com>
References: <1419270744-1408-1-git-send-email-bdwalton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: dturner@twopensource.com, git@vger.kernel.org
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 22:45:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3AnU-0001rL-Vp
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 22:45:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755686AbaLVVpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 16:45:45 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53987 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754781AbaLVVpo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 16:45:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B3F3029F2F;
	Mon, 22 Dec 2014 16:45:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fh/dS4SesdFPjPd2y7D3ETAlLJA=; b=bstFzP
	HQ8fEyvgm6MF96aGJLypjdTdworJjweu+yuKTQyFlsFVH2dxHDqWWPnWq3UIGjya
	q34aLBEk+qiMD58KSzZ0fsuc5rXuJQJ6nomeqe/XWZ86OglfEdMY+QsKPC7B0yU6
	Ka2Fh9AcwgPVGLykKlFeSNc+pTwd7n+pwGVm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Eo8a9nzzopMKVnGKmz/ApLpFvtzQJwsm
	0W5rpyFIFJWkcygB3DZogBzn874mInWsh3WwA3I5BXc6UMoG3DpuieqfNki/TIiD
	kOfQEsDTYuEgRfej4ywwPUaYgBvlBDsUWmieSmbUCC2WIXtW30UJqs5JwF7qhHIO
	ws7WxmxUR50=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A9C7529F2D;
	Mon, 22 Dec 2014 16:45:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3634029F2B;
	Mon, 22 Dec 2014 16:45:43 -0500 (EST)
In-Reply-To: <1419270744-1408-1-git-send-email-bdwalton@gmail.com> (Ben
	Walton's message of "Mon, 22 Dec 2014 17:52:24 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E10F6CC8-8A23-11E4-893F-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261674>

Ben Walton <bdwalton@gmail.com> writes:

> The awk statements previously used in this test weren't compatible
> with the native versions of awk on Solaris:
>
> echo "dir" | /bin/awk -v c=0 '$1 {++c} END {print c}'
> awk: syntax error near line 1
> awk: bailing out near line 1
>
> echo "dir" | /usr/xpg4/bin/awk -v c=0 '$1 {++c} END {print c}'
> 0
>
> And with GNU awk for comparison:
> echo "dir" | /opt/csw/gnu/awk -v c=0 '$1 {++c} END {print c}'
> 1
>
> Instead of modifying the awk code to work, use wc -w instead as that
> is both adequate and simpler.

Hmm, why "wc -w" not "wc -l", though?  Is somebody squashing a
one-elem-per-line output from ls-files onto a single line?
