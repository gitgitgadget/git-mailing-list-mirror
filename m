From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: http.c (curl_easy_setopt and CURLAUTH_ANY)
Date: Fri, 28 Aug 2015 08:34:04 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1508280831230.20243@tvnag.unkk.fr>
References: <CAF0pADEsO0y_6wcx-xNwRqjauJmMcQ8mUmbUbbWCBrK2gQ1quA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Stephen Kazakoff <sh.kazakoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 08:39:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVDJo-0002mJ-79
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 08:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbbH1GjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 02:39:14 -0400
Received: from giant.haxx.se ([80.67.6.50]:59646 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752056AbbH1GjN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 02:39:13 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Aug 2015 02:39:12 EDT
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-7) with ESMTP id t7S6Y43Y008230
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2015 08:34:04 +0200
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id t7S6Y4H9008224;
	Fri, 28 Aug 2015 08:34:04 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <CAF0pADEsO0y_6wcx-xNwRqjauJmMcQ8mUmbUbbWCBrK2gQ1quA@mail.gmail.com>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276707>

On Fri, 28 Aug 2015, Stephen Kazakoff wrote:

> From:
> curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
>
> To:
> curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_BASIC | CURLAUTH_NTLM);
>
> I did however find the CURL documentation 
> (https://secure.php.net/manual/en/function.curl-setopt.php) slightly 
> conflicting. On one hand, "CURLAUTH_ANY" is effectively the same as passing 
> "CURLAUTH_BASIC | CURLAUTH_NTLM". But the documentation for 
> "CURLOPT_PROXYAUTH" says that only "CURLAUTH_BASIC" and "CURLAUTH_NTLM" are 
> currently supported. By that, I'm assuming "CURLAUTH_ANY" is not supported.

That would rather indicate a problem somewhere else.

CURLAUTH_ANY is just a convenience define that sets a bunch of bits at once, 
and libcurl will discard bits you'd set for auth methods your libcurl hasn't 
been built to deal with anyway. Thus, the above two lines should result in 
(almost) exactly the same behavior from libcurl's point of view.

The fact that they actually make a difference is probably because ANY then 
enables a third authentication method that perhaps your server doesn't like? 
Or is it a libcurl bug?

Hard to tell without more info, including libcurl version. But no, the above 
suggested change doesn't really make much sense for the general population.

-- 

  / daniel.haxx.se
