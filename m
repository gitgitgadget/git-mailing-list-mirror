From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/3] git p4 test: should honor symlink in p4 client root
Date: Fri, 08 Mar 2013 07:42:04 +0100
Message-ID: <5139883C.6080308@viscovery.net>
References: <20130307091317.GY7738@serenity.lan> <1362698357-7334-1-git-send-email-pw@padd.com> <1362698357-7334-3-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-15?Q?Mikl=F3s_Fazekas?= <mfazekas@szemafor.com>,
	John Keeping <john@keeping.me.uk>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Fri Mar 08 07:42:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDr0o-000170-5t
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 07:42:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147Ab3CHGmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 01:42:12 -0500
Received: from so.liwest.at ([212.33.55.24]:59425 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750880Ab3CHGmL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 01:42:11 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UDr0H-0004sb-5Y; Fri, 08 Mar 2013 07:42:05 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id BFD541660F;
	Fri,  8 Mar 2013 07:42:04 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <1362698357-7334-3-git-send-email-pw@padd.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217641>

Am 3/8/2013 0:19, schrieb Pete Wyckoff:
> +# When the p4 client Root is a symlink, make sure chdir() does not use
> +# getcwd() to convert it to a physical path.
> +test_expect_failure 'p4 client root symlink should stay symbolic' '
> +	physical="$TRASH_DIRECTORY/physical" &&
> +	symbolic="$TRASH_DIRECTORY/symbolic" &&
> +	test_when_finished "rm -rf \"$physical\"" &&
> +	test_when_finished "rm \"$symbolic\"" &&
> +	mkdir -p "$physical" &&
> +	ln -s "$physical" "$symbolic" &&

This test needs a SYMLINKS prerequisite to future-proof it, in case the
Windows port gains p4 support some time.

> +	test_when_finished cleanup_git &&
> +	(
> +		P4CLIENT=client-sym &&
> +		p4 client -i <<-EOF &&
> +		Client: $P4CLIENT
> +		Description: $P4CLIENT
> +		Root: $symbolic
> +		LineEnd: unix
> +		View: //depot/... //$P4CLIENT/...
> +		EOF
> +		git p4 clone --dest="$git" //depot &&
> +		cd "$git" &&
> +		test_commit file2 &&
> +		git config git-p4.skipSubmitEdit true &&
> +		git p4 submit
> +	)
> +'

-- Hannes
