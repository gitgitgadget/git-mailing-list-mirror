From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] difftool: add various git-difftool tests
Date: Tue, 24 Mar 2009 19:42:29 -0700
Message-ID: <7vr60m9vca.fsf@gitster.siamese.dyndns.org>
References: <1237797676-32047-1-git-send-email-davvid@gmail.com>
 <1237797676-32047-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 03:44:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmJ6C-0001lD-6v
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 03:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176AbZCYCml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 22:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752702AbZCYCml
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 22:42:41 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59394 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153AbZCYCmk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 22:42:40 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 62A73960E;
	Tue, 24 Mar 2009 22:42:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8794B960D; Tue,
 24 Mar 2009 22:42:31 -0400 (EDT)
In-Reply-To: <1237797676-32047-2-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Mon, 23 Mar 2009 01:41:16 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9A0F81C8-18E6-11DE-8790-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114544>

David Aguilar <davvid@gmail.com> writes:

> +remove_config_vars()
> +{
> +	# Unset all config variables used by git-difftool
> +	git config --unset diff.tool
> +	git config --unset difftool.test-tool.cmd
> +	git config --unset merge.tool
> +	git config --unset mergetool.test-tool.cmd
> +	return 0
> +}
> +
> +restore_test_defaults()
> +{
> +	# Restores the test defaults used by several tests
> +	remove_config_vars
> +	unset GIT_DIFF_TOOL &&
> +	unset GIT_MERGE_TOOL &&
> +	unset GIT_DIFFTOOL_NO_PROMPT &&

I thought some shells' "unset" returns non-zero status when is given an
already unset variable.  I suspect you would want to drop the && chain
just like you did for remove_config_vars for the same reason.

> +	git config diff.tool test-tool &&
> +	git config difftool.test-tool.cmd "cat \$LOCAL"
> +}

'cat $LOCAL' would be much easier to read, wouldn't it?

> + ...
> +# Specify the diff tool using $GIT_DIFF_TOOL
> +test_expect_success 'GIT_DIFF_TOOL variable' '
> +	git config --unset diff.tool &&

You might want to lose && here in case the user told an earlier test that
sets the configuration to some value skipped (or such test failed), or
perhaps later somebody adds tests before this one that leaves the config
without this variable.

Other than that I didn't see major breakages.

Thanks.
