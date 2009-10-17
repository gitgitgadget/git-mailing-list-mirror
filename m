From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/5] Refactor pretty_print_commit arguments into a
 struct
Date: Sat, 17 Oct 2009 10:05:35 -0700
Message-ID: <7vljja7xy8.fsf@alter.siamese.dyndns.org>
References: <cover.1255701207.git.trast@student.ethz.ch>
 <9d3d0f0a6126afc86689138adf58ac7a12c43858.1255701207.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jef Driesen <jefdriesen@hotmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Oct 17 19:05:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzCj7-0002IV-6M
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 19:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842AbZJQRFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2009 13:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752498AbZJQRFq
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 13:05:46 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64106 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbZJQRFp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2009 13:05:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D4AF17BFAD;
	Sat, 17 Oct 2009 13:05:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w/u3h8QkdJiSTJc920/4uhw3p6g=; b=h0AfUz
	AHWP+PpSgoI7m6e4VrvipSCcTO7xsBroXhNoxlHabABYlKX9Sz5TTifdsEoIoG1b
	1Lh5YEbUj3VRfML+jHKWAC4ApXV1vTLkTBfOe8B/ch47mhg9edM3usAq/8qUuZbh
	bGYOPkZHdmR3P30rrv9a4x7Y0RJNwubu+WjuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PSx2QyFi+MfFVz0go2Fx0NdabUqbWD/Z
	LHCW6fsJE4ny8V0pUnIE+iPicQqb+D/yOPlP+/n/tguL3dl8nAUjR/zNtl5IH6El
	oFua6IGZmEmgPHF/zaAQKoXNHCmK0DZUs7f36cLPqj1NCFdYArnr8JTGo0lbbWJe
	kcya65g2mx8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 944817BFAC;
	Sat, 17 Oct 2009 13:05:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D0AAD7BFA8; Sat, 17 Oct 2009
 13:05:36 -0400 (EDT)
In-Reply-To: <9d3d0f0a6126afc86689138adf58ac7a12c43858.1255701207.git.trast@student.ethz.ch> (Thomas Rast's message of "Fri\, 16 Oct 2009 16\:20\:33 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4E1EB62A-BB3F-11DE-B287-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130566>

Thomas Rast <trast@student.ethz.ch> writes:

> pretty_print_commit() has a bunch of rarely-used arguments, and
> introducing more of them requires yet another update of all the call
> sites.  Refactor most of them into a struct to make future extensions
> easier.
>
> The ones that stay "plain" arguments were chosen on the grounds that
> all callers put real arguments there, whereas some callers have 0/NULL
> for all arguments that were factored into the struct.
>
> We declare the struct 'const' to ensure none of the callers are bitten
> by the changed (no longer call-by-value) semantics.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>

Good idea, a slightly sloppy/careless execution.

The existing calls to format_commit_message() often take DATE_NORMAL to
its "enum date_mode dmode" argument, and you replaced it with a pointer to
a struct.  DATE_NORMAL happens to be "0" and the compiler does not catch
calls you forgot to convert in this patch.
