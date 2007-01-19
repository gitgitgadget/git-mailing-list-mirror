From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Fri, 19 Jan 2007 13:25:05 +0100
Message-ID: <200701191325.06337.jnareb@gmail.com>
References: <200701150144.56793.jnareb@gmail.com> <200701171500.33220.jnareb@gmail.com> <200701191310.32417.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nikolai Weibull <now@bitwi.se>, Junio C Hamano <junkio@cox.net>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 13:24:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7snL-0005Z0-Nm
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 13:24:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbXASMYd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 07:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965098AbXASMYd
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 07:24:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:46325 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965095AbXASMYc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jan 2007 07:24:32 -0500
Received: by ug-out-1314.google.com with SMTP id 44so444657uga
        for <git@vger.kernel.org>; Fri, 19 Jan 2007 04:24:31 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GVH2wgK5AOVqyakIryG31ZV4MrcMR6c2e3kj4egKlLiqAU7lVV1e2zMCBDdmBv2ps6J/oZ5PtarLiM2SNXG/xqPqO0iQQQyeSKiaX8bkK5O7/HnX85ZkuGTwkOqcDlidtqaIWABFf/mQO70kpnUd9/Un7hOk0AUgJbQ9U/z6I24=
Received: by 10.67.93.6 with SMTP id v6mr2919825ugl.1169209471079;
        Fri, 19 Jan 2007 04:24:31 -0800 (PST)
Received: from host-81-190-20-200.torun.mm.pl ( [81.190.20.200])
        by mx.google.com with ESMTP id 72sm2072357ugb.2007.01.19.04.24.29;
        Fri, 19 Jan 2007 04:24:30 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: KMail/1.9.3
In-Reply-To: <200701191310.32417.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37176>

Jakub Narebski wrote:
> Jakub Narebski wrote:
> 
>> BTW. it looks like C escape sequences are parsed, but not octal
>> escape sequences, nor no-op escaping other character.
>  
> From a bit of testing, as documentation of config file format
> is woefully incomplete, (yes, I know I should use the source)
> _some_ of C escape sequences aka. character escape codes (CEC)
> are parsed:
>  - "\t", tab character (HT, TAB)
>  - "\n", newline (NL)
>  - "\b", backspace (BS)
> It's a bit strange that "\b" is parsed...
[...]
> Values of configuration variables can span multiple lines by escaping
> newline, i.e. putting \ as the last character. Nice.

>From config.c:parse_value:73

		if (c == '\\') {
			c = get_next_char();
			switch (c) {
			case '\n':
				continue;
			case 't':
				c = '\t';
				break;
			case 'b':
				c = '\b';
				break;
			case 'n':
				c = '\n';
				break;
			/* Some characters escape as themselves */
			case '\\': case '"':
				break;
			/* Reject unknown escape sequences */
			default:
				return NULL;
			}

-- 
Jakub Narebski
Poland
