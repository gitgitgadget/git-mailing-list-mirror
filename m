From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 1/2] git-p4.py: support Python 2.5
Date: Sat, 26 Jan 2013 07:45:10 -0500
Message-ID: <20130126124510.GA31052@padd.com>
References: <1359146641-27810-1-git-send-email-drafnel@gmail.com>
 <1359146641-27810-2-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, esr@thyrsus.com, john@keeping.me.uk,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 13:45:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tz58b-0003DL-BR
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 13:45:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753806Ab3AZMpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 07:45:16 -0500
Received: from honk.padd.com ([74.3.171.149]:46986 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753630Ab3AZMpO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 07:45:14 -0500
Received: from arf.padd.com (unknown [50.52.174.88])
	by honk.padd.com (Postfix) with ESMTPSA id 66DFD2F3F;
	Sat, 26 Jan 2013 04:45:13 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 0CDA22262D; Sat, 26 Jan 2013 07:45:10 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1359146641-27810-2-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214622>

drafnel@gmail.com wrote on Fri, 25 Jan 2013 12:44 -0800:
> Python 2.5 and older do not accept None as the first argument to
> translate() and complain with:
> 
>    TypeError: expected a character buffer object
> 
> Satisfy this older python by calling maketrans() to generate an empty
> translation table and supplying that to translate().
> 
> This allows git-p4 to be used with Python 2.5.

This was a lot easier than I imagined!

>  def wildcard_present(path):
> -    return path.translate(None, "*#@%") != path
> +    from string import maketrans
> +    return path.translate(maketrans("",""), "*#@%") != path

translate() was a bit too subtle already.  Could you try
something like this instead?

    m = re.search("[*#@%]", path)
    return m is not None

I think that'll work everywhere and not force people to look
up how translate and maketrans work.

		-- Pete
