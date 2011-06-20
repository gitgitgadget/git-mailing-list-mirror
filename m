From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 08/20] remote-curl: accept empty line as terminator
Date: Mon, 20 Jun 2011 12:41:02 -0700
Message-ID: <7v4o3kcmup.fsf@alter.siamese.dyndns.org>
References: <1308496725-22329-9-git-send-email-srabbelier@gmail.com>
 <1308537351-23209-1-git-send-email-divanorama@gmail.com>
 <20110620075541.GA28282@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 20 21:41:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYkLR-0000Bz-Cb
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 21:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755244Ab1FTTlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 15:41:08 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57694 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352Ab1FTTlF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 15:41:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 360D053A0;
	Mon, 20 Jun 2011 15:43:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ueA5ZymN5xv5qiWb77b2QMXpy8k=; b=iys0NZ
	eDguvNkASXtBXFMhaZATLH3Hs5QD9NdXa/vqZhNsiPDqQMkL0HKqxa1fsBh7SSEY
	sTBXVgsj/5qk/FZY4cmqliuDfa3LmvexW6LQF54+hVIr/9UadsfsC8q6hdM8ak8E
	pb1xdgzRI4FNWwgLf6wCyGKkqwOkr5V+VLYsU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PxfOQCUSrFfsdJnZh44xldt5xmaCMo1G
	OqdsaQodCGClsfZmFfji6KBqA0zoOktSctwaqsQC5BBN3zPluNcytoRR/jPP31T9
	XSOerYJWnofk7ewxVZA2mLpwzXWjo2kIiWW2r3Q/qjZPplF/0L2tWa72bAG1Ywgt
	TwJUxcxQBTc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2FD44539F;
	Mon, 20 Jun 2011 15:43:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7BFA3539E; Mon, 20 Jun 2011
 15:43:14 -0400 (EDT)
In-Reply-To: <20110620075541.GA28282@elie> (Jonathan Nieder's message of
 "Mon, 20 Jun 2011 02:55:41 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 89B8ED00-9B75-11E0-9CEE-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176088>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Side note: a "done" capability doesn't sound like a bad idea, though,
> for another reason.  The transport-helper could tell fast-import to
> expect a "done" command at the end when importing from a remote helper
> declaring it, to catch situations in which the pipe prematurely closes
> (for example, because the remote helper has segfaulted).
>
>> I don't see a convention of terminating on a
>> blank line in docs,
>
> Yes, this would be nice to document.
>
>> only on EOF.  Also I can imagine a blank
>> line being read in a case of communication error
>
> A spurious NL, NL, EOF sequence does not sound likely to me.  If the
> command stream is passing through a noisy channel, there are worse
> corruptions to worry about (e.g., fetching to the wrong ref).

I think everything you said in this message makes sense, especially the
part about "premature EOF detection".

The spurious LF is an issue if you are trying to drive the backend by hand
for testing, but otherwise probably not.
