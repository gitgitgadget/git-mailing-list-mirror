From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: Re: [PATCH] Allow HTTP proxy to be overridden in config
Date: Fri, 23 Nov 2007 16:35:44 +1300
Organization: Catalyst IT (NZ) Ltd
Message-ID: <47464A90.4030509@catalyst.net.nz>
References: <1195776420-22075-1-git-send-email-sam.vilain@catalyst.net.nz> <7voddl24b7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, francois@debian.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 05:06:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvPoV-0004Ke-Je
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 05:06:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753252AbXKWEGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 23:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753032AbXKWEG3
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 23:06:29 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:39254 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081AbXKWEG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 23:06:29 -0500
X-Greylist: delayed 1814 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Nov 2007 23:06:28 EST
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=[192.168.2.22])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <sam.vilain@catalyst.net.nz>)
	id 1IvPKT-0006L4-Gf; Fri, 23 Nov 2007 16:35:45 +1300
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <7voddl24b7.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65870>

Junio C Hamano wrote:
>> The http_proxy / HTTPS_PROXY variables used by curl to control
>> proxying may not be suitable for git.  Allow the user to override them
>> in the configuration file.
>> ---
>>   In particular, privoxy will block directories called /ad/ ... d'oh!
>> +++ b/Documentation/config.txt
>> +http.proxy::
>> +	Override the HTTP proxy, normally configured using the 'http_proxy'
>> +	environment variable (see gitlink:curl[1]).
> 
> This may work around the issue you cited, but it makes me wonder
> if it is a road to insanity.  Does the curl library expect that
> (1) each and every HTTP talking application that uses the
> library offer this kind of knob for its users to tweak, and (2)
> users set the knob for each and every one of such application?

This is true.  However I still think that it is a useful feature for
many users, with few side effects.  If nothing else the bit on the man
page will prompt them to think, "oh, I should set that in the environment".

> I would say if privoxy cannot be tweaked to allow /ad/ in chosen
> context (e.g. /ad/ in general is rejected but /objects/ad/ is
> Ok), that is what needs to be fixed.
> Or it would be the use of such a broken proxy by the user.  That
> can be fixed and much easily.

Yes - but consider the dilemma of the user.  They've apt-get installed
this privoxy thing and figured out how to set their applications to use
it.  Now, it doesn't work and they think it is the proxy in the way, and
they've no idea that they might be able to reconfigure it.  This way
they can tell git to bypass it.

I don't know, I see your point and pretty much agree with it.  It just
seems like something that might come in handy (as well as be another
vector for something you need to check when you get HTTP fetch issues -
so maybe a command-line option would be better).

Actually something that would really have helped is more documentation
of the various GIT_CURL_* environment variables available for debugging.
-- 
Sam Vilain, Chief Yak Shaver, Catalyst IT (NZ) Ltd.
phone: +64 4 499 2267        PGP ID: 0x66B25843
