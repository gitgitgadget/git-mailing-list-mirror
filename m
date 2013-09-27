From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 3/3] for-each-ref: introduce %(upstream:track[short])
Date: Fri, 27 Sep 2013 16:25:52 +0200
Message-ID: <52459570.4030301@viscovery.net>
References: <1380283828-25420-1-git-send-email-artagnon@gmail.com> <1380283828-25420-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 27 16:26:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPYzZ-0000GX-IM
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 16:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495Ab3I0OZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 10:25:58 -0400
Received: from lilzmailmt02.liwest.at ([212.33.55.12]:54333 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752993Ab3I0OZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 10:25:57 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1VPYzR-0003Gm-HP; Fri, 27 Sep 2013 16:25:53 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 41EAA16613;
	Fri, 27 Sep 2013 16:25:53 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <1380283828-25420-4-git-send-email-artagnon@gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235462>

Am 9/27/2013 14:10, schrieb Ramkumar Ramachandra:
> +			else if (!strcmp(formatp, "track") &&
> +				!prefixcmp(name, "upstream")) {
> +				char buf[40];
> +
> +				if (!upstream_present)
> +					continue;
> +				stat_tracking_info(branch, &num_ours, &num_theirs);
> +				if (!num_ours && !num_theirs)
> +					v->s = "";
> +				else if (!num_ours) {
> +					sprintf(buf, "[behind %d]", num_theirs);
> +					v->s = xstrdup(buf);
> +				} else if (!num_theirs) {
> +					sprintf(buf, "[ahead %d]", num_ours);
> +					v->s = xstrdup(buf);
> +				} else {
> +					sprintf(buf, "[ahead %d, behind %d]",
> +						num_ours, num_theirs);
> +					v->s = xstrdup(buf);
> +				}

These strdupped strings are leaked, right?

> +				continue;
> +			} else if (!strcmp(formatp, "trackshort") &&
> +				!prefixcmp(name, "upstream")) {
> +				if (!upstream_present)
> +					continue;
> +				stat_tracking_info(branch, &num_ours, &num_theirs);
> +				if (!num_ours && !num_theirs)
> +					v->s = "=";
> +				else if (!num_ours)
> +					v->s = "<";
> +				else if (!num_theirs)
> +					v->s = ">";
> +				else
> +					v->s = "<>";
> +				continue;
> +			} else
>  				die("unknown %.*s format %s",
>  				    (int)(formatp - name), name, formatp);
>  		}
> 

-- Hannes
