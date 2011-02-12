From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] fast-import: add 'ls' command
Date: Fri, 11 Feb 2011 19:36:43 -0600
Message-ID: <20110212013643.GB24736@elie>
References: <20110211224339.GA9973@elie>
 <7vlj1mytjv.fsf@alter.siamese.dyndns.org>
 <20110212012153.GA24736@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	vcs-fast-import-devs@lists.launchpad.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 12 02:36:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Po4Pv-0005cj-1J
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 02:36:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757088Ab1BLBgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 20:36:50 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58703 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756120Ab1BLBgt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 20:36:49 -0500
Received: by yxt3 with SMTP id 3so1335513yxt.19
        for <git@vger.kernel.org>; Fri, 11 Feb 2011 17:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=AJNiOw7vwNdObixJywI4aJrVmR5W/m3kvGAwz+Phv3Y=;
        b=DzwQKCAFoIfKAMjP3obOi/mPpnIXMgaKD6146YiGOmPN2HVpvN4rGnhPjGOwOa/W8E
         2o6jSoIitI0paR0BS1It49YfUjQX4pBoQmyjiSihwx1ytcQ9iB6/nen+XdEP5pggv+It
         KPWRct7UV87RpVAwIc/WtpUChqKftYONBNj58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rTptDYHFluFlC+hlCgGYP0T4xx/6IiLDlpdsG5xBFeSXwLDcvG6NmWEQuq9P8MG/pT
         tMXAT6NULuZ9IobMw+bUc/WQN03KVXg5D6nURs4j5jbPf2JuA89mTdCzaw4LBkvS6Q0O
         fNsoYM94gMKQbh4FusiCQIFY0qjyJ6nCc/6Cw=
Received: by 10.150.92.13 with SMTP id p13mr1361412ybb.408.1297474609053;
        Fri, 11 Feb 2011 17:36:49 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id v6sm133708ybk.8.2011.02.11.17.36.45
        (version=SSLv3 cipher=OTHER);
        Fri, 11 Feb 2011 17:36:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110212012153.GA24736@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166587>

Jonathan Nieder wrote:

> It is probably be less confusing to use "missing" and let frontends
> handle that rather shielding the frontend from reality.  Like so:
                    ^

This should say "rather than", as in: "It is confusing to lie to the
frontend; let's not do that."

Side note: this adds some complication to frontends.  For example,
to copy some/path from the commit called :5, without this change,
one could do

	echo 'ls :5 some/path'
	read -r mode type dataref path
	echo "M $mode $dataref $path"

but now one would have to do:

	echo 'ls :5 some/path'
	read -r mode rest
	case $mode in
	missing)
		echo "D some/path"
		;;
	*)
		dataref=${rest#* }
		echo "M $mode $dataref some/path"
		;;
	esac

The former is simpler; the latter is more explicit and probably less
confusing.

Sorry for the nonsense.
Jonathan
