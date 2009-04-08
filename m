From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] git remote update: Report error for non-existing
 groups
Date: Tue, 07 Apr 2009 19:16:21 -0700
Message-ID: <7vprfnubyi.fsf@gitster.siamese.dyndns.org>
References: <1239025262-16960-1-git-send-email-finnag@pvv.org>
 <1239025262-16960-2-git-send-email-finnag@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Wed Apr 08 04:17:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrNMU-0005KM-1s
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 04:17:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758107AbZDHCQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 22:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757150AbZDHCQ3
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 22:16:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38863 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757261AbZDHCQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 22:16:28 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A8892A82D5;
	Tue,  7 Apr 2009 22:16:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9DBA0A82D3; Tue,
  7 Apr 2009 22:16:23 -0400 (EDT)
In-Reply-To: <1239025262-16960-2-git-send-email-finnag@pvv.org> (Finn Arne
 Gangstad's message of "Mon, 6 Apr 2009 15:41:00 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 439DEE6C-23E3-11DE-B463-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116019>

Finn Arne Gangstad <finnag@pvv.org> writes:

> @@ -1227,8 +1229,11 @@ static int update(int argc, const char **argv)
>  
>  	remote_group.list = &list;
>  	for (i = 1; i < argc; i++) {
> +		int groups_found = 0;
>  		remote_group.name = argv[i];
> -		result = git_config(get_remote_group, NULL);
> +		result = git_config(get_remote_group, &groups_found);
> +		if (!groups_found && (i != 1 || strcmp(argv[1], "default")))
> +			die("No such remote group: '%s'", argv[i]);

I think you are trying to be silent about the case where the caller feeds
you the default_argv[] array with this, but do we want to be more explicit
about this so that we do die when the end user explicitly says "default"
from the command line?
