From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/4] Refactoring: connect.c: move duplicated code to get_host_and_port
Date: Mon, 15 Feb 2010 22:11:56 +0100
Message-ID: <4B79B89C.1050603@kdbg.org>
References: <1266182863-5048-1-git-send-email-michael.lukashov@gmail.com> <1266182863-5048-2-git-send-email-michael.lukashov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Lukashov <michael.lukashov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 22:12:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nh8En-0004cy-H5
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 22:12:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141Ab0BOVMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 16:12:08 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:12303 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932133Ab0BOVMG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 16:12:06 -0500
Received: from [77.119.192.246] (77.119.192.246.wireless.dyn.drei.com [77.119.192.246])
	by bsmtp.bon.at (Postfix) with ESMTP id D9879CDF8C;
	Mon, 15 Feb 2010 22:12:00 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1266182863-5048-2-git-send-email-michael.lukashov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140034>

Michael Lukashov schrieb:
> +static void get_host_and_port(char **host, const char **port, int set_port_none)

Minor nit: The last parameter, set_port_none, is a rather prominent sign 
that this function mixes policy and functionality. And indeed, this 
implementation:

> +	if (colon) {
> +		*colon = 0;
> +		*port = colon + 1;
> +		if (set_port_none && !**port)
> +			*port = "<none>";
> +	}

proves it. The _functionality_ is to find host and port from a string. The 
_policy_ is to set the port to "<none>" if it would otherwise be empty. 
The callers take care of the _policy_, this function should only care 
about _functionality_. There's only one call site that wants "<none>"; 
don't move this detail into this function.

Other than that: nice catch.

-- Hannes
