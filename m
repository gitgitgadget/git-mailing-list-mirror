From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 14/14] Add git-check-ignore sub-command
Date: Fri, 21 Sep 2012 12:42:00 -0700
Message-ID: <7v392b5fjr.fsf@alter.siamese.dyndns.org>
References: <7vvcfwf937.fsf@alter.siamese.dyndns.org>
 <1348170383-15751-1-git-send-email-git@adamspiers.org>
 <1348170383-15751-15-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Fri Sep 21 21:42:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TF979-00044R-Aq
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 21:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753886Ab2IUTmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 15:42:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53529 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753578Ab2IUTmD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 15:42:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6A2C9DB2;
	Fri, 21 Sep 2012 15:42:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ketofzP4s4w0hsl+udw6/paC/8w=; b=ilqSX+
	xsSAf7TEzVSfvWwnReoerVS5qh4S0ll7ynrYSF91uK3jTMWDSG+eL/bR5SyZyQYT
	poSpNGci5C15xTPF4uljDLES6bDet7uyFH5n1XzGSFn3uZ8Ycxrvj4SCCHhYuw/u
	2AAtGZThYz0qSZ+RahLs7iblptKeeXVWJBB3A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mYNt79qJ2eBHhH9zJiptqV5p2HrOh0Dc
	hIsYfIvGqruiiwonOQ2kA+RzAyvvAfNOAIJbLPf0q5lw5V0uK0RSLtL4VK2/5Itu
	51MXYUpZ7a0C2WWqilSXXDk92Qm3KZtpEWfpnQ8W/203r/Qe72zvHTKhCITnlkE+
	4Zw1XoiNjTg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A41929DB1;
	Fri, 21 Sep 2012 15:42:02 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 173219DB0; Fri, 21 Sep 2012
 15:42:01 -0400 (EDT)
In-Reply-To: <1348170383-15751-15-git-send-email-git@adamspiers.org> (Adam
 Spiers's message of "Thu, 20 Sep 2012 20:46:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6A2A7468-0424-11E2-B3E5-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206153>

Adam Spiers <git@adamspiers.org> writes:

> +expect_in () {
> +	dest="$HOME/expected-$1" text="$2"
> +	if test -z "$text"
> +	then
> +		>"$dest" # avoid newline
> +	else
> +		echo -e "$text" >"$dest"

This breaks when your shell is not "bash".

> +test_check_ignore () {
> +	args="$1" expect_code="${2:-0}" global_args="$3"
> +
> +	init_vars &&
> +	rm -f "$HOME/stdout" "$HOME/stderr" "$HOME/cmd" &&
> +	echo $(which git) $global_args check-ignore $quiet_opt $verbose_opt $args \
> +		>"$HOME/cmd" &&

Don't use which in scripts.  Is this just leftover cruft from debugging?
