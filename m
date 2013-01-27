From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 3/4] mergetool--lib: Add functions for finding available
 tools
Date: Sun, 27 Jan 2013 23:04:04 +0000
Message-ID: <20130127230404.GX7498@serenity.lan>
References: <1359321886-80523-1-git-send-email-davvid@gmail.com>
 <1359321886-80523-4-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 00:04:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzbH8-0003ej-Fk
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 00:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756820Ab3A0XEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 18:04:13 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:52436 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755920Ab3A0XEM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 18:04:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id B9E96CDA5BA;
	Sun, 27 Jan 2013 23:04:11 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Hk-VAhTGrRL; Sun, 27 Jan 2013 23:04:11 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 35580CDA580;
	Sun, 27 Jan 2013 23:04:11 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 14847161E564;
	Sun, 27 Jan 2013 23:04:11 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d07fYjbslhxh; Sun, 27 Jan 2013 23:04:11 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id A4F61161E54F;
	Sun, 27 Jan 2013 23:04:06 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <1359321886-80523-4-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214748>

On Sun, Jan 27, 2013 at 01:24:45PM -0800, David Aguilar wrote:
> +filter_tools () {
> +	filter="$1"
> +	prefix="$2"
> +	(
> +		cd "$MERGE_TOOLS_DIR" &&
> +		for i in *
> +		do
> +			echo "$i"
> +		done
> +	) | sort | while read tool
> +	do
> +		setup_tool "$tool" 2>/dev/null &&
> +		(eval "$filter" "$tool") &&
> +		printf "$prefix$tool\n"
> +	done
> +}

Can we change this so that it does this:

    filter_tools () {
    	filter="$1"
    	(
    		cd "$MERGE_TOOLS_DIR" &&
    		for i in *
    		do
    			echo "$i"
    		done
    	) |
        while read tool
    	do
    		setup_tool "$tool" 2>/dev/null &&
    		(eval "$filter" "$tool") &&
    		echo "$tool"
    	done
    }

and keep the sorting and prefix in show_tool_help?  This will make it
easier to integrate the user-configured tools from git-config.


John
