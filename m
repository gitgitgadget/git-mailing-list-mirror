From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Segmentation fault found while fuzzing .pack file under 2.7.0.rc3
Date: Tue, 5 Jan 2016 16:23:33 -0800
Message-ID: <20160106002333.GA16090@google.com>
References: <568BC8D1.3080201@gmail.com>
 <20160105152436.GA1205@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jacek Wielemborek <d33tah@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 06 01:24:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGbu5-0004wm-Bi
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 01:24:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbcAFAYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 19:24:38 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33678 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598AbcAFAYg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 19:24:36 -0500
Received: by mail-pa0-f54.google.com with SMTP id cy9so223278316pac.0
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 16:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Sd0dtHlT/jFlGM1AiZUH1zP25d83Arowg6pCJnWo6vA=;
        b=lymL3do7fSuvYSBa5fquJWvPhb9gSIXy11Z5PoyJMmN3ftWgcz/kqIB4cM74qxG2V9
         sgDDsuMYRQdqSLJXsGdacc1vUKTITKEWc5WWMZKQTxmqcMsK0Mh+SSSx0P3V/SKByG2B
         syQ9BOF7FXPSOpunwmapbGB+l3GXp8iVG6QQGtJAWbUMRi0zROiaHiNxaq2PIN/a9pbc
         Q+Dr4E9Jtyt06E1Z8Q0waHqanrBzPsOoTLoaZob4OsSyEv8h70yWYtsVLK2aPyh1mQ7J
         7jipSuGTY77xBkhl72YwL7ObceHv0XK+JVDQqvX1t+xfRMl746EnCEO95kgQ6lzJx4I4
         iLPA==
X-Received: by 10.66.233.10 with SMTP id ts10mr136169792pac.69.1452039876062;
        Tue, 05 Jan 2016 16:24:36 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:ad02:a50c:7ba0:6c50])
        by smtp.gmail.com with ESMTPSA id xr8sm135969776pab.26.2016.01.05.16.24.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Jan 2016 16:24:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160105152436.GA1205@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283409>

Jeff King wrote:

> Git packfiles come from two places:
>
>   1. Local maintenance repacks loose and already-packed objects into a
>      new packfile. We trust the local repack process to generate a valid
>      packfile (though the contents of individual objects may be
>      untrusted, of course).

I think we should reconsider such trust.  If one user creates a
malicious pack, if another user uses read-only git commands to access
the repository (after inspecting .git/config to make sure it doesn't
contain anything scary) the result should not be arbitrary code
execution.

Producing bogus output or aborting is okay; arbitrary code execution
less so.

Thanks,
Jonathan
