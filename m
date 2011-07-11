From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/17] revert: Save command-line options for continuing
 operation
Date: Mon, 11 Jul 2011 14:15:18 -0700
Message-ID: <7vei1wbjji.fsf@alter.siamese.dyndns.org>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-13-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 11 23:21:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgNv3-0004LK-75
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 23:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757576Ab1GKVVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 17:21:25 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40931 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901Ab1GKVVY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 17:21:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A49846A0C;
	Mon, 11 Jul 2011 17:21:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=o8ryvFUk1f2IvqTMcCyNDlAhY24=; b=ICenZNPCX6oo1vL2LV3N
	TSc9O+uVxNH6wy6vT/mgCgf1mGIQGdI1ykZjz4NMsplE4EaXmh7vaFaNz2A6LkXs
	TIv4Hgh/m1QdgiBERt0x8CZXvDr6PsvCwcEDpT2z6FJUQVlfk46hwVEk6iQCUGdd
	RExbrcu8GmLwDGClM6QR4aI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=gTlvycooceOF6f0IUOZMs7n7Mg9jqiddGcbPxj1+LxSSbI
	axEhPcUNl+C6QnqJ4NRDo+YJ3Tbw0I0OZApzQo22eIkN+1XhWEabR5evpNl2Zwrd
	fgbbhiU2csFzeCnlNp3atTE8sYgUs7QAxj4bpnVFWa0swCI3FqydwXl+4Aurc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9C1D56A0B;
	Mon, 11 Jul 2011 17:21:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E66656A0A; Mon, 11 Jul 2011
 17:21:22 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BA2D304C-AC03-11E0-9C91-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176899>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> +	die(_("Malformed options sheet: %s"), git_path(SEQ_OPTS_FILE));
> +}
> +
> +static void read_populate_opts(struct replay_opts **opts_ptr)

It would make sense to refactor config.c:git_parse_file() to be easier to
use, rename it to be more descriptive (it should be a function that takes
a struct that holds these fields

        static FILE *config_file;
        static const char *config_file_name;
        static int config_linenr;
        static int config_file_eof;

in addition to the callback "fn" and callback "data", expects the file to
be in something similar to the .ini format, parses it with the help from
the callback function), and use it here, without rolling your own.

Also I get

builtin/revert.c:682: error: 'read_populate_todo' defined but not used
builtin/revert.c:848: error: 'read_populate_opts' defined but not used

at this step in the series, which is not quite optimal.
