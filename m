From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-backend: Don't infinite loop during die()
Date: Mon, 22 Mar 2010 13:25:23 -0700
Message-ID: <7vhbo885os.fsf@alter.siamese.dyndns.org>
References: <51569EE6-A926-45DB-A588-B659750BA643@catherman.org>
 <20100322142204.GB8916@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brady Catherman <brady@catherman.org>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 22 21:25:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtoBu-00032l-QR
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 21:25:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755914Ab0CVUZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 16:25:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45807 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755843Ab0CVUZc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 16:25:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2623DA4E6F;
	Mon, 22 Mar 2010 16:25:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CrTghC9fNFLxqtLWU9M0sk6Jbwk=; b=V7TrwJ
	k/J1Gk7slxcPHXeMpQdaBsMPsLjpnJLxupppjpXFO2FsX4TbzPGNLKGejzXm0Wdy
	+vg746G5e5vR5Iqf5ro51kkyErzu2lJZ2Z9NFk9OOkZXdQHFWwPtyDWpyZa/aAiV
	nfJJu/+JKLefUmSEpQ1ABgaKnUMtuC0qXTNAg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ges9C1Rdg5GJMEqMt0YNmkwLJn+oQzun
	FTTv4UnWaJyUz7SHAE/FqL63JvMX2EaOcJfiuN7L+D7p6+s7qDlweG5n09mnvirM
	2/y1Jdb5ygv5/MLsDVbBTLH1yKFVhmyxIaTRtnczwV9mAIZvYlHZbTB0xUvnqt6n
	O62IufDCMX4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E928EA4E6C;
	Mon, 22 Mar 2010 16:25:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D811A4E60; Mon, 22 Mar
 2010 16:25:25 -0400 (EDT)
In-Reply-To: <20100322142204.GB8916@spearce.org> (Shawn O. Pearce's message
 of "Mon\, 22 Mar 2010 07\:22\:04 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0E647FE2-35F1-11DF-AB50-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142966>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> If stdout has already been closed by the CGI and die() gets called,
> the CGI will fail to write the "Status: 500 Internal Server Error" to
> the pipe, which results in die() being called again (via safe_write).
> This goes on in an infinite loop until the stack overflows and the
> process is killed by SIGSEGV.

Before looking at the code I first thought "wouldn't we have the same
problem in die(), and shouldn't we have "dying" flag there?" but I was
stupid as usual ;-)

The patch looks sane.  Thanks.
